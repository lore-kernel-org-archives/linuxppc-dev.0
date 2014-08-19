Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5326F1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 14:59:32 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] KVM: PPC: Book3S HV: Cleanup kvmppc_load/save_fp
Date: Tue, 19 Aug 2014 14:59:29 +1000
Message-Id: <1408424370-16960-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This cleans up kvmppc_load/save_fp.  It removes unnecessary isyncs.  It also
removes the unnecessary resetting of the MSR bits on exit of kvmppc_save_fp.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f0c4db7..c4bd2d7 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2434,7 +2434,6 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
 	mtmsrd	r8
-	isync
 	addi	r3,r3,VCPU_FPRS
 	bl	store_fp_state
 #ifdef CONFIG_ALTIVEC
@@ -2470,7 +2469,6 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
 	mtmsrd	r8
-	isync
 	addi	r3,r4,VCPU_FPRS
 	bl	load_fp_state
 #ifdef CONFIG_ALTIVEC
-- 
1.9.1
