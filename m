Date: Tue, 25 May 2004 02:27:45 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 1/7] update to new irq API
Message-ID: <Pine.LNX.4.58.0405250227340.19010@scrub.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Update the apus interrupt functions to the new irq API

Index: 2.6/arch/ppc/amiga/amiints.c
diff -u 2.6/arch/ppc/amiga/amiints.c:1.1.1.1 2.6/arch/ppc/amiga/amiints.c:1.2
--- 2.6/arch/ppc/amiga/amiints.c:1.1.1.1	Sat Jan 31 15:23:58 2004
+++ 2.6/arch/ppc/amiga/amiints.c	Wed Feb  4 13:21:34 2004
@@ -67,9 +67,10 @@

 static short ami_ablecount[AMI_IRQS];

-static void ami_badint(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_badint(int irq, void *dev_id, struct pt_regs *fp)
 {
 /*	num_spurious += 1;*/
+	return IRQ_NONE;
 }

 /*
@@ -206,7 +207,7 @@
  * The builtin Amiga hardware interrupt handlers.
  */

-static void ami_int1(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int1(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;

@@ -227,9 +228,10 @@
 		custom.intreq = IF_SOFT;
 		amiga_do_irq(IRQ_AMIGA_SOFT, fp);
 	}
+	return IRQ_HANDLED;
 }

-static void ami_int3(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int3(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;

@@ -248,9 +250,11 @@
 	/* if a vertical blank interrupt */
 	if (ints & IF_VERTB)
 		amiga_do_irq_list(IRQ_AMIGA_VERTB, fp);
+
+	return IRQ_HANDLED;
 }

-static void ami_int4(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int4(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;

@@ -277,9 +281,10 @@
 		custom.intreq = IF_AUD3;
 		amiga_do_irq(IRQ_AMIGA_AUD3, fp);
 	}
+	return IRQ_HANDLED;
 }

-static void ami_int5(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int5(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;

@@ -294,11 +299,13 @@
 		custom.intreq = IF_DSKSYN;
 		amiga_do_irq(IRQ_AMIGA_DSKSYN, fp);
 	}
+	return IRQ_HANDLED;
 }

-static void ami_int7(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int7(int irq, void *dev_id, struct pt_regs *fp)
 {
 	panic ("level 7 interrupt received\n");
+	return IRQ_NONE;
 }

 #ifdef CONFIG_APUS
Index: 2.6/arch/ppc/amiga/cia.c
diff -u 2.6/arch/ppc/amiga/cia.c:1.1.1.1 2.6/arch/ppc/amiga/cia.c:1.2
--- 2.6/arch/ppc/amiga/cia.c:1.1.1.1	Sat Jan 31 15:23:58 2004
+++ 2.6/arch/ppc/amiga/cia.c	Wed Feb  4 13:21:34 2004
@@ -134,7 +134,7 @@
 	return cia_able_irq_private(base, mask);
 }

-static void cia_handler(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t cia_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct ciabase *base = (struct ciabase *)dev_id;
 	irq_desc_t *desc;
@@ -156,6 +156,7 @@
 		desc++;
 	}
 	amiga_do_irq_list(base->server_irq, fp);
+	return IRQ_HANDLED;
 }

 void __init cia_init_IRQ(struct ciabase *base)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
