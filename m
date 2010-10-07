Return-Path: <vgallard@amcc.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C0CBB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 06:59:32 +1100 (EST)
From: Victor Gallardo <vgallardo@apm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/4xx: Add Kilauea suspend and idle support
Date: Thu,  7 Oct 2010 12:07:39 -0700
Message-Id: <1286478459-10000-1-git-send-email-vgallardo@apm.com>
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
- Add NO_HZ and CONFIG_HIGH_RES_TIMERS support by
  default in defconfig

Signed-off-by: Victor Gallardo <vgallardo@apm.com>
---
 arch/powerpc/boot/dts/kilauea.dts          |    9 +++++++++
 arch/powerpc/configs/40x/kilauea_defconfig |    5 +++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 083e68e..89edb16 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -82,6 +82,15 @@
 		interrupt-parent = <&UIC0>;
 	};
 
+	CPM0: cpm {
+		compatible = "ibm,cpm";
+		dcr-access-method = "native";
+		dcr-reg = <0x0b0 0x003>;
+		unused-units = <0x00000000>;
+		idle-doze = <0x02000000>;
+		standby = <0xe3e74800>;
+	};
+
 	plb {
 		compatible = "ibm,plb-405ex", "ibm,plb4";
 		#address-cells = <1>;
diff --git a/arch/powerpc/configs/40x/kilauea_defconfig b/arch/powerpc/configs/40x/kilauea_defconfig
index 4e19ee7..34b8c1a 100644
--- a/arch/powerpc/configs/40x/kilauea_defconfig
+++ b/arch/powerpc/configs/40x/kilauea_defconfig
@@ -12,6 +12,8 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_KILAUEA=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 # CONFIG_WALNUT is not set
 CONFIG_SPARSE_IRQ=y
 CONFIG_PCI=y
@@ -42,6 +44,9 @@ CONFIG_MTD_PHYSMAP_OF=y
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
