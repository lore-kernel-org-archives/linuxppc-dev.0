Message-ID: <366EEC05.E01F2088@talknet.de>
Date: Wed, 09 Dec 1998 21:30:45 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Matt Porter <mmporter@home.com>, VALETTE Eric <valette@crf.canon.fr>
Subject: PREP Hardware goes IDE again
Content-Type: multipart/mixed; boundary="------------969634B45BC217F0C2BF17EB"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------969634B45BC217F0C2BF17EB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here are some small patches (ralative to 2.1.129) which make IDE
working on PREP Hardware especially the RiscPC (probably also needed
for MPC750).

The first problem I had was related to interrups on the RiscPC.
It always assigned IRQ13 to the IDE port. However actually the
port is connected to IRQ14. The next problem was that prep_pci.c
assigned IRQ14 to PCI. The Patch now assigns 14 to IDE and uses
9,11 and 15 for PCI. In addition to this it sets the edge/level
control according to PCI preconfiguration. In addition it adds
3 more entries to the Blackhawk table.

The second problem was that the partition table of a DOS IDE drive
was not recognized unless I specified hda=swapdata at the boot prompt.
IDE CD-Rom drives were not recognized at all. All the required coding
to operate IDE devices correctly is already there but it is not used
for PREP hardware. I changed ide.h so that PREP is handled the same
way as CHRP. This makes IDE disks and CD-roms work without the need
to specify boot options.
--------------969634B45BC217F0C2BF17EB
Content-Type: text/plain; charset=us-ascii; name="linux.diff2"
Content-Disposition: inline; filename="linux.diff2"
Content-Transfer-Encoding: 7bit

+ diff -urN linux-2.1.129.org/include/asm-ppc/ide.h linux-2.1.129/include/asm-ppc/ide.h
--- linux-2.1.129.org/include/asm-ppc/ide.h	Tue Dec  1 09:40:36 1998
+++ linux-2.1.129/include/asm-ppc/ide.h	Wed Dec  9 23:02:45 1998
@@ -88,7 +88,7 @@
                 return chrp_ide_irq;
         }
 	switch (base) {
-		case 0x1f0: return 13;
+		case 0x1f0: return 14;
 		case 0x170: return 13;
 		case 0x1e8: return 11;
 		case 0x168: return 10;
@@ -146,7 +146,7 @@
    (Despite what it says in drivers/block/ide.h, they come up as little endian...)
    Changes to linux/hdreg.h may require changes here. */
 static __inline__ void ide_fix_driveid (struct hd_driveid *id) {
-	if (( _machine == _MACH_Pmac ) || (_machine == _MACH_chrp)|| (_machine == _MACH_mbx) ) {
+	if (( _machine == _MACH_Pmac ) || (_machine == _MACH_chrp)|| (_machine == _MACH_mbx) || (_machine == _MACH_prep) ) {
 		int i;
 		unsigned short *stringcast;
 		id->config         = __le16_to_cpu(id->config);
@@ -215,7 +215,7 @@
 
 #undef insw
 #define insw(port, buf, ns) 	do {			\
-	if ( _machine == _MACH_chrp)  {\
+	if ( (_machine == _MACH_chrp)  || (_machine == _MACH_prep) )  {\
 		 ide_insw((port)+_IO_BASE, (buf), (ns));  \
 	}\
 	else if ( (_machine == _MACH_Pmac) || (_machine == _MACH_mbx) )			\
@@ -227,7 +227,7 @@
 #undef outsw
 /*	printk("port: %x buf: %p ns: %d\n",port,buf,ns); \ */
 #define outsw(port, buf, ns) 	do {			\
-	if ( _machine == _MACH_chrp) {\
+	if ( (_machine == _MACH_chrp)  || (_machine == _MACH_prep) ) {\
 		ide_outsw((port)+_IO_BASE, (buf), (ns)); \
 	}\
 	else if ( (_machine == _MACH_Pmac) || (_machine == _MACH_mbx) )			\
+ diff -urN linux-2.1.129.org/arch/ppc/kernel/prep_pci.c linux-2.1.129/arch/ppc/kernel/prep_pci.c
--- linux-2.1.129.org/arch/ppc/kernel/prep_pci.c	Sun Nov  1 11:40:26 1998
+++ linux-2.1.129/arch/ppc/kernel/prep_pci.c	Wed Dec  9 23:14:19 1998
@@ -107,7 +107,7 @@
 };
 
 /* Motorola PowerStack */
-static char Blackhawk_pci_IRQ_map[16] __prepdata =
+static char Blackhawk_pci_IRQ_map[19] __prepdata =
 {
   	0,	/* Slot 0  - unused */
   	0,	/* Slot 1  - unused */
@@ -125,6 +125,9 @@
   	0,	/* Slot 13 - unused */
   	1,	/* Slot 14 - Ethernet */
   	0,	/* Slot 15 - unused */
+  	1,	/* Slot P7 */
+  	2,	/* Slot P6 */
+  	3,	/* Slot P5 */
 };
 
 static char Blackhawk_pci_IRQ_routes[] __prepdata =
@@ -132,7 +135,7 @@
    	0,	/* Line 0 - Unused */
    	9,	/* Line 1 */
    	11,	/* Line 2 */
-   	14,	/* Line 3 */
+   	15,	/* Line 3 */
    	15	/* Line 4 */
 };
    
@@ -440,6 +443,8 @@
 	
 	if ( _prep_type == _PREP_Motorola)
 	{
+		unsigned short irq_mode;
+
 		switch (inb(0x800) & 0xF0)
 		{
 		case 0x10: /* MVME16xx */
@@ -474,6 +479,14 @@
 			Motherboard_routes = Blackhawk_pci_IRQ_routes;
 			break;
 		}
+		/* AJF adjust level/edge control according to routes */
+		irq_mode = 0;
+		for (i = 1;  i <= 4;  i++)
+		{
+			irq_mode |= ( 1 << Motherboard_routes[i] );
+		}
+		outb( irq_mode & 0xff, 0x4d0 );
+		outb( (irq_mode >> 8) & 0xff, 0x4d1 );
 	} else if ( _prep_type == _PREP_IBM )
 	{
 		unsigned char pl_id;
+ diff -urN linux-2.1.129.org/arch/ppc/kernel/irq.c linux-2.1.129/arch/ppc/kernel/irq.c
--- linux-2.1.129.org/arch/ppc/kernel/irq.c	Tue Nov 24 18:48:32 1998
+++ linux-2.1.129/arch/ppc/kernel/irq.c	Wed Dec  9 23:06:45 1998
@@ -1099,6 +1099,8 @@
 			/*
 			 * Sound on the Powerstack reportedly needs to be edge triggered
 			 */
+/* AJF Moved to prep_pci.c */
+#if 0
 			if ( _prep_type == _PREP_Motorola )
 			{
 				irq_mode2 &= ~0x04L;
@@ -1106,7 +1108,7 @@
 				outb( irq_mode1 , 0x4d0 );
 				outb( irq_mode2 , 0x4d1 );
 			}
-
+#endif
 		}
 		break;
 #ifdef CONFIG_APUS		

--------------969634B45BC217F0C2BF17EB--




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
