Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6DDFDDDF08
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 12:43:04 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l5F2gwQl027660
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 19:42:58 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5F2gumm022117
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 21:42:57 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Fri, 15 Jun 2007 10:44:49 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2AE6C@zch01exm26.fsl.freescale.net>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0307485D@ismail.innsys.innovsys.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Rune Torgersen" <runet@innovsys.com>, <joakim.tjernlund@transmode.se>
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

> -----Original Message-----
> From: Rune Torgersen [mailto:runet@innovsys.com]
> Sent: Friday, June 15, 2007 6:50 AM
> To: joakim.tjernlund@transmode.se; Li Yang-r58472
> Cc: linuxppc-dev Development; Liu Dave-r63238
> Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
>=20
> Here is what I had to do to get best-fit + not allocating too much:
> (against 2.6.18)
> --- linux-innsys/arch/ppc/lib/rheap.c	2006/10/10 22:54:41	175
> +++ linux-innsys/arch/ppc/lib/rheap.c	2006/12/03 18:04:42	205
{snip}
>  	if (assure_empty(info, 1) < 0)
>  		return ERR_PTR(-ENOMEM);

You also need to change this to assure_empty(info, 2), as you are very
likely to need 2 slots afterward.  You need to assure there are enough
slots or grow the block number.

- Leo
