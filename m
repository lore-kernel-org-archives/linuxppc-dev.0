Date: Wed, 28 Jan 2004 17:09:36 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Pavel Machek <pavel@ucw.cz>, Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	<ncunningham@clear.net.nz>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
In-Reply-To: <1075238892.17953.201.camel@gaston>
Message-ID: <Pine.LNX.4.44.0401281707260.21460-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Battery requests might have been underway; pmud is running. If I read
> > pmu_suspend() right, pending battery requests should result in pmu_suspend
> > waiting for them to finish?
>
> Normally yes... pmud isn't running at this point (all processes are frozen)

OK. I put a mdelay(100) between the PMU_SYSTEM_READY request and the
pmu_suspend() call in pmu_sys_resume and it seems to work so far. Side
note: if you are saving a large system and have multiple swap files, play
with swap priorities to make sure the pages are swapped out to the file
_not_ used for suspend.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
