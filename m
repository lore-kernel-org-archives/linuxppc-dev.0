Date: Thu, 29 Jul 2004 22:34:48 +0100
To: paulus@samba.org
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [7/9] Support for old IBM PReP boxes
Message-ID: <20040729213448.GA5914@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Some older E20/E30 machines have a very old implementation of the
OpenPIC which trips up the existing ibm_prep_init() function.  This
adds support for it.  It also changes the OPENPIC_VEC_SPURIOUS
constant to work around the buggy OpenPIC in those machines.


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c	2004-06-09 13:58:50.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-09 13:59:05.000000000 +0100
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
diff -urNX .diffex linux-2.6.6-prev/include/asm-ppc/open_pic.h linux-2.6.6/include/asm-ppc/open_pic.h
--- linux-2.6.6-prev/include/asm-ppc/open_pic.h	2004-06-07 11:44:57.000000000 +0100
+++ linux-2.6.6/include/asm-ppc/open_pic.h	2004-06-09 13:59:05.000000000 +0100
@@ -23,7 +23,7 @@

 #define OPENPIC_VEC_TIMER	110	/* and up */
 #define OPENPIC_VEC_IPI		118	/* and up */
-#define OPENPIC_VEC_SPURIOUS	127
+#define OPENPIC_VEC_SPURIOUS	239

 /* OpenPIC IRQ controller structure */
 extern struct hw_interrupt_type open_pic;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
