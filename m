Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPjz52r1zDr2m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:47:19 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id c11-v6so12517548plr.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:47:19 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 02/29] powerpc: add TEXASR related macros
Date: Wed, 23 May 2018 15:01:45 +0800
Message-Id: <1527058932-7434-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patches add some macros for CR0/TEXASR bits so that PR KVM TM
logic(tbegin./treclaim./tabort.) can make use of them later.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/reg.h              | 32 +++++++++++++++++++++++------
 arch/powerpc/platforms/powernv/copy-paste.h |  3 +--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 44b2be4..5625684 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -146,6 +146,12 @@
 #define MSR_64BIT	0
 #endif
 
+/* Condition Register related */
+#define CR0_SHIFT	28
+#define CR0_MASK	0xF
+#define CR0_TBEGIN_FAILURE	(0x2 << 28) /* 0b0010 */
+
+
 /* Power Management - Processor Stop Status and Control Register Fields */
 #define PSSCR_RL_MASK		0x0000000F /* Requested Level */
 #define PSSCR_MTL_MASK		0x000000F0 /* Maximum Transition Level */
@@ -239,13 +245,27 @@
 #define SPRN_TFIAR	0x81	/* Transaction Failure Inst Addr   */
 #define SPRN_TEXASR	0x82	/* Transaction EXception & Summary */
 #define SPRN_TEXASRU	0x83	/* ''	   ''	   ''	 Upper 32  */
-#define   TEXASR_ABORT	__MASK(63-31) /* terminated by tabort or treclaim */
-#define   TEXASR_SUSP	__MASK(63-32) /* tx failed in suspended state */
-#define   TEXASR_HV	__MASK(63-34) /* MSR[HV] when failure occurred */
-#define   TEXASR_PR	__MASK(63-35) /* MSR[PR] when failure occurred */
-#define   TEXASR_FS	__MASK(63-36) /* TEXASR Failure Summary */
-#define   TEXASR_EXACT	__MASK(63-37) /* TFIAR value is exact */
+
+#define TEXASR_FC_LG	(63 - 7)	/* Failure Code */
+#define TEXASR_AB_LG	(63 - 31)	/* Abort */
+#define TEXASR_SU_LG	(63 - 32)	/* Suspend */
+#define TEXASR_HV_LG	(63 - 34)	/* Hypervisor state*/
+#define TEXASR_PR_LG	(63 - 35)	/* Privilege level */
+#define TEXASR_FS_LG	(63 - 36)	/* failure summary */
+#define TEXASR_EX_LG	(63 - 37)	/* TFIAR exact bit */
+#define TEXASR_ROT_LG	(63 - 38)	/* ROT bit */
+
+#define   TEXASR_ABORT	__MASK(TEXASR_AB_LG) /* terminated by tabort or treclaim */
+#define   TEXASR_SUSP	__MASK(TEXASR_SU_LG) /* tx failed in suspended state */
+#define   TEXASR_HV	__MASK(TEXASR_HV_LG) /* MSR[HV] when failure occurred */
+#define   TEXASR_PR	__MASK(TEXASR_PR_LG) /* MSR[PR] when failure occurred */
+#define   TEXASR_FS	__MASK(TEXASR_FS_LG) /* TEXASR Failure Summary */
+#define   TEXASR_EXACT	__MASK(TEXASR_EX_LG) /* TFIAR value is exact */
+#define   TEXASR_ROT	__MASK(TEXASR_ROT_LG)
+#define   TEXASR_FC	(ASM_CONST(0xFF) << TEXASR_FC_LG)
+
 #define SPRN_TFHAR	0x80	/* Transaction Failure Handler Addr */
+
 #define SPRN_TIDR	144	/* Thread ID register */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
index c9a5036..3fa62de 100644
--- a/arch/powerpc/platforms/powernv/copy-paste.h
+++ b/arch/powerpc/platforms/powernv/copy-paste.h
@@ -7,9 +7,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <asm/ppc-opcode.h>
+#include <asm/reg.h>
 
-#define CR0_SHIFT	28
-#define CR0_MASK	0xF
 /*
  * Copy/paste instructions:
  *
-- 
1.8.3.1
