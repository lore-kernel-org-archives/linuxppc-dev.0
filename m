Message-ID: <3D3C3E88.4080807@sysgo.de>
Date: Mon, 22 Jul 2002 19:19:04 +0200
From: Pavel Bartusek <pba@sysgo.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MDIO clock speed computation
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I found a little problem with computation of MDIO clock speed in
linux/arch/ppc/8xx_io/fec.c
The MPC855T users manual: "The MII_SPEED field must be programmed with a
value to provide an MDC frequency of less than or equal to 2.5 MHz to
comply with the IEEE MII specification."
The code produces ie. value 0x18 to the MII Speed Control Register for
64MHz system clock it means 2.67Mhz MDIO clock.

This patch will repair it.


        /* Set MII speed to 2.5 MHz
        */
        fecp->fec_mii_speed = fep->phy_speed =
-               (( (bd->bi_intfreq + 500000) / 2500000 / 2 ) & 0x3F ) << 1;
+               (( (bd->bi_intfreq + (2500000-1)) / 2500000 / 2 ) & 0x3F
) << 1;
 #else
        fecp->fec_mii_speed = 0;        /* turn off MDIO */
 #endif /* CONFIG_USE_MDIO */

--

----------------------------------------------------------------------
|                          Pavel Bartusek                            |
|                                                                    |
| Sysgo RTS GmbH,                     phone: +49 (0) 6136 9948-722   |
| Am Pfaffenstein 14                  fax:   +49 (0) 6136 9948-10    |
| D-55270 Klein-Winternheim           email: pba@sysgo.de            |
| Germany                                                            |
|                                                                    |
|       http://www.sysgo.de           http://www.elinos.com          |
|                                                                    |
----------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
