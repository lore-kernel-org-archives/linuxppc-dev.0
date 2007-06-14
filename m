Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4CC01DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 22:46:26 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5ECkKNu007187
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 05:46:21 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5ECkJkV011393
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 07:46:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Thu, 14 Jun 2007 20:48:11 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2ADEF@zch01exm26.fsl.freescale.net>
In-Reply-To: <4671321E.9000204@ThePTRGroup.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Chuck Meade" <chuck@ThePTRGroup.com>, <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Liu Dave-r63238 <DaveLiu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

You are right.  The proposed change is just an unwise suggestion.

I later overhauled and reworked the aligned allocation of rheap to
prevent it from generating internal fragment.  Patch coming soon.

- Leo

> -----Original Message-----
> From: Chuck Meade [mailto:chuck@ThePTRGroup.com]
> Sent: Thursday, June 14, 2007 8:19 PM
> To: joakim.tjernlund@transmode.se
> Cc: Li Yang-r58472; linuxppc-dev Development; Liu Dave-r63238
> Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
>=20
> This output looks buggy:
>=20
{snip}

>=20
> These buffer overlaps probably have a lot to do with your pings
stopping.
> I would say first order of business would be to investigate what could
> be generating all these overlapped allocations.  Some of these make me
think
> the allocator code could be racy, like allocations are not aware of
other
> "recent" or ongoing allocations.  But in any case the allocator is
broken.
>=20
> Chuck
