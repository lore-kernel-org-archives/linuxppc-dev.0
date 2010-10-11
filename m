Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7BC61B70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 04:30:22 +1100 (EST)
Received: from mail193-tx2 (localhost.localdomain [127.0.0.1])	by
	mail193-tx2-R.bigfish.com (Postfix) with ESMTP id D31EA1BC81CB	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 17:30:11 +0000 (UTC)
Received: from TX2EHSMHS042.bigfish.com (unknown [10.9.14.242])	by
	mail193-tx2.bigfish.com (Postfix) with ESMTP id 67E8C18E8056	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 17:30:11 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9BHU8mF028567	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 10:30:08 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9BHU89J012757	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 12:30:08 -0500 (CDT)
Date: Mon, 11 Oct 2010 12:30:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: <david.hagood@gmail.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20101011123006.5b489d19@udp111988uds.am.freescale.net>
In-Reply-To: <9af5fd3c8f713d261c7acdc1d195fb84.squirrel@localhost>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
	<20101011105031.52a5c06a@udp111988uds.am.freescale.net>
	<9af5fd3c8f713d261c7acdc1d195fb84.squirrel@localhost>
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

On Mon, 11 Oct 2010 12:02:15 -0500
<david.hagood@gmail.com> wrote:

> Re-ordering your questions a bit:
> 
> > What board are you using?  What kernel?
> 
> One of 2 boards: Either an Embedded Planet or a Performance Tech uTCA
> board based on the MPC8641D, running the 2.6.26 as supplied by EP.

That's a very old kernel.  Have you contacted EP support?

You may be better off trying to migrate anything board-specific to the
latest kernel, rather than do new development on the vendor kernel,
especially if you're looking for community support, and definitely if
you're trying to do something that could be merged upstream to help
others.

The MPC8641D itself is supported in mainline Linux.

> > On Sat, 9 Oct 2010 10:52:49 -0500
> > Documentation/powerpc/dts-bindings/fsl/mpic.txt
> Not present in the version I have.

We didn't have a time machine, so we were only able to add things to new
releases, not old ones. :-)

Should it have been documented from the start?  Ideally, yes, and we're
pickier now than we were then about insisting on bindings being
documented before they're used.  But nothing's perfect.

> > If it's not in the dts, add it.  If for whatever reason that's not an
> > option, you can use irq_create_mapping() as I mentioned in the previous
> > e-mail.
> And as I've said previously, I have no good info on HOW to add the nodes,
> WHAT to add, or WHERE. You may as well be saying "Bargle the Narbog".

There are no nodes to add with irq_create_mapping().

Just bargle the narbog.

> And when I try to use irq_create_mapping() it seg faults, which doesn't
> exactly help me get my interrupt hooked up.

Well, I didn't know it was going to do that...  Your usage of
irq_create_mapping() seems fine, there's just something going wrong.
See my other reply about the number of MPIC interrupts.

> > If you grep arch/powerpc/boot/dts for msi in a reasonably recent kernel
> > you should find msi nodes.
> 
> ddhagood@WIC-102362:..Workspace/Linux_Kernel_for_PPC> grep msi
> arch/powerpc/boot/dts  -ir
> arch/powerpc/boot/dts/glacier.dts:			enable-msi-hole;
> arch/powerpc/boot/dts/taishan.dts:			enable-msi-hole;
> arch/powerpc/boot/dts/canyonlands.dts:			enable-msi-hole;
> arch/powerpc/boot/dts/katmai.dts:			enable-msi-hole;

"reasonably recent kernel"

$ grep -rI msi arch/powerpc/boot/dts/|wc -l
85

> > What did I get signed up for? :-)
> 
> It sounds like Tiejun thinks you might be working on, well, basically what
> I am working on - a generic interface to allow user space to support being
> a endpoint,

I am not working on that -- not sure how I gave that impression.

> with the ability to generate interrupts to the host root
> complex, get interrupts from the host root complex, provide memory to be
> accessed by the host root complex via the PPC's BARs, and to access the
> host root complex's PCI address space via the OATMU windows. Something to
> allow a person to use a PPC SOC as an endpoint, and to get on with the job
> of providing functionality rather than having to deal with esoterica.

That does sound like it would be a useful addition.

-Scott
