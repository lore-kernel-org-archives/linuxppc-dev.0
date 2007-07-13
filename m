Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 316A2DDD05
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 00:37:52 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
Date: Fri, 13 Jul 2007 16:19:54 +0200
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707131541150.18802@pademelon.sonytel.be>
	<1184335333.3402.20.camel@localhost.localdomain>
In-Reply-To: <1184335333.3402.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707131619.54898.arnd@arndb.de>
Cc: James Bottomley <James.Bottomley@steeleye.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@vision.unipv.it>,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <jens.axboe@oracle.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 13 July 2007, James Bottomley wrote:
>=20
> > IC.
> >=20
> > =A0 - flush_kernel_dcache_page() is a no-op on ppc64
> > =A0 =A0 (ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE is defined on parisc only).
> >=20
> > =A0 - For reference, drivers/scsi/ipr.c (another ppc64 driver) just use=
s a plain
> > =A0 =A0 kmap/memcpy/kunmap sequence
> >=20
> > So what should I do?
>=20
> Ask someone who knows the architecture ... Anton, Paulus or Benh ... I'm
> fairly certain PPC is VIPT and will need some kind of alias
> resolution ... perhaps its associative enough not to let the aliases be
> a problem.

I'm pretty sure that no ppc64 machine needs alias resolution in the kernel,
although some are VIPT. Last time we discussed this, Segher explained it
to me, but I don't remember which way Cell does it. IIRC, it automatically
flushes cache lines that are accessed through aliases.

It's probably a good idea to have the flush_kernel_dcache_page() in there
anyway, if only to serve as an example for people that copy it into
architecture-independent drivers, same as what we do for the
k{,un}map_atomic() that is also not required on ppc64.

	Arnd <><
