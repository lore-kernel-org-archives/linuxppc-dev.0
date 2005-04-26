Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4734D67AC6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 05:21:43 +1000 (EST)
Date: Tue, 26 Apr 2005 12:21:40 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050426192140.GB22714@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [RFC] [PATCH] ppc32: workaround for spurious IRQs on PQ2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

There is a problem with big amount of spurious IRQs on 8248-based 
design I'm working on.

I observed this problem with 2.4.30 kernel, but it was reported to be
still present on 2.6 as well.

Traces show that spurious IRQ happens right after handle_IRQ_events() 
enables external interrupts and _before_ even calling real IRQ 
handler.

I fixed this problem by adding sync at the end of cpm2_mask_and_ack. 
Using out_XXX macros for accessing SIU register doesn't seem to help.
Dan thinks there are some pipeline-related issues here, although I 
failed to found any mentions of them in 8272 user manual.

Also, there is a possibility, that we need more explicit sync's in 
cpm2_pic code.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

===== arch/ppc/syslib/cpm2_pic.c 1.11 vs edited =====
--- 1.11/arch/ppc/syslib/cpm2_pic.c	2005-03-31 02:59:05 -08:00
+++ edited/arch/ppc/syslib/cpm2_pic.c	2005-04-26 11:55:51 -07:00
@@ -90,6 +90,7 @@
 	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
 	sipnr[word] = 1 << bit;
+	mb();
 }
 
 static void cpm2_end_irq(unsigned int irq_nr)
