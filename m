Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id EE3CE2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 18:27:47 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="=-GLxTMzPkbcBa0OHZjE4o"
Date: Fri, 26 Nov 2004 08:27:35 +0100
Message-Id: <1101454055.10754.0.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Subject: [patch] Race condition #1 in arch/ppc/cpm2_io/fcc_enet.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-GLxTMzPkbcBa0OHZjE4o
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

According to my PHY's (lxt972) datasheet, during the second half of a
read frame on the MDIO, the PHY drives MDIO to the value of the
respective data bit at the rising edge of MDC.

The current code samples MDIO immediately after it generates the rising
edge, so a fast enough processor (like the PowerQUICC III) will not read
the corresponding response of the PHY, but the value MDIO had in the
cycle before, which amounts to all response words appearing shifted by
one bit.

The patch simply moves the udelay(1) between rising MDC and reading
MDIO, leaving the PHY enough time to respond.

-- 
Stefan Nickl
Kontron Modular Computers


--=-GLxTMzPkbcBa0OHZjE4o
Content-Disposition: attachment; filename=fcc_enet-mdio_race.patch
Content-Type: text/x-patch; name=fcc_enet-mdio_race.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/arch/ppc/cpm2_io/fcc_enet.c	2004-08-09 08:32:28.000000000 +0200
+++ fcc_enet.c	2004-11-25 18:28:56.000000000 +0100
@@ -2095,10 +2095,10 @@ mii_send_receive(fcc_info_t *fip, uint c
 		for (i = 0, off = 15; i < 16; i++, off--)
 		{
 			FCC_PDATC_MDC(1);
+			udelay(1);
 			retval <<= 1;
 			if (io->iop_pdatc & fip->fc_mdio)
 				retval++;
-			udelay(1);
 			FCC_PDATC_MDC(0);
 			udelay(1);
 		}

--=-GLxTMzPkbcBa0OHZjE4o--
