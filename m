Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1EC622C02AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 21:16:17 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/512x: add function for chip select parameter
 configuration
Date: Mon,  4 Feb 2013 11:16:02 +0100
Message-Id: <1359972962-9379-1-git-send-email-agust@denx.de>
In-Reply-To: <1359725305-23916-1-git-send-email-agust@denx.de>
References: <1359725305-23916-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add ability to configure chip select (CS) parameters for devices
that need different CS parameters setup after their configuration.
I.e. an FPGA device on LP bus can require different CS parameters
for its bus interface after loading firmware into it. A driver
can easily reconfigure the LPC CS parameters using this function.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v2:
 - define CS in commit log
 - use unsigned int type for cs argument to simplify
   valid CS range check
 - use EXPORT_SYMBOL

 arch/powerpc/include/asm/mpc5121.h           |   16 +++++++++++++
 arch/powerpc/platforms/512x/mpc512x_shared.c |   30 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc5121.h b/arch/powerpc/include/asm/mpc5121.h
index 8c0ab2c..8ae133e 100644
--- a/arch/powerpc/include/asm/mpc5121.h
+++ b/arch/powerpc/include/asm/mpc5121.h
@@ -53,4 +53,20 @@ struct mpc512x_ccm {
 	u32	m4ccr;	/* MSCAN4 CCR */
 	u8	res[0x98]; /* Reserved */
 };
+
+/*
+ * LPC Module
+ */
+struct mpc512x_lpc {
+	u32	cs_cfg[8];	/* CS config */
+	u32	cs_ctrl;	/* CS Control Register */
+	u32	cs_status;	/* CS Status Register */
+	u32	burst_ctrl;	/* CS Burst Control Register */
+	u32	deadcycle_ctrl;	/* CS Deadcycle Control Register */
+	u32	holdcycle_ctrl;	/* CS Holdcycle Control Register */
+	u32	alt;		/* Address Latch Timing Register */
+};
+
+int mpc512x_cs_config(unsigned int cs, u32 val);
+
 #endif /* __ASM_POWERPC_MPC5121_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 39d5630..8e2bde9 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -456,3 +456,33 @@ void __init mpc512x_init(void)
 	mpc512x_restart_init();
 	mpc512x_psc_fifo_init();
 }
+
+/**
+ * mpc512x_cs_config - Setup chip select configuration
+ * @cs: chip select number
+ * @val: chip select configuration value
+ *
+ * Perform chip select configuration for devices on LocalPlus Bus.
+ * Intended to dynamically reconfigure the chip select parameters
+ * for configurable devices on the bus.
+ */
+int mpc512x_cs_config(unsigned int cs, u32 val)
+{
+	static struct mpc512x_lpc __iomem *lpc;
+	struct device_node *np;
+
+	if (cs > 7)
+		return -EINVAL;
+
+	if (!lpc) {
+		np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-lpc");
+		lpc = of_iomap(np, 0);
+		of_node_put(np);
+		if (!lpc)
+			return -ENOMEM;
+	}
+
+	out_be32(&lpc->cs_cfg[cs], val);
+	return 0;
+}
+EXPORT_SYMBOL(mpc512x_cs_config);
-- 
1.7.5.4
