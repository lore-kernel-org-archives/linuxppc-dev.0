Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 7D9ADB70A4
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 08:56:37 +1000 (EST)
Date: Mon, 2 Aug 2010 15:54:40 -0700
From: Greg KH <gregkh@suse.de>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] usb gadget: don't save bind callback in struct
	usb_gadget_driver
Message-ID: <20100802225440.GA9190@suse.de>
References: <op.vgs04dub7p4s8u@pikus>
	<1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<Pine.LNX.4.64.1008021446470.10662@ask.diku.dk>
	<20100802131248.GD13900@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100802131248.GD13900@pengutronix.de>
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
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Fabien Chouteau <fabien.chouteau@barco.com>,
	Dan Carpenter <error27@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Vladimir Zapolskiy <vzapolskiy@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Vincent Sanders <support@simtec.co.uk>, Marc Singer <elf@buici.com>,
	David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
	=?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Tobias Klauser <tklauser@distanz.ch>, Anatolij Gustschin <agust@denx.de>,
	Alexey Dobriyan <adobriyan@gmail.com>, Eirik Aanonsen <eaa@wprmedical.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Thomas Dahlmann <dahlmann.thomas@arcor.de>,
	linux-geode@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	Magnus Damm <damm@igel.co.jp>, Thomas Gleixner <tglx@linutronix.de>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org,
	Robert Lukassen <robert.lukassen@tomtom.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	=?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>,
	Jiri Kosina <jkosina@suse.cz>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-usb@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Nazarewicz <m.nazarewicz@samsung.com>,
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

On Mon, Aug 02, 2010 at 03:12:48PM +0200, Uwe Kleine-König wrote:
> On Mon, Aug 02, 2010 at 02:51:36PM +0200, Julia Lawall wrote:
> > > diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
> > > index 731150d..c266c1e 100644
> > > --- a/drivers/usb/gadget/amd5536udc.c
> > > +++ b/drivers/usb/gadget/amd5536udc.c
> > > @@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
> > >  }
> > >  
> > >  /* Called by gadget driver to register itself */
> > > -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> > > +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> > > +		int (*bind)(struct usb_gadget *))
> > >  {
> > >  	struct udc		*dev = udc;
> > >  	int			retval;
> > >  	u32 tmp;
> > >  
> > > -	if (!driver || !driver->bind || !driver->setup
> > > +	if (!driver || bind || !driver->setup
> > 
> > I have the impression that this should be !bind rather than bind.  
> ah, now I see what you meant.  Obviously you're right.  I fixed it up
> locally here for now.  Greg, just tell me when/if you need a fixed
> patch.

Didn't you already post a "fixed" patch?

thanks,

greg k-h
