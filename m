Date: Sun, 24 Mar 2002 20:38:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Val Henson <val@nmt.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
In-Reply-To: <20020324120930.A14640@boardwalk>
Message-ID: <Pine.GSO.4.21.0203242036480.11148-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Mar 2002, Val Henson wrote:
> On Sun, Mar 24, 2002 at 01:20:48PM +0100, Benjamin Herrenschmidt wrote:
> > We define a special BI_DEVICE type of bi_rec that represents
> > a HW device for which the firmware provides some informations. Since
> > the firmware is free to provide whatever informations it want (that
> > set is not fully defined), the content of the BI_DEVICE record is itself
> > a list of bi_recs.
> <snip>
> > The "standard" kernel only define a few BI_DEV_TYPE's (like PCI,
> > 4xx OCP, 8xx OCP). Drivers define attributes they can read from the
> > BI_DEVICE (4xx ethernet can read a HW eth adress for example).
> > Board vendors are free to provide additional information in the
> > BI_DEVICE, and add the ability to the driver (patches welcome) to
> > make good use of that information ;) (Could be, for example, wiring
> > of the PHY since it may not use MII, etc...).
> >
> > What do you think ?
>
> I had an amazing and brilliant insight (which I'm sure everyone else
> has already had). :) The kernel just ignores bi_recs it doesn't
> understand.  Really, you don't need any BI_DEV_TYPE's for non-core
> kernel code - just a type that the kernel is guaranteed never to use
> for any other bi_rec type.

Yes indeed.

BTW, I just thought of something different: some people want to keep data
stored in bi_recs for later use, after the initialization of the kernel. What
about a new tag to mark data that is to be copied and stored for later use?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
