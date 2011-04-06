Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 09477B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 03:16:30 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] RapidIO/mpc85xx: Fix possible mport registration problems.
Date: Wed,  6 Apr 2011 13:16:00 -0400
Message-Id: <1302110160-13763-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix possible problem with mport registration left non cleared after
fsl_rio_setup() exits on link error. Abort mport initialization
if registration failed.

This patch is applicable to 2.6.39-rc1 only. The problem does not exists
for earlier versions.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Thomas Moll <thomas.moll@sysgo.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    4 +++-
 drivers/rapidio/rio.c         |    5 +++--
 include/linux/rio.h           |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 14232d5..4979853 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1457,7 +1457,6 @@ int fsl_rio_setup(struct platform_device *dev)
 	port->ops = ops;
 	port->priv = priv;
 	port->phys_efptr = 0x100;
-	rio_register_mport(port);
 
 	priv->regs_win = ioremap(regs.start, regs.end - regs.start + 1);
 	rio_regs_win = priv->regs_win;
@@ -1504,6 +1503,9 @@ int fsl_rio_setup(struct platform_device *dev)
 	dev_info(&dev->dev, "RapidIO Common Transport System size: %d\n",
 			port->sys_size ? 65536 : 256);
 
+	if (rio_register_mport(port))
+		goto err;
+
 	if (port->host_deviceid >= 0)
 		out_be32(priv->regs_win + RIO_GCCSR, RIO_PORT_GEN_HOST |
 			RIO_PORT_GEN_MASTER | RIO_PORT_GEN_DISCOVERED);
diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index c29719c..86c9a09 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -1171,16 +1171,17 @@ static int rio_hdid_setup(char *str)
 
 __setup("riohdid=", rio_hdid_setup);
 
-void rio_register_mport(struct rio_mport *port)
+int rio_register_mport(struct rio_mport *port)
 {
 	if (next_portid >= RIO_MAX_MPORTS) {
 		pr_err("RIO: reached specified max number of mports\n");
-		return;
+		return 1;
 	}
 
 	port->id = next_portid++;
 	port->host_deviceid = rio_get_hdid(port->id);
 	list_add_tail(&port->node, &rio_mports);
+	return 0;
 }
 
 EXPORT_SYMBOL_GPL(rio_local_get_device_id);
diff --git a/include/linux/rio.h b/include/linux/rio.h
index 4e37a7c..4d50611 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -396,7 +396,7 @@ union rio_pw_msg {
 };
 
 /* Architecture and hardware-specific functions */
-extern void rio_register_mport(struct rio_mport *);
+extern int rio_register_mport(struct rio_mport *);
 extern int rio_open_inb_mbox(struct rio_mport *, void *, int, int);
 extern void rio_close_inb_mbox(struct rio_mport *, int);
 extern int rio_open_outb_mbox(struct rio_mport *, void *, int, int);
-- 
1.7.3.1
