Date: Thu, 6 Sep 2001 11:26:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Walnut bootloader fix
Message-ID: <20010906112610.E20279@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The following patch adds code to the "simple" bootloader to disable
the ethernet controller on the Walnut board before booting the
kernel.  This is necessary on the Walnut I have, at least, or the EMAC
has a tendency to DMA broadcast packets into the kernel text.

diff -urN ../linuxppc_2_4_devel/arch/ppc/boot/simple/embed_config.c linux-bungo/arch/ppc/boot/simple/embed_config.c
--- ../linuxppc_2_4_devel/arch/ppc/boot/simple/embed_config.c	Fri Aug 31 13:08:41 2001
+++ linux-bungo/arch/ppc/boot/simple/embed_config.c	Thu Sep  6 11:25:24 2001
@@ -638,6 +638,8 @@
 */
 #define	BOARD_INFO_VECTOR	0xFFFE0B50

+#define PPC405_EM0MR0_ADDR	0xEF600800;
+
 void
 embed_config(bd_t **bdp)
 {
@@ -646,6 +648,7 @@
 	bd_t	*bd, *walnut_bd;
 	bd_t *(*get_board_info)(void) =
 	    (bd_t *(*)(void))(*(unsigned long *)BOARD_INFO_VECTOR);
+	volatile u32 *em0mr0 = (volatile u32 *)PPC405_EM0MR0_ADDR;

 	bd = &bdinfo;
 	*bdp = bd;
@@ -668,5 +671,14 @@
 		bd->bi_busfreq = 100000000;
 		bd->bi_pci_busfreq = 66666666;
 	}
+
+	/* Now turn of the EMAC - otherwise it has a tendency to DMA
+	   crap into the kernel text */
+	mtdcr(DCRN_MALCR, MALCR_MMSR);                /* 1st reset MAL */
+
+	while (mfdcr(DCRN_MALCR) & MALCR_MMSR)
+		;    /* wait for the reset */
+
+	*em0mr0 = 0x20000000;        /* then reset EMAC */
 }
 #endif


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
