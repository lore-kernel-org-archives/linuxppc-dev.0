Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A1A61008EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 23:04:28 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 6/7] KVM: PPC: Make long relocations be ulong
Date: Thu, 29 Jul 2010 15:04:21 +0200
Message-Id: <1280408662-10328-7-git-send-email-agraf@suse.de>
In-Reply-To: <1280408662-10328-1-git-send-email-agraf@suse.de>
References: <1280408662-10328-1-git-send-email-agraf@suse.de>
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

On Book3S KVM we directly expose some asm pointers to C code as
variables. These need to be relocated and thus break on relocatable
kernels.

To make sure we can at least build, let's mark them as long instead
of u32 where 64bit relocations don't work.

This fixes the following build error:

WARNING: 2 bad relocations^M
> c000000000008590 R_PPC64_ADDR32    .text+0x4000000000008460^M
> c000000000008594 R_PPC64_ADDR32    .text+0x4000000000008598^M

Please keep in mind that actually using KVM on a relocated kernel
might still break. This only fixes the compile problem.

Reported-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |    4 ++--
 arch/powerpc/kvm/book3s_rmhandlers.S  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 00cf8b0..f04f516 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -132,8 +132,8 @@ extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
-extern u32 kvmppc_trampoline_lowmem;
-extern u32 kvmppc_trampoline_enter;
+extern ulong kvmppc_trampoline_lowmem;
+extern ulong kvmppc_trampoline_enter;
 extern void kvmppc_rmcall(ulong srr0, ulong srr1);
 extern void kvmppc_load_up_fpu(void);
 extern void kvmppc_load_up_altivec(void);
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 229d3d6..2b9c908 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -252,10 +252,10 @@ define_load_up(vsx)
 
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
