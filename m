Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id C2FAB2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2014 21:51:55 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 14637-09 for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  3 Feb 2014 10:51:48 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Moese' <michael.moese@men.de>
Subject: RE: PCIe Access - achieve bursts without DMA
Date: Mon, 3 Feb 2014 10:51:08 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6B7792@AcuExch.aculab.com>
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
 <1391208815.27142.38.camel@pasglop> <52EC2F46.7000609@ovro.caltech.edu>
 <20140203082050.GB1970@localhost.intra.men.de>
 <063D6719AE5E284EB5DD2968C1650D6D0F6B774B@AcuExch.aculab.com>
 <20140203103943.GC1970@localhost.intra.men.de>
In-Reply-To: <20140203103943.GC1970@localhost.intra.men.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Hawkins <dwh@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Moese=20
> On Mon, Feb 03, 2014 at 10:17:43AM +0000, David Laight wrote:
>=20
> > We achieved about twice that using the PEX dma controller.
>=20
> > Your 3MB/s for single word transfers is similar to what we saw.
> > Cycle times that make an ISA bus look fast.
>=20
> Indeed, this is a really poor performance. I know we could achieve much
> more performance using DMA, we have several products where we simply
> don't have DMA available - this requires searching for other paths.

I got the host (ppc) to do a dma, not the card. (This does need a
dma controller that is adequately intergrated with the PCIe logic.)
So it doesn't require any hardware changes.
I did have to design the software to minimise the number of single
memory transfers.

> My ioremap_wt() could help in these situations, at least increasing
> performance for non-DMA operation to a not-that-bad level.

I needed to do writes as well as reads - so I think I would have
needed to map PCIe space fully cached (rather than write-through).
The speed of back to back writes is better than reads (even if they don't
get combined) because the requests get 'posted' and overlap on the
PCIe bus.

Managing cached accesses does get tricky - you need to make sure that
both sides never have to write to the same cache line.

> I don't know if other devices could benefit from this, but surely we
> got several IPs that would, but those were not yet upstreamed, we're
> still working on this.
>=20
> Michael
>=20
