Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 18 Aug 2006 18:13:28 +1000
Subject: [RFC/PATCH 1/4] Add firmware flags for PCIe/MSI
Message-Id: <20060818081329.AADA067B54@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jake Moilanen <moilanen@austin.ibm.com>

Add firmware flags for PCIe/MSI.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
---

 arch/powerpc/kernel/prom_init.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: git/arch/powerpc/kernel/prom_init.c
===================================================================
--- git.orig/arch/powerpc/kernel/prom_init.c
+++ git/arch/powerpc/kernel/prom_init.c
@@ -634,6 +634,12 @@ static void __init early_cmdline_parse(v
 /* ibm,dynamic-reconfiguration-memory property supported */
 #define OV5_DRCONF_MEMORY	0x20
 #define OV5_LARGE_PAGES		0x10	/* large pages supported */
+/* PCIe/MSI support. Without MSI full PCIe is not supported */
+#ifdef CONFIG_PCI_MSI
+#define OV5_MSI			0x01	/* PCIe/MSI supported */
+#else
+#define OV5_MSI			0x00
+#endif
 
 /*
  * The architecture vector has an array of PVR mask/value pairs,
@@ -677,7 +683,7 @@ static unsigned char ibm_architecture_ve
 	/* option vector 5: PAPR/OF options */
 	3 - 1,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES,
+	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_MSI,
 };
 
 /* Old method - ELF header with PT_NOTE sections */
