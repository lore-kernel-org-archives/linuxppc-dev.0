From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Sun, 24 Mar 2002 17:46:49 +0100
Message-Id: <20020324164649.32343@smtp.wanadoo.fr>
In-Reply-To: <20020324120930.A14640@boardwalk>
References: <20020324120930.A14640@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I had an amazing and brilliant insight (which I'm sure everyone else
>has already had). :) The kernel just ignores bi_recs it doesn't
>understand.  Really, you don't need any BI_DEV_TYPE's for non-core
>kernel code - just a type that the kernel is guaranteed never to use
>for any other bi_rec type.

Of course you want to add whatever additional bi_recs, and among the things
I propose is the definition that the kernel will only use all-lowercase
bi_rec types for it's own use leaving any other combo for other uses.

The point is to pass informations to drivers in a bit cleaner
way than inventing a bi_rec type for each combination of driver
and attribute (expecially if a given board can decline in several
models with, for example, a different number of on-chip eth controllers,
or things like that).

>How about one BI_IGNORE type, and driver writers and firmware authors
>can put whatever they feel like inside that bi_rec?  The BI_IGNORE
>bi_rec can contain whatever you want - more bi_recs, object code,
>random data - and it would be the driver and firmware writers'
>responsibility to make them match up.  I personally think this is an
>awful idea, but it would give everyone the freedom they want while
>staying within the very nice bi_rec interface.  The rest of the
>bi_recs, the ones that the core kernel code will interpret, can be
>simple, one-dimensional bi_recs.  What do you think, Ben?

Which means that as soon as you want to add more infos, you will have
to deal with all the pre-bi_rec problems when you own stuffs have to
evolve. (versionning etc...).

Again, for anything not realted to device drivers infos (things like
HW ethernet addresses, PHY IDs, eventually interrupt routing), a whole
bunch of bi_rec types will be left free by the kernel for use by your
proprietary stuff the way you want, so you can pretty much define
whatever you want (or not, it's up to you).

But, I feel it's more convenient for drivers to use this signle-level
BI_DEVICE bi_rec that contains itself bi_recs.

>I really agree with Dan Malek on this - we shouldn't use bi_recs as a
>way to reimplement methods of passing information that already exist,
>for example, the __setup() functions.  It should be a way of passing
>information that only a bootloader can know, such as the location of a
>ramdisk, or the command line that the user typed into the bootloader.

Which is exactly what I'm proposing. Passing generic informations like
CPU core clocks, command line, ramdisk, etc... is done via bi_recs at
the toplevel.

The BI_DEVICE bi_rec's allow to provide other informations that are
also only known by the firmware (most of the time), like eth MAC
address, PHY wiring, or other kind of wiring informations related
to a given rev. of a board, etc... provided that those infos
concern a given driver for a specific device. It's also a convenient
way to provide interrupt routing informations.

>People who don't agree with this philosophy can shove whatever they
>like into the BI_IGNORE record type, and suffer the consequences. :)

No. A BI_IGNORE makes no sense. A whole class of bi_rec types guaranteed
not to be used by the kernel makes sense. I don't want to fix the kernel
side of the problem just to put back the same problem on my vendor specific
infos (I have various ones; depending on the product, they can have to evolve
especially as I have to maintain different revisions of the produce, and if
possible with the same kernel / firmware). It's always a win when you don't
have to change a line of the kernel code because your HW engineer wired an
interrupt differently. That means I only have to update the tables in
the firmware and not touch the kernel version.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
