Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CEFDDDF08
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 09:08:28 +1100 (EST)
Subject: RE: dcr stuff.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080324043416.3634316E007A@mail15-dub.bigfish.com>
References: <20080321190524.4F3491CE0087@mail160-dub.bigfish.com>
	<20080321201704.032999c3@zod.rchland.ibm.com>
	<20080324043416.3634316E007A@mail15-dub.bigfish.com>
Content-Type: text/plain
Date: Tue, 25 Mar 2008 08:59:33 +1100
Message-Id: <1206395973.7197.50.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-03-23 at 21:34 -0700, Stephen Neuendorffer wrote:
> 
> Certainly, if it ain't broke don't fix it.  What I'm really trying to
> do is figure out how to clean up alot of non-mainline drivers.
> At the moment, several cores use DCR, but the drivers for those cores
> have internal code for DCR, their own ifdefs, etc.  This *is* broken.
> I'm looking at the available documentation to figure out the best way
> of approaching the problem.
> 
> It might be nice if there was an extra layer of indirection which was
> only enabled if DCR_NATIVE and DCR_MMIO, and which was no cost
> otherwise,
> but the bigger problem I see in the short term is that we'll likely
> have to support ARCH ppc for at least some time into the future, and
> it would be
> nice if we used the same driver code to do it: it doesn't seem obvious
> how to achieve this.

It's not too hard to have the DCR code be common, it's harder to deal
with the lack of device-tree in arch/ppc tho.

As for enabling support for both native and MMIO, that's certainly
possible, patches welcome :-) You could make the dcr host structure
contain the type or even function pointers, as you see fit. But make is
so that when only native is enabled, it turns back into the inlines we
have now.

Cheers,
Ben.
