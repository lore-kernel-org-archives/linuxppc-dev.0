Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay3.sgi.com [192.48.152.1])
	by ozlabs.org (Postfix) with ESMTP id C21DAB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 00:25:03 +1000 (EST)
Date: Thu, 11 Aug 2011 09:25:00 -0500
From: Robin Holt <holt@sgi.com>
To: U Bhaskar-B22300 <B22300@freescale.com>
Subject: [PATCH] p1010rdb: gianfar config does not have queues.
Message-ID: <20110811142500.GD4926@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>,
	Eric Dumazet <eric.dumazet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If I have the the fsl,num_rx_queues and fsl,num_tx_queues properties
defined in the p1010's device tree file, I get a kernel panic very
shortly after boot.  The failure indicates we are configuring the
gianfar.c driver for a queue depth greater than actual.  Removing the
properties got the problem resolved.

Signed-off-by: Robin Holt <holt@sgi.com>
To: U Bhaskar-B22300 <B22300@freescale.com>
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>

diff --git a/arch/powerpc/boot/dts/p1010si.dtsi b/arch/powerpc/boot/dts/p1010si.dtsi
index 7f51104..91566aa 100644
--- a/arch/powerpc/boot/dts/p1010si.dtsi
+++ b/arch/powerpc/boot/dts/p1010si.dtsi
@@ -258,8 +258,6 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&mpic>;
 
@@ -280,8 +278,6 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&mpic>;
 
@@ -302,8 +298,6 @@
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "fsl,etsec2";
-			fsl,num_rx_queues = <0x8>;
-			fsl,num_tx_queues = <0x8>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&mpic>;
 
