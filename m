Return-Path: <waite@skycomputers.com>
Received: from sky.skycomputers.com (sky.skycomputers.com [198.4.246.2])
	by ozlabs.org (Postfix) with ESMTP id 317D067A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 03:32:08 +1100 (EST)
Received: from dayton (dayton [192.9.200.220])
	by sky.skycomputers.com (Postfix) with ESMTP id 24D6614F299
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 11:40:32 -0500 (EST)
From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 17 Mar 2005 11:21:48 -0500
References: <200503170953.02626.waite@skycomputers.com>
	<200503171111.39210.waite@skycomputers.com>
	<20050317162509.GB5762@gate.ebshome.net>
In-Reply-To: <20050317162509.GB5762@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1254337.cfc4tLyS2p";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200503171121.51698.waite@skycomputers.com>
Subject: Re: [PATCH] ppc32: 3/2 HDPU platform fix PCI bus 1 enumeration
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1254337.cfc4tLyS2p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Lets try this again....

Signed-off-by: Brian Waite <waite@skycomputers.com>
Add the proper bus enumeration code that was missing for bus 1.

===== arch/ppc/platforms/hdpu.c 1.2 vs 1.3 =====
--- 1.2/arch/ppc/platforms/hdpu.c       Thu Mar 17 10:42:34 2005
+++ 1.3/arch/ppc/platforms/hdpu.c       Thu Mar 17 11:07:38 2005
@@ -260,6 +260,17 @@
        ppc_md.pci_swizzle = common_swizzle;
        ppc_md.pci_map_irq = hdpu_map_irq;

+       mv64x60_set_bus(&bh, 0, 0);
+       bh.hose_a->first_busno = 0;
+       bh.hose_a->last_busno = 0xff;
+       bh.hose_a->last_busno = pciauto_bus_scan(bh.hose_a, 0);
+
+       bh.hose_b->first_busno = bh.hose_a->last_busno + 1;
+       mv64x60_set_bus(&bh, 1, bh.hose_b->first_busno);
+       bh.hose_b->last_busno = 0xff;
+       bh.hose_b->last_busno = pciauto_bus_scan(bh.hose_b,
+               bh.hose_b->first_busno);
+
        ppc_md.pci_exclude_device = mv64x60_pci_exclude_device;

        hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_INIT_REG);




--nextPart1254337.cfc4tLyS2p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCOa6fmxLCz0u+Ko8RAhb7AJ4qSiEjH41W3Cs9NTmaU22m0qhyLQCcDv5f
NVW0cTsA5lIfYK9OjLl39co=
=zv+T
-----END PGP SIGNATURE-----

--nextPart1254337.cfc4tLyS2p--
