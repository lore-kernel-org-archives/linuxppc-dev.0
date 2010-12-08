Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA5A4B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 09:26:14 +1100 (EST)
Received: from mail40-tx2 (localhost.localdomain [127.0.0.1])	by
	mail40-tx2-R.bigfish.com (Postfix) with ESMTP id BE6AF44170C	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 22:26:04 +0000 (UTC)
Received: from TX2EHSMHS029.bigfish.com (unknown [10.9.14.253])	by
	mail40-tx2.bigfish.com (Postfix) with ESMTP id 970221A58052	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 22:26:04 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB8MQ3Xa018150	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 8 Dec 2010 15:26:03 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB8MiIW2025792	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Dec 2010 16:44:19 -0600 (CST)
Date: Wed, 8 Dec 2010 16:25:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: Mark Mason <mason@postdiluvian.org>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101208162559.26e40cf2@udp111988uds.am.freescale.net>
In-Reply-To: <20101208220245.GB26836@postdiluvian.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Dec 2010 17:02:45 -0500
Mark Mason <mason@postdiluvian.org> wrote:

> I don't think that using a software NAND controller instead of the LBC
> FCM mode is all that bad.  Again, I haven't actually done it, so check
> the MTD docs, but I'm pretty sure the software is meant to do that, so
> it doesn't even really constitute a "fix".  Assuming that it is
> supported then I doubt that configuring the NAND layer to use your
> setup would be any harder than configuring the FCM.

The MTD layer supports some really simple NAND controllers, but what do
you mean by not having a controller at all?  Hooking everything up to
GPIO?  Using UPM?

There is already a UPM NAND driver, BTW.

You would lose hardware ECC and the ability to be interrupt-driven (the
latter should be possible with SW changes, using GPIO interrupts).

-Scott
