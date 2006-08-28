Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 872F5679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 16:57:13 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7S6vCD1002260 for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Aug 2006 23:57:12 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7S6v9pb011718
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 01:57:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Cache coherency question
Date: Mon, 28 Aug 2006 14:57:40 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC5FF@zch01exm20.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D263511B8CA@zch01exm21.fsl.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>,
	"Martin, Tim" <tim.martin@viasat.com>, "ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> Liu Dave-r63238
> Sent: Monday, August 28, 2006 11:18 AM
> To: Martin, Tim; ppc
> Subject: RE: Cache coherency question
>=20
> > Ah.  This must be the problem.  I have a few PCI devices, and
> > on one of them it looked like snooping was working.  I just
> > assumed the other device was setup correctly.
>=20
> Why one is looked like snooping was working, and the other device
> not working?
>=20
> > > Also, you can define the CONFIG_NOT_COHERENT_CACHE, then you are
> > > assuming The system has not hardware coherency. You need use the
> > > software to keep the cache coherency.
> > >
> >
> > I tried this, and got compiler errors.

Which arch are you using?  powerpc or ppc?  CONFIG_NOT_COHERENT_CACHE
doesn't seem to be ported to powerpc arch completely.

>=20
> What is the file got compiler errors? I notice that the
> /ev64360_defconfig
> Did define CONFIG_NOT_COHERENT_CACHE.
>=20
>=20
> > I added some inline assembly dcbi/dcbf (invalidate/flush)
> > instructions to the particular code in question, and the
> > problems went away.  So definitely a cache problem.  As I
> > said above, defining CONFIG_NOT_COHERENT_CACHE causes
> > compiler errors, so I'm going to look into this more.  I
> > suppose whatever file implements the
> > include/linux/dma-mapping.h stuff isn't BSP specific, so its
> > probably just not being compiled in?  Will look into it.
>=20
> Somebody said from maillist. The bridge MV64360 seems
> having some issue about cache coherent. I don't know if it is really?

Looking from source code, there is such problem for MV64360.  It's
likely that MV54360 has the same problem.
