Date: Mon, 10 Jul 2000 23:12:51 -0700
From: Matt Porter <mmporter@home.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Michael Lundkvist <ml@epact.se>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
Message-ID: <20000710231251.B23538@cx258813-a.chnd1.az.home.com>
References: <20000708162915.A11060@cx258813-a.chnd1.az.home.com> <Pine.HPX.4.10.10007101358110.9548-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10007101358110.9548-100000@gra-ux1.iram.es>; from paubert@iram.es on Mon, Jul 10, 2000 at 02:12:08PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 10, 2000 at 02:12:08PM +0200, Gabriel Paubert wrote:
>
>
> On Sat, 8 Jul 2000, Matt Porter wrote:
>
> >
> > On Thu, Jul 06, 2000 at 07:32:49PM +0200, Michael Lundkvist wrote:
> > >
> > > Gabriel Paubert <paubert@iram.es> writes:
> > > > Under 2.2.12 dd if=/dev/hda of=xxx bs=512 count=1 and see what comes out.
> > > > Can PPCBUG actually boot from these disks ?
> >
> > PPCBUG expects a little endian partition table, so no.
>
> Ok, my queston was rather: does PPCBUG have support for generic IDE
> interfaces or not ?

Do you mean standard PCI IDE interfaces as in the PCI spec addon?  I'm
pretty sure that the init code doesn't put the onboard controllers in
native mode so the Ramix controller on the bus will need massaged to
get into native mode so it can relocated safely in I/O space.  So,
the answer is no.

> > I really have to recommend against that.  Once Ramix sees the icky PPCBUG
> > code they will hate as much as I do.  I gave well documented changes to
> > the PPCBUG guys so that BUGBOOT wasn't needed to boot a kernel from
> > FLASH on a PowerPlus board but they haven't incorporated those changes
> > after a full year now. :)
>
> The other change I would like to see in PPCBUG is that it complies with
> the documentatioon that claims that its services will work when the MMU is
> enabled. At least on 603e it does not work since it sets the MSR IP bit
> and then silently crashes in the TLB handlers. I doubt that this would
> work on a 604 or a 750 either (I did not test it), but if you get an ISI
> or DSI exception, you are probably screwed too.

:)
> If people volunteer to write a new MVME bootrom from scratch (or a working
> OF), I shall be the first in line to get it and flash it in my boards.
> ppc*BUG* deserves its name, at least the second part :-(

There's a few different bootrom projects in fairly early stages and
lots of interest from various embedded Linux parties since many
board manufacturers don't have anything more than VxWorks BSPs for
their hardware and now want Linux support.  I'm predicting that you'll
see some usable GPL bootrom frameworks/code come out of this need in
the near future.  I swear I saw a free OF project forming somewhere
too.

I agree on that last part, it is buggy and impossible to maintain due
to it's poor design.  It's a true testament to the failure of rushed
proprietary software.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
