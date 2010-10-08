Return-Path: <vgallard@amcc.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 850C610084B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 07:25:49 +1100 (EST)
From: Victor Gallardo <vgallardo@apm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] powerpc/4xx: Add Canyonlands suspend and idle support
Date: Fri,  8 Oct 2010 13:25:44 -0700
Message-Id: <1286569544-21217-1-git-send-email-vgallardo@apm.com>
Cc: Victor Gallardo <vgallardo@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add Clock Power Management (CPM) node to dts tree
- Add idle-doze entry in CPM node
- Add standby entry in CPM node
- Add PM and SUSPEND support by default in defconfig
- Remove UART2 and UART3 as they are unused, this will
  allow CPM to put unused-units (UART2 and UART3) to sleep.

Signed-off-by: Victor Gallardo <vgallardo@apm.com>
---
 arch/powerpc/boot/dts/canyonlands.dts          |   31 +++++++-----------------
 arch/powerpc/configs/44x/canyonlands_defconfig |    3 ++
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index a303703..5b27a4b 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -105,6 +105,15 @@
 		dcr-reg = <0x00c 0x002>;
 	};
 
+	CPM0: cpm {
+		compatible = "ibm,cpm";
+		dcr-access-method = "native";
+		dcr-reg = <0x160 0x003>;
+		unused-units = <0x00000100>;
+		idle-doze = <0x02000000>;
+		standby = <0xfeff791d>;
+	};
+
 	L2C0: l2c {
 		compatible = "ibm,l2-cache-460ex", "ibm,l2-cache";
 		dcr-reg = <0x020 0x008		/* Internal SRAM DCR's */
@@ -270,28 +279,6 @@
 				interrupts = <0x1 0x4>;
 			};
 
-			UART2: serial@ef600500 {
-				device_type = "serial";
-				compatible = "ns16550";
-				reg = <0xef600500 0x00000008>;
-				virtual-reg = <0xef600500>;
-				clock-frequency = <0>; /* Filled in by U-Boot */
-				current-speed = <0>; /* Filled in by U-Boot */
-				interrupt-parent = <&UIC1>;
-				interrupts = <28 0x4>;
-			};
-
-			UART3: serial@ef600600 {
-				device_type = "serial";
-				compatible = "ns16550";
-				reg = <0xef600600 0x00000008>;
-				virtual-reg = <0xef600600>;
-				clock-frequency = <0>; /* Filled in by U-Boot */
-				current-speed = <0>; /* Filled in by U-Boot */
-				interrupt-parent = <&UIC1>;
-				interrupts = <29 0x4>;
-			};
-
 			IIC0: i2c@ef600700 {
 				compatible = "ibm,iic-460ex", "ibm,iic";
 				reg = <0xef600700 0x00000014>;
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig b/arch/powerpc/configs/44x/canyonlands_defconfig
index 45c64d8..17e4dd9 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -42,6 +42,9 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_NDFC=y
 CONFIG_PROC_DEVICETREE=y
+CONFIG_PM=y
+CONFIG_SUSPEND=y
+CONFIG_PPC4xx_CPM=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=35000
 # CONFIG_MISC_DEVICES is not set
-- 
1.6.1.rc3
