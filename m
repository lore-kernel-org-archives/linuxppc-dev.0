Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B2F63B70E2
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 22:51:45 +1000 (EST)
Date: Mon, 2 Aug 2010 14:51:36 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] usb gadget: don't save bind callback in struct
	usb_gadget_driver
In-Reply-To: <1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1008021446470.10662@ask.diku.dk>
References: <op.vgs04dub7p4s8u@pikus>
	<1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Cc: Cliff Cai <cliff.cai@analog.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>, Takashi Iwai <tiwai@suse.de>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Philipp Zabel <philipp.zabel@gmail.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Felipe Balbi <felipe.balbi@nokia.com>,
	Andrea Gelmini <andrea.gelmini@gelma.net>,
	Robert Jarzmik <robert.jarzmik@free.fr>, Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <error27@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Vladimir Zapolskiy <vzapolskiy@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Vincent Sanders <support@simtec.co.uk>, Marc Singer <elf@buici.com>,
	David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Tobias Klauser <tklauser@distanz.ch>,
	Alexey Dobriyan <adobriyan@gmail.com>, Eirik Aanonsen <eaa@wprmedical.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Thomas Dahlmann <dahlmann.thomas@arcor.de>,
	linux-geode@lists.infradead.org,
	Fabien Chouteau <fabien.chouteau@barco.com>,
	Ben Dooks <ben-linux@fluff.org>, Magnus Damm <damm@igel.co.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org,
	Robert Lukassen <robert.lukassen@tomtom.com>,
	Anatolij Gustschin <agust@denx.de>, Eric Miao <eric.y.miao@gmail.com>,
	=?UTF-8?q?N=C3=A9meth=20M=C3=A1rton?= <nm127@freemail.hu>,
	Jiri Kosina <jkosina@suse.cz>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-usb@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Nazarewicz?= <m.nazarewicz@samsung.com>,
	Harro Haan <hrhaan@gmail.com>, Kyle McMartin <kyle@mcmartin.ca>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cory Maccarrone <darkstar6262@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
> index 731150d..c266c1e 100644
> --- a/drivers/usb/gadget/amd5536udc.c
> +++ b/drivers/usb/gadget/amd5536udc.c
> @@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
>  }
>  
>  /* Called by gadget driver to register itself */
> -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct udc		*dev = udc;
>  	int			retval;
>  	u32 tmp;
>  
> -	if (!driver || !driver->bind || !driver->setup
> +	if (!driver || bind || !driver->setup

I have the impression that this should be !bind rather than bind.  
That would be like what is done in the patch for 
drivers/usb/gadget/fsl_udc_core.c below


> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
> index 08a9a62..c16b402 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -1765,7 +1765,8 @@ static irqreturn_t fsl_udc_irq(int irq, void *_udc)
>   * Hook to gadget drivers
>   * Called by initialization code of gadget drivers
>  *----------------------------------------------------------------*/
> -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	int retval = -ENODEV;
>  	unsigned long flags = 0;
> @@ -1775,8 +1776,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  
>  	if (!driver || (driver->speed != USB_SPEED_FULL
>  				&& driver->speed != USB_SPEED_HIGH)
> -			|| !driver->bind || !driver->disconnect
> -			|| !driver->setup)
> +			|| !bind || !driver->disconnect || !driver->setup)
>  		return -EINVAL;

Here !driver->bind is converted to !bind.

julia
