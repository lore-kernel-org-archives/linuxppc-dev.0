Date: Thu, 29 Jan 2004 09:11:04 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Pavel Machek <pavel@ucw.cz>, Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	<ncunningham@clear.net.nz>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
In-Reply-To: <1075326924.5658.299.camel@gaston>
Message-ID: <Pine.LNX.4.44.0401290908290.16923-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > OK. I put a mdelay(100) between the PMU_SYSTEM_READY request and the
> > pmu_suspend() call in pmu_sys_resume and it seems to work so far. Side
> > note: if you are saving a large system and have multiple swap files, play
> > with swap priorities to make sure the pages are swapped out to the file
> > _not_ used for suspend.
>
> Ah ? What's up ? suspend trashes the swap ? That's very bad...

Nope; freeing memory puts everything in the highest priority swap (happens
to be the first one), and suspend doesn't find enough room in that swap
area. The calculation of free swap done by pmdisk is bogus, it calculates
total free swap, not free swap in the area that pmdisk is going to use for
the snapshot.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
