Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [212.227.59.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C626DDE3C
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 07:06:46 +1100 (EST)
Subject: [PATCH] PPC440EP Interrupt Triggering and Level Settings
From: Wolfgang Ocker <weo@reccoware.de>
To: jwboyer@linux.vnet.ibm.com, mporter@kernel.crashing.org
Content-Type: text/plain
Date: Sun, 10 Feb 2008 20:24:02 +0100
Message-Id: <1202671442.3384.15.camel@galileo.recco.de>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wolfgang Ocker <weo@reccoware.de>

Corrected IRQ triggering and level settings according to latest revision
of the 440EP User Manual (rev 1.24 nov 16, 2007).

The incorrect settings might cause a failure of the network if both
onchip ethernet ports are under heavy load.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---

--- linux-2.6.24/arch/ppc/platforms/4xx/ibm440ep.c.irq-trig     2008-01-24 23:58:37.000000000 +0100
+++ linux-2.6.24/arch/ppc/platforms/4xx/ibm440ep.c      2008-02-10 19:43:32.000000000 +0100
@@ -172,11 +172,11 @@
 /* Polarity and triggering settings for internal interrupt sources */
 struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
        { .polarity     = 0xffbffe03,
-         .triggering   = 0xfffffe00,
+         .triggering   = 0x00000000,
          .ext_irq_mask = 0x000001fc,   /* IRQ0 - IRQ6 */
        },
-       { .polarity     = 0xffffc6ef,
-         .triggering   = 0xffffc7ff,
+       { .polarity     = 0xffffc6af,
+         .triggering   = 0x06000140,
          .ext_irq_mask = 0x00003800,   /* IRQ7 - IRQ9 */
        },
 };
