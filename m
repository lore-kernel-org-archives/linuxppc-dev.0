Date: Mon, 8 Apr 2002 08:48:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020408154808.GH2716@opus.bloom.county>
References: <0204062023.AA17004@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204062023.AA17004@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Apr 06, 2002 at 12:23:17PM -0800, Michael Sokolov wrote:

> The platforms I've initially included in this new model are Adirondack,
> EV-64260A, and K2.

Just checking, but right now these are only supported with StarMON and
not necessarily their shipping ROMs, right? :)

> Other non-CONFIG_ALL_PPC 6xx/7xx/74xx boards in the current
> 2_4_devel can be easily added given someone knowledgeable about that board.
> (Some may require an #ifdef-ectomy.)

I'm sure it's unintentional, but it looks more like it'd be changing
platform_init to x_init, and serial fixes rather than changing #ifdefs.

>(And perhaps the PReP port
> could then be just like, say, the K2 port and the CHRP and PMac ones combined
> into a single OF port as I've heard suggestions.)

... And then the pplus stuff ripped out of the 'PReP' support and
CONFIG_PPLUS converted too.  Before we get too far along, I should say I
actually do like this idea.

> There is no extra overhead in the kernel for CONFIG_GENERIC_PPC32. A
> CONFIG_GENERIC_PPC32 configuration with only one port selected is no different
> from any of current castle-walled board ports in 2_4_devel.

Aside from some ugliness added back to the code (see my other email).

One other problem is that in case anyone forgot, back when we used to
always define a new _MACH type, we had actually ran out (or got w/in 3
or so) so we might want to think of changing the values in 2.5 to
something that can scale better, if we're going to do this.

> ... have a zImage wrapper that can sense the machine type,
> or have make zImage create a bunch of zImages for different ports

Well, in the case of most firmwares, this is what would be done.

> and/or
> bootloaders as done currently for CONFIG_ALL_PPC where make zImage gives you 3
> zImages for chrp, pmac, and prep.

It's worth noting why these are done as they are, since I'm not sure you
quite see why.  pmac and chrp fall into the same category as ppcstar,
which is 'We know the firmware, it can be useful, and we will use it'.
prep is more along the lines of 'Nothing useful here, but we've been
loaded, go go go!'.  The 'simple' stuff is 95% prep, but with the legacy
prep workarounds removed.  Also, pmac at least spits out 3 or 4 images
as it is.

> However, the arch/ppc/boot/simple way of
> doing things that the MVistities seem to love so much is fundamentally
> incompatible with this.

I'm sure there was no slight intended there, but the reason we 'love it
so' is that it just works.  If you've got a firmware which can load an
ELF image, that just works, barring HW/Firmware deficiencies/issues [1].
If you didn't have the option of replacing a firmware, I'd bet you'd end
up using it too :)

But anyhow, it's actually not incompatible with this.  I've gone and
looked at this abit, and it'd be a matter of re-writing the Makefile a
bit (obj-$(...) and XXX_OBJS -> platform.o, rm -f'ed after each zImage,
and then a -DMACH_TYPE=_MACH_xxx for one of the files..).

> The problem is what to do about all the other board ports I envision people
> adding, each having its own unique boot mechanism requiring its own zImage. In
> that case I don't see much choice other than extending the chrp/pmac/prep 3
> zImages model to N zImages for all those platform-unique booters.

Well, since 'simple' will still work, this is a non-issue once again.

> This will be
> an encouragement to board makers to use standardized firmware like OF,
> StarMON, or PPCBoot rather than roll a board-unique one: use something
> standard and you can use one of existing zImages, or roll your own and
> be prepared to convince people to accept adding yet another zImage.

Or use a firmware which can load an ELF image (pmon, yes?) or fake it
(IIRC, the embeddedplantet 8xx firmware doesn't quite do ELF, but it
does seem to recognize the header and skip it, if you don't strip it
off).

> OTOH, it seems like a lot of boards
> ship without any usable firmware at all and anyone wanting to run Linux has to
> reach for the PROM burner anyway. For those we can simply tell people to use
> StarMON or PPCBoot to run the new generic PPC Linux.

<joke>
Personally, I think some people spend too much time in the firmware and
not enough time actually in linux.
</joke>

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

[1]:  Take a look at what Matt did for 440 work.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
