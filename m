Return-Path: <michaelbarkowski@ruggedcom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E1C84B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 07:20:47 +1000 (EST)
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id 2D2BBDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 07:20:46 +1000 (EST)
Message-ID: <4A8B1B2C.5090606@ruggedcom.com>
Date: Tue, 18 Aug 2009 17:20:44 -0400
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: [PATCH v2] qe_lib: Set gpio data before changing the direction to
	output
References: <4A8B164E.6030704@ruggedcom.com>
	<20090818210805.GA1725@oksana.dev.rtsoft.ru>
In-Reply-To: <20090818210805.GA1725@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
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
Anton Vorontsov wrote:
> There is a recursive locking bug: _set() takes the same spinlock.
> So you'd better move this call two lines upper. Otherwise the
> patch looks OK.
> 
> Thanks!

Thanks - here is v2.

 arch/powerpc/sysdev/qe_lib/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
index 3485288..8e7a776 100644
--- a/arch/powerpc/sysdev/qe_lib/gpio.c
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -105,14 +105,14 @@ static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
 	unsigned long flags;
 
+	qe_gpio_set(gc, gpio, val);
+
 	spin_lock_irqsave(&qe_gc->lock, flags);
 
 	__par_io_config_pin(mm_gc->regs, gpio, QE_PIO_DIR_OUT, 0, 0, 0);
 
 	spin_unlock_irqrestore(&qe_gc->lock, flags);
 
-	qe_gpio_set(gc, gpio, val);
-
 	return 0;
 }
 
-- 
1.6.3.3
