Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C123FB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 07:00:33 +1000 (EST)
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id 5A3C7DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 07:00:32 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MdVn5-000330-Bw
	for linuxppc-dev@ozlabs.org; Tue, 18 Aug 2009 23:00:23 +0200
Received: from 24.114.226.27 ([24.114.226.27])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 23:00:23 +0200
Received: from michaelbarkowski by 24.114.226.27 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 23:00:23 +0200
To: linuxppc-dev@ozlabs.org
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: [PATCH] qe_lib: Set gpio data before changing the direction to output
Date: Tue, 18 Aug 2009 16:59:58 -0400
Message-ID: <4A8B164E.6030704@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@ger.gmane.org>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This avoids having a short glitch if the desired initial value is not
the same as what was previously in the data register.

Signed-off-by: Michael Barkowski <michaelbarkowski@ruggedcom.com>
---
I can't think of a reason not to do this.  The data register has no
effect except when the pin is configured as an output, right?

Please enlighten me if this is not correct. The behaviour I see gels
with my thinking, but there may be a case I haven't thought of.

 arch/powerpc/sysdev/qe_lib/gpio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
index 3485288..e7bf136 100644
--- a/arch/powerpc/sysdev/qe_lib/gpio.c
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -107,12 +107,11 @@ static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	spin_lock_irqsave(&qe_gc->lock, flags);
 
+	qe_gpio_set(gc, gpio, val);
 	__par_io_config_pin(mm_gc->regs, gpio, QE_PIO_DIR_OUT, 0, 0, 0);
 
 	spin_unlock_irqrestore(&qe_gc->lock, flags);
 
-	qe_gpio_set(gc, gpio, val);
-
 	return 0;
 }
 
-- 
1.6.3.3
