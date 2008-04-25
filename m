Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0039DDF8B
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 21:10:09 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3PBA2Pc006622
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 04:10:03 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3PBA1vl007552
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 06:10:01 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] MTD: fix partition scan control logic in physmap_ofand
	fsl_elbc_nand
Date: Fri, 25 Apr 2008 19:09:59 +0800
Message-ID: <989B956029373F45A0B8AF029708189002007C8F@zch01exm26.fsl.freescale.net>
In-Reply-To: <1208890162.9212.646.camel@pmac.infradead.org>
References: <1204201051-13107-1-git-send-email-leoli@freescale.com>
	<1208890162.9212.646.camel@pmac.infradead.org>
From: "Li Yang" <LeoLi@freescale.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Woodhouse [mailto:dwmw2@infradead.org]=20
> Sent: Wednesday, April 23, 2008 2:49 AM
> To: Li Yang
> Cc: linux-mtd@lists.infradead.org; Stefan Roese;=20
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] MTD: fix partition scan control logic in=20
> physmap_ofand fsl_elbc_nand
>=20
> On Thu, 2008-02-28 at 20:17 +0800, Li Yang wrote:
> > The generic rule for partition scan is to try all supported=20
> partition=20
> > types before an usable partition table is found.
> > However the original code returns unsuccessful when there=20
> is an error=20
> > in any of the partition types.
> >=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Cc: Stefan Roese <sr@denx.de>
> > Cc: Peter Korsgaard <jacmet@sunsite.dk>
> > ---
> > I later found that Stefan has proposed a similar patch for=20
> physmap_of=20
> > and Peter proposed another patch to fix cmdlinepart instead.
> > I'd say that even after cmdlinepart patch is applied the=20
> scan control=20
> > logic still needs to be fixed.
>=20
> I'm not convinced. I think the partition code should return=20
> an error if it hits a hard error, like a failure to read from=20
> the device. And return zero when it doesn't find anything.

The error can also be soft error like a typo in the cmdline or device
tree.  I could be better to try other ways to see if we can find a sane
partition table than just to fail.

- Leo
