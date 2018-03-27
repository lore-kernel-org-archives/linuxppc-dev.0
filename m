Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409JCK34S4zF27r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:37:33 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 david@gibson.dropbear.id.au, npiggin@gmail.com,
 pedromfc@linux.vnet.ibm.com, kvm-ppc@vger.kernel.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH v3 5/8] KVM: PPC: Book3S HV: Return error from h_set_dabr() on
 POWER9
Date: Tue, 27 Mar 2018 15:37:21 +1100
Message-Id: <20180327043724.13862-6-mikey@neuling.org>
In-Reply-To: <20180327043724.13862-1-mikey@neuling.org>
References: <20180327043724.13862-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER7 compat mode guests can use h_set_dabr on POWER9. POWER9 should
use the DAWR but since it's disabled there we can't.

This returns H_UNSUPPORTED on a h_set_dabr() on POWER9 where the DAWR
is disabled.

Current Linux guests ignore this error, so they will silently not get
the DAWR (sigh). The same error code is being used by POWERVM in this
case.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hvcall.h       | 1 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index eca3f9c689..e87d465af4 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -88,6 +88,7 @@
 #define H_P8		-61
 #define H_P9		-62
 #define H_TOO_BIG	-64
+#define H_UNSUPPORTED	-67
 #define H_OVERLAP	-68
 #define H_INTERRUPT	-69
 #define H_BAD_DATA	-70
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f31f357b8c..13e23a5275 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2506,8 +2506,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	li	r3,0
 	blr
 
+2:
+BEGIN_FTR_SECTION
+	/* POWER9 with disabled DAWR */
+	li	r3, H_UNSUPPORTED
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_DAWR)
 	/* Emulate H_SET_DABR/X on P8 for the sake of compat mode guests */
-2:	rlwimi	r5, r4, 5, DAWRX_DR | DAWRX_DW
+	rlwimi	r5, r4, 5, DAWRX_DR | DAWRX_DW
 	rlwimi	r5, r4, 2, DAWRX_WT
 	clrrdi	r4, r4, 3
 	std	r4, VCPU_DAWR(r3)
-- 
2.14.1
