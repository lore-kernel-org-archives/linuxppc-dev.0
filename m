Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A3F12C0295
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 00:28:34 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3YyJzZ4Mdlz3hjkH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 14:28:25 +0100 (CET)
Received: from localhost (pD9E2F39A.dip.t-dialin.net [217.226.243.154])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3YyJzY37JszbdHQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 14:28:25 +0100 (CET)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/512x: add function for CS parameter configuration
Date: Fri,  1 Feb 2013 14:28:25 +0100
Message-Id: <1359725305-23916-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add ability to configure CS parameters for devices that need
different CS parameters setup after their configuration. I.e.
an FPGA device on LP bus can require different CS parameters
for its bus interface after loading firmware into it. A driver
can easily reconfigure the LPC CS parameters using this function.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/include/asm/mpc5121.h           |   16 +++++++++++++
 arch/powerpc/platforms/512x/mpc512x_shared.c |   30 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc5121.h b/arch/powerpc/include/asm/mpc5121.h
index 8c0ab2c..738ebca 100644
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
+int mpc512x_cs_config(int cs, u32 val);
+
 #endif /* __ASM_POWERPC_MPC5121_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index c344438..112b4f6 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -436,3 +436,33 @@ void __init mpc512x_init(void)
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
+int mpc512x_cs_config(int cs, u32 val)
+{
+	static struct mpc512x_lpc __iomem *lpc;
+	struct device_node *np;
+
+	if (cs < 0 || cs > 7)
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
+EXPORT_SYMBOL_GPL(mpc512x_cs_config);
-- 
1.7.5.4
