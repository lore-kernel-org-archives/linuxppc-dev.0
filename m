Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 34B7ADDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 18:28:04 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/9] qe/muram dts: Explicitly set address-cells and size cells
	for muram
Date: Mon, 28 Jan 2008 02:27:51 -0500
Message-Id: <a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently there are several dts that don't specify address or size
cells for the muram.  This causes dtc to use default values, one of
which is an address-cells of two, and this breaks the parsing of the
muram ranges, which is assuming an address-cells of one. For example:

Warning (reg_format): "reg" property in
/qe@e0100000/muram@10000/data-only@0 has invalid length
(8 bytes) (#address-cells == 2, #size-cells == 1)

Explicitly setting the address and size cells gets it parsed properly
and gets rid of the four dtc warnings.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc836x_mds.dts |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 2181d2c..10b5d6d 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -214,10 +214,12 @@
 		bus-frequency = <179A7B00>;
 
 		muram@10000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "muram";
 			ranges = <0 00010000 0000c000>;
 
-			data-only@0{
+			data-only@0 {
 				reg = <0 c000>;
 			};
 		};
-- 
1.5.4.rc4.gcab31
