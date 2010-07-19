Return-Path: <agraf@suse.de>
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Make long relocations be ulong
Date: Mon, 19 Jul 2010 16:54:53 +0200
Message-Id: <1279551293-32473-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev@ozlabs.org, subrata@linux.vnet.ibm.com, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Book3S KVM we directly expose some asm pointers to C code as
variables. These need to be relocated and thus break on relocatable
kernels.

To make sure we can at least build, let's mark them as long instead
of u32 where 64bit relocations don't work.

This fixes the following build error:

WARNING: 2 bad relocations
> c000000000008590 R_PPC64_ADDR32    .text+0x4000000000008460
> c000000000008594 R_PPC64_ADDR32    .text+0x4000000000008598

Please keep in mind that actually using KVM on a relocated kernel
might still break. This only fixes the compile problem.

Reported-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Signed-off-by: Alexander Graf <agraf@suse.de>

---

I'm not sure which tree this should go through. Avi and Ben, please
coordinate this.
---
 arch/powerpc/include/asm/kvm_book3s.h |    4 ++--
 arch/powerpc/kvm/book3s_rmhandlers.S  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index b5b1961..b3d763d 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -131,8 +131,8 @@ extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 
-extern u32 kvmppc_trampoline_lowmem;
-extern u32 kvmppc_trampoline_enter;
+extern ulong kvmppc_trampoline_lowmem;
+extern ulong kvmppc_trampoline_enter;
 extern void kvmppc_rmcall(ulong srr0, ulong srr1);
 extern void kvmppc_load_up_fpu(void);
 extern void kvmppc_load_up_altivec(void);
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 506d5c3..20eb908 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -242,10 +242,10 @@ define_load_up(vsx)
 
 .global kvmppc_trampoline_lowmem
 kvmppc_trampoline_lowmem:
-	.long kvmppc_handler_lowmem_trampoline - CONFIG_KERNEL_START
+	PPC_LONG kvmppc_handler_lowmem_trampoline - CONFIG_KERNEL_START
 
 .global kvmppc_trampoline_enter
 kvmppc_trampoline_enter:
-	.long kvmppc_handler_trampoline_enter - CONFIG_KERNEL_START
+	PPC_LONG kvmppc_handler_trampoline_enter - CONFIG_KERNEL_START
 
 #include "book3s_segment.S"
-- 
1.6.0.2
