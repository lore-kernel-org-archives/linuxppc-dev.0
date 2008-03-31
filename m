Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id E4EDDDDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 18:21:36 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Mon, 31 Mar 2008 10:21:28 +0200
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<18416.813.635397.559197@cargo.ozlabs.ibm.com>
	<56851566f85e117c42b078dd2d6a2028@kernel.crashing.org>
In-Reply-To: <56851566f85e117c42b078dd2d6a2028@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803311021.28919.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linux-mtd@lists.infradead.org,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 31 March 2008 00:39, Segher Boessenkool wrote:
> >>> For RAMs we
> >>> need something to indicate that it's memory but intended for=20
> >>> secondary
> >>> storage, not as main memory.
> >>
> >> How it is intended to be used is not a property of the hardware, so
> >> that information doesn't belong in the device tree at all.  The Linux
> >> platform code should handle this, I imagine.
> >
> > There must be some reason why it is not intended to be used as main
> > memory.  Presumably it has something different about it compared to
> > "normal" RAM, and that difference could perfectly well be expressed in
> > the device tree.
>=20
> Sure, that's a different thing.  It might sit on a bus that doesn't
> do cache coherency, or maybe it's just slow (or sits on a slow bus).
> All these things can be usefully expressed in the device tree (but
> typically are not, it is left to the client code to know this stuff
> implicitly).
>=20
> It's still the (platform) probe code its responsibility to figure
> out what (if anything) to do with any device.  And "main memory"
> is probed differently (via /chosen/memory, for example) anyway.
> Well, actually, Linux searches for all nodes with device_type "memory",
> which should work fine as well [*].
>=20
> So, all in all, I think we should just give these "auxiliary memory"
> devices a name of "ram" c.q. "rom", and some "reg", and that should
> be all that is needed: the main memory probe stuff won't consider
> these nodes, and the (platform) device probe code can do whatever it
> wants (create mtd devices, I guess).

Ok, I get your point. I'll prepare a new documentation patch; changes to=20
physmap_of.c will go away.

If I understand you correctly, there should be no "compatible" property on =
the=20
ram and rom devices. Should the "non-volatile", "slow" and "static ram"=20
properties still be expressed in the device tree ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
