Return-Path: <Martin.Leisner@xerox.com>
Received: from wbmler1.mail.xerox.com (wbmler1.mail.xerox.com [13.13.138.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler1.mail.xerox.com",
	Issuer "wbmler1.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3D845DDF15
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 09:04:05 +1100 (EST)
Received: from wbmlir1.mail.xerox.com (wbmlir1.mail.xerox.com [13.131.8.221])
	by wbmler1.mail.xerox.com (8.14.2/8.13.8) with ESMTP id
	m2JLqlr4021741
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 17:52:48 -0400
Received: from wbmlir1.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir1.mail.xerox.com (8.14.2/8.13.6) with ESMTP id m2JLqZst013778
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 17:52:35 -0400
Received: from USA7061GW002.na.xerox.net (usa7061gw002.na.xerox.net
	[13.151.210.15])
	by wbmlir1.mail.xerox.com (8.14.2/8.13.6) with ESMTP id m2JLqTMc013719
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 17:52:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 7448/2.6.20 problems (double boots or hangs)
Date: Wed, 19 Mar 2008 17:52:16 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C084C2113@USA0300MS03.na.xerox.net>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <linuxppc-dev@ozlabs.org>
Cc: "Lund, Nathan \(Nathan.Lund@usa.xerox.com\)" <Nathan.Lund@xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My taiga board is now dead -- on our development board (with a taiga
kernel
and a custom modified dts) we see either


1) it hangs at the same point ("PID has table entries")
   or
2) it boots but it seems to restart the boot process after the "PID hash
table entries line"

This was never a problem with 2.6.10 or with 2.6.22.

I modified a driver, saw this oddness and changed to the original driver
(the oddness went away).  I did this about 3 times so I can say "ah
ha!!"

We're using 2.6.20.11...but I recall later to 2.6.20s were no better...

Any recommendations/hypothesis?

marty

arch: exit                   =20
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->   131072
[    0.000000]   Normal     131072 ->   131072
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   131072       =20
[    0.000000] Built 1 zonelists.  Total pages: 130048
[    0.000000] Kernel command line:
nfsroot=3D13.121.21.120:/usr/local/tmp/ganymede ip=3Ddhcp
console=3DttyS0,115200
[    0.000000] mpic: Setting up MPIC "Tsi108_PIC" version 1.2 at
c0007400, max 4 CPUs                        =20
[    0.000000] mpic: ISU size: 24, shift: 5, mask: 1f

[    0.000000] mpic: Initializing for 24 sources    =20
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
                                                                  =20
[    0.000000] Using MPC7448 HPC2 machine description
[    0.000000] setup ppc6xx_idle
[    0.000000] Total memory =3D 512MB; using 1024kB for hash table (at
cff00000)
[    0.000000] Linux version 2.6.20 (mleisner@mleisner-linux) (gcc
version 4.0.0 (DENX ELDK 4.1 4.0.0)) #27 Wed Mar 5 10:56:11 EST 2008
[    0.000000] Found tsi108 PCI host bridge at 0xc0001000. Firmware bus
number: 0->0
[    0.000000] MPC7448HPC2 (TAIGA) Platform
[    0.000000] Jointly ported by Freescale and Tundra Semiconductor
[    0.000000] Enabling L2 cache then enabling the HID0 prefetch engine.
 [    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->   131072
