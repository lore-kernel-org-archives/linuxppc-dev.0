Date: Fri, 24 Mar 2000 19:27:40 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <20000324181746.026025@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10003241842211.22814-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >I'd like to reach a point where I understand what's happening in the
> >XFree PCI code before getting into that sort of discussion. And the X
> >source is way too convoluted for me to achieve that right now.
> >
> >I'll stick to pre-4.0 XFree rather.
>
> I spent some time discussion with Egbert. The result is basically that in
> order to support all archs, bogus BIOS, legacy cards, softbooting, etc...
> XF must take over the PCI the way it does it. There are lots of reasons
> for that, I could try to summarize them if you really want the gory
> details, I beleive Egbert is bored of repeating himself all the time ;)

Nah, I take this to mean we better fix our PCI resource conflicts in the
kernel if at all possible. But as I see everybody juggle with PCI resource
and hot swap options only available in 2.3 the XFree people should plaster
a big fat warning 'will not work with 2.2 kernels on some PPC hardware' on
their release notes.
'Resource conflict' isn't even strictly true, the PIO resource on the Rage
Pro is disabled (so we'd probably better use the MMIO range), and MMIO is
a subrange of the full aperture. It's not violating anything as far as I
can see.

> I suggested making that optional (and relying, for example, only on fbdev
> or disabling the re-assignement when the appropriate option is set in
> XF86Config), but Egbert thinks that would be a support nightmare with
> users playing with the config options.

I sometimes wonder - the FBDev X server used to be a painless thing: the
kernel frame buffer driver would handle the gory details and X would use a
simplified, maybe slow but stable interface. X used to deal with that
fine. Suddenly the kernel isn't to be trusted to correctly set up things
anymore, and we're back to square one in terms of X stability. How did
that happen?

> He agrees that things are not perfect, especially since the way we handle
> PIO and iobase is bogus (see other discussions about this). Also, the
> current remapping scheme can make the kernel (and fbdev) quite confused
> with new hot-swap PCI, Cardbus, etc... He plans to rework the PCI
> interface of XFree so that better cooperation with the kernel can be

I'd be glad if the X PCI code would recognize the same facts as reported
via the kernel /proc/bus/pci interface, and 1) leave disabled regions
alone and not bitch about them, 2) tolerate one region being fully
contained inside another if it's on the same card. But it sure is easier
to work around X.

> implemented. On another hand, I think _we_ should find a definitive
> solution for the PIO problem before he can begin adapting XFree. There
> are lots of changes to be done to legacy drivers (VGA) to make them grok
> a notion of iobase (since iobase can be different per-device, it can't be
> handled inside inb/outb and friends).

Can't the PIO registers be accessed via the MMIO aperture? Either way,
with non accelerated framebuffer drivers there's no need to ever use VGA
registers. And there's no fbdev driver for stupid VGA cards (yuck). It's a
non issue from my point of view.

> Note that XF will always have to disable IO response on VGA cards when
> more than one card is present in the machine since that's the only way to
> prevent 2 VGA cards from trying to hard-decode legacy VGA addresses at
> the same time. We need to find a way to make the kernel (and the fbdev)
> aware of what's going on.

X is free to disable whatever it likes on cards that aren't handled by
framebuffer drivers. It should not disable anything otherwise and leave it
to the kernel framebuffer drivers to sort things out. More communication
between X and kernel is fine, but why not leave things as they were for
framebuffer drivers? This is all that the framebuffer concept was about,
why throw it out?
You probably have had all these discussions with the X team already and
there's nothing of substance I could add, presumably. It does sound like
the old framebuffer driver concept is dead for good so we need to find
other ways.

> No time do give more details now, tell me if you need more precisions on
> one of these specific points.

I'd just need specifics on how to fudge the ATI PCI resources from kernel
space. I'll take cues from the 2.3 resource handling code and hope to not
blow up my system too badly.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
