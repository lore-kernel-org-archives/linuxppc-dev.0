Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 721EEDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 18:01:42 +1100 (EST)
In-Reply-To: <20070222011811.GA18364@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <45b623f395654fc4f4920b9553794def@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Thu, 22 Feb 2007 08:01:31 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <b08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> what problem is this trying to solve?
>
> As he says, it's for devices with interrupts routed to multiple
> controllers.  The normal interrupts property assumes a single
> interrupt parent for a device.  This is needed on most 4xx boards,
> where the MAL has 5 interrupts, some of which are on UIC0 and some of
> which are on UIC1.  At the moment the Ebony port deals with this using
> an "interesting" hack, treating the MAL as an interrupt nexus for
> itself, using an interrupt-map to remap its interrupts to the two
> controllers.

Not really a hack, this is documented in the interrupt
binding:

> 3.3.  "interrupt-map" property
> At any level in the interrupt tree, a mapping may need to take
> place between the child interrupt domain and the parent=92s.  This
> is represented by a new property called "interrupt-map".

Note it says "*any* level".

> The interrupt-array proposal does the same thing much
> more neatly and compactly.

Sure, for every specific case one can envision a more neat
and compact device tree ;-P

If in a certain tree you have this "problem" with not only
the MAL but with lots of devices, you could introduce a
"fake" interrupt nexus that doesn't represent a physical
device as such, but that represents the combined cascaded
interrupt controllers, and maps the interrupts to the nodes
for the "physical" interrupt controllers.  Just don't make
the mistake of putting an "interrupt-controller" property
in there and all is just fine.  As an added bonus you end up
with one single namespace for the interrupts (one interrupt
domain in interrupt-mapping speak), which is probably what
the chip documentation does as well.


Segher
