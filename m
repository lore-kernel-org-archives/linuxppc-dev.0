Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id 6AEE6683AF
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 08:41:47 +1000 (EST)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.36 #1 (Debian))
	id 1EJIiI-0004z2-00
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 00:41:46 +0200
Date: Sun, 25 Sep 2005 00:41:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509250041340.19159@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH 1/8] apus: irq API updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Update the apus interrupt functions to the new irq API

---

 arch/ppc/amiga/amiints.c |   19 +++++++++++++------
 arch/ppc/amiga/cia.c     |    3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

Index: linux/arch/ppc/amiga/amiints.c
===================================================================
--- linux.orig/arch/ppc/amiga/amiints.c	2005-09-23 16:20:11.000000000 +0200
+++ linux/arch/ppc/amiga/amiints.c	2005-09-23 16:20:18.000000000 +0200
@@ -67,9 +67,10 @@ static const unsigned char ami_servers[A
 
 static short ami_ablecount[AMI_IRQS];
 
-static void ami_badint(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_badint(int irq, void *dev_id, struct pt_regs *fp)
 {
 /*	num_spurious += 1;*/
+	return IRQ_NONE;
 }
 
 /*
@@ -206,7 +207,7 @@ void amiga_do_irq_list(int irq, struct p
  * The builtin Amiga hardware interrupt handlers.
  */
 
-static void ami_int1(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int1(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;
 
@@ -227,9 +228,10 @@ static void ami_int1(int irq, void *dev_
 		custom.intreq = IF_SOFT;
 		amiga_do_irq(IRQ_AMIGA_SOFT, fp);
 	}
+	return IRQ_HANDLED;
 }
 
-static void ami_int3(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int3(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;
 
@@ -248,9 +250,11 @@ static void ami_int3(int irq, void *dev_
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
 
@@ -277,9 +281,10 @@ static void ami_int4(int irq, void *dev_
 		custom.intreq = IF_AUD3;
 		amiga_do_irq(IRQ_AMIGA_AUD3, fp);
 	}
+	return IRQ_HANDLED;
 }
 
-static void ami_int5(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t ami_int5(int irq, void *dev_id, struct pt_regs *fp)
 {
 	unsigned short ints = custom.intreqr & custom.intenar;
 
@@ -294,11 +299,13 @@ static void ami_int5(int irq, void *dev_
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
Index: linux/arch/ppc/amiga/cia.c
===================================================================
--- linux.orig/arch/ppc/amiga/cia.c	2005-09-23 16:20:11.000000000 +0200
+++ linux/arch/ppc/amiga/cia.c	2005-09-23 16:20:18.000000000 +0200
@@ -134,7 +134,7 @@ unsigned char cia_able_irq(unsigned int 
 	return cia_able_irq_private(base, mask);
 }
 
-static void cia_handler(int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t cia_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct ciabase *base = (struct ciabase *)dev_id;
 	irq_desc_t *desc;
@@ -156,6 +156,7 @@ static void cia_handler(int irq, void *d
 		desc++;
 	}
 	amiga_do_irq_list(base->server_irq, fp);
+	return IRQ_HANDLED;
 }
 
 void __init cia_init_IRQ(struct ciabase *base)
