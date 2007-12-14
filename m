Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B1D2FDDFF5
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 11:37:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/7] [POWERPC] Xilinx: clear data caches.
Date: Thu, 13 Dec 2007 16:36:46 -0800
In-Reply-To: <1197590981.15741.201.camel@pasglop>
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234240.F3CC3AD805D@mail122-sin.bigfish.com>
	<1197590848.15741.199.camel@pasglop>
	<1197590981.15741.201.camel@pasglop>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <benh@kernel.crashing.org>
Message-Id: <20071214003648.68E5EC68059@mail177-blu.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Unfortunately, I think your right... The asm code seems so clean at the
moment, I don't really want be the one to start tarnishing it with a
bunch of little fixups.. :)

Steve

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Thursday, December 13, 2007 4:10 PM
> To: Stephen Neuendorffer
> Cc: grant.likely@secretlab.ca; simekm2@fel.cvut.cz;=20
> jwilliams@itee.uq.edu.au; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2/7] [POWERPC] Xilinx: clear data caches.
>=20
>=20
> On Fri, 2007-12-14 at 11:07 +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2007-12-13 at 15:43 -0800, Stephen Neuendorffer wrote:
> > > This code is needed to boot without a boot loader.
> > >=20
> > > Grant:  I'm not sure where the right place to put this=20
> is.  I'm assuming we'll actually need some boot code that is=20
> not generic?  Also, note that there is a V4FX errata=20
> workaround in arch/ppc/boot/head.S, which probably also needs=20
> to get pulled to powerpc.
> > >=20
> > > Signed-off-by: Stephen Neuendorffer=20
> <stephen.neuendorffer@xilinx.com>
> > > ---
> > >  arch/powerpc/boot/raw-platform.c |   22 ++++++++++++++++++++++
> > >  1 files changed, 22 insertions(+), 0 deletions(-)
> >=20
> > This raw-platform.c file doesn't seem like a good place for=20
> code that is
> > totally platform specific ...
>=20
> Maybe best is to do that in asm ? The problem when you are in=20
> C code is
> that you may already have hit stale cache entries. "raw" platforms
> probably need to perform various CPU-specific initializations anyway,
> prior to entering C code, in a custom crt0.S, so that's probably the
> best place to do the cache clearing.
>=20
> Ben.
>=20
>=20
>=20
