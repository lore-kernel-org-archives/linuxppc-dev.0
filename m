Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217]) by ozlabs.org (Postfix) with ESMTP id A2614B7C67
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 19:32:24 +1100 (EST)
Received: by bwz9 with SMTP id 9so1689859bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 01:32:22 -0700 (PDT)
Date: Wed, 31 Mar 2010 12:32:18 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Requesting a GPIO that hasn't been registered yet
Message-ID: <20100331083218.GA15664@oksana.dev.rtsoft.ru>
References: <4BB2BBDD.6050304@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4BB2BBDD.6050304@billgatliff.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 30, 2010 at 10:05:01PM -0500, Bill Gatliff wrote:
[...]
> In other words, the GPIO pin I'm using for the key is one of the bits on
> my pca953x GPIO expander chip.
> 
> The above would all be great, except that I haven't come up with a way
> to make sure that my encoder_button doesn't try to probe before lext60
> is available.  In fact, I'm consistently getting initialization in the
> wrong order!
> 
> Eventually the GPIO expander chip gets plugged in, because I can see it
> show up in sysfs.  And what's really odd is, I recently made similar
> mods to gpio_leds and they are working fine--- although the GPIO pin is
> on a pca953x at address 20, instead of 60.  I'm at a loss to explain why
> one works, but the other doesn't.  And I don't know how to really fix
> this problem for good!

That's because of drivers/Makefile:

obj-$(CONFIG_INPUT)             += input/
...
obj-y                           += i2c/ media/
...
obj-$(CONFIG_NEW_LEDS)          += leds/

So, all these drivers use module_init(), which means that the
order of execution depends on link order. To fix probing you need
to move i2c/ above input/:

diff --git a/drivers/Makefile b/drivers/Makefile
index 34f1e10..d31bb52 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,12 +67,12 @@ obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_MUSB_HDRC)	+= usb/musb/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
+obj-y				+= i2c/ media/
 obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_RTC_LIB)		+= rtc/
-obj-y				+= i2c/ media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_POWER_SUPPLY)	+= power/
