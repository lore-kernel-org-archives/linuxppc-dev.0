Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 6BDD3DDE1E
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 07:20:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so26238anc
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 12:20:36 -0800 (PST)
Message-ID: <fa686aa40711241220r4e808ad8obb27ae8bf5890048@mail.gmail.com>
Date: Sat, 24 Nov 2007 13:20:36 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 5/5] USB: Add Cypress c67x00 OTG controller driver to
	Kconfig and Makefiles
In-Reply-To: <200711241212.27787.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124002451.25361.90102.stgit@trillian.cg.shawcable.net>
	<200711241212.27787.david-b@pacbell.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/24/07, David Brownell <david-b@pacbell.net> wrote:
> On Friday 23 November 2007, Grant Likely wrote:
> > +config USB_C67X00_DRV
> > +tristate "Cypress C67x00 support"
> > +# only allowed to be =y if both USB!=m and USB_GADGET!=m
>
> This is wrong.  Remember that since this is a dual-role driver,
> there are exactly three possible driver modes ... and the driver
> must support only one of them at a time:

Actually, this part has 2 serial in interface engines; either of which
can be in host, peripheral or OTG mode.  So; it is entirely relevant
for the driver to be doing both host and peripheral at the same time
with a single device.

>
>   - Host-only ... only allowed if host side USB is enabled.  The
>     controller driver can be statically linked iff usbcore is too.
>
>   - Peripheral-only ... only allowed if peripheral side USB is
>     enabled.  Only one port may be used as the peripheral; the
>     controller driver can be linked statically or as a module.
>
>   - OTG ... only allowed if both host and peripheral side USB
>     are enabled.  Only one port can be the OTG port, but other
>     ports can be used for host functionality.  Static/modular
>     linkage follows (more restrictive) the host-only rule.
>
> And of course, what a given board supports is controlled by the
> connectors it has ... A, B, or AB.  (Possibly AB plus n*A.)  So
> the driver should probably be able to make sense of having OTG
> support, but needing to cope with a non-OTG board ... or having
> an OTG board, a driver that only copes with one role.
>
> Hmmm ... your patches don't include peripheral mode support yet.

No, nobody has written it yet.

>
> Either all these gadget hooks should vanish, or you should try
> to get the controller mode stuff right from the beginning.
>
> I've appended the relevant Kconfig bits from the musb_hdrc
> driver, which (despite some glitches) are pretty much correct.

I'll drop the gadget hooks for now.  Most likely gadget and OTG
support will require more changes to this driver regardless, so it's
not a big deal.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
