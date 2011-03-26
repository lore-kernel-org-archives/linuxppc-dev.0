Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DE6FCB6FB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 18:11:31 +1100 (EST)
Date: Sat, 26 Mar 2011 18:11:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: restore some misc devices to our configs
Message-Id: <20110326181129.2b578a57.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	=?UTF-8?B?IlV3ZSBLbGVpbmUtS8O2bmlnIg==?= <u.kleine-koenig@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Uwe Kleine-König reported:

	while working on an defconfig (arm/mx27) I noticed that just updating
	it[1] results in removing CONFIG_EEPROM_AT24=y.  The reason is that
	since commit

		v2.6.36-5965-g5f2365d (misc devices: do not enable by default)

	MISC_DEVICES isn't enabled anymore by default.  So all defconfigs that
	have CONFIG_SOME_SYMBOL=y (or =m) (with SOME_SYMBOL depending on
	MISC_DEVICES) but not CONFIG_MISC_DEVICES=y suffer from the same
	problem.

This restores those misc devices to the powerpc defconfigs.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de
---
 arch/powerpc/configs/44x/warp_defconfig          |    1 +
 arch/powerpc/configs/52xx/motionpro_defconfig    |    1 +
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig    |    1 +
 arch/powerpc/configs/86xx/gef_sbc310_defconfig   |    1 +
 arch/powerpc/configs/86xx/gef_sbc610_defconfig   |    1 +
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig |    1 +
 arch/powerpc/configs/e55xx_smp_defconfig         |    1 +
 arch/powerpc/configs/linkstation_defconfig       |    1 +
 arch/powerpc/configs/mpc512x_defconfig           |    1 +
 arch/powerpc/configs/mpc5200_defconfig           |    1 +
 arch/powerpc/configs/mpc85xx_defconfig           |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig       |    1 +
 arch/powerpc/configs/mpc86xx_defconfig           |    1 +
 arch/powerpc/configs/pasemi_defconfig            |    1 +
 arch/powerpc/configs/ppc6xx_defconfig            |    1 +
 15 files changed, 15 insertions(+), 0 deletions(-)

This has been verified by doing a "make <config>;make savedefconfig"
before and after applying it.  The only changes before/after for all the
powerpc configs is that these misc devices are reenabled in the configs.

diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 6cf9d66..abf74dc 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -47,6 +47,7 @@ CONFIG_MTD_NAND_NDFC=y
 CONFIG_MTD_UBI=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index 6828eda..0c7de96 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -43,6 +43,7 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_SCSI_TGT=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
index 4b24412..d41857a 100644
--- a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
+++ b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
@@ -85,6 +85,7 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
 CONFIG_DS1682=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECS=y
diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
index a360ba4..38303ec 100644
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
@@ -85,6 +85,7 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
 CONFIG_DS1682=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECS=y
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index be2829d..9853397 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -138,6 +138,7 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
 CONFIG_DS1682=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
diff --git a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
index 0c9c7ed..b614508d 100644
--- a/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
@@ -63,6 +63,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
diff --git a/arch/powerpc/configs/e55xx_smp_defconfig b/arch/powerpc/configs/e55xx_smp_defconfig
index 06f9549..9fa1613 100644
--- a/arch/powerpc/configs/e55xx_smp_defconfig
+++ b/arch/powerpc/configs/e55xx_smp_defconfig
@@ -32,6 +32,7 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index f39d0cf..8a874b9 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -78,6 +78,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index 62db8a3..c02bbb2 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -61,6 +61,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_XIP=y
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 # CONFIG_SCSI_PROC_FS is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 7376e27..e63f537 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -52,6 +52,7 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI_TGT=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 99a19d1..c06a86c 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -82,6 +82,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index c636f23..942ced9 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -84,6 +84,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
diff --git a/arch/powerpc/configs/mpc86xx_defconfig b/arch/powerpc/configs/mpc86xx_defconfig
index 55b5431..038a308 100644
--- a/arch/powerpc/configs/mpc86xx_defconfig
+++ b/arch/powerpc/configs/mpc86xx_defconfig
@@ -66,6 +66,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index edd2d54..f4deb0b 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -59,6 +59,7 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 9d64a68..0a10fb0 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -398,6 +398,7 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_VIRTIO_BLK=m
 CONFIG_BLK_DEV_HD=y
+CONFIG_MISC_DEVICES=y
 CONFIG_ENCLOSURE_SERVICES=m
 CONFIG_SENSORS_TSL2550=m
 CONFIG_EEPROM_AT24=m
-- 
1.7.4.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
