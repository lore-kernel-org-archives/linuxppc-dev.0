Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6E3FB67A3F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 13:17:39 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7S3Hbv6025160 for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Aug 2006 20:17:37 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7S3HZF4005326
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Aug 2006 22:17:36 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Cache coherency question
Date: Mon, 28 Aug 2006 11:17:32 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511B8CA@zch01exm21.fsl.freescale.net>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE4871062827EA@VCAEXCH01.hq.corp.viasat.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Martin, Tim" <tim.martin@viasat.com>, "ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Ah.  This must be the problem.  I have a few PCI devices, and=20
> on one of them it looked like snooping was working.  I just=20
> assumed the other device was setup correctly.

Why one is looked like snooping was working, and the other device
not working?

> > Also, you can define the CONFIG_NOT_COHERENT_CACHE, then you are=20
> > assuming The system has not hardware coherency. You need use the=20
> > software to keep the cache coherency.
> >=20
>=20
> I tried this, and got compiler errors.

What is the file got compiler errors? I notice that the
/ev64360_defconfig
Did define CONFIG_NOT_COHERENT_CACHE.


> I added some inline assembly dcbi/dcbf (invalidate/flush)=20
> instructions to the particular code in question, and the=20
> problems went away.  So definitely a cache problem.  As I=20
> said above, defining CONFIG_NOT_COHERENT_CACHE causes=20
> compiler errors, so I'm going to look into this more.  I=20
> suppose whatever file implements the=20
> include/linux/dma-mapping.h stuff isn't BSP specific, so its=20
> probably just not being compiled in?  Will look into it.

Somebody said from maillist. The bridge MV64360 seems
having some issue about cache coherent. I don't know if it is really?

-Dave
