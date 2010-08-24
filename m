Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 3749AB70D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 19:26:30 +1000 (EST)
Received: by ewy21 with SMTP id 21so3100035ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 02:26:26 -0700 (PDT)
Date: Tue, 24 Aug 2010 13:26:23 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] gpiolib: Add 'struct gpio_chip' forward declaration for
	!GPIOLIB case
Message-ID: <20100824092623.GA20334@oksana.dev.rtsoft.ru>
References: <1282631168.22370.517.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1282631168.22370.517.camel@pasglop>
Cc: David Brownell <david-b@pacbell.net>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With CONFIG_GPIOLIB=n, the 'struct gpio_chip' is not declared,
so the following pops up on PowerPC:

  cc1: warnings being treated as errors
  In file included from arch/powerpc/platforms/52xx/mpc52xx_common.c:19:
  include/linux/of_gpio.h:74: warning: 'struct gpio_chip' declared
                              inside parameter list
  include/linux/of_gpio.h:74: warning: its scope is only this definition
                              or declaration, which is probably not what
			      you want
  include/linux/of_gpio.h:75: warning: 'struct gpio_chip' declared
                              inside parameter list
  make[2]: *** [arch/powerpc/platforms/52xx/mpc52xx_common.o] Error 1

This patch fixes the issue by providing the proper forward declaration.

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---

On Tue, Aug 24, 2010 at 04:26:08PM +1000, Benjamin Herrenschmidt wrote:
> I get that with my current stuff:
> 
> cc1: warnings being treated as errors
> In file included from [..]/mpc52xx_common.c:19:
> of_gpio.h:74: error: ‘struct gpio_chip’ declared inside parameter list
[...]
> make[3]: *** Waiting for unfinished jobs....

That's because with GPIOCHIP=n no one declares struct gpio_chip.

It should be either of_gpio.h or gpio.h. Let's make it gpio.h, as
this feels more generic, and we already have some !GPIOLIB handling
in there.

 include/linux/gpio.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 03f616b..85207d2 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -15,6 +15,12 @@
 struct device;
 
 /*
+ * Some code might rely on the declaration. Still, it is illegal
+ * to dereference it for !GPIOLIB case.
+ */
+struct gpio_chip;
+
+/*
  * Some platforms don't support the GPIO programming interface.
  *
  * In case some driver uses it anyway (it should normally have
-- 
1.7.0.5
