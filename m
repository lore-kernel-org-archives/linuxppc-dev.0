Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) by ozlabs.org (Postfix) with ESMTP id 4C22FB70D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 Aug 2010 23:16:25 +1000 (EST)
Received: by eyd9 with SMTP id 9so182333eyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 Aug 2010 06:16:22 -0700 (PDT)
Date: Fri, 13 Aug 2010 17:16:18 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Ravi Gupta <dceravigupta@gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
Message-ID: <20100813131618.GA25414@oksana.dev.rtsoft.ru>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
	<AANLkTimJ1+d7U2SN_SSHepo6u01RJqUEXUDQXUgBfCWK@mail.gmail.com>
	<20100811164527.GA19793@oksana.dev.rtsoft.ru>
	<AANLkTi=H1sKaGL8cHm9LAZm1tzm88dvkReXk12hmkWLj@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTi=H1sKaGL8cHm9LAZm1tzm88dvkReXk12hmkWLj@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, MJ embd <mj.embd@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, Aug 13, 2010 at 03:29:11PM +0530, Ravi Gupta wrote:
[...]
> Thanks for the reply.
> I had added the entries for gpio pin 9 for both controllers(I was not sure
> with controller's pin is connected to LED, but now I know it is pin no. 233
> i.e 224+9) in the mpc8377_rdb.dts file. Below is a portion of my dts file, I
> have attached the complete dts file as attachment.
> 
> immr@e0000000 {
[...]
>    * led@0 {
>         compatible = "gpio-leds";
>         label = "hdd";
>         gpios = <&gpio1 9 0>;
>     };

What kernel version you look at? Please see the latest kernel,
it has MCU GPIO LED nodes already, and you can just add some
additional nodes.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/powerpc/boot/dts/mpc8377_rdb.dts#l490

[...]
> Also I have enabled drivers/leds/leds-gpio.c in my kernel. To test whether
> the leds entires in dts file get attached to leds-gpio driver, I added
> printks in the probe function of the driver.
> 
> static int gpio_led_probe(struct platform_device *pdev)
> {
>   struct gpio_led_platform_data *pdata = pdev->dev.platform_data;
>   struct gpio_led *cur_led;
>   struct gpio_led_data *leds_data, *led_dat;
>   int i, ret = 0;
> 
>   *printk(KERN_INFO "led: inside gpio_led_probe.\n");*

You have put the printk into the wrong function. It should
have been of_gpio_leds_probe():

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/leds/leds-gpio.c#l227

If you don't have that function then you use too old kernel.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
