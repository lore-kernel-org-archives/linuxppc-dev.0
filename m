Return-Path: <michael.barkowski@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D4E9DE714
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 02:18:39 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mADFIYBP005224
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 08:18:35 -0700 (MST)
Message-ID: <491C4544.7020707@freescale.com>
Date: Thu, 13 Nov 2008 10:18:28 -0500
From: Michael Barkowski <michael.barkowski@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc832x_rdb: fix swapped ethernet ids
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ethernet0 (called FSL UEC0 in U-Boot) should be enet1 (UCC3/eth1), and
ethernet1 should be enet0 (UCC2/eth0), to be consistent with U-Boot so
that the interfaces do not swap addresses when control passes from
U-Boot to the kernel.

Signed-off-by: Michael Barkowski <michael.barkowski@freescale.com>
Acked-by: Kim Phillips <kim.phillips@freescale.com>
---
Cheat sheet:
| *Nickname* | WAN port | LAN switch |
| *MAC address* | ethaddr | eth1addr |
| *U-Boot name* | FSL UEC0 | FSL UEC1 |
| *Linux name* | eth1 | eth0 |
| *Phy ID* | 4 | 0 |
| *QE Device* | UCC3@2200 | UCC2@3000 |

arch/powerpc/boot/dts/mpc832x_rdb.dts |    4 ++--
1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 226ff06..dea3091 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -18,8 +18,8 @@
	#size-cells = <1>;

	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
+		ethernet0 = &enet1;
+		ethernet1 = &enet0;
		serial0 = &serial0;
		serial1 = &serial1;
		pci0 = &pci0;
-- 
1.5.4.3
