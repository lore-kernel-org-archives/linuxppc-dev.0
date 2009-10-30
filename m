Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15F4BB7C3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 17:20:07 +1100 (EST)
Subject: [PATCH] powerpc/8xx: Fix build breakage with sparse irq changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Oct 2009 17:19:57 +1100
Message-ID: <1256883597.6372.70.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Sticking that on top of my -next branch

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 385acfc..242954c 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -222,7 +222,7 @@ static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
 	int cascade_irq;
 
 	if ((cascade_irq = cpm_get_irq()) >= 0) {
-		struct irq_desc *cdesc = irq_desc + cascade_irq;
+		struct irq_desc *cdesc = irq_to_desc(cascade_irq);
 
 		generic_handle_irq(cascade_irq);
 		cdesc->chip->eoi(cascade_irq);
-- 
1.6.1.2.14.gf26b5
