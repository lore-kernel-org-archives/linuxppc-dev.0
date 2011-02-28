Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C0647B7128
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Mar 2011 07:52:18 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] RapidIO: Modify mport ID assignment
Date: Mon, 28 Feb 2011 15:51:04 -0500
Message-Id: <1298926265-5381-5-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1298926265-5381-1-git-send-email-alexandre.bounine@idt.com>
References: <1298926265-5381-1-git-send-email-alexandre.bounine@idt.com>
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

Changes mport ID and host destination ID assignment to implement unified
method common to all mport drivers. Makes "riohdid=" kernel command line
parameter common for all architectures with support for more that one
host destination ID assignment.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
---
 arch/powerpc/sysdev/fsl_rio.c |   25 -------------------------
 drivers/rapidio/rio.c         |   26 ++++++++++++++++++++++++++
 include/linux/rio.h           |    1 +
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 6995907..7d35a12 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1288,28 +1288,6 @@ err_out:
 	return rc;
 }
 
-static char *cmdline = NULL;
-
-static int fsl_rio_get_hdid(int index)
-{
-	/* XXX Need to parse multiple entries in some format */
-	if (!cmdline)
-		return -1;
-
-	return simple_strtol(cmdline, NULL, 0);
-}
-
-static int fsl_rio_get_cmdline(char *s)
-{
-	if (!s)
-		return 0;
-
-	cmdline = s;
-	return 1;
-}
-
-__setup("riohdid=", fsl_rio_get_cmdline);
-
 static inline void fsl_rio_info(struct device *dev, u32 ccsr)
 {
 	const char *str;
@@ -1439,7 +1417,6 @@ int fsl_rio_setup(struct platform_device *dev)
 		rc = -ENOMEM;
 		goto err_port;
 	}
-	port->id = 0;
 	port->index = 0;
 
 	priv = kzalloc(sizeof(struct rio_priv), GFP_KERNEL);
@@ -1470,8 +1447,6 @@ int fsl_rio_setup(struct platform_device *dev)
 	priv->dev = &dev->dev;
 
 	port->ops = ops;
-	port->host_deviceid = fsl_rio_get_hdid(port->id);
-
 	port->priv = priv;
 	port->phys_efptr = 0x100;
 	rio_register_mport(port);
diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index f861b72..9a7b216 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -32,6 +32,7 @@
 #include "rio.h"
 
 static LIST_HEAD(rio_mports);
+static unsigned char next_portid;
 
 /**
  * rio_local_get_device_id - Get the base/extended device id for a port
@@ -1164,8 +1165,33 @@ int __devinit rio_init_mports(void)
 
 device_initcall_sync(rio_init_mports);
 
+static int hdids[RIO_MAX_MPORTS + 1];
+
+static int rio_get_hdid(int index)
+{
+	if (!hdids[0] || hdids[0] <= index || index >= RIO_MAX_MPORTS)
+		return -1;
+
+	return hdids[index + 1];
+}
+
+static int rio_hdid_setup(char *str)
+{
+	(void)get_options(str, ARRAY_SIZE(hdids), hdids);
+	return 1;
+}
+
+__setup("riohdid=", rio_hdid_setup);
+
 void rio_register_mport(struct rio_mport *port)
 {
+	if (next_portid >= RIO_MAX_MPORTS) {
+		pr_err("RIO: reached specified max number of mports\n");
+		return;
+	}
+
+	port->id = next_portid++;
+	port->host_deviceid = rio_get_hdid(port->id);
 	list_add_tail(&port->node, &rio_mports);
 }
 
diff --git a/include/linux/rio.h b/include/linux/rio.h
index b6bcb16..4e37a7c 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -24,6 +24,7 @@
 #define RIO_NO_HOPCOUNT		-1
 #define RIO_INVALID_DESTID	0xffff
 
+#define RIO_MAX_MPORTS		8
 #define RIO_MAX_MPORT_RESOURCES	16
 #define RIO_MAX_DEV_RESOURCES	16
 
-- 
1.7.3.1
