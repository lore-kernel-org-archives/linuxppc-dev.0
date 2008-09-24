Return-Path: <david-b@pacbell.net>
Received: from smtp124.sbc.mail.sp1.yahoo.com (smtp124.sbc.mail.sp1.yahoo.com
	[69.147.64.97]) by ozlabs.org (Postfix) with SMTP id D507ADDFDD
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 06:47:58 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Date: Wed, 24 Sep 2008 13:10:02 -0700
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<200808281704.20999.arnd@arndb.de>
In-Reply-To: <200808281704.20999.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809241310.03171.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 28 August 2008, Arnd Bergmann wrote:
> > +/*-------------------------------------------------------------------------
> > +     Gadget driver register and unregister.
> > + --------------------------------------------------------------------------*/
> > +int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> > +EXPORT_SYMBOL(usb_gadget_register_driver);
> > +
> > +int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
> > +EXPORT_SYMBOL(usb_gadget_unregister_driver);
> 
> Not addressing this driver in particular, but the USB gadget layer in
> general: This is a horrible interface, since every gadget driver exports
> the same symbols, 

Bad terminology.  Gadget drivers are what sit on TOP of peripheral
controller drivers ... only peripheral controller drivers touch the
actual hardware registers.  They export an abstract "gadget" interface.

Gadget drivers are what talk *to* that abstract interface.


> you can never build a kernel that includes more than 
> one gadget driver. Even if the drivers are all built as modules, simply
> loading one of them prevents loading another one.

That's never been a particular requirement.  Systems won't get
USB branding if they have more than one USB peripheral (upstream)
port.  Supporting more than one type of controller hardware is
at best a pretty esoteric configuration.

If you really want to see such stuff ... -ENOPATCH.  :)

- Dave
