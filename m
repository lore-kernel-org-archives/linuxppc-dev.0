Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub2.si.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 by ozlabs.org (Postfix) with ESMTP id 1C80E2C01B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 15:27:51 +1000 (EST)
Date: Thu, 18 Apr 2013 07:26:11 +0200
Message-Id: <201304180526.r3I5QB6v029520@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>,
 Marcelo Tosatti <marcelo@kvack.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] Erroneous double irq_eoi() on CPM IRQ in MPC8xx
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

irq_eoi() is already called by generic_handle_irq() so 
it shall not be called a again

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Index: linux/arch/powerpc/platforms/8xx/m8xx_setup.c
===================================================================
--- linux/arch/powerpc/platforms/8xx/m8xx_setup.c	(revision 4802)
+++ linux/arch/powerpc/platforms/8xx/m8xx_setup.c	(working copy)
@@ -218,19 +218,12 @@
 
 static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip;
-	int cascade_irq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int cascade_irq = cpm_get_irq();
 
-	if ((cascade_irq = cpm_get_irq()) >= 0) {
-		struct irq_desc *cdesc = irq_to_desc(cascade_irq);
-
+	if (cascade_irq >= 0)
 		generic_handle_irq(cascade_irq);
 
-		chip = irq_desc_get_chip(cdesc);
-		chip->irq_eoi(&cdesc->irq_data);
-	}
-
-	chip = irq_desc_get_chip(desc);
 	chip->irq_eoi(&desc->irq_data);
 }
 
