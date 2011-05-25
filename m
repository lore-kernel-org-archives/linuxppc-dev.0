Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 400FAB7003
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 16:34:24 +1000 (EST)
Subject: [PATCH 6/8] powerpc 8xx: cascade eoi will be performed by
	generic_handle_irq handler
From: Milton Miller <miltonm@bga.com>
Message-Id: <8xx-cascade-eoi@mdm.bga.com>
In-Reply-To: <more-irq-cleanups@mdm.bga.com>
References: <more-irq-cleanups@mdm.bga.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2011 01:34:17 -0500
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 8xx cpm_cascade was calling irq_eoi for the cascaded irq,
but that will already have been called by the handle_fasteoi_irq
that generic_handle_irq will call.  The handler is set in
arch/powerpc/sysdev/cpm1.c by the host map routine.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/arch/powerpc/platforms/8xx/m8xx_setup.c
===================================================================
--- work.git.orig/arch/powerpc/platforms/8xx/m8xx_setup.c	2011-05-18 22:50:38.983498572 -0500
+++ work.git/arch/powerpc/platforms/8xx/m8xx_setup.c	2011-05-18 22:52:48.920532258 -0500
@@ -221,15 +221,9 @@ static void cpm_cascade(unsigned int irq
 	struct irq_chip *chip;
 	int cascade_irq;
 
-	if ((cascade_irq = cpm_get_irq()) >= 0) {
-		struct irq_desc *cdesc = irq_to_desc(cascade_irq);
-
+	if ((cascade_irq = cpm_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-		chip = irq_desc_get_chip(cdesc);
-		chip->irq_eoi(&cdesc->irq_data);
-	}
-
 	chip = irq_desc_get_chip(desc);
 	chip->irq_eoi(&desc->irq_data);
 }
