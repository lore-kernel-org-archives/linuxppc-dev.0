Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4C85067A88
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Jan 2005 05:28:00 +1100 (EST)
Date: Sun, 23 Jan 2005 12:27:44 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0501231220001.19795@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix PCI2 IO space mapping on CDS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The ppc pci bus and resource fixups will automatically adjust the IO space 
mappings by (hose->io_base_virt - isa_io_base).  Since we map all of PCI 
IO space (PCI1 & PCI2) with a single mapping so it is continguious in 
virtual, physical, and PCI IO space the offset will equal 
MPC85XX_PCI1_IO_SIZE.  There for we needed to reduce the setting by 
that amount for everything to work properly on CDS.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h	2005-01-23 12:22:34 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h	2005-01-23 12:22:34 -06:00
@@ -60,8 +60,10 @@
 #define MPC85XX_PCI1_IO_SIZE         0x01000000
 
 /* PCI 2 memory map */
-#define MPC85XX_PCI2_LOWER_IO        0x01000000
-#define MPC85XX_PCI2_UPPER_IO        0x01ffffff
+/* Note: the standard PPC fixups will cause IO space to get bumped by
+ * hose->io_base_virt - isa_io_base => MPC85XX_PCI1_IO_SIZE */
+#define MPC85XX_PCI2_LOWER_IO        0x00000000
+#define MPC85XX_PCI2_UPPER_IO        0x00ffffff
 
 #define MPC85XX_PCI2_LOWER_MEM       0xa0000000
 #define MPC85XX_PCI2_UPPER_MEM       0xbfffffff
