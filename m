Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Pavel Machek <pavel@ucw.cz>, Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	ncunningham@clear.net.nz,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.44.0401271130010.23778-100000@opal.biophys.uni-duesseldorf.de>
References: 
	 <Pine.LNX.4.44.0401271130010.23778-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain
Message-Id: <1075199877.5659.190.camel@gaston>
Mime-Version: 1.0
Date: Tue, 27 Jan 2004 21:37:57 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I don't mind the wait for memory being freed. Copying more pages with
> interrupts disabled would mean a higher chance for PMU lockup, won't it?

It's also possible that there is a bug and it just crashes :)

Also, I do suspend devices before the page copy, and I quickly hacked a
PMU sysdev that should suspend ADB interrupts (at least) so that should
be fine, except if you have a brightness request in flight maybe ?

The whole PMU suspend thing must be reworked I suppose. (And the battery
monitoring thing "paused" as well, we must wait for async PMU requests,
that is at least battery requests and backlight ones to stop)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
