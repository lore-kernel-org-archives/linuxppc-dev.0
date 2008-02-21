Return-Path: <david-b@pacbell.net>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by ozlabs.org (Postfix) with SMTP id 3FB0BDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 14:06:38 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v8 3/4] USB: add Cypress c67x00 OTG controller HCD driver
Date: Wed, 20 Feb 2008 19:06:35 -0800
References: <20080220090727.904160000@sunsite.dk>
	<20080220091401.612406000@sunsite.dk>
In-Reply-To: <20080220091401.612406000@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802201906.35830.david-b@pacbell.net>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, stern@rowland.harvard.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 20 February 2008, Peter Korsgaard wrote:
> +ifeq ($(CONFIG_USB_DEBUG),y)
> +       EXTRA_CFLAGS            += -DDEBUG
> +endif

The canonical Sam Ravnborg comment is to replace that with:

  +ccflags-$(CONFIG_USB_DEBUG)    += -DDEBUG

It's a newish idiom, most easily applied to new code before
it merges ...  :)


> +++ linux-2.6/drivers/usb/host/Kconfig
> @@ -261,3 +261,15 @@
>           To compile this driver as a module, choose M here: the
>           module will be called r8a66597-hcd.
>  
> +config USB_C67X00_HCD
> +       tristate "Cypress C67x00 HCD support"
> +       depends on USB

And I realize that some of the drivers there have violated the
normal "alphabetical order" convention, so maybe one big
cleanup patch would be in order ... but still, I'd rather see
such new options added in the right place, rather than need
to see them fixed up later.

- Dave
