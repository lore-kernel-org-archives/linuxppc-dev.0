Date: Mon, 25 Mar 2002 09:51:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Val Henson <val@nmt.edu>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
In-Reply-To: <20020324164649.32343@smtp.wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0203250948360.11999-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Mar 2002, Benjamin Herrenschmidt wrote:
> Which means that as soon as you want to add more infos, you will have
> to deal with all the pre-bi_rec problems when you own stuffs have to
> evolve. (versionning etc...).
>
> Again, for anything not realted to device drivers infos (things like
> HW ethernet addresses, PHY IDs, eventually interrupt routing), a whole
> bunch of bi_rec types will be left free by the kernel for use by your
> proprietary stuff the way you want, so you can pretty much define
> whatever you want (or not, it's up to you).
>
> But, I feel it's more convenient for drivers to use this signle-level
> BI_DEVICE bi_rec that contains itself bi_recs.
>
> >I really agree with Dan Malek on this - we shouldn't use bi_recs as a
> >way to reimplement methods of passing information that already exist,
> >for example, the __setup() functions.  It should be a way of passing
> >information that only a bootloader can know, such as the location of a
> >ramdisk, or the command line that the user typed into the bootloader.
>
> Which is exactly what I'm proposing. Passing generic informations like
> CPU core clocks, command line, ramdisk, etc... is done via bi_recs at
> the toplevel.
>
> The BI_DEVICE bi_rec's allow to provide other informations that are
> also only known by the firmware (most of the time), like eth MAC
> address, PHY wiring, or other kind of wiring informations related
> to a given rev. of a board, etc... provided that those infos
> concern a given driver for a specific device. It's also a convenient
> way to provide interrupt routing informations.

Alternatively, why not create a whole device tree for this? There already
exists a standard for device trees: IEEE 1275 Open Firmware. Then you need only
one extra bi_rec tag: BI_OF_TREE.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
