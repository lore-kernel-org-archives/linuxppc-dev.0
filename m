Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (unknown [24.220.19.6])
	by ozlabs.org (Postfix) with ESMTP id 9CD112BD71
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2004 05:34:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 14 Sep 2004 14:22:52 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB67@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
Subject: 8260 FCC Ethernet problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just found that there is a problem in the FCC driver.
This was fixed in some versions of the 2.4 source....

Th Local Protect Bit is not set when enterring Full Duplex mode. This
causes the=20
FCC to turn off the transmitter when packets are received, and also
causes=20
NonOctet frame errors and CRC errors (late collission)

This diff is agains the 2.6.7 sources, but should apply cleanly against
top of source.

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


Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com
