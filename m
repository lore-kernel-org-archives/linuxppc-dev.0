Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ECAB7DE06E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 17:12:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18926.44987.591720.873463@cargo.ozlabs.ibm.com>
Date: Wed, 22 Apr 2009 15:48:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get some more bug fixes for powerpc, plus some documentation and
defconfig updates and a MAINTAINERS update.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt       |   89 -
 Documentation/powerpc/dts-bindings/mtd-physmap.txt |   80 +
 MAINTAINERS                                        |    5=20
 arch/powerpc/boot/dts/lite5200b.dts                |   39=20
 arch/powerpc/configs/52xx/cm5200_defconfig         |   69 +
 arch/powerpc/configs/52xx/lite5200b_defconfig      |   74 +
 arch/powerpc/configs/52xx/motionpro_defconfig      |   77 +
 arch/powerpc/configs/52xx/pcm030_defconfig         |   69 +
 arch/powerpc/configs/52xx/tqm5200_defconfig        |   76 +
 arch/powerpc/configs/85xx/mpc8536_ds_defconfig     | 1802 ------------=
--------
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig     | 1802 ------------=
--------
 arch/powerpc/configs/85xx/mpc8568mds_defconfig     | 1309 ------------=
---
 arch/powerpc/configs/mpc5200_defconfig             |  188 ++
 arch/powerpc/configs/mpc85xx_defconfig             |  252 +--
 arch/powerpc/configs/mpc85xx_smp_defconfig         |  343 ++--
 arch/powerpc/include/asm/elf.h                     |    3=20
 arch/powerpc/kernel/prom_parse.c                   |   11=20
 arch/powerpc/mm/hash_utils_64.c                    |    2=20
 arch/powerpc/platforms/fsl_uli1575.c               |    5=20
 arch/powerpc/platforms/pasemi/setup.c              |    4=20
 arch/powerpc/platforms/ps3/os-area.c               |    2=20
 arch/powerpc/sysdev/fsl_rio.c                      |   28=20
 drivers/macintosh/Kconfig                          |    2=20
 drivers/macintosh/mediabay.c                       |    2=20
 include/linux/fsl_devices.h                        |    4=20
 25 files changed, 896 insertions(+), 5441 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/mtd-physmap.txt
 delete mode 100644 arch/powerpc/configs/85xx/mpc8536_ds_defconfig
 delete mode 100644 arch/powerpc/configs/85xx/mpc8544_ds_defconfig
 delete mode 100644 arch/powerpc/configs/85xx/mpc8568mds_defconfig
 rename arch/powerpc/configs/{85xx/mpc8572_ds_defconfig =3D> mpc85xx_sm=
p_defconfig} (91%)

Alexander Beregalov (1):
      powerpc: Make macintosh/mediabay driver depend on CONFIG_BLOCK

Andreas Schwab (1):
      powerpc/32: Don't clobber personality flags on exec

Anton Vorontsov (2):
      powerpc/5200: Bring the legacy fsl_spi_platform_data hooks back
      fsl_rio: Pass the proper device to dma mapping routines

Bartlomiej Zolnierkiewicz (1):
      powerpc: Fix modular build of ide-pmac when mediabay is built in

Geoff Levand (3):
      powerpc/ps3: Fix CONFIG_PS3_FLASH=3Dn build warning
      maintainers: Fix PS3 patterns
      powerpc/pasemi: Fix build error on UP

Grant Likely (2):
      powerpc/5200: Add FLASH nodes to lite5200 device tree
      powerpc/5200: defconfig updates

Ilpo J=E4rvinen (1):
      powerpc: Fix of_node_put() exit path in of_irq_map_one()

Kumar Gala (4):
      powerpc/85xx: Updated generic mpc85xx_defconfig
      powerpc/85xx: Enabled a bunch of FSL specific drivers/options
      powerpc/85xx: Added SMP defconfig
      powerpc/85xx: Remove defconfigs that mpc85xx_{smp_}defconfig cove=
r

Michael Ellerman (1):
      powerpc: Fix crash on CPU hotplug

Stefan Roese (2):
      powerpc/of-device-tree: Factor MTD physmap bindings out of bootin=
g-without-of
      powerpc/device-tree: Document MTD nodes with multiple "reg" tuple=
s

Timur Tabi (1):
      powerpc: don't disable SATA interrupts on Freescale MPC8610 HPCD
