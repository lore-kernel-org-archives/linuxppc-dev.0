Date: Mon, 29 Apr 2002 17:34:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [trini@kernel.crashing.org: [PATCH] Allow openpic_init to set all combos of polarity and sense]
Message-ID: <20020430003434.GA21482@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I thought I sent this here too, but oh well

----- Forwarded message from Tom Rini <trini@kernel.crashing.org> -----

Date: Mon, 29 Apr 2002 12:42:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Allow openpic_init to set all combos of polarity and sense


The following patch adds support for telling open_pic.c not just the
sense (edge or level) of an IRQ but the polarity as well.  After
Paul's cleanup of the code (which killed the overloading of
OpenPIC_InitSenses and added openpic_set_sources()) this problem finally
showed up on hardhware which previously worked (by luck?).  What we do
now is to define that bit 0x1 of the table is for sense (0 for edge, 1
for level) and bit 0x2 of the table is for polarity (0 for negative, 1
for positive).  This does mean that all tables currently in _devel will
be broken, but I suspect that many, and possibly all of them are
broken right now and need to be updated to use openpic_set_sources().

An offshoot of this patch is that in openpic_init we no long have to
have the SIOint special case, since OpenPIC_InitSources[0] can define
the correct sense/polarity.  Additionally this allows for cascades to be
on other IRQs (and will cleanup Sandpoint abit).

Also, it's possible to define the table in terms of 0-3 still, but I've
added defines for IRQ_SENSE_xxx and IRQ_POLARITY_xxx so people can make
things clear.

Comments?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/kernel/open_pic.c 1.50 vs edited =====
--- 1.50/arch/ppc/kernel/open_pic.c	Wed Apr 24 10:15:11 2002
+++ edited/arch/ppc/kernel/open_pic.c	Sun Apr 28 09:10:36 2002
@@ -34,6 +34,11 @@

 void* OpenPIC_Addr;
 static volatile struct OpenPIC *OpenPIC = NULL;
+/*
+ * We define OpenPIC_InitSenses table thusly:
+ * bit 0x1: sense, 0 for edge and 1 for level.
+ * bit 0x2: polarity, 0 for negative, 1 for positive.
+ */
 u_int OpenPIC_NumInitSenses __initdata = 0;
 u_char *OpenPIC_InitSenses __initdata = NULL;
 extern int use_of_interrupt_tree;
@@ -370,15 +385,8 @@

 	openpic_set_priority(0xf);

-	/* SIOint (8259 cascade) is special */
-	if (offset) {
-		if (ppc_md.progress) ppc_md.progress("openpic: SIOint",0x3bc);
-		openpic_initirq(0, 8, offset, 1, 1);
-		openpic_mapirq(0, 1<<0, 0);
-	}
-
-	/* Init all external sources */
-	for (i = (offset ? 1 : 0); i < NumSources; i++) {
+	/* Init all external sources, including possibly the cascade. */
+	for (i = 0; i < NumSources; i++) {
 		int pri, sense;

 		if (ISR[i] == 0)
@@ -388,12 +396,18 @@
 		openpic_disable_irq(i+offset);

 		pri = (i == programmer_switch_irq)? 9: 8;
+		/*
+		 * We find the vale from either the InitSenses table
+		 * or assume a negative polarity level interrupt.
+		 */
 		sense = (i < OpenPIC_NumInitSenses)? OpenPIC_InitSenses[i]: 1;
-		if (sense)
+
+		if ((sense & IRQ_SENSE_MASK) == 1)
 			irq_desc[i+offset].status = IRQ_LEVEL;

 		/* Enabled, Priority 8 or 9 */
-		openpic_initirq(i, pri, i+offset, !sense, sense);
+		openpic_initirq(i, pri, i+offset, (sense & IRQ_POLARITY_MASK),
+				(sense & IRQ_SENSE_MASK));
 		/* Processor 0 */
 		openpic_mapirq(i, 1<<0, 0);
 	}
===== arch/ppc/kernel/prom.c 1.67 vs edited =====
--- 1.67/arch/ppc/kernel/prom.c	Tue Apr 16 04:42:08 2002
+++ edited/arch/ppc/kernel/prom.c	Sun Apr 28 09:49:50 2002
@@ -758,8 +758,10 @@
 	for (np = allnodes; np != 0; np = np->allnext) {
 		for (j = 0; j < np->n_intrs; j++) {
 			i = np->intrs[j].line;
-			if (i >= off && i < max)
-				senses[i-off] = np->intrs[j].sense;
+			if (i >= off && i < max && (i == 1))
+				senses[i-off] = IRQ_SENSE_LEVEL;
+			else if (i >= off && i < max && (i == 0))
+				senses[i-off] = IRQ_SENSE_EDGE;
 		}
 	}
 }
===== include/asm-ppc/open_pic.h 1.26 vs edited =====
--- 1.26/include/asm-ppc/open_pic.h	Thu Jan 24 17:48:13 2002
+++ edited/include/asm-ppc/open_pic.h	Sun Apr 28 09:35:04 2002
@@ -28,6 +28,19 @@
 #define OPENPIC_VEC_IPI		72	/* and up */
 #define OPENPIC_VEC_SPURIOUS	127

+/*
+ * For the OpenPIC_InitSenses table, we include both the sense
+ * and polarity in one number and mask out the value we want
+ * later on. -- Tom
+ */
+#define IRQ_SENSE_MASK		0x1
+#define IRQ_SENSE_LEVEL		0x1
+#define IRQ_SENSE_EDGE		0x0
+
+#define IRQ_POLARITY_MASK	0x2
+#define IRQ_POLARITY_POSITIVE	0x2
+#define IRQ_POLARITY_NEGATIVE	0x0
+
 /* OpenPIC IRQ controller structure */
 extern struct hw_interrupt_type open_pic;


----- End forwarded message -----

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
