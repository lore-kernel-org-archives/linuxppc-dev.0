Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id D7ADFB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 18:14:50 +1000 (EST)
Message-ID: <4C270876.2050806@redhat.com>
Date: Sun, 27 Jun 2010 11:14:46 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-27-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-27-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2010 02:25 AM, Alexander Graf wrote:
> We just introduced a new PV interface that screams for documentation. So here
> it is - a shiny new and awesome text file describing the internal works of
> the PPC KVM paravirtual interface.
>    

Good, that lets people who have no idea what they're talking about 
participate in the review.

> +
> +PPC hypercalls
> +==============
> +
> +The only viable ways to reliably get from guest context to host context are:
> +
> +	1) Call an invalid instruction
> +	2) Call the "sc" instruction with a parameter to "sc"
> +	3) Call the "sc" instruction with parameters in GPRs
> +
> +Method 1 is always a bad idea. Invalid instructions can be replaced later on
> +by valid instructions, rendering the interface broken.
> +
> +Method 2 also has downfalls. If the parameter to "sc" is != 0 the spec is
> +rather unclear if the sc is targeted directly for the hypervisor or the
> +supervisor. It would also require that we read the syscall issuing instruction
> +every time a syscall is issued, slowing down guest syscalls.
> +
> +Method 3 is what KVM uses. We pass magic constants (KVM_SC_MAGIC_R3 and
> +KVM_SC_MAGIC_R4) in r3 and r4 respectively. If a syscall instruction with these
> +magic values arrives from the guest's kernel mode, we take the syscall as a
> +hypercall.
>    

Is there any chance a normal syscall will have those values in r3 and r4?

If so, maybe it's better to use pc as they key for hypercalls.  Let the 
guest designate one instruction address as the hypercall call point; kvm 
can easily check it and reflect it back to the guest if it doesn't match.

Is it valid and useful to issue sc from privileged mode anyway, except 
for calling the hypervisor?

> +
> +The parameters are as follows:
> +
> +	r3		KVM_SC_MAGIC_R3
> +	r4		KVM_SC_MAGIC_R4
> +	r5		Hypercall number
> +	r6		First parameter
> +	r7		Second parameter
> +	r8		Third parameter
> +	r9		Fourth parameter
> +
> +Hypercall definitions are shared in generic code, so the same hypercall numbers
> +apply for x86 and powerpc alike.
>    

Addresses passed in hypercall paramters are guest physical addresses.

Do you have >32 bit physical addresses on 32-bit guests?  if so, you'll 
need to pass physical addresses in two registers.

> +
> +The magic page
> +==============
> +
> +To enable communication between the hypervisor and guest there is a new shared
> +page that contains parts of supervisor visible register state. The guest can
> +map this shared page using the KVM hypercall KVM_HC_PPC_MAP_MAGIC_PAGE.
> +
> +With this hypercall issued the guest always gets the magic page mapped at the
> +desired location in effective and physical address space. For now, we always
> +map the page to -4096. This way we can access it using absolute load and store
> +functions. The following instruction reads the first field of the magic page:
> +
> +	ld	rX, -4096(0)
>    

Is the address guest controlled or host controlled?

> +
> +The interface is designed to be extensible should there be need later to add
> +additional registers to the magic page. If you add fields to the magic page,
> +also define a new hypercall feature to indicate that the host can give you more
> +registers. Only if the host supports the additional features, make use of them.
> +
> +The magic page has the following layout as described in
> +arch/powerpc/include/asm/kvm_para.h:
> +
> +struct kvm_vcpu_arch_shared {
> +	__u64 scratch1;
> +	__u64 scratch2;
> +	__u64 scratch3;
> +	__u64 critical;		/* Guest may not get interrupts if == r1 */
>    

Elaborate?

> +	__u64 sprg0;
> +	__u64 sprg1;
> +	__u64 sprg2;
> +	__u64 sprg3;
> +	__u64 srr0;
> +	__u64 srr1;
> +	__u64 dar;
> +	__u64 msr;
> +	__u32 dsisr;
> +	__u32 int_pending;	/* Tells the guest if we have an interrupt */
> +};
> +
> +Additions to the page must only occur at the end. Struct fields are always 32
> +bit aligned.
> +
> +Patched instructions
> +====================
> +
> +The "ld" and "std" instructions are transormed to "lwz" and "stw" instructions
> +respectively on 32 bit systems with an added offset of 4 to accomodate for big
> +endianness.
>    

Who does the patching? guest or host?

> +
> +From			To
> +====			==
> +
> +mfmsr	rX		ld	rX, magic_page->msr
> +mfsprg	rX, 0		ld	rX, magic_page->sprg0
> +mfsprg	rX, 1		ld	rX, magic_page->sprg1
> +mfsprg	rX, 2		ld	rX, magic_page->sprg2
> +mfsprg	rX, 3		ld	rX, magic_page->sprg3
> +mfsrr0	rX		ld	rX, magic_page->srr0
> +mfsrr1	rX		ld	rX, magic_page->srr1
> +mfdar	rX		ld	rX, magic_page->dar
> +mfdsisr	rX		ld	rX, magic_page->dsisr
> +
> +mtmsr	rX		std	rX, magic_page->msr
> +mtsprg	0, rX		std	rX, magic_page->sprg0
> +mtsprg	1, rX		std	rX, magic_page->sprg1
> +mtsprg	2, rX		std	rX, magic_page->sprg2
> +mtsprg	3, rX		std	rX, magic_page->sprg3
> +mtsrr0	rX		std	rX, magic_page->srr0
> +mtsrr1	rX		std	rX, magic_page->srr1
> +mtdar	rX		std	rX, magic_page->dar
> +mtdsisr	rX		std	rX, magic_page->dsisr
> +
> +tlbsync			nop
> +
> +mtmsrd	rX, 0		b	<special mtmsr section>
> +mtmsr			b	<special mtmsr section>
> +
> +mtmsrd	rX, 1		b	<special mtmsrd section>
> +
> +[BookE only]
> +wrteei	[0|1]		b	<special wrteei section>
>    

Probably the guest, as only it can arrange for special * sections.  Good.

> +
> +Some instructions require more logic to determine what's going on than a load
> +or store instruction can deliver. To enable patching of those, we keep some
> +RAM around where we can live translate instructions to. What happens is the
> +following:
> +
> +	1) copy emulation code to memory
> +	2) patch that code to fit the emulated instruction
> +	3) patch that code to return to the original pc + 4
> +	4) patch the original instruction to branch to the new code
> +
> +That way we can inject an arbitrary amount of code as replacement for a single
> +instruction. This allows us to check for pending interrupts when setting EE=1
> +for example.
> +
>    

Or not.

What about transitions from paravirt to non-paravirt?  For example, a 
system reset.

-- 
error compiling committee.c: too many arguments to function
