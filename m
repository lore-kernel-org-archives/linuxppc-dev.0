Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 08 May 2007 12:58:35 +1000
Subject: [PATCH 4/7] Tell Phyp we support MSI
In-Reply-To: <1178593113.675058.404575641543.qpush@cradle>
Message-Id: <20070508025840.DF3F2DDF56@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tell Phyp we support MSI via the client architecture support mechanism.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

---

 arch/powerpc/kernel/prom_init.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: msi-new/arch/powerpc/kernel/prom_init.c
===================================================================
--- msi-new.orig/arch/powerpc/kernel/prom_init.c
+++ msi-new/arch/powerpc/kernel/prom_init.c
@@ -635,6 +635,12 @@ static void __init early_cmdline_parse(v
 /* ibm,dynamic-reconfiguration-memory property supported */
 #define OV5_DRCONF_MEMORY	0x20
 #define OV5_LARGE_PAGES		0x10	/* large pages supported */
+/* PCIe/MSI support.  Without MSI full PCIe is not supported */
+#ifdef CONFIG_PCI_MSI
+#define OV5_MSI			0x01	/* PCIe/MSI support */
+#else
+#define OV5_MSI			0x00
+#endif /* CONFIG_PCI_MSI */
 
 /*
  * The architecture vector has an array of PVR mask/value pairs,
@@ -679,7 +685,7 @@ static unsigned char ibm_architecture_ve
 	/* option vector 5: PAPR/OF options */
 	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY,
+	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY | OV5_MSI,
 };
 
 /* Old method - ELF header with PT_NOTE sections */
