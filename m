Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 98C1667B7C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 02:22:35 +1100 (EST)
Date: Wed, 1 Nov 2006 02:22:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: build problems with powerpc allmodconfig
Message-Id: <20061101022213.0b6bcaf9.sfr@canb.auug.org.au>
In-Reply-To: <20061031142213.GA9275@lst.de>
References: <20061031142213.GA9275@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__1_Nov_2006_02_22_13_+1100_uAX8=MLyQ8oHh9Cq"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__1_Nov_2006_02_22_13_+1100_uAX8=MLyQ8oHh9Cq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 31 Oct 2006 15:22:13 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
>  - vicocons.c can't be compiled at the same time as CONFIG_VT, but
>    instead of expressing that in the Kconfig it errors out in that
>    case.  This should at least be a Kconfig dependency, but long
>    term viocons must work at the same time as the normal vt code
>    to have a single ppc64 image

viocons is deprecated (in favour of hvc_iseries) so we just need Kconfig
to say to build it only CONFIG_VT is not defined.

>  - vioscsi linkage fails because iseries_vscsi.c and rpa_vscsi.c.
>    This needs some trivial indirection via function vectors, but
>    how can we find out which one to use from the driver?  Both
>    seem to look the same in the device tree

The maintainer suggested that we just don't build vioscsi for iseries
if we are building the rpa version as it is not often used (in particular,
it is not used for installations).  We could, however distinguish them
by changing the "compat" field in the iSeries device tree if we wished.

>  - arch/powerpc/platforms/iseries/setup.c references rd_size
>    when CONFIG_INITRD is set.  But rd_size is defined drivers/block/rd.c
>    which can me modular (and is selected by CONFIG_BLK_DEV_RAM).
>    This same bug is repeated in the arm amd arm26 code, but except
>    for those no one outside of rd.c uses this symbol.  I don't see
>    a point why arch code should modify this as it's already big enough.

A fix for this has already been posted
(http://patchwork.ozlabs.org/linuxppc/patch?id=7523).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__1_Nov_2006_02_22_13_+1100_uAX8=MLyQ8oHh9Cq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFR2owFdBgD/zoJvwRAtcgAJoC1NHGTO5hZmEzzaXBRW7sg3obnwCfYtW7
42chS6C4D4ZF8L2HyYy8Rhc=
=i6NR
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Nov_2006_02_22_13_+1100_uAX8=MLyQ8oHh9Cq--
