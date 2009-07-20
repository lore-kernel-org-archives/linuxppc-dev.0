Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C402CB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 07:36:48 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E72E5DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 07:36:46 +1000 (EST)
Date: Tue, 21 Jul 2009 01:36:43 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Fix PCI IO base address on MPC837xE-RDB boards
Message-ID: <20090720213643.GA4209@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

U-Boot maps PCI IO at 0xe0300000, while current dts files specify
0xe2000000. This leads to the following oops with CONFIG_8139TOO_PIO=y.

8139too Fast Ethernet driver 0.9.28
Machine check in kernel mode.
Caused by (from SRR1=41000): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
MPC837x RDB
[...]
NIP [00000900] 0x900
LR [c0439df8] rtl8139_init_board+0x238/0x524
Call Trace:
[cf831d90] [c0439dcc] rtl8139_init_board+0x20c/0x524 (unreliable)
[cf831de0] [c043a15c] rtl8139_init_one+0x78/0x65c
[cf831e40] [c0235250] pci_call_probe+0x20/0x30
[...]

This patch fixes the issue by specifying the correct PCI IO base
address.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_rdb.dts |    2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts |    2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 224b4f0..4f06dbc 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -410,7 +410,7 @@
 		bus-range = <0 0>;
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
 		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 474ea2f..aabf343 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -394,7 +394,7 @@
 		bus-range = <0 0>;
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
 		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index d4838af..9b1da86 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -424,7 +424,7 @@
 		bus-range = <0x0 0x0>;
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
 		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
-- 
1.6.3.3
