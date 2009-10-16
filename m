Return-Path: <richard.cochran@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFD13B7BCB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 17:32:51 +1100 (EST)
From: Richard Cochran <richard.cochran@omicron.at>
To: "'Scott Wood'" <scottwood@freescale.com>
Date: Fri, 16 Oct 2009 08:31:19 +0200
Subject: RE: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E30E2AE800@alice.at.omicron.at>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
	<20091014152722.GA17867@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AE72C@alice.at.omicron.at>
	<20091015162728.GB3730@loki.buserror.net>
In-Reply-To: <20091015162728.GB3730@loki.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]
> Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
>
> On Thu, Oct 15, 2009 at 02:19:30PM +0200, Richard Cochran wrote:
> > 2. Having only one dts for his board, but Ethernet doesn't work.
>
> The point is to fix u-boot so that it *does* work with only one dts.  If
> people not upgrading u-boot is your concern, we could put the fixup in th=
e
> Linux platform code instead.

Yes, I was thinking that upgrading u-boot can be problematic for
people who don't have a JTAG flash tool, in case things go wrong. The
whole kernel-uboot-dts triangle is a constant source of confusion, IMHO.

But I thought the whole point of the device tree was, that it is easy
to produce a dts that exactly matches a particular physical board
design. If MPC8313-ERDB REVC has a different IRQ routing, then doesn't
it deserve its own dts? Or do only *some* of the REVC boards have this
routing?

> And feel free to ask through official Freescale support channels why the
> U-Boot that shipped on these boards does not have such a fixup (or why th=
ey
> decided it was better to make late-rev 8313's interrupt assignments match
> other 83xx than for all revs of the same part number to have the same
> interrupt assignments).

It sounds like you are not overly satisfied with Freescale's handling
of their BSPs ;)

To be fair, I am happy that Freescale appears to take Linux support
seriously, but I do think they drop the ball once a BSP is
published. For example, the MPC8313-ERDB ships with kernel 2.6.23
(with the old style dts) and a fair number of non-mainstream
patches. It is not so easy to get a recent kernel booting on that
board.

I have the LITE5200B, MPC8313-ERDB, MPC8572DS, and the P2020DS in
house, and it is really the same, sad story with each of
them. Wouldn't it be grand if the development boards would boot "out
of the box" when compiling the most recent kernel with default config?

Maybe that's only wishful thinking, but I am happy to contribute what I
can...

Richard
