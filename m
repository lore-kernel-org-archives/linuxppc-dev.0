Return-Path: <Harald.Kuethe@controlware.de>
Received: from cwarens1.controlware.de (CWareNS1.Controlware.DE
	[193.22.120.157]) by ozlabs.org (Postfix) with ESMTP id C7E5E2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 16:54:21 +1000 (EST)
Received: from post2.controlware.de (localhost.controlware.de [127.0.0.1])
	by cwarens1.controlware.de (Postfix) with ESMTP id 511722BCB2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 08:27:09 +0200 (CEST)
Message-Id: <s163ac5c.063@post2.controlware.de>
Date: Wed, 06 Oct 2004 08:26:43 +0200
From: "=?ISO-8859-1?Q?Harald=20K=FCthe?=" <Harald.Kuethe@controlware.de>
To: <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH][PPC32] 2.4.27: fixes for 8xx fec.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, I sent this one some time ago.

I found two problems concerning the fast ethernet driver=20
for ppc 8xx processors (fec.c) in linux kernel version 2.4.26/27=20
and I think in the 2.6 series as well (not confirmed).

First problem is only when CONFIG_USE_MDIO is __not__ set.
How to reproduce:
start the system with fec ethernet, everything works,=20
issue a ifconfig ethX down and ifconfig ethX up and ethernet is not =
working anymore.
Fix (or at least a workaround). In fec_enet_open() add a fec_restart() at =
the end=20
if CONFIG_USE_MDIO is not set.

2nd problem is with CONFIG_USE_MDIO set:=20
The promiscuous mode/multicast settings are getting lost if link status =
changes occurs=20
How to reproduce:
build a bridge with the fec device. Then simply unplug and replug the =
ethernet cable.=20
fec_restart() is called which idles all promiscuous mode/multicast =
settings.
The bridge will then only forward broadcast frames because the promiscuous =
setting is lost.
Fix: call set_multicast_list(dev) at the end of fec_restart() before =
ethernet is reenabled.

If there are more questions please write back.

Reagrds
Harald

diff -urN linux-2.4.27.orig/arch/ppc/8xx_io/fec.c linux-2.4.27/arch/ppc/8xx=
_io/fec.c
--- linux-2.4.27.orig/arch/ppc/8xx_io/fec.c	2003-11-28 19:26:18.0000000=
00 +0100
+++ linux-2.4.27/arch/ppc/8xx_io/fec.c	2004-08-10 13:54:06.000000000 =
+0200
@@ -1466,6 +1466,8 @@
 	return -ENODEV;		/* No PHY we understand */
 #else
 	fep->link =3D 1;
+	/* after ifconfig down and up fec will not start -> restart it */
+	fec_restart (dev, 0);
 	netif_start_queue(dev);
 	return 0;	/* Success */
 #endif	/* CONFIG_USE_MDIO */
@@ -2049,6 +2051,9 @@
 	fecp->fec_imask =3D ( FEC_ENET_TXF | FEC_ENET_TXB |
 			    FEC_ENET_RXF | FEC_ENET_RXB | FEC_ENET_MII );
=20
+	/* set old promiscuous/multicast settings which are lost above */
+	set_multicast_list(dev);
+
 	/* And last, enable the transmit and receive processing.
 	*/
 	fecp->fec_ecntrl =3D FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN;
