Date: Tue, 27 Jan 2004 15:32:26 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Pavel Machek <pavel@ucw.cz>, Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	<ncunningham@clear.net.nz>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
In-Reply-To: <1075199877.5659.190.camel@gaston>
Message-ID: <Pine.LNX.4.44.0401271400530.5220-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I don't mind the wait for memory being freed. Copying more pages with
> > interrupts disabled would mean a higher chance for PMU lockup, won't it?
>
> It's also possible that there is a bug and it just crashes :)
>
> Also, I do suspend devices before the page copy, and I quickly hacked a
> PMU sysdev that should suspend ADB interrupts (at least) so that should
> be fine, except if you have a brightness request in flight maybe ?

I haven't. I've added another pmu_suspend/pmu_resume around the bulk of
pmdisk_save, that seems to have improved things (but not completely). It's
executed outside your sysdev calls, so it shouldn't really improve things.

> The whole PMU suspend thing must be reworked I suppose. (And the battery
> monitoring thing "paused" as well, we must wait for async PMU requests,
> that is at least battery requests and backlight ones to stop)

Battery requests might have been underway; pmud is running. If I read
pmu_suspend() right, pending battery requests should result in pmu_suspend
waiting for them to finish?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
