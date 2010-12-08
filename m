Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3112B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 09:05:42 +1100 (EST)
Received: from mail101-tx2 (localhost.localdomain [127.0.0.1])	by
	mail101-tx2-R.bigfish.com (Postfix) with ESMTP id C689410082A9	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 22:05:37 +0000 (UTC)
Received: from TX2EHSMHS031.bigfish.com (unknown [10.9.14.245])	by
	mail101-tx2.bigfish.com (Postfix) with ESMTP id 805F840055	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 22:05:37 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oB8M5YVN015170	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Dec 2010 15:05:34 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB8M5YA5013487	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Dec 2010 16:05:34 -0600 (CST)
Date: Wed, 8 Dec 2010 16:05:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101208160531.393bedf1@udp111988uds.am.freescale.net>
In-Reply-To: <OF6F049A4C.3AEB4068-ONC12577F3.00751175-C12577F3.0075D3F5@transmode.se>
References: <20101207031554.GA12731@postdiluvian.org>
	<20101207145153.540da45a@udp111988uds.am.freescale.net>
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

On Wed, 8 Dec 2010 22:26:59 +0100
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> Scott Wood <scottwood@freescale.com> wrote on 2010/12/08 21:25:51:
> >
> > On Wed, 8 Dec 2010 21:11:08 +0100
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >
> > > Scott Wood <scottwood@freescale.com> wrote on 2010/12/08 20:59:28:
> > > >
> > > > On Wed, 8 Dec 2010 20:57:03 +0100
> > > > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > >
> > > > > Can you think of any workaround such as not connecting the BUSY pin at all?
> > > >
> > > > Maybe connect the busy pin to a gpio?
> > >
> > > Is BUSY required for sane operation or it an optimization?
> >
> > You could probably get away without it by inserting delays if you know
> > the chip specs well enough.
> 
> Urgh, that does not feel like a good solution.

No, but you asked if it could be done, and if it was just a
performance issue. :-)

> > > Is there any risk that the NAND device will drive the LB and corrupt
> > > the bus for other devices?
> >
> > I think the only thing the NAND chip should be driving is the busy pin,
> 
> OK, good. What function is actually lost if one uses an GPIO instead of
> BUSY?

Not much, if you enable interrupts on the GPIO pin.  The driver would
have to be reworked a bit, of course.

> You think Freescale could test and validate a GPIO solution? I don't
> think we will be very happy to design our board around an unproven
> workaround.

Ask your sales/support contacts.

> An even better workaround would be if one could add logic between the
> NAND and the CPU which would compensate for this defect without needing
> special SW fixes.

The problem with that is when would you assert the chipselect again to
check if it's done?  Current SW depends on being able to tell the LBC
to interrupt (or take other action) when busy goes away.

I suppose you could poll with status reads, which could at least be
preempted if you've got something higher priority to do with the LBC.

-Scott
