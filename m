Return-Path: <tnt@246tNt.com>
Received: from outmx008.isp.belgacom.be (outmx008.isp.belgacom.be
	[195.238.5.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30FB4DDF5C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 08:28:36 +1000 (EST)
Received: from outmx008.isp.belgacom.be (localhost [127.0.0.1])
	by outmx008.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l3AMSH16029321
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 00:28:17 +0200
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: mpc52xx_pic, fix main interrupt masking
Date: Wed, 11 Apr 2007 00:27:49 +0200
Message-Id: <11762440693810-git-send-email-tnt@246tNt.com>
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>,
	Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Domen Puncer <domen.puncer@telargo.com>

The bit setting was off by one.
Tested with RTC and GPIO_WKUP interrupts.

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
Hi Paulus,

If you still accept patch for 2.6.21, could you pickup that one ?
It's a quite serious issue with interrupt masking and I dumbly put it
into my "for-2.6.22" queue instead of forwarding it when I received it ...

If it's too late, just tell me and I'll include it in my 'for-2.6.22' batch
end of this week.


Thanks,

	Sylvain
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index c751925..fbfff95 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -128,7 +128,7 @@ static void mpc52xx_main_mask(unsigned int virq)
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
-	io_be_setbit(&intr->main_mask, 15 - l2irq);
+	io_be_setbit(&intr->main_mask, 16 - l2irq);
 }
 
 static void mpc52xx_main_unmask(unsigned int virq)
@@ -141,7 +141,7 @@ static void mpc52xx_main_unmask(unsigned int virq)
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
-	io_be_clrbit(&intr->main_mask, 15 - l2irq);
+	io_be_clrbit(&intr->main_mask, 16 - l2irq);
 }
 
 static struct irq_chip mpc52xx_main_irqchip = {
-- 
1.5.0.1
