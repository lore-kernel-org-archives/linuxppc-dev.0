Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B1762C0154
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 00:08:42 +1100 (EST)
Received: from mail220-co9 (localhost [127.0.0.1])	by
 mail220-co9-R.bigfish.com (Postfix) with ESMTP id 8DE554C0173	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:36 +0000 (UTC)
Received: from CO9EHSMHS026.bigfish.com (unknown [10.236.132.243])	by
 mail220-co9.bigfish.com (Postfix) with ESMTP id 3C0C4380049	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:35 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 13/17] powerpc/rcpm: add struct ccsr_rcpm_v2
Date: Wed, 3 Apr 2013 21:09:21 +0800
Message-ID: <1364994565-16010-13-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chen-Hui Zhao <chenhui.zhao@freescale.com>

Add struct ccsr_rcpm_v2 to descibe the v2 RCPM register map on some SoCs,
such as T4240, etc.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/include/asm/fsl_guts.h |   66 +++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index b8a08d5..193d1f1 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -145,6 +145,72 @@ struct ccsr_rcpm {
 	__be32	cmcpmaskcr;	/* 0x00a4 - Core machine check mask control register */
 };
 
+struct ccsr_rcpm_v2 {
+	u8	res_00[12];
+	u32	tph10sr0;	/* Thread PH10 Status Register */
+	u8	res_10[12];
+	u32	tph10setr0;	/* Thread PH10 Set Control Register */
+	u8	res_20[12];
+	u32	tph10clrr0;	/* Thread PH10 Clear Control Register */
+	u8	res_30[12];
+	u32	tph10psr0;	/* Thread PH10 Previous Status Register */
+	u8	res_40[12];
+	u32	twaitsr0;	/* Thread Wait Status Register */
+	u8	res_50[96];
+	u32	pcph15sr;	/* Physical Core PH15 Status Register */
+	u32	pcph15setr;	/* Physical Core PH15 Set Control Register */
+	u32	pcph15clrr;	/* Physical Core PH15 Clear Control Register */
+	u32	pcph15psr;	/* Physical Core PH15 Prev Status Register */
+	u8	res_c0[16];
+	u32	pcph20sr;	/* Physical Core PH20 Status Register */
+	u32	pcph20setr;	/* Physical Core PH20 Set Control Register */
+	u32	pcph20clrr;	/* Physical Core PH20 Clear Control Register */
+	u32	pcph20psr;	/* Physical Core PH20 Prev Status Register */
+	u32	pcpw20sr;	/* Physical Core PW20 Status Register */
+	u8	res_e0[12];
+	u32	pcph30sr;	/* Physical Core PH30 Status Register */
+	u32	pcph30setr;	/* Physical Core PH30 Set Control Register */
+	u32	pcph30clrr;	/* Physical Core PH30 Clear Control Register */
+	u32	pcph30psr;	/* Physical Core PH30 Prev Status Register */
+	u8	res_100[32];
+	u32	ippwrgatecr;	/* IP Power Gating Control Register */
+	u8	res_124[12];
+	u32	powmgtcsr;	/* Power Management Control & Status Reg */
+#define RCPM_POWMGTCSR_LPM20_RQ		0x00100000
+#define RCPM_POWMGTCSR_LPM20_ST		0x00000200
+#define RCPM_POWMGTCSR_P_LPM20_ST	0x00000100
+	u8	res_134[12];
+	u32	ippdexpcr[4];	/* IP Powerdown Exception Control Reg */
+	u8	res_150[12];
+	u32	tpmimr0;	/* Thread PM Interrupt Mask Reg */
+	u8	res_160[12];
+	u32	tpmcimr0;	/* Thread PM Crit Interrupt Mask Reg */
+	u8	res_170[12];
+	u32	tpmmcmr0;	/* Thread PM Machine Check Interrupt Mask Reg */
+	u8	res_180[12];
+	u32	tpmnmimr0;	/* Thread PM NMI Mask Reg */
+	u8	res_190[12];
+	u32	tmcpmaskcr0;	/* Thread Machine Check Mask Control Reg */
+	u32	pctbenr;	/* Physical Core Time Base Enable Reg */
+	u32	pctbclkselr;	/* Physical Core Time Base Clock Select */
+	u32	tbclkdivr;	/* Time Base Clock Divider Register */
+	u8	res_1ac[4];
+	u32	ttbhltcr[4];	/* Thread Time Base Halt Control Register */
+	u32	clpcl10sr;	/* Cluster PCL10 Status Register */
+	u32	clpcl10setr;	/* Cluster PCL30 Set Control Register */
+	u32	clpcl10clrr;	/* Cluster PCL30 Clear Control Register */
+	u32	clpcl10psr;	/* Cluster PCL30 Prev Status Register */
+	u32	cddslpsetr;	/* Core Domain Deep Sleep Set Register */
+	u32	cddslpclrr;	/* Core Domain Deep Sleep Clear Register */
+	u32	cdpwroksetr;	/* Core Domain Power OK Set Register */
+	u32	cdpwrokclrr;	/* Core Domain Power OK Clear Register */
+	u32	cdpwrensr;	/* Core Domain Power Enable Status Register */
+	u32	cddslsr;	/* Core Domain Deep Sleep Status Register */
+	u8	res_1e8[8];
+	u32	dslpcntcr[8];	/* Deep Sleep Counter Cfg Register */
+	u8	res_300[3568];
+};
+
 #ifdef CONFIG_PPC_86xx
 
 #define CCSR_GUTS_DMACR_DEV_SSI	0	/* DMA controller/channel set to SSI */
-- 
1.7.3
