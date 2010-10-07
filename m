Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8996EB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 07:27:02 +1100 (EST)
Received: from mail119-va3 (localhost.localdomain [127.0.0.1])	by
	mail119-va3-R.bigfish.com (Postfix) with ESMTP id C75DD9B80D9	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2010 20:26:56 +0000 (UTC)
Received: from VA3EHSMHS019.bigfish.com (unknown [10.7.14.248])	by
	mail119-va3.bigfish.com (Postfix) with ESMTP id E951E908083	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2010 20:26:33 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o97KQSNf011941	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 7 Oct 2010 13:26:28 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o97KQSkW021687	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 7 Oct 2010 15:26:28 -0500 (CDT)
Date: Thu, 7 Oct 2010 15:26:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: <david.hagood@gmail.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20101007152626.4e834d43@udp111988uds.am.freescale.net>
In-Reply-To: <fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
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

On Thu, 7 Oct 2010 15:12:26 -0500
<david.hagood@gmail.com> wrote:

> > On Tue, 21 Sep 2010 17:37:15 -0400
> > The MPIC interrupt numberspace in the device tree (which is not
> > virtual; it is a private numberspace to MPIC) is based on the offset of
> > the registers for that interrupt source. External interrupts start at
> > zero (which is valid), internal at 16, and special things like MSIs at
> > higher numbers (I don't think it's quite 256).
> 
> OK, so I'm slowly wrapping my head around this (OT: Has anybody considered
> sending this information to the folks doing the Linux Device Drivers
> books? They are just a bit x86 centric right now...).
> 
> As I understand, what I have to do is somehow get a device_node *, then
> make a call to irq_of_parse_and_map() to convert that into a system IRQ.
> 
> What I am doing right now is:
> device_node *mpic = of_find_node_by_type(0,"open-pic");
> irq = irq_of_parse_and_map(mpic,256);

This is asking for the 256th specifier in the interrupts property in
the mpic node -- not what you want.

Ideally you would have a node for your device with an interrupt
specifier that you could look up with irq_of_parse_and_map().  But if
not, you can use irq_create_mapping() to directly convert an MPIC IRQ
number to a virtual IRQ.

What interrupt are you trying to select with 256?  That doesn't look
like a valid MPIC interrupt number.

> 2) How do I know for certain that 256 is the right value for the first MSI
> signaled via MSIR0?

It isn't.  The vector/priority register (MSIVPR0) is at offset
0x51c00.  Each interrupt source is 32 bytes.  The first interrupt
source is at 0x50000.

So the interrupt number is (0x51c00 - 0x50000) / 32 = 224.

BTW, the MSIs are already described in an msi node in the device tree.
Are you trying to do something different with them than PCI MSIs?  If
not, is the existing MSI driver not working?  If you are trying to do
something different, you should bind to that node yourself and use
irq_of_parse_and_map() on it.

-Scott
