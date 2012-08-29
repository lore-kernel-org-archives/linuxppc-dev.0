Return-Path: <B40534@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EE712C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2012 13:31:35 +1000 (EST)
Received: from mail110-va3 (localhost [127.0.0.1])	by
 mail110-va3-R.bigfish.com (Postfix) with ESMTP id 553B0200A7	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2012 03:31:31 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.238])	by
 mail110-va3.bigfish.com (Postfix) with ESMTP id 2A1613E0141	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2012 03:31:29 +0000 (UTC)
From: <Dongsheng.wang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/8544ds: add partition table for norflash
Date: Wed, 29 Aug 2012 11:00:49 +0800
Message-ID: <1346209249-5049-1-git-send-email-Dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Wang Dongsheng <Dongsheng.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <Dongsheng.Wang@freescale.com>

create partition table for norflash.

Signed-off-by: Wang Dongsheng <Dongsheng.Wang@freescale.com>
---

 arch/powerpc/boot/dts/mpc8544ds.dts  |    4 ++-
 arch/powerpc/boot/dts/mpc8544ds.dtsi |   38 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index e934987..ed38874 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -20,8 +20,10 @@
 		reg = <0 0 0 0>;	// Filled by U-Boot
 	};
 
-	lbc: localbus@e0005000 {
+	board_lbc: lbc: localbus@e0005000 {
 		reg = <0 0xe0005000 0 0x1000>;
+
+		ranges = <0x0 0x0 0x0 0xff800000 0x800000>;
 	};
 
 	board_soc: soc: soc8544@e0000000 {
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dtsi b/arch/powerpc/boot/dts/mpc8544ds.dtsi
index 77ebc9f..8be5b31 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8544ds.dtsi
@@ -32,6 +32,44 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+&board_lbc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x800000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		partition@0 {
+			reg = <0x0 0x10000>;
+			label = "dtb-nor";
+		};
+
+		partition@20000 {
+			reg = <0x20000 0x30000>;
+			label = "diagnostic-nor";
+			read-only;
+		};
+
+		partition@200000 {
+			reg = <0x200000 0x200000>;
+			label = "dink-nor";
+			read-only;
+		};
+
+		partition@400000 {
+			reg = <0x400000 0x380000>;
+			label = "kernel-nor";
+		};
+
+		partition@780000 {
+			reg = <0x780000 0x80000>;
+			label = "u-boot-nor";
+		};
+	};
+};
+
 &board_soc {
 	enet0: ethernet@24000 {
 		phy-handle = <&phy0>;
-- 
1.7.5.1
