Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (unknown [24.220.19.6])
	by ozlabs.org (Postfix) with ESMTP id A9ACA2BD3C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 02:05:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 15 Sep 2004 11:05:05 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB69@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH]8260 FCC Full Duplex
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Tom Rini [mailto:trini@kernel.crashing.org]=20
> Sent: Tuesday, September 14, 2004 18:14
> To: Rune Torgersen
> Subject: Re: 8260 FCC Ethernet problem
> If you haven't seen it yet:=20
> http://ozlabs.org/mailman/listinfo/linuxppc-> dev
Yep, found it yesterday...
=20
> Also, can=20
> you please read the Developer's Certificate=20
> of Origin 1.0 (found in Documentation/SubmittingPatches) and=20
> please add a Signed-off-by line?  Thanks.

Sure=20

=3D=3D=3D=3D=3D arch/ppc/8260_io/fcc_enet.c 1.20 vs edited =
=3D=3D=3D=3D=3D
--- 1.20/arch/ppc/8260_io/fcc_enet.c    2004-07-06 16:44:29 -05:00
+++ edited/arch/ppc/8260_io/fcc_enet.c  2004-09-10 14:44:05 -05:00
@@ -2013,9 +2013,9 @@
        fccp =3D fcp->fccp;

        if (duplex)
-               fccp->fcc_fpsmr |=3D FCC_PSMR_FDE;
+               fccp->fcc_fpsmr |=3D FCC_PSMR_FDE | FCC_PSMR_LPB;
        else
-               fccp->fcc_fpsmr &=3D ~FCC_PSMR_FDE;
+               fccp->fcc_fpsmr &=3D ~(FCC_PSMR_FDE | FCC_PSMR_LPB);

        /* Enable transmit/receive */
        fccp->fcc_gfmr |=3D FCC_GFMR_ENR | FCC_GFMR_ENT;


Signed-off-by: Rune Torgersen <runet@innovsys.com>

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com
