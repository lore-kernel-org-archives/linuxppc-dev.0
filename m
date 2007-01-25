Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:14 +1100
Subject: [RFC/PATCH 12/16] Tell firmware we support MSI
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083416.3F707DE34B@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tell firmware we support MSI.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/prom_init.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: msi/arch/powerpc/kernel/prom_init.c
===================================================================
--- msi.orig/arch/powerpc/kernel/prom_init.c
+++ msi/arch/powerpc/kernel/prom_init.c
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
