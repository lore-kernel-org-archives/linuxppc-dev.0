Date: Thu, 29 Jan 2004 00:35:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	ncunningham@clear.net.nz,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-ID: <20040128233509.GA336@elf.ucw.cz>
References: <Pine.LNX.4.44.0401281707260.21460-100000@opal.biophys.uni-duesseldorf.de> <1075326924.5658.299.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075326924.5658.299.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

> > > > Battery requests might have been underway; pmud is running. If I read
> > > > pmu_suspend() right, pending battery requests should result in pmu_suspend
> > > > waiting for them to finish?
> > >
> > > Normally yes... pmud isn't running at this point (all processes are frozen)
> >
> > OK. I put a mdelay(100) between the PMU_SYSTEM_READY request and the
> > pmu_suspend() call in pmu_sys_resume and it seems to work so far. Side
> > note: if you are saving a large system and have multiple swap files, play
> > with swap priorities to make sure the pages are swapped out to the file
> > _not_ used for suspend.
>
> Ah ? What's up ? suspend trashes the swap ? That's very bad...

No, it does not.

But swap space is shared between suspend and swap. And if that place
is full (unlikely), you've got a problem.
								Pavel
--
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
