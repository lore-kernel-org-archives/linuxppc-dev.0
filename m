Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.182.166]) by ozlabs.org (Postfix) with ESMTP id 66493679F2
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 22:07:44 +1000 (EST)
Received: from filter03.roc.ny.frontiernet.net
	(filter03.roc.ny.frontiernet.net [66.133.183.70])
	by relay03.roc.ny.frontiernet.net (Postfix) with ESMTP id E9A1E3580D2
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 12:07:41 +0000 (UTC)
Received: from relay03.roc.ny.frontiernet.net ([66.133.182.166])
	by filter03.roc.ny.frontiernet.net (filter03.roc.ny.frontiernet.net
	[66.133.183.70]) (amavisd-new, port 10024)
	with LMTP id 22691-02-13 for <linuxppc-embedded@ozlabs.org>;
	Fri, 3 Jun 2005 12:07:41 +0000 (UTC)
Received: from chuck2 (170-215-150-213.br1.rmn.wv.frontiernet.net
	[170.215.150.213])
	by relay03.roc.ny.frontiernet.net (Postfix) with ESMTP id 5FB41358398
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 12:07:34 +0000 (UTC)
Message-ID: <002901c56834$ef358f60$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <20050601165054.GA2607@logos.cnet><1117680392.31082.16.camel@gaston>
	<20050602170245.GA7456@logos.cnet>
	<1117750262.31082.73.camel@gaston>
Date: Fri, 3 Jun 2005 08:08:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [RFC] handle access to non-present IO ports on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > >
> > > Hrm... removing a PCMCIA card triggers mchecks ? that is bad... With
> > > "proper" PCMCIA controllers, those are swallowed properly when the
card
> > > is removed. The eating of the machine check is a bit too hackish to my
> > > taste... Better is to "not do that" by making sure the legacy crap
isn't
> > > trying  to tap unexisting ports, but then, if PCMCIA is also a
> > > problem...
> >
> > Well, cardmgr calls the driver's shutdown/close routine as soon as
> > the card is removed. Some of those methods write to IO registers in
> > the process (eg net/pcmcia/pcnet_cs.c).
> >
> > I dont see any elegant change that could be done in PCMCIA.
>
> I know, the thing is, on platforms with a "classical" PCI<->PCMCIA
> bridge, the bridge will not issue machine checks when the card is
> removed. I don't know if that is possible with your HW setup, I suppose
> you are hooking PCMCIA directly to the CPU IO bus ...
>

I forget if I pointed this out already or not, but there's a good chance the
mchecks you are seeing are from a bad PCMCIA implementation, not
the 8xx itself.  PCMCIA uses WAIT, which is a negative ACK really,
and that must be pulled up externally, so if you remove the card any
active WAIT goes away.  I'd be glad to take a look at the schematics
if available and tell you if I think there might be a problem there.

Then again, maybe it doesn't matter where the mchecks are coming
from, you just need to handle them...

Mark Chambers
