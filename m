Return-Path: <m.nazarewicz@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
	[210.118.77.11]) by ozlabs.org (Postfix) with ESMTP id 0EF731007D1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 00:24:07 +1000 (EST)
Received: from eu_spt1 (mailout1.w1.samsung.com [210.118.77.11])
	by mailout1.w1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L6J00D2Q403X0@mailout1.w1.samsung.com> for
	linuxppc-dev@ozlabs.org; Mon, 02 Aug 2010 15:24:03 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
	by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul
	14 2004)) with ESMTPA id <0L6J00BNN40132@spt1.w1.samsung.com> for
	linuxppc-dev@ozlabs.org; Mon, 02 Aug 2010 15:24:03 +0100 (BST)
Date: Mon, 02 Aug 2010 16:25:34 +0200
From: =?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?= <m.nazarewicz@samsung.com>
Subject: Re: [PATCH] usb gadget: don't save bind callback in struct
	usb_gadget_driver
In-reply-to: <1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-usb@vger.kernel.org,
	=?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Message-id: <op.vgtecwcq7p4s8u@pikus>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8; format=flowed; delsp=yes
References: <op.vgs04dub7p4s8u@pikus>
	<1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: Cliff Cai <cliff.cai@analog.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>, Takashi Iwai <tiwai@suse.de>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Julia Lawall <julia@diku.dk>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Philipp Zabel <philipp.zabel@gmail.com>,
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
	=?utf-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Tobias Klauser <tklauser@distanz.ch>, Anatolij Gustschin <agust@denx.de>,
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
	Eric Miao <eric.y.miao@gmail.com>,
	=?utf-8?Q?N=C3=A9meth_M=C3=A1rton?= <nm127@freemail.hu>,
	Jiri Kosina <jkosina@suse.cz>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
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

Some random thoughts, one bug and mostly just minor comments:

> @@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
>  }
> /* Called by gadget driver to register itself */
> -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct udc		*dev =3D udc;
>  	int			retval;
>  	u32 tmp;
>-	if (!driver || !driver->bind || !driver->setup
> +	if (!driver || bind || !driver->setup


** BUG: Should read "!bind".


> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_u=
dc.c
> @@ -1612,7 +1613,7 @@ int usb_gadget_register_driver (struct usb_gadge=
t_driver *driver)
>  	DBG("bound to %s\n", driver->driver.name);
>  	return 0;
>  }
> -EXPORT_SYMBOL (usb_gadget_register_driver);
> +EXPORT_SYMBOL (usb_gadget_probe_driver);

How about also correcting space before "("?

> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/=
atmel_usba_udc.c
> @@ -1789,7 +1789,8 @@ out:
>  	return IRQ_HANDLED;
>  }
>-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct usba_udc *udc =3D &the_udc;
>  	unsigned long flags;

There was no checking here?  How about adding?

> diff --git a/drivers/usb/gadget/ci13xxx_udc.c b/drivers/usb/gadget/ci1=
3xxx_udc.c
> @@ -2340,12 +2340,13 @@ static const struct usb_ep_ops usb_ep_ops =3D =
{
>  static const struct usb_gadget_ops usb_gadget_ops;
> /**
> - * usb_gadget_register_driver: register a gadget driver
> + * usb_gadget_probe_driver: register a gadget driver
>   *
> - * Check usb_gadget_register_driver() at "usb_gadget.h" for details
> - * Interrupts are enabled here
> + * Check usb_gadget_probe_driver() at "usb_gadget.h" for details.
> + * Interrupts are enabled here.
>   */

usb_gadget.h is the old name.  How about correcting it as well?

> diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/fi=
le_storage.c
> @@ -3583,7 +3582,7 @@ static int __init fsg_init(void)
>  	if ((rc =3D fsg_alloc()) !=3D 0)
>  		return rc;
>  	fsg =3D the_fsg;
> -	if ((rc =3D usb_gadget_register_driver(&fsg_driver)) !=3D 0)
> +	if ((rc =3D usb_gadget_probe_driver(&fsg_driver, fsg_bind)) !=3D 0)

I'm tempted to propose:

+ rc =3D usb_gadget_probe_driver(&fsg_driver, fsg_bind);
+ if (rc !=3D 0)

which is more compatible with coding style but it probably would be inco=
nsistent
with the rest of the code.

> diff --git a/drivers/usb/gadget/langwell_udc.c b/drivers/usb/gadget/la=
ngwell_udc.c
> @@ -1807,7 +1807,8 @@ static DEVICE_ATTR(langwell_udc, S_IRUGO, show_l=
angwell_udc, NULL);
>   * the driver might get unbound.
>   */
>-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct langwell_udc	*dev =3D the_controller;
>  	unsigned long		flags;

Again, function has no checking, how about adding?

> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_ga=
dget.c
> @@ -1698,7 +1698,8 @@ void musb_gadget_cleanup(struct musb *musb)
>   * @param driver the gadget driver
>   * @return <0 if error, 0 if everything is fine
>   */

I've just noticed that it misses @param bind in the comment.  Would be g=
reat to update it
and all other occurrences.

> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> @@ -798,17 +797,18 @@ struct usb_gadget_driver {
>   */
> /**
> - * usb_gadget_register_driver - register a gadget driver
> - * @driver:the driver being registered
> + * usb_gadget_probe_driver - probe a gadget driver
> + * @driver: the driver being registered

+ * @bind: the driver's bind callback.

>   * Context: can sleep
>   *
>   * Call this in your gadget driver's module initialization function,
>   * to tell the underlying usb controller driver about your driver.
> - * The driver's bind() function will be called to bind it to a
> - * gadget before this registration call returns.  It's expected that
> - * the bind() functions will be in init sections.
> + * The bind() function will be called to bind it to a gadget before t=
his
> + * registration call returns.  It's expected that the bind() function=
 will

Maybe "the @bind function" in those two places?

So for what it's worth, I haven't noticed any other obvious problems.

I think it still does not fix all the section mismatch warnings -- would=
 have to look
closer at composite gadgets -- so I think still parts of my patch is leg=
it.

-- =

Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=3D./ `o
| Computer Science,  Micha=C5=82 "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
