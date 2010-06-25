Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 7A9F21007F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:20 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
Date: Sat, 26 Jun 2010 01:25:14 +0200
Message-Id: <1277508314-915-27-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We just introduced a new PV interface that screams for documentation. So here
it is - a shiny new and awesome text file describing the internal works of
the PPC KVM paravirtual interface.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 Documentation/kvm/ppc-pv.txt |  164 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 164 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/kvm/ppc-pv.txt

diff --git a/Documentation/kvm/ppc-pv.txt b/Documentation/kvm/ppc-pv.txt
new file mode 100644
index 0000000..7cbcd51
--- /dev/null
+++ b/Documentation/kvm/ppc-pv.txt
@@ -0,0 +1,164 @@
+The PPC KVM paravirtual interface
+=================================
+
+The basic execution principle by which KVM on PowerPC works is to run all kernel
+space code in PR=1 which is user space. This way we trap all privileged
+instructions and can emulate them accordingly.
+
+Unfortunately that is also the downfall. There are quite some privileged
+instructions that needlessly return us to the hypervisor even though they
+could be handled differently.
+
+This is what the PPC PV interface helps with. It takes privileged instructions
+and transforms them into unprivileged ones with some help from the hypervisor.
+This cuts down virtualization costs by about 50% on some of my benchmarks.
+
+The code for that interface can be found in arch/powerpc/kernel/kvm*
+
+Querying for existence
+======================
+
+To find out if we're running on KVM or not, we overlay the PVR register. Usually
+the PVR register contains an id that identifies your CPU type. If, however, you
+pass KVM_PVR_PARA in the register that you want the PVR result in, the register
+still contains KVM_PVR_PARA after the mfpvr call.
+
+	LOAD_REG_IMM(r5, KVM_PVR_PARA)
+	mfpvr	r5
+	[r5 still contains KVM_PVR_PARA]
+
+Once determined to run under a PV capable KVM, you can now use hypercalls as
+described below.
+
+PPC hypercalls
+==============
+
+The only viable ways to reliably get from guest context to host context are:
+
+	1) Call an invalid instruction
+	2) Call the "sc" instruction with a parameter to "sc"
+	3) Call the "sc" instruction with parameters in GPRs
+
+Method 1 is always a bad idea. Invalid instructions can be replaced later on
+by valid instructions, rendering the interface broken.
+
+Method 2 also has downfalls. If the parameter to "sc" is != 0 the spec is
+rather unclear if the sc is targeted directly for the hypervisor or the
+supervisor. It would also require that we read the syscall issuing instruction
+every time a syscall is issued, slowing down guest syscalls.
+
+Method 3 is what KVM uses. We pass magic constants (KVM_SC_MAGIC_R3 and
+KVM_SC_MAGIC_R4) in r3 and r4 respectively. If a syscall instruction with these
+magic values arrives from the guest's kernel mode, we take the syscall as a
+hypercall.
+
+The parameters are as follows:
+
+	r3		KVM_SC_MAGIC_R3
+	r4		KVM_SC_MAGIC_R4
+	r5		Hypercall number
+	r6		First parameter
+	r7		Second parameter
+	r8		Third parameter
+	r9		Fourth parameter
+
+Hypercall definitions are shared in generic code, so the same hypercall numbers
+apply for x86 and powerpc alike.
+
+The magic page
+==============
+
+To enable communication between the hypervisor and guest there is a new shared
+page that contains parts of supervisor visible register state. The guest can
+map this shared page using the KVM hypercall KVM_HC_PPC_MAP_MAGIC_PAGE.
+
+With this hypercall issued the guest always gets the magic page mapped at the
+desired location in effective and physical address space. For now, we always
+map the page to -4096. This way we can access it using absolute load and store
+functions. The following instruction reads the first field of the magic page:
+
+	ld	rX, -4096(0)
+
+The interface is designed to be extensible should there be need later to add
+additional registers to the magic page. If you add fields to the magic page,
+also define a new hypercall feature to indicate that the host can give you more
+registers. Only if the host supports the additional features, make use of them.
+
+The magic page has the following layout as described in
+arch/powerpc/include/asm/kvm_para.h:
+
+struct kvm_vcpu_arch_shared {
+	__u64 scratch1;
+	__u64 scratch2;
+	__u64 scratch3;
+	__u64 critical;		/* Guest may not get interrupts if == r1 */
+	__u64 sprg0;
+	__u64 sprg1;
+	__u64 sprg2;
+	__u64 sprg3;
+	__u64 srr0;
+	__u64 srr1;
+	__u64 dar;
+	__u64 msr;
+	__u32 dsisr;
+	__u32 int_pending;	/* Tells the guest if we have an interrupt */
+};
+
+Additions to the page must only occur at the end. Struct fields are always 32
+bit aligned.
+
+Patched instructions
+====================
+
+The "ld" and "std" instructions are transormed to "lwz" and "stw" instructions
+respectively on 32 bit systems with an added offset of 4 to accomodate for big
+endianness.
+
+From			To
+====			==
+
+mfmsr	rX		ld	rX, magic_page->msr
+mfsprg	rX, 0		ld	rX, magic_page->sprg0
+mfsprg	rX, 1		ld	rX, magic_page->sprg1
+mfsprg	rX, 2		ld	rX, magic_page->sprg2
+mfsprg	rX, 3		ld	rX, magic_page->sprg3
+mfsrr0	rX		ld	rX, magic_page->srr0
+mfsrr1	rX		ld	rX, magic_page->srr1
+mfdar	rX		ld	rX, magic_page->dar
+mfdsisr	rX		ld	rX, magic_page->dsisr
+
+mtmsr	rX		std	rX, magic_page->msr
+mtsprg	0, rX		std	rX, magic_page->sprg0
+mtsprg	1, rX		std	rX, magic_page->sprg1
+mtsprg	2, rX		std	rX, magic_page->sprg2
+mtsprg	3, rX		std	rX, magic_page->sprg3
+mtsrr0	rX		std	rX, magic_page->srr0
+mtsrr1	rX		std	rX, magic_page->srr1
+mtdar	rX		std	rX, magic_page->dar
+mtdsisr	rX		std	rX, magic_page->dsisr
+
+tlbsync			nop
+
+mtmsrd	rX, 0		b	<special mtmsr section>
+mtmsr			b	<special mtmsr section>
+
+mtmsrd	rX, 1		b	<special mtmsrd section>
+
+[BookE only]
+wrteei	[0|1]		b	<special wrteei section>
+
+
+Some instructions require more logic to determine what's going on than a load
+or store instruction can deliver. To enable patching of those, we keep some
+RAM around where we can live translate instructions to. What happens is the
+following:
+
+	1) copy emulation code to memory
+	2) patch that code to fit the emulated instruction
+	3) patch that code to return to the original pc + 4
+	4) patch the original instruction to branch to the new code
+
+That way we can inject an arbitrary amount of code as replacement for a single
+instruction. This allows us to check for pending interrupts when setting EE=1
+for example.
+
-- 
1.6.0.2
