Date: Thu, 20 Sep 2001 08:46:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010920084607.D13721@cpe-24-221-152-185.az.sprintbbd.net>
References: <EFEAIMDCOOOHIEPHDNFJEEMCDCAA.stefan.roese@esd-electronics.com> <3BAA093A.10E96272@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BAA093A.10E96272@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 11:20:26AM -0400, Dan Malek wrote:
>
> Stefan Roese wrote:
>
> > #ifndef __CPCI405_H
> > #define __CPCI405_H
> >
> > #include <linux/config.h>
> >
> > #include <asm/ppcboot.h>
> >
> > #endif  /* __CPCI405_H */
>
> This is fine, Tom said it was an empty file.........

Well, that's empty to me. :)  ppcboot.h should include linux/config.h and
that's all it does...

> > Dan, you are right that we (PPCBoot) people will have some homework to do,
> > but right now our only way to Linux is via the bd_info struct!
>
> No, the way to Linux is to _always_ use a zImage with an attached bootloader.
> PPCboot can continue to pass whatever it wants, or the bootloader can find
> the information in other ways as it does today with many boards.  Booting
> a vmlinux image and trying to keep track of that private interface between
> the bootloader and the kernel is difficult.  We already have more changes
> planned in addition to the bi_recs interface.  Much of the code found today
> in the head.S files is going to migrate to the bootloaders.

In the x86 world it's always true that we have a bit of a loader tacked
on someplace.  In some parts of the PPC world, we can't/don't for various
reasons (technical and/or ingrained).  For example, I don't see a problem
with something which takes a vmlinux.gz and boots it.  As long as we get the
information we need, we shouldn't care.  The in-kernel loaders are the easiest
to get changed.  But we should define what we're going to do before we do
it so that yaboot/ppcboot and apus can figure out how much re-working
they'll need and whatnot..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
