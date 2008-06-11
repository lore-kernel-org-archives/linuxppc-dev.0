Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 584ACDDED7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 09:42:16 +1000 (EST)
Date: Thu, 12 Jun 2008 03:42:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/QE: use arch_initcall to probe QUICC Engine GPIOs
Message-ID: <20080611234214.GA5296@polina.dev.rtsoft.ru>
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174705.GD28185@polina.dev.rtsoft.ru>
	<CC7DA92D-EE00-48E9-AAA0-51A13A3BD5D0@kernel.crashing.org>
	<20080611122919.GA2573@polina.dev.rtsoft.ru>
	<CF897329-1FD6-4F3D-B91C-2C7B4225126E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <CF897329-1FD6-4F3D-B91C-2C7B4225126E@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It was discussed that global arch_initcall() is preferred way to probe
QE GPIOs, so let's use it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Wed, Jun 11, 2008 at 08:52:16AM -0500, Kumar Gala wrote:
[...]
>>> applied.
>>
>> I've just rebased on the pushed out powerpc-next branch, and noticed
>> that you merged this patch from the old series.
>>
>> The difference is in absence of arch_initcall() for QE GPIOs
>> initialization, i.e. in this version boards should explicitly call
>> qe_add_gpiochips(). So.. was this done deliberately? Or should I send
>> you an update?
>
> just send me an update to my tree at this point.

Here it is.

Thanks,

 arch/powerpc/sysdev/qe_lib/gpio.c |    5 ++++-
 include/asm-powerpc/qe.h          |    1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
index c712e24..8e5a0bc 100644
--- a/arch/powerpc/sysdev/qe_lib/gpio.c
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -102,7 +103,7 @@ static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
-void __init qe_add_gpiochips(void)
+static int __init qe_add_gpiochips(void)
 {
 	struct device_node *np;
 
@@ -143,4 +144,6 @@ err:
 		kfree(qe_gc);
 		/* try others anyway */
 	}
+	return 0;
 }
+arch_initcall(qe_add_gpiochips);
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 1355e72..edee15d 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -101,7 +101,6 @@ struct qe_pio_regs {
 #endif
 };
 
-extern void __init qe_add_gpiochips(void);
 extern int par_io_init(struct device_node *np);
 extern int par_io_of_config(struct device_node *np);
 #define QE_PIO_DIR_IN	2
-- 
1.5.5.4
