Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F8AEB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 04:56:54 +1100 (EST)
Received: from mail185-va3 (localhost.localdomain [127.0.0.1])	by
	mail185-va3-R.bigfish.com (Postfix) with ESMTP id 25041D60347	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 17:56:48 +0000 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.249])	by
	mail185-va3.bigfish.com (Postfix) with ESMTP id 9CC0CE60053	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 17:56:47 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id oBAHww29004686	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 10:58:58 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oBAHufdM019447	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 11:56:42 -0600 (CST)
Date: Fri, 10 Dec 2010 11:56:39 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101210115639.08d37db9@udp111988uds.am.freescale.net>
In-Reply-To: <OF260A956E.E4DC084C-ONC12577F5.00456569-C12577F5.00457DC0@transmode.se>
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
	<20101208220245.GB26836@postdiluvian.org>
	<20101208162559.26e40cf2@udp111988uds.am.freescale.net>
	<OF260A956E.E4DC084C-ONC12577F5.00456569-C12577F5.00457DC0@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Mark Mason <mason@postdiluvian.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Dec 2010 13:39:01 +0100
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> Scott Wood <scottwood@freescale.com> wrote on 2010/12/08 23:25:59:
> >
> > On Wed, 8 Dec 2010 17:02:45 -0500
> > Mark Mason <mason@postdiluvian.org> wrote:
> >
> > > I don't think that using a software NAND controller instead of the LBC
> > > FCM mode is all that bad.  Again, I haven't actually done it, so check
> > > the MTD docs, but I'm pretty sure the software is meant to do that, so
> > > it doesn't even really constitute a "fix".  Assuming that it is
> > > supported then I doubt that configuring the NAND layer to use your
> > > setup would be any harder than configuring the FCM.
> >
> > The MTD layer supports some really simple NAND controllers, but what do
> > you mean by not having a controller at all?  Hooking everything up to
> > GPIO?  Using UPM?
> >
> > There is already a UPM NAND driver, BTW.
> >
> > You would lose hardware ECC and the ability to be interrupt-driven (the
> > latter should be possible with SW changes, using GPIO interrupts).
> 
> hmm, you think it would be possible to use one of the IRQ pins instead?

GPIO should be fine, software just needs to be changed to use the
interrupt functionality.

An external IRQ line would let you limit interrupts to rising edges
rather than all edges, though you'd lose the ability to directly read
the line status.

-Scott
