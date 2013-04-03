Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B069C2C0214
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 00:08:36 +1100 (EST)
Received: from mail114-co9 (localhost [127.0.0.1])	by
 mail114-co9-R.bigfish.com (Postfix) with ESMTP id 3357D240349	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:31 +0000 (UTC)
Received: from CO9EHSMHS003.bigfish.com (unknown [10.236.132.244])	by
 mail114-co9.bigfish.com (Postfix) with ESMTP id 48C1820005C	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:29 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 09/17] powerpc/85xx: add time base sync for SoCs based on
 e500mc/e5500
Date: Wed, 3 Apr 2013 21:09:17 +0800
Message-ID: <1364994565-16010-9-git-send-email-chenhui.zhao@freescale.com>
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

In the case of SMP, during the time base sync period, all time bases of
online cores must stop, then start simultaneously.

There is a RCPM (Run Control/Power Management) module in CoreNet based SoCs.
Define a struct ccsr_rcpm to describe the register map.

This patch supports SoCs based on e500mc/e5500, such as P4080, P5020,
etc.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/fsl_guts.h |   38 +++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/smp.c   |   32 +++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index 77ced0b..4eac1cf 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -106,6 +106,44 @@ struct ccsr_guts {
 /* Alternate function signal multiplex control */
 #define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
 
+struct ccsr_rcpm {
+	u8	res0000[4];
+	__be32	cdozsr;		/* 0x0004 - Core Doze Status Register */
+	u8	res0008[4];
+	__be32	cdozcr;		/* 0x000c - Core Doze Control Register */
+	u8	res0010[4];
+	__be32	cnapsr;		/* 0x0014 - Core Nap Status Register */
+	u8	res0018[4];
+	__be32	cnapcr;		/* 0x001c - Core Nap Control Register */
+	u8	res0020[4];
+	__be32	cdozpsr;	/* 0x0024 - Core Doze Previous Status Register */
+	u8	res0028[4];
+	__be32	cnappsr;	/* 0x002c - Core Nap Previous Status Register */
+	u8	res0030[4];
+	__be32	cwaitsr;	/* 0x0034 - Core Wait Status Register */
+	u8	res0038[4];
+	__be32	cwdtdsr;	/* 0x003c - Core watchdog detect status register */
+	__be32	powmgtcsr;	/* 0x0040 - Power Mangement Control & Status Register */
+	u8	res0044[12];
+	__be32	ippdexpcr;	/* 0x0050 - IP Powerdown Exception Control Register */
+	u8	res0054[16];
+	__be32	cpmimr;		/* 0x0064 - Core PM IRQ Mask Register */
+	u8	res0068[4];
+	__be32	cpmcimr;	/* 0x006c - Core PM Critical IRQ Mask Register */
+	u8	res0070[4];
+	__be32	cpmmcmr;	/* 0x0074 - Core PM Machine Check Mask Register */
+	u8	res0078[4];
+	__be32	cpmnmimr;	/* 0x007c - Core PM NMI Mask Register */
+	u8	res0080[4];
+	__be32	ctbenr;		/* 0x0084 - Core Time Base Enable Register */
+	u8	res0088[4];
+	__be32	ctbckselr;	/* 0x008c - Core Time Base Clock Select Register */
+	u8	res0090[4];
+	__be32	ctbhltcr;	/* 0x0094 - Core Time Base Halt Control Register */
+	u8	res0098[4];
+	__be32	cmcpmaskcr;	/* 0x00a4 - Core machine check mask control register */
+};
+
 #ifdef CONFIG_PPC_86xx
 
 #define CCSR_GUTS_DMACR_DEV_SSI	0	/* DMA controller/channel set to SSI */
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 35dae8e..3de85a4 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -44,7 +44,36 @@ static struct ccsr_guts __iomem *guts;
 static u64 timebase;
 static int tb_req;
 static int tb_valid;
+static u32 cur_booting_core;
 
+#ifdef CONFIG_PPC_E500MC
+/* get a physical mask of online cores and booting core */
+static inline u32 get_phy_cpu_mask(void)
+{
+	u32 mask;
+	int cpu;
+
+	mask = 1 << cur_booting_core;
+	for_each_online_cpu(cpu)
+		mask |= 1 << get_hard_smp_processor_id(cpu);
+
+	return mask;
+}
+
+static void mpc85xx_timebase_freeze(int freeze)
+{
+	struct ccsr_rcpm __iomem *rcpm = (typeof(rcpm))guts;
+	u32 mask = get_phy_cpu_mask();
+
+	if (freeze)
+		clrbits32(&rcpm->ctbenr, mask);
+	else
+		setbits32(&rcpm->ctbenr, mask);
+
+	/* read back to push the previos write */
+	in_be32(&rcpm->ctbenr);
+}
+#else
 static void mpc85xx_timebase_freeze(int freeze)
 {
 	uint32_t mask;
@@ -57,6 +86,7 @@ static void mpc85xx_timebase_freeze(int freeze)
 
 	in_be32(&guts->devdisr);
 }
+#endif
 
 static void mpc85xx_give_timebase(void)
 {
@@ -252,6 +282,7 @@ out:
 	  __pa((u64)*((unsigned long long *)generic_secondary_smp_init)));
 	flush_spin_table(spin_table);
 #endif
+	cur_booting_core = hw_cpu;
 
 	local_irq_restore(flags);
 
@@ -386,6 +417,7 @@ static const struct of_device_id mpc85xx_smp_guts_ids[] = {
 	{ .compatible = "fsl,p1022-guts", },
 	{ .compatible = "fsl,p1023-guts", },
 	{ .compatible = "fsl,p2020-guts", },
+	{ .compatible = "fsl,qoriq-rcpm-1.0", },
 	{},
 };
 
-- 
1.7.3
