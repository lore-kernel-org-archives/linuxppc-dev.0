Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C427B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 08:27:05 +1100 (EST)
In-Reply-To: <20101208142551.19ea2333@udp111988uds.am.freescale.net>
References: <20101207031554.GA12731@postdiluvian.org>	<20101207145153.540da45a@udp111988uds.am.freescale.net>
	<OFF94B1B01.88594E81-ONC12577F3.002B63AA-C12577F3.002BEE0B@transmode.se>	<20101208111839.1cf95553@udp111988uds.am.freescale.net>
	<OF349DC945.8BC48D34-ONC12577F3.00601D94-C12577F3.00605153@transmode.se>	<20101208192616.GA24560@postdiluvian.org>
	<OF14047E09.664EC753-ONC12577F3.006CF507-C12577F3.006D97EA@transmode.se>	<20101208135928.0278f97d@udp111988uds.am.freescale.net>
	<OFC37E86C9.59866BED-ONC12577F3.006E8F8D-C12577F3.006EE1FA@transmode.se>
	<20101208142551.19ea2333@udp111988uds.am.freescale.net>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF6F049A4C.3AEB4068-ONC12577F3.00751175-C12577F3.0075D3F5@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 8 Dec 2010 22:26:59 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mark Mason <mason@postdiluvian.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 2010/12/08 21:25:51:
>
> On Wed, 8 Dec 2010 21:11:08 +0100
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
> > Scott Wood <scottwood@freescale.com> wrote on 2010/12/08 20:59:28:
> > >
> > > On Wed, 8 Dec 2010 20:57:03 +0100
> > > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > >
> > > > Can you think of any workaround such as not connecting the BUSY pin at all?
> > >
> > > Maybe connect the busy pin to a gpio?
> >
> > Is BUSY required for sane operation or it an optimization?
>
> You could probably get away without it by inserting delays if you know
> the chip specs well enough.

Urgh, that does not feel like a good solution. One would have add
big margins to the delays mking the NAND much slower.

>
> > Is there any risk that the NAND device will drive the LB and corrupt
> > the bus for other devices?
>
> I think the only thing the NAND chip should be driving is the busy pin,

OK, good. What function is actually lost if one uses an GPIO instead of
BUSY?
You think Freescale could test and validate a GPIO solution? I don't
think we will be very happy to design our board around an unproven
workaround.

An even better workaround would be if one could add logic between the
NAND and the CPU which would compensate for this defect without needing
special SW fixes.
