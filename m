Return-Path: <Ennio.Turconi@italtel.it>
Received: from ns.italtel.it (ns.italtel.it [138.132.53.3])
	by ozlabs.org (Postfix) with ESMTP id 67C4567A05
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 23:22:16 +1000 (EST)
Received: from ns.italtel.it (localhost [127.0.0.1])
	by ns.italtel.it (8.12.11/8.12.11) with ESMTP id j4UDMDiw006014
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 15:22:14 +0200 (MEST)
Received: from ICSSW035.corp.dom (icssw035.settimo.italtel.it [138.132.90.72])
	by ns.italtel.it (8.12.11/8.12.11) with ESMTP id j4UDMCNc005993
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 15:22:13 +0200 (MEST)
Date: Mon, 30 May 2005 15:22:07 +0200
Message-ID: <E8C53B167EBC9045BD1861C36916BD2D7C2832@BESTWO.corp.dom>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: "Turconi Ennio Angelo" <Ennio.Turconi@italtel.it>
To: <linuxppc-embedded@ozlabs.org>
Subject: Error in fcc_enet driver in 2.6.10 version
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody.
I think I found out an error in arch/ppc/8260io/fcc_enet.c source =
(kernel version Vanilla 2.6.10).
When obtaining the pointer to the CPM DPRAM, ioremap() is not used.
In 85xx architecture, it causes a bus error each time the driver =
attempts to access
a location in the CCSRBAR region.

I used the follwing patch (valid only for 85xx devices)

--- fcc_enet.c  2004-12-24 22:34:44.000000000 +0100
+++ fcc_enet_new.c      2005-05-30 15:00:38.000000000 +0200
@@ -1450,7 +1450,7 @@
        volatile        cpm2_map_t              *immap;
        volatile        iop_cpm2_t      *io;

-       immap =3D (cpm2_map_t *)CPM_MAP_ADDR;     /* and to internal =
registers */
+       immap =3D (cpm2_map_t *)ioremap(CPM_MAP_ADDR,MPC85xx_CPM_SIZE);  =
 /* and to i
nternal registers */
        io =3D &immap->im_ioport;

        np =3D sizeof(fcc_ports) / sizeof(fcc_info_t);


Can anyone tell me why a 1 to 1 logical to physical mapping was assumed?

Ennio Turconi
Senior Fw Designer
Gateway Products
ITALTEL SpA
Settimo Mil., Italy


=20
