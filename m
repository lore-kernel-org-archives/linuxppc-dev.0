Date: Fri, 2 Nov 2001 00:34:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: APUS irq patch 2
Message-ID: <Pine.LNX.4.33.0111020032070.8971-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Here are some small changes to the APUS interrupt code:
- fix PCMCIA initialisation
- fix interrupt statistics
- fix prototype

bey, Roman

--- arch/ppc/amiga/amiints.c	2001/07/08 15:58:24	1.1.1.7
+++ arch/ppc/amiga/amiints.c	2001/08/24 19:17:27	1.7
@@ -115,7 +115,7 @@

 	/* turn off PCMCIA interrupts */
 	if (AMIGAHW_PRESENT(PCMCIA))
-		pcmcia_disable_irq();
+		gayle.inten = GAYLE_IRQ_IDE;

 	/* turn off all interrupts... */
 	custom.intena = 0x7fff;
@@ -350,7 +350,7 @@

 inline void amiga_do_irq(int irq, struct pt_regs *fp)
 {
-	kstat.irqs[0][SYS_IRQS + irq]++;
+	kstat.irqs[0][irq]++;
 	ami_irq_list[irq]->handler(irq, ami_irq_list[irq]->dev_id, fp);
 }

@@ -358,7 +358,7 @@
 {
 	irq_node_t *node;

-	kstat.irqs[0][SYS_IRQS + irq]++;
+	kstat.irqs[0][irq]++;

 	custom.intreq = ami_intena_vals[irq];

@@ -489,7 +489,7 @@
 		if (!(node = ami_irq_list[i]))
 			continue;
 		len += sprintf(buf+len, "ami  %2d: %10u ", i,
-		               kstat.irqs[0][SYS_IRQS + i]);
+		               kstat.irqs[0][i]);
 		do {
 			if (node->flags & SA_INTERRUPT)
 				len += sprintf(buf+len, "F ");
--- arch/ppc/amiga/cia.c	2001/07/08 15:58:25	1.1.1.6
+++ arch/ppc/amiga/cia.c	2001/08/24 19:17:27	1.3
@@ -185,17 +185,16 @@
 static void cia_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct ciabase *base = (struct ciabase *)dev_id;
-	int mach_irq, i;
+	int i;
 	unsigned char ints;

-	mach_irq = base->cia_irq;
-	irq = SYS_IRQS + mach_irq;
+	irq = base->cia_irq;
 	ints = cia_set_irq_private(base, CIA_ICR_ALL);
 	custom.intreq = base->int_mask;
-	for (i = 0; i < CIA_IRQS; i++, irq++, mach_irq++) {
+	for (i = 0; i < CIA_IRQS; i++, irq++) {
 		if (ints & 1) {
 			kstat.irqs[0][irq]++;
-			base->irq_list[i].handler(mach_irq, base->irq_list[i].dev_id, fp);
+			base->irq_list[i].handler(irq, base->irq_list[i].dev_id, fp);
 		}
 		ints >>= 1;
 	}
@@ -229,7 +228,7 @@
 	j = base->cia_irq;
 	for (i = 0; i < CIA_IRQS; i++) {
 		len += sprintf(buf+len, "cia  %2d: %10d ", j + i,
-			       kstat.irqs[0][SYS_IRQS + j + i]);
+			       kstat.irqs[0][j + i]);
 			len += sprintf(buf+len, "  ");
 		len += sprintf(buf+len, "%s\n", base->irq_list[i].devname);
 	}
--- include/asm-ppc/amigaints.h	2001/07/08 15:09:50	1.1.1.7
+++ include/asm-ppc/amigaints.h	2001/07/08 16:59:56	1.6
@@ -110,12 +110,8 @@
 #define IF_DSKBLK   0x0002	/* diskblock DMA finished */
 #define IF_TBE	    0x0001	/* serial transmit buffer empty interrupt */

-struct irq_server {
-	unsigned short count, reentrance;
-};
-
 extern void amiga_do_irq(int irq, struct pt_regs *fp);
-extern void amiga_do_irq_list(int irq, struct pt_regs *fp, struct irq_server *server);
+extern void amiga_do_irq_list(int irq, struct pt_regs *fp);

 /* CIA interrupt control register bits */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
