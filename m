Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 5A22667A80
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 05:13:54 +1100 (EST)
Message-ID: <41F7DDDC.8090304@mvista.com>
Date: Wed, 26 Jan 2005 11:13:48 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------060409030604030106020005"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] cpci690 update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------060409030604030106020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch updates the cpci690 platform file.  The platform file now 
uses the platform_notify hook to update platform_data.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------060409030604030106020005
Content-Type: text/plain;
 name="cpci690.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpci690.patch"

diff -Nru a/arch/ppc/platforms/cpci690.c b/arch/ppc/platforms/cpci690.c
--- a/arch/ppc/platforms/cpci690.c	2005-01-26 11:11:50 -07:00
+++ b/arch/ppc/platforms/cpci690.c	2005-01-26 11:11:50 -07:00
@@ -289,35 +289,6 @@
 	return;
 }
 
-static int __init
-cpci690_fixup_pd(void)
-{
-#if defined(CONFIG_SERIAL_MPSC)
-	struct list_head	*entry;
-	struct platform_device	*pd;
-	struct device		*dev;
-	struct mpsc_pd_dd	*dd;
-
-	list_for_each(entry, &platform_bus_type.devices.list) {
-		dev = container_of(entry, struct device, bus_list);
-		pd = container_of(dev, struct platform_device, dev);
-
-		if (!strncmp(pd->name, MPSC_CTLR_NAME, BUS_ID_SIZE)) {
-			dd = (struct mpsc_pd_dd *) dev_get_drvdata(&pd->dev);
-
-			dd->max_idle = 40;
-			dd->default_baud = 9600;
-			dd->brg_clk_src = 8;
-			dd->brg_clk_freq = 133000000;
-		}
-	}
-#endif
-
-	return 0;
-}
-
-subsys_initcall(cpci690_fixup_pd);
-
 static void __init
 cpci690_setup_arch(void)
 {
@@ -359,6 +330,50 @@
 	return;
 }
 
+/* Platform device data fixup routines. */
+#if defined(CONFIG_SERIAL_MPSC)
+static void __init
+cpci690_fixup_mpsc_pdata(struct platform_device *pdev)
+{
+	struct mpsc_pdata *pdata;
+
+	pdata = (struct mpsc_pdata *)pdev->dev.platform_data;
+
+	pdata->max_idle = 40;
+	pdata->default_baud = 9600;
+	pdata->brg_clk_src = 8;
+	pdata->brg_clk_freq = 133000000;
+
+	return;
+}
+
+static int __init
+cpci690_platform_notify(struct device *dev)
+{
+	static struct {
+		char	*bus_id;
+		void	((*rtn)(struct platform_device *pdev));
+	} dev_map[] = {
+		{ MPSC_CTLR_NAME "0", cpci690_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME "1", cpci690_fixup_mpsc_pdata },
+	};
+	struct platform_device	*pdev;
+	int	i;
+
+	if (dev && dev->bus_id)
+		for (i=0; i<ARRAY_SIZE(dev_map); i++)
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id,
+				BUS_ID_SIZE)) {
+
+				pdev = container_of(dev,
+					struct platform_device, dev);
+				dev_map[i].rtn(pdev);
+			}
+
+	return 0;
+}
+#endif
+
 static void
 cpci690_reset_board(void)
 {
@@ -488,6 +503,10 @@
 	ppc_md.setup_io_mappings = cpci690_map_io;
 	ppc_md.early_serial_map = cpci690_early_serial_map;
 #endif	/* CONFIG_KGDB */
+
+#if defined(CONFIG_SERIAL_MPSC)
+	platform_notify = cpci690_platform_notify;
+#endif
 
 	return;
 }

--------------060409030604030106020005--
