Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 981F91007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 04:51:45 +1100 (EST)
Received: from mail11-am1 (localhost.localdomain [127.0.0.1])	by
	mail11-am1-R.bigfish.com (Postfix) with ESMTP id E971EF30501	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 13 Dec 2010 17:51:38 +0000 (UTC)
Received: from AM1EHSMHS002.bigfish.com (unknown [10.3.201.247])	by
	mail11-am1.bigfish.com (Postfix) with ESMTP id C02E52B0050	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 13 Dec 2010 17:51:38 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oBDHruW8008204	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 13 Dec 2010 10:53:56 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oBDI8lcm010633	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 12:08:47 -0600 (CST)
Date: Mon, 13 Dec 2010 11:51:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101213115131.57050e1d@udp111988uds.am.freescale.net>
In-Reply-To: <OF45E5CF67.CA505B87-ONC12577F8.00610A85-C12577F8.00612FDB@transmode.se>
References: <OF51D61C57.96435CC9-ONC12577F6.00326299-C12577F6.0032BA93@transmode.se>
	<AE90C24D6B3A694183C094C60CF0A2F6D8ABFB@saturn3.aculab.com>
	<OF4BAAB822.8E759F4C-ONC12577F8.00393E37-C12577F8.0039DC9E@transmode.se>
	<20101213113356.1596c6a6@udp111988uds.am.freescale.net>
	<OF45E5CF67.CA505B87-ONC12577F8.00610A85-C12577F8.00612FDB@transmode.se>
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

On Mon, 13 Dec 2010 18:41:32 +0100
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> Scott Wood <scottwood@freescale.com> wrote on 2010/12/13 18:33:56:
> >
> > On Mon, 13 Dec 2010 11:32:00 +0100
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >
> > > What if one has several NAND chips to build a big FS? Is the NAND
> > > controller equipped to handle that?
> >
> > FCM can drive one NAND chip per eLBC chipselect, though possibly you
> > could go beyond that with a board-logic chipselect mechanism.
> 
> hmm, then I guess one would have to use one GPIO/IRQ per NAND chip?

Couldn't you just tie together all the open-drain busy lines before you
invert it?  You'll only be driving one NAND chip at a time anyway; the
others should not be asserting busy.

-Scott
