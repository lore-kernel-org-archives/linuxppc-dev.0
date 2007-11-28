Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id EC3F3DDE9A
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 03:31:46 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 1/2] powerpc: add hugepagesz boot-time parameter
Date: Wed, 28 Nov 2007 17:30:40 +0100
References: <474CF68E.1040709@us.ibm.com> <200711280826.46820.arnd@arndb.de>
	<20071128161201.GA10916@csn.ul.ie>
In-Reply-To: <20071128161201.GA10916@csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711281730.40907.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, kniht@linux.vnet.ibm.com,
	Linux Memory Management List <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 28 November 2007, Mel Gorman wrote:
> On (28/11/07 08:26), Arnd Bergmann didst pronounce:
> > On Wednesday 28 November 2007, Jon Tollefson wrote:
> > > This patch adds the hugepagesz boot-time parameter for ppc64 that let=
s=20
> > > you pick the size for your huge pages. =A0The choices available are 6=
4K=20
> > > and 16M. =A0It defaults to 16M (previously the only choice) if nothin=
g or=20
> > > an invalid choice is specified. =A0Tested 64K huge pages with the=20
> > > libhugetlbfs 1.2 release with its 'make func' and 'make stress' test=
=20
> > > invocations.
> >=20
> > How hard would it be to add the 1MB page size that some CPUs support
> > as well? On systems with small physical memory like the PS3, that
> > sounds very useful to me.
> >=20
>=20
> Does the PS3 support 1M pages in hardware? When I last looked, the magic
> ibm,segment-page-sizes file that described the supported pagesizes was
> missing from the device tree. In this situation, the default sizes
> become 4K and 16M because no other ones are advertised.

I think you can select the page size using a hypercall on the PS3.
The CPU supports any two of (64k, 1M, 16M) simultaneously.

	Arnd <><
