To: linuxppc-embedded@lists.linuxppc.org
Cc: Tom Rini <trini@kernel.crashing.org>
Subject: get_irq fix for 8260 platform
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Jan 2002 18:15:52 +1100
Message-ID: <29887.1011251752@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All, if you have an 8260 and are wondering why the latest revisions of
the devel kernel hang during boot, then this patch might help you.

Things were changed recently to call the *_get_irq() function repeatedly
until it indicated there were no more interrupts pending by returning -1.

The appropriate changes were made to ppc8xx_pic.c for the 8xx platform, but
not to ppc8260_pic.c for the 8260 platform. I simply mirrored the changes.

I have no idea whether the end_irq function addition is required, but it
doesn't appear to do any harm (for me). The important change is to make
m8260_get_irq() return -1 if the SIVEC register contains zero (which is
documented - poorly - to be an Error condition - no interrupt pending).

Cheers!
								Murray...

--- linuxppc_2_4_devel_vanilla/arch/ppc/kernel/ppc8260_pic.c	Thu Dec 13 16:45:43 2001
+++ linuxppc_2_4_devel_hymod/arch/ppc/kernel/ppc8260_pic.c	Wed Jan 16 15:14:31 2002
@@ -85,6 +85,21 @@
 	sipnr[word] = 1 << (31 - bit);
 }

+static void m8260_end_irq(unsigned int irq_nr)
+{
+	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
+		int	bit, word;
+		volatile uint	*simr;
+
+		bit = irq_to_siubit[irq_nr];
+		word = irq_to_siureg[irq_nr];
+
+		simr = &(immr->im_intctl.ic_simrh);
+		ppc_cached_irq_mask[word] |= (1 << (31 - bit));
+		simr[word] = ppc_cached_irq_mask[word];
+	}
+}
+
 struct hw_interrupt_type ppc8260_pic = {
 	" 8260 SIU  ",
 	NULL,
@@ -92,6 +107,7 @@
 	m8260_unmask_irq,
 	m8260_mask_irq,
 	m8260_mask_and_ack,
+	m8260_end_irq,
 	0
 };

@@ -106,6 +122,14 @@
          * to get the irq number.         */
         bits = immr->im_intctl.ic_sivec;
         irq = bits >> 26;
+
+	/*
+	 * When we read the sivec without an interrupt to process, we will
+	 * get back a vector of 0.  In this case, return -1
+	 */
+	if (irq == 0)
+		return -1;
+
 #if 0
         irq += ppc8260_pic.irq_offset;
 #endif


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
