Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 0DA52DE114
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Oct 2008 01:42:20 +1100 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29]
	helo=jupiter.intranet.kreuzholzen.de)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1Kq7Zf-0000x9-0d
	for linuxppc-embedded@ozlabs.org; Wed, 15 Oct 2008 16:42:14 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 15 Oct 2008 16:42:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810151642.05145.jbe@pengutronix.de>
Subject: MPC5200: How to share GPIO and watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi list,

the timer0 on the MPC5200B contains one GPIO and a timer/watchdog.

If I'm using this node:

timer@600 {	/* General Purpose Timer */
    compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
    cell-index =3D <0>;
    reg =3D <0x600 0x10>;
    interrupts =3D <0x1 0x9 0x0>;
    interrupt-parent =3D <&mpc5200_pic>;
   fsl,has-wdt;
};

I will get watchdog support.

If I'm using this node:

timer@600 {	/* General Purpose Timer */
    compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt","fsl,mpc5200b-gpt-g=
pio","fsl,mpc5200-gpt-gpio";
    cell-index =3D <0>;
    reg =3D <0x600 0x10>;
    interrupts =3D <0x1 0x9 0x0>;
    interrupt-parent =3D <&mpc5200_pic>;
    gpio-controller;
    #gpio-cells =3D <2>;
    fsl,has-wdt;
};

I will get GPIO support, but no longer watchdog support (watchdogs probe
function will never be called).

Is there a way to get both features supported?

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
