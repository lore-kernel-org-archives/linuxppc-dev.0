Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2683B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 03:05:51 +1100 (EST)
Received: from mail153-va3 (localhost.localdomain [127.0.0.1])	by
	mail153-va3-R.bigfish.com (Postfix) with ESMTP id 54A6CE680A3	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 15:50:35 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.245])	by
	mail153-va3.bigfish.com (Postfix) with ESMTP id 05395198054	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 15:50:35 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9BFojDe007961	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 08:50:45 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9BFoX6i007795	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 10:50:33 -0500 (CDT)
Date: Mon, 11 Oct 2010 10:50:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: <david.hagood@gmail.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20101011105031.52a5c06a@udp111988uds.am.freescale.net>
In-Reply-To: <adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 9 Oct 2010 10:52:49 -0500
<david.hagood@gmail.com> wrote:

> First of all - where is all of this documented? There seems to be a great
> deal of "oral tradition" type knowledge here, but is any of it actually
> written down somewhere? (see below for examples)

Documentation/powerpc/dts-bindings/fsl/mpic.txt

Plus the chip manual, for the register offsets.

> > On Thu, 7 Oct 2010 15:12:26 -0500
> > This is asking for the 256th specifier in the interrupts property in
> > the mpic node -- not what you want.
> 
> That was from some of the previous emails in this thread.
> 
> > Ideally you would have a node for your device with an interrupt
> > specifier that you could look up with irq_of_parse_and_map().
> 
> OK, and how do these devices come into being? From what I can tell, they
> are defined by uBoot, and if uBoot doesn't define it, then you are out of
> luck.

More commonly they're statically defined in the dts file, not
dynamically created by u-boot.

If it's not in the dts, add it.  If for whatever reason that's not an
option, you can use irq_create_mapping() as I mentioned in the previous
e-mail.

> * A set of APIs (irq_of_parse_and_map(), irq_create_mapping) that were,
> for all intents, undocumented (just "here's the parameters", no
> description of when and how to use them), that took a ???? and returned a
> ???? (because, with the documentation I had, that's basically all I could
> say about them).

Yes, there are many parts of the kernel that could use better
documentation.

> > BTW, the MSIs are already described in an msi node in the device tree.
> 
> As I stated previously - not that I can see.

What board are you using?  What kernel?

If you grep arch/powerpc/boot/dts for msi in a reasonably recent kernel
you should find msi nodes.

> It may be they are defined in PCI Root Complex mode, 

No, it's a separate node.

-Scott
