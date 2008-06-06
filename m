Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D024EDE557
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 01:38:54 +1000 (EST)
Date: Fri, 6 Jun 2008 10:38:24 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: MPC8548CDS - Fix size of PCIe IO space
Message-ID: <Pine.LNX.4.64.0806061037530.13744@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: andrew@cesa.opbu.xerox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Klossner pointed out the IO space size was in violation of
the alignment requirements for windows on the 85xx.  The size should
have been 1M (to match u-boot).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8548cds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index fa298a8..4811b81 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -409,7 +409,7 @@
 		interrupts = <26 2>;
 		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x0 0xe3000000 0x0 0x8000000>;
+			  0x1000000 0x0 0x0 0xe3000000 0x0 0x100000>;
 		clock-frequency = <33333333>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -428,7 +428,7 @@

 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
-				  0x0 0x8000000>;
+				  0x0 0x100000>;
 		};
 	};
 };
-- 
1.5.5.1
