Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1B27B7CBB
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 08:03:14 +1100 (EST)
Date: Mon, 8 Feb 2010 13:02:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
Message-Id: <20100208130248.72febd68.akpm@linux-foundation.org>
In-Reply-To: <20100205203236.GC1475@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 5 Feb 2010 23:32:36 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> This patch implements GPIOLIB notifier hooks, and thus makes device-enabled
> GPIO chips (i.e. the ones that have gpio_chip->dev specified) automatically
> attached to the OpenFirmware subsystem. Which means that now we can handle
> I2C and SPI GPIO chips almost* transparently.
> 
> * "Almost" because some chips still require platform data, and for these
>   chips OF-glue is still needed, though with this support the glue will
>   be much smaller.
> 

We can clean this up a little with the WARN_ON trick:

diff -puN drivers/of/gpio.c~of-gpio-implement-gpiolib-notifier-hooks-fix drivers/of/gpio.c
--- a/drivers/of/gpio.c~of-gpio-implement-gpiolib-notifier-hooks-fix
+++ a/drivers/of/gpio.c
@@ -255,10 +255,8 @@ static int of_gpiochip_register_simple(s
 {
 	struct of_gpio_chip *of_gc;
 
-	if (np->data) {
-		WARN_ON(1);
+	if (WARN_ON(np->data))
 		return -EBUSY;
-	}
 
 	of_gc = kzalloc(sizeof(*of_gc), GFP_KERNEL);
 	if (!of_gc)
@@ -287,10 +285,8 @@ static int of_gpiochip_unregister(struct
 {
 	struct of_gpio_chip *of_gc = np->data;
 
-	if (!of_gc || of_gc->chip != chip) {
-		WARN_ON(1);
+	if (WARN_ON(!of_gc || of_gc->chip != chip))
 		return -EINVAL;
-	}
 
 	np->data = NULL;
 	kfree(of_gc);
_
