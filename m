Message-ID: <1859.80.7.99.14.1086887283.squirrel@www.solinno.co.uk>
Date: Thu, 10 Jun 2004 18:08:03 +0100 (BST)
Subject: [RFC][PATCH 7/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is to support the old OpenPICs in old E20/E30 machines.  They
seem to be mapped as I/O instead of memory mapped.  These also seem
to have a bug that the spurious interrupt always seems to be reported
as 255.  Changing the OPENPIC_VEC_SPURIOUS to 239 (which maps to
255 after adding the offset of 16) seems to make it work.  As the
change seems to make no difference on other machines, it seems better
to do that than have special code for it.  However, I don't really
understand how this spurious vector stuff works, so....


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c
linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c	2004-06-09
13:58:50.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-09
13:59:05.000000000 +0100
@@ -837,7 +837,7 @@
 ibm_prep_init(void)
 {
 	if (have_residual_data()) {
-		u32 addr, real_addr, len;
+		u32 addr, real_addr, len, offset;
 		PPC_DEVICE *mpic;
 		PnP_TAG_PACKET *pkt;

@@ -859,15 +859,22 @@
 			return;

 #define p pkt->L4_Pack.L4_Data.L4_PPCPack
-		if (!((p.PPCData[0] == 2) && (p.PPCData[1] == 32)))
-			return; /* not a 32-bit memory address */
+	 	if (p.PPCData[1] == 32) {
+			switch (p.PPCData[0]) {
+				case 1:  offset = PREP_ISA_IO_BASE;  break;
+				case 2:  offset = PREP_ISA_MEM_BASE; break;
+				default: return; /* Not I/O or memory?? */
+			}
+		}
+		else
+			return; /* Not a 32-bit address */

 		real_addr = ld_le32((unsigned int *) (p.PPCData + 4));
 		if (real_addr == 0xffffffff)
 			return;

 		/* Adjust address to be as seen by CPU */
-		addr = real_addr + PREP_ISA_MEM_BASE;
+		addr = real_addr + offset;

 		len = ld_le32((unsigned int *) (p.PPCData + 12));
 		if (!len)
diff -urNX .diffex linux-2.6.6-prev/include/asm-ppc/open_pic.h
linux-2.6.6/include/asm-ppc/open_pic.h
--- linux-2.6.6-prev/include/asm-ppc/open_pic.h	2004-06-07
11:44:57.000000000 +0100
+++ linux-2.6.6/include/asm-ppc/open_pic.h	2004-06-09 13:59:05.000000000
+0100
@@ -23,7 +23,7 @@

 #define OPENPIC_VEC_TIMER	110	/* and up */
 #define OPENPIC_VEC_IPI		118	/* and up */
-#define OPENPIC_VEC_SPURIOUS	127
+#define OPENPIC_VEC_SPURIOUS	239

 /* OpenPIC IRQ controller structure */
 extern struct hw_interrupt_type open_pic;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
