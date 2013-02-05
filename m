Return-Path: <paulus@ozlabs.org>
Date: Tue, 5 Feb 2013 15:10:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH 3/4] KVM: PPC: Book3S HV: Preserve guest CFAR register value
Message-ID: <20130205041051.GD20303@drongo>
References: <20130205040902.GA20303@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130205040902.GA20303@drongo>
Cc: kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CFAR (Come-From Address Register) is a useful debugging aid that
exists on POWER7 processors.  Currently HV KVM doesn't save or restore
the CFAR register for guest vcpus, making the CFAR of limited use in
guests.

This adds the necessary code to capture the CFAR value saved in the
early exception entry code (it has to be saved before any branch is
executed), save it in the vcpu.arch struct, and restore it on entry
to the guest.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/exception-64s.h  |    8 ++++++--
 arch/powerpc/include/asm/kvm_book3s_asm.h |    3 +++
 arch/powerpc/include/asm/kvm_host.h       |    1 +
 arch/powerpc/kernel/asm-offsets.c         |    5 +++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |    9 +++++++++
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 4dfc515..05e6d2e 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -199,10 +199,14 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __KVM_HANDLER(area, h, n)					\
 do_kvm_##n:								\
+	BEGIN_FTR_SECTION_NESTED(947)					\
+	ld	r10,area+EX_CFAR(r13);					\
+	std	r10,HSTATE_CFAR(r13);					\
+	END_FTR_SECTION_NESTED(CPU_FTR_CFAR,CPU_FTR_CFAR,947);		\
 	ld	r10,area+EX_R10(r13);					\
-	stw	r9,HSTATE_SCRATCH1(r13);			\
+	stw	r9,HSTATE_SCRATCH1(r13);				\
 	ld	r9,area+EX_R9(r13);					\
-	std	r12,HSTATE_SCRATCH0(r13);			\
+	std	r12,HSTATE_SCRATCH0(r13);				\
 	li	r12,n;							\
 	b	kvmppc_interrupt
 
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 88609b2..cdc3d27 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -93,6 +93,9 @@ struct kvmppc_host_state {
 	u64 host_dscr;
 	u64 dec_expires;
 #endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	u64 cfar;
+#endif
 };
 
 struct kvmppc_book3s_shadow_vcpu {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ca9bf45..03d7bea 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -440,6 +440,7 @@ struct kvm_vcpu_arch {
 	ulong uamor;
 	u32 ctrl;
 	ulong dabr;
+	ulong cfar;
 #endif
 	u32 vrsave; /* also USPRG0 */
 	u32 mmucr;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index e39ca55..9a73fb0 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -475,6 +475,7 @@ int main(void)
 	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
 	DEFINE(VCPU_TRAP, offsetof(struct kvm_vcpu, arch.trap));
 	DEFINE(VCPU_PTID, offsetof(struct kvm_vcpu, arch.ptid));
+	DEFINE(VCPU_CFAR, offsetof(struct kvm_vcpu, arch.cfar));
 	DEFINE(VCORE_ENTRY_EXIT, offsetof(struct kvmppc_vcore, entry_exit_count));
 	DEFINE(VCORE_NAP_COUNT, offsetof(struct kvmppc_vcore, nap_count));
 	DEFINE(VCORE_IN_GUEST, offsetof(struct kvmppc_vcore, in_guest));
@@ -554,6 +555,10 @@ int main(void)
 	DEFINE(IPI_PRIORITY, IPI_PRIORITY);
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	HSTATE_FIELD(HSTATE_CFAR, cfar);
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
 #else /* CONFIG_PPC_BOOK3S */
 	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
 	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 10b6c35..e33d11f 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -539,6 +539,11 @@ fast_guest_return:
 
 	/* Enter guest */
 
+BEGIN_FTR_SECTION
+	ld	r5, VCPU_CFAR(r4)
+	mtspr	SPRN_CFAR, r5
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
+
 	ld	r5, VCPU_LR(r4)
 	lwz	r6, VCPU_CR(r4)
 	mtlr	r5
@@ -604,6 +609,10 @@ kvmppc_interrupt:
 	lwz	r4, HSTATE_SCRATCH1(r13)
 	std	r3, VCPU_GPR(R12)(r9)
 	stw	r4, VCPU_CR(r9)
+BEGIN_FTR_SECTION
+	ld	r3, HSTATE_CFAR(r13)
+	std	r3, VCPU_CFAR(r9)
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 
 	/* Restore R1/R2 so we can handle faults */
 	ld	r1, HSTATE_HOST_R1(r13)
-- 
1.7.10.4
