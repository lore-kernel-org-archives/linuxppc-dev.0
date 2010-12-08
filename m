Return-Path: <mason@postdiluvian.org>
Received: from porklips.postdiluvian.org (postdiluvian.org [128.30.54.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1790B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 09:02:50 +1100 (EST)
Date: Wed, 8 Dec 2010 17:02:45 -0500
From: Mark Mason <mason@postdiluvian.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101208220245.GB26836@postdiluvian.org>
References: <20101207145153.540da45a@udp111988uds.am.freescale.net>
	<OFF94B1B01.88594E81-ONC12577F3.002B63AA-C12577F3.002BEE0B@transmode.se>
	<20101208111839.1cf95553@udp111988uds.am.freescale.net>
	<OF349DC945.8BC48D34-ONC12577F3.00601D94-C12577F3.00605153@transmode.se>
	<20101208192616.GA24560@postdiluvian.org>
	<OF14047E09.664EC753-ONC12577F3.006CF507-C12577F3.006D97EA@transmode.se>
	<20101208135928.0278f97d@udp111988uds.am.freescale.net>
	<OFC37E86C9.59866BED-ONC12577F3.006E8F8D-C12577F3.006EE1FA@transmode.se>
	<20101208142551.19ea2333@udp111988uds.am.freescale.net>
	<OF6F049A4C.3AEB4068-ONC12577F3.00751175-C12577F3.0075D3F5@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF6F049A4C.3AEB4068-ONC12577F3.00751175-C12577F3.0075D3F5@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> > > Is there any risk that the NAND device will drive the LB and
> > > corrupt the bus for other devices?
> >
> > I think the only thing the NAND chip should be driving is the busy pin,
> 
> OK, good. What function is actually lost if one uses an GPIO instead
> of BUSY?

I tried to take this route, since it was a fairly minor board change.
Unfortunately all the GPIOs were already used.

I looked long and hard for a way to not have the NAND hold the bus
with BUSY.  If you don't connect BUSY then you can't use the LBC's
flash controller (FCM mode).

I haven't done it personally, but I believe that connecting BUSY to a
GPIO is very common thing to do, since this is the route you'd have to
take if you didn't have a built-in flash controller.  The Linux MTD
layer supports it.

> An even better workaround would be if one could add logic between
> the NAND and the CPU which would compensate for this defect without
> needing special SW fixes.

That probably won't work.  Presumably you're talking about something
like a gate so the BUSY is only passed from the NAND when the NAND's
chip select is asserted.  Unfortunately the NAND controller is
monitoring the BUSY line, and if it sees the signal deassert then it
will think the NAND is done.

I don't think that using a software NAND controller instead of the LBC
FCM mode is all that bad.  Again, I haven't actually done it, so check
the MTD docs, but I'm pretty sure the software is meant to do that, so
it doesn't even really constitute a "fix".  Assuming that it is
supported then I doubt that configuring the NAND layer to use your
setup would be any harder than configuring the FCM.  And, U-Boot uses
the Linux MTD code, so you'd get the same support there.

There might also be a way to keep the BUSY and find a workaround with
the other chips on the bus, depending on what they are.  Chances are
that they have a BUSY, but maybe you could move the peripheral's BUSY
to another LBC line and use UPM mode to interpret that line as a BUSY.
Writing UPM programs isn't really all that difficult (well, not the
second time you do it anyway).  That's getting into kludge territory,
though.
