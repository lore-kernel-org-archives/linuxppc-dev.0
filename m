Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by ozlabs.org (Postfix) with ESMTP id 8739CB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Aug 2010 02:45:33 +1000 (EST)
Received: by bwz15 with SMTP id 15so268128bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Aug 2010 09:45:31 -0700 (PDT)
Date: Wed, 11 Aug 2010 20:45:27 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
Message-ID: <20100811164527.GA19793@oksana.dev.rtsoft.ru>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
	<AANLkTimJ1+d7U2SN_SSHepo6u01RJqUEXUDQXUgBfCWK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTimJ1+d7U2SN_SSHepo6u01RJqUEXUDQXUgBfCWK@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, MJ embd <mj.embd@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Aug 11, 2010 at 06:57:16PM +0530, Ravi Gupta wrote:
> I am new to device driver development. I am trying to access the GPIO of
> MPC837xERDB eval board. I have upgraded its kernel to linux-2.6.28.9 and
> enable support for mpc8xxx_gpio.c. On boot up, it successfully detect two
> gpio controllers. Now my question is how I am going to use it to communicate
> with the gpio pins? Do I have to modify the code in mpc8xxx_gpio.c file to
> do whatever I want to do with gpios or I can use the standard gpio API
> provided in kernel ( gpio_request()/gpio_free() ). I also tries the standard
> kernel API, but it fails. Here is my code :

No, you don't have to modify anything, and yes, you can
use standard kernel GPIO API.

> #include <linux/module.h>
> #include <linux/errno.h>  /* error codes */
> #include <linux/gpio.h>
>
> static __init int sample_module_init(void)
> {
>   int ret;
>
>   int i;
>   for (i=1; i<32; i++) {
>     ret = gpio_request(i, "Sample Driver");

Before issing gpio_request() you must get GPIO number from the
of_get_gpio() or of_get_gpio_flags() calls (the _flags variant
will also retreive flags such as 'active-low').

The calls assume that you have gpio = <> specifier in the
device tree, see arch/powerpc/boot/dts/mpc8377_rdb.dts's
"leds" node as an example.

As you want GPIO LEDs, you can use drivers/leds/leds-gpio.c
(see of_gpio_leds_probe() call, it gets gpio numbers via
of_get_gpio_flags() and then requests them via gpio_request()).

Also see

Documentation/powerpc/dts-bindings/gpio/gpio.txt
Documentation/powerpc/dts-bindings/gpio/led.txt

>     if (ret) {
>       printk(KERN_WARNING "sample_driver: unable to request GPIO_PG%d\n",
> i);
>       //return ret;
>     }
>   }
>
>   return 0;
> }


On Wed, Aug 11, 2010 at 07:49:40PM +0530, Ravi Gupta wrote:
> Also, when I try to export a gpio in sysfs
> 
> echo 9 > /sys/class/gpio/export

The gpio numbers are global, i.e. GPIO controller base + GPIO
number within the controller.

[...]
> drwxr-xr-x    3 root     root            0 Jan  1 00:00 gpiochip192

So, if you want GPIO9 within gpiochip192, you should issue
"echo 201 > export".

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
