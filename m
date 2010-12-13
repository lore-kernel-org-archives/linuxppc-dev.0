Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5991EB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 04:34:11 +1100 (EST)
Received: from mail7-va3 (localhost.localdomain [127.0.0.1])	by
	mail7-va3-R.bigfish.com (Postfix) with ESMTP id 4BB55ED040B	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 13 Dec 2010 17:34:03 +0000 (UTC)
Received: from VA3EHSMHS027.bigfish.com (unknown [10.7.14.251])	by
	mail7-va3.bigfish.com (Postfix) with ESMTP id 19820430050	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 13 Dec 2010 17:34:03 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oBDHXxjx017094	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 10:33:59 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oBDHXwsk021682	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 11:33:58 -0600 (CST)
Date: Mon, 13 Dec 2010 11:33:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101213113356.1596c6a6@udp111988uds.am.freescale.net>
In-Reply-To: <OF4BAAB822.8E759F4C-ONC12577F8.00393E37-C12577F8.0039DC9E@transmode.se>
References: <OF51D61C57.96435CC9-ONC12577F6.00326299-C12577F6.0032BA93@transmode.se>
	<AE90C24D6B3A694183C094C60CF0A2F6D8ABFB@saturn3.aculab.com>
	<OF4BAAB822.8E759F4C-ONC12577F8.00393E37-C12577F8.0039DC9E@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Mark Mason <mason@postdiluvian.org>, David Laight <David.Laight@ACULAB.COM>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Dec 2010 11:32:00 +0100
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> "David Laight" <David.Laight@ACULAB.COM> wrote on 2010/12/13 09:33:37:
> >
> >
> > > > An external IRQ line would let you limit interrupts to rising edges
> > > > rather than all edges, though you'd lose the ability to
> > > > directly read the line status.
> > >
> > > oh, one cannot read the IRQ line? didn't know that.
> > > Also I not sure all Freescale CPUs can do rising edge.

Ah right, 83xx has IPIC rather than MPIC.

> > I suspect that you may be able to leave the interupt masked, but still
> > read the 'interrupt pending' register. Which would have the same effect.
>
> Ah, that should work too. I should be able to read the 'interrupt pending'
> register at all times, even when it isn't masked.

This could work OK if you have board logic to invert the signal.

> What if one has several NAND chips to build a big FS? Is the NAND
> controller equipped to handle that?

FCM can drive one NAND chip per eLBC chipselect, though possibly you
could go beyond that with a board-logic chipselect mechanism.

-Scott
