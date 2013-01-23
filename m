Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (unknown [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1608C2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 07:14:03 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc: enable MTD options in sbc8548 defconfig
Date: Wed, 23 Jan 2013 15:13:33 -0500
Message-Id: <1358972013-5271-5-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
References: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This board has soldered on flash, and a SODIMM flash module.
Both can be used for booting, via switching JP12 and SW2.8
and using the sbc8548-altflash.dts when booting from SODIMM.

Here we enable MTD in kernel so that we can see the bootloader
(and other flash sectors) from linux.

Normal configuration:

 root@sbc8548:~# cat /proc/mtd
 dev:    size   erasesize  name
 mtd0: 007a0000 00020000 "space"
 mtd1: 00060000 00020000 "bootloader"
 mtd2: 03f00000 00080000 "space"
 mtd3: 00100000 00080000 "bootloader"
 root@sbc8548:~# dd if=/dev/mtd1 count=1 bs=48|hexdump -C
 1+0 records in
 1+0 records out
 00000000  27 05 19 56 55 2d 42 6f  6f 74 20 32 30 31 32 2e  |'..VU-Boot 2012.|
 00000010  31 30 2d 64 69 72 74 79  20 28 4a 61 6e 20 31 39  |10-dirty (Jan 19|
 00000020  20 32 30 31 33 20 2d 20  31 39 3a 34 30 3a 31 31  | 2013 - 19:40:11|
 00000030
 root@sbc8548:~# dd if=/dev/mtd3 count=1 bs=48|hexdump -C
 1+0 records in
 1+0 records out
 00000000  27 05 19 56 55 2d 42 6f  6f 74 20 32 30 31 32 2e  |'..VU-Boot 2012.|
 00000010  31 30 2d 64 69 72 74 79  20 28 44 65 63 20 31 33  |10-dirty (Dec 13|
 00000020  20 32 30 31 32 20 2d 20  31 35 3a 30 30 3a 30 37  | 2012 - 15:00:07|
 00000030
 root@sbc8548:~#

Alternate configuration, with sbc8548-altflash.dts:

 root@sbc8548:~# cat /proc/mtd
 dev:    size   erasesize  name
 mtd0: 03f00000 00080000 "space"
 mtd1: 00100000 00080000 "bootloader"
 mtd2: 007a0000 00020000 "space"
 mtd3: 00060000 00020000 "bootloader"
 root@sbc8548:~# dd if=/dev/mtd1 count=1 bs=48|hexdump -C
 1+0 records in
 1+0 records out
 00000000  27 05 19 56 55 2d 42 6f  6f 74 20 32 30 31 32 2e  |'..VU-Boot 2012.|
 00000010  31 30 2d 64 69 72 74 79  20 28 44 65 63 20 31 33  |10-dirty (Dec 13|
 00000020  20 32 30 31 32 20 2d 20  31 35 3a 30 30 3a 30 37  | 2012 - 15:00:07|
 00000030
 root@sbc8548:~# dd if=/dev/mtd3 count=1 bs=48|hexdump -C
 1+0 records in
 1+0 records out
 00000000  27 05 19 56 55 2d 42 6f  6f 74 20 32 30 31 32 2e  |'..VU-Boot 2012.|
 00000010  31 30 2d 64 69 72 74 79  20 28 4a 61 6e 20 31 39  |10-dirty (Jan 19|
 00000020  20 32 30 31 33 20 2d 20  31 39 3a 34 30 3a 31 31  | 2013 - 19:40:11|
 00000030
 root@sbc8548:~#

Note that in the latter, the larger SODIMM device appears 1st,
as mtd0 and mtd1, as indicated in the sizes, and in the date
of the u-boot image.

The kernel configuration is the same in both cases; only the dtb
needs to be changed in accordance with the JP12/SW2.8 settings.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/configs/85xx/sbc8548_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/configs/85xx/sbc8548_defconfig b/arch/powerpc/configs/85xx/sbc8548_defconfig
index 5b2b651..008a7a4 100644
--- a/arch/powerpc/configs/85xx/sbc8548_defconfig
+++ b/arch/powerpc/configs/85xx/sbc8548_defconfig
@@ -55,3 +55,22 @@ CONFIG_ROOT_NFS=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_MTD=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_I4=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_UTIL=y
+CONFIG_MTD_PHYSMAP_OF=y
-- 
1.8.1
