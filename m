Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 8E0ADDDE05
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 08:04:24 +1000 (EST)
Date: Tue, 31 Jul 2007 15:07:49 -0700
From: Dave Jiang <djiang@mvista.com>
To: galak@kernel.crashing.org
Subject: [PATCH v2 2/3] powerpc: create pci err platform device for EDAC on
	mpc85xx
Message-ID: <20070731220749.GB29780@blade.az.mvista.com>
References: <20070726222021.GA10427@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20070726222021.GA10427@blade.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Creating a platform device for the PCI error registers in order for the
mpc85xx EDAC driver to pick up proper resources. This is to prevent the EDAC
driver from monopolizing the of_device and thus preventing future PCI code from
using the PCI of_device(s).

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

 fsl_soc.c |   29 +++++++++++++++++++++++++++++
  1 file changed, 29 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 727453d..fff7c91 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1186,3 +1186,32 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+#ifdef CONFIG_85xx
+
+/* setting up 85xx PCI error platform device for EDAC consumption */
+static int __init mpc85xx_pcierr_setup(void)
+{
+	struct device_node *np = NULL;
+	int id = 0;
+	struct resource res[2];
+
+	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci") {
+		memset(res, 0, sizeof(struct resource) * 2);
+		if (of_address_to_resource(np, 0, &res[0])) {
+			printk(KERN_WARNING "Can't get pci register base!\n");
+			continue;
+		}
+
+		/* move start to where the error registers are */
+		res[0].start += 0xe00;
+
+		of_irq_to_resource(np, 0, &res[1]);
+		platform_device_register_simple("mpc85xx_pci_err", id, res, 2);
+		id++;
+	}
+	return 0;
+}
+arch_initcall(mpc85xx_pcierr_setup);
+
+#endif
