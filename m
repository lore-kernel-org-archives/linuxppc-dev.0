Return-Path: <B40534@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BD9F62C025E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 20:29:29 +1100 (EST)
Received: from mail81-db9 (localhost [127.0.0.1])	by mail81-db9-R.bigfish.com
 (Postfix) with ESMTP id 326313A0275	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 15 Oct 2013 09:29:17 +0000 (UTC)
Received: from DB9EHSMHS028.bigfish.com (unknown [10.174.16.231])	by
 mail81-db9.bigfish.com (Postfix) with ESMTP id 0A5E218008F	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 09:29:14 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v5 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0 define
Date: Tue, 15 Oct 2013 17:21:08 +0800
Message-ID: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: bharat.bhushan@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

E6500 PVR and SPRN_PWRMGTCR0 will be used in subsequent pw20/altivec
idle patches.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
*v3:
Add bit definitions for PWRMGTCR0.

 arch/powerpc/include/asm/reg.h       | 2 ++
 arch/powerpc/include/asm/reg_booke.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 64264bf..d4160ca 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1053,6 +1053,8 @@
 #define PVR_8560	0x80200000
 #define PVR_VER_E500V1	0x8020
 #define PVR_VER_E500V2	0x8021
+#define PVR_VER_E6500	0x8040
+
 /*
  * For the 8xx processors, all of them report the same PVR family for
  * the PowerPC core. The various versions of these processors must be
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index ed8f836..4a6457e 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -170,6 +170,7 @@
 #define SPRN_L2CSR1	0x3FA	/* L2 Data Cache Control and Status Register 1 */
 #define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
 #define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register */
+#define SPRN_PWRMGTCR0	0x3FB	/* Power management control register 0 */
 #define SPRN_SVR	0x3FF	/* System Version Register */
 
 /*
@@ -216,6 +217,14 @@
 #define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity checking */
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
+/* Bit definitions for PWRMGTCR0. */
+#define PWRMGTCR0_PW20_WAIT		(1 << 14) /* PW20 state enable bit */
+#define PWRMGTCR0_PW20_ENT_SHIFT	8
+#define PWRMGTCR0_PW20_ENT		0x3F00
+#define PWRMGTCR0_AV_IDLE_PD_EN		(1 << 22) /* Altivec idle enable */
+#define PWRMGTCR0_AV_IDLE_CNT_SHIFT	16
+#define PWRMGTCR0_AV_IDLE_CNT		0x3F0000
+
 /* Bit definitions for the MCSR. */
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
 #define MCSR_IB		0x40000000 /* Instruction PLB Error */
-- 
1.8.0
