Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 18BD3DDF7E
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 02:30:16 +1100 (EST)
Date: Sun, 11 Jan 2009 18:30:13 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Make serial ports work on MPC8315E-RDB w/
	FSL U-Boots
Message-ID: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FSL U-Boots use /soc8315@e0000000 node to search and fixup serial
nodes' clock-frequency properties. Though in upstream kernels we use
new naming convention -- for IMMR address space dts files specify
/immr@e0000000 nodes.

This makes FSL U-Boots fail to fixup the clock frequencies, and that
leads to serial ports misbehaviour. We can workaround the issue by
filling the clock frequency values manually.

p.s. For the same reason FSL U-Boots fail to fixup MAC addresses for
ethernet nodes, so users should either change the .dts file locally
or set MAC address via `ifconfig hw ether' command.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Leon,

With this patch 2.6.28 kernel boots and works fine with the U-Boot
I took from this image (downloadable from freescale.com):

$ md5sum MPC8315ERDB_20080321-ltib.iso
009730826366d593347b88fa4fdb9be0  MPC8315ERDB_20080321-ltib.iso

That is, U-Boot 1.3.0-rc2 (Mar 21 2008 - 13:36:09) MPC83XX

 arch/powerpc/boot/dts/mpc8315erdb.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 9a4fa2a..88d691c 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -257,7 +257,7 @@
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
+			clock-frequency = <133333333>;
 			interrupts = <9 0x8>;
 			interrupt-parent = <&ipic>;
 		};
@@ -267,7 +267,7 @@
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
+			clock-frequency = <133333333>;
 			interrupts = <10 0x8>;
 			interrupt-parent = <&ipic>;
 		};
-- 
1.5.6.5
