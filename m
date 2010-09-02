Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 80488B712F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 22:46:25 +1000 (EST)
Received: by ewy21 with SMTP id 21so180475ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Sep 2010 05:46:23 -0700 (PDT)
Date: Thu, 2 Sep 2010 16:46:17 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: sposelenov@emcraft.com
Subject: Re: [PATCH 1/2] [PPC] Motion-PRO: Added LED support for the
	Promess Motion-Pro board. The driver is based on the original
	version(http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg06694.html),
	adapted for the current kernel structures.
Message-ID: <20100902124617.GA27957@oksana.dev.rtsoft.ru>
References: <1283422832-9620-1-git-send-email-sposelenov@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1283422832-9620-1-git-send-email-sposelenov@emcraft.com>
Cc: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 02, 2010 at 12:20:31PM +0200, sposelenov@emcraft.com wrote:
[...]
> +config LEDS_MOTIONPRO
> +	tristate "Motionpro LEDs Support"
> +	depends on LEDS_CLASS
> +	help
> +	  This option enables support for status and ready LEDs connected
> +	  to GPIO lines on Motionpro board.

Why not expose these GPIOs via GPIOLIB[1] and use generic GPIO
LEDs[2] driver, along with the timer LED trigger[3] for blinking?

Thanks,

[1] Documentation/gpio.txt
    Documentation/powerpc/dts-bindings/gpio/gpio.txt
[2] drivers/leds/leds-gpio.c
    Documentation/powerpc/dts-bindings/gpio/led.txt
[3] drivers/leds/ledtrig-timer.c

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
