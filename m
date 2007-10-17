Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18198.1222.253923.277227@cargo.ozlabs.ibm.com>
Date: Wed, 17 Oct 2007 22:49:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get some a collection of fixes for powerpc, plus a set of commits
that add some new driver code for the "bestcomm" hardware on some
Freescale embedded PowerPC chips.

Thanks,
Paul.

 arch/powerpc/Kconfig                               |    4 
 arch/powerpc/boot/dts/lite5200b.dts                |   18 +
 arch/powerpc/configs/bamboo_defconfig              |    7 
 arch/powerpc/configs/celleb_defconfig              |    7 
 arch/powerpc/configs/chrp32_defconfig              |    7 
 arch/powerpc/configs/ebony_defconfig               |    7 
 arch/powerpc/configs/g5_defconfig                  |    7 
 arch/powerpc/configs/holly_defconfig               |    7 
 arch/powerpc/configs/iseries_defconfig             |    7 
 arch/powerpc/configs/kilauea_defconfig             |    7 
 arch/powerpc/configs/linkstation_defconfig         |    7 
 arch/powerpc/configs/lite5200_defconfig            |    7 
 arch/powerpc/configs/maple_defconfig               |    8 
 arch/powerpc/configs/mpc7448_hpc2_defconfig        |    5 
 arch/powerpc/configs/mpc8272_ads_defconfig         |    7 
 arch/powerpc/configs/mpc8313_rdb_defconfig         |    7 
 arch/powerpc/configs/mpc832x_mds_defconfig         |    5 
 arch/powerpc/configs/mpc832x_rdb_defconfig         |    5 
 arch/powerpc/configs/mpc834x_itx_defconfig         |    5 
 arch/powerpc/configs/mpc834x_itxgp_defconfig       |    5 
 arch/powerpc/configs/mpc834x_mds_defconfig         |    5 
 arch/powerpc/configs/mpc836x_mds_defconfig         |    5 
 arch/powerpc/configs/mpc8540_ads_defconfig         |    7 
 arch/powerpc/configs/mpc8544_ds_defconfig          |    7 
 arch/powerpc/configs/mpc8560_ads_defconfig         |    7 
 arch/powerpc/configs/mpc8568mds_defconfig          |    7 
 arch/powerpc/configs/mpc8572_ds_defconfig          |    7 
 arch/powerpc/configs/mpc85xx_cds_defconfig         |    7 
 arch/powerpc/configs/mpc8610_hpcd_defconfig        |    7 
 arch/powerpc/configs/mpc8641_hpcn_defconfig        |    7 
 arch/powerpc/configs/mpc866_ads_defconfig          |    5 
 arch/powerpc/configs/pasemi_defconfig              |    7 
 arch/powerpc/configs/pmac32_defconfig              |    7 
 arch/powerpc/configs/ppc64_defconfig               |   11 
 arch/powerpc/configs/pq2fads_defconfig             |    7 
 arch/powerpc/configs/prpmc2800_defconfig           |    5 
 arch/powerpc/configs/ps3_defconfig                 |    7 
 arch/powerpc/configs/pseries_defconfig             |   11 
 arch/powerpc/configs/sequoia_defconfig             |    7 
 arch/powerpc/configs/walnut_defconfig              |    7 
 arch/powerpc/kernel/entry_64.S                     |    6 
 arch/powerpc/kernel/ibmebus.c                      |  263 +++-------
 arch/powerpc/kernel/of_device.c                    |   80 +++
 arch/powerpc/kernel/of_platform.c                  |   70 ---
 arch/powerpc/kernel/setup_64.c                     |   13 
 arch/powerpc/kernel/time.c                         |    2 
 arch/powerpc/kernel/vdso64/sigtramp.S              |   11 
 arch/powerpc/lib/Makefile                          |    5 
 arch/powerpc/lib/rheap.c                           |   15 +
 arch/powerpc/math-emu/math.c                       |   13 
 arch/powerpc/mm/hash_utils_64.c                    |    3 
 arch/powerpc/mm/init_64.c                          |    2 
 arch/powerpc/mm/slb.c                              |    3 
 arch/powerpc/platforms/Kconfig                     |    4 
 arch/powerpc/platforms/Kconfig.cputype             |    1 
 arch/powerpc/platforms/iseries/htab.c              |    4 
 arch/powerpc/platforms/iseries/vio.c               |    2 
 arch/powerpc/sysdev/Makefile                       |    1 
 arch/powerpc/sysdev/bestcomm/Kconfig               |   39 +
 arch/powerpc/sysdev/bestcomm/Makefile              |   14 +
 arch/powerpc/sysdev/bestcomm/ata.c                 |  154 ++++++
 arch/powerpc/sysdev/bestcomm/ata.h                 |   37 +
 arch/powerpc/sysdev/bestcomm/bcom_ata_task.c       |   67 +++
 arch/powerpc/sysdev/bestcomm/bcom_fec_rx_task.c    |   78 +++
 arch/powerpc/sysdev/bestcomm/bcom_fec_tx_task.c    |   91 +++
 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.c |   63 ++
 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.c |   69 +++
 arch/powerpc/sysdev/bestcomm/bestcomm.c            |  528 ++++++++++++++++++++
 arch/powerpc/sysdev/bestcomm/bestcomm.h            |  190 +++++++
 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h       |  334 +++++++++++++
 arch/powerpc/sysdev/bestcomm/fec.c                 |  270 ++++++++++
 arch/powerpc/sysdev/bestcomm/fec.h                 |   61 ++
 arch/powerpc/sysdev/bestcomm/gen_bd.c              |  260 ++++++++++
 arch/powerpc/sysdev/bestcomm/gen_bd.h              |   48 ++
 arch/powerpc/sysdev/bestcomm/sram.c                |  177 +++++++
 arch/powerpc/sysdev/bestcomm/sram.h                |   54 ++
 arch/powerpc/sysdev/fsl_pci.c                      |    2 
 arch/ppc/Kconfig                                   |    6 
 drivers/infiniband/hw/ehca/ehca_classes.h          |    2 
 drivers/infiniband/hw/ehca/ehca_eq.c               |    6 
 drivers/infiniband/hw/ehca/ehca_main.c             |   32 +
 drivers/net/ehea/ehea.h                            |    2 
 drivers/net/ehea/ehea_main.c                       |   72 +--
 include/asm-powerpc/cputable.h                     |    3 
 include/asm-powerpc/ibmebus.h                      |   38 -
 include/asm-powerpc/of_device.h                    |    4 
 include/asm-ppc/mpc52xx_psc.h                      |   10 
 include/linux/of_device.h                          |    5 
 88 files changed, 3010 insertions(+), 483 deletions(-)
 create mode 100644 arch/powerpc/sysdev/bestcomm/Kconfig
 create mode 100644 arch/powerpc/sysdev/bestcomm/Makefile
 create mode 100644 arch/powerpc/sysdev/bestcomm/ata.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/ata.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_ata_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_fec_rx_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_fec_tx_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_rx_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bcom_gen_bd_tx_task.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/fec.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/fec.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/gen_bd.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/gen_bd.h
 create mode 100644 arch/powerpc/sysdev/bestcomm/sram.c
 create mode 100644 arch/powerpc/sysdev/bestcomm/sram.h

Anton Blanchard (4):
      [POWERPC] Enable SLUB in *_defconfig
      [POWERPC] Quieten clockevent printk
      [POWERPC] Quieten cache information at boot
      [POWERPC] Enable NO_HZ and high res timers for pseries and ppc64 configs

Benjamin Herrenschmidt (1):
      [POWERPC] Fix 64 bits vDSO DWARF info for CR register

Domen Puncer (1):
      [POWERPC] mpc52xx: device tree changes for FEC and MDIO

Joachim Fenkes (4):
      [POWERPC] Move of_device allocation into of_device.[ch]
      [POWERPC] ibmebus: Remove bus match/probe/remove functions
      [POWERPC] ibmebus: Add device creation and bus probing based on of_device
      [POWERPC] ibmebus: Move to of_device and of_platform_driver, match eHCA and eHEA drivers

Kumar Gala (1):
      [POWERPC] Fix handling of stfiwx math emulation

Olof Johansson (2):
      [POWERPC] Fix 1TB segment detection
      [POWERPC] Add 1TB workaround for PA6T

Stephen Rothwell (2):
      [POWERPC] Fix copyright symbol
      [POWERPC] Fix iSeries_hpte_insert prototype

Sylvain Munaut (7):
      [POWERPC] exports rheap symbol to modules
      [POWERPC] rheap: Changes config mechanism
      [POWERPC] mpc52xx: Update mpc52xx_psc structure with B revision changes
      [POWERPC] bestcomm: core bestcomm support for Freescale MPC5200
      [POWERPC] bestcomm: ATA task support
      [POWERPC] bestcomm: FEC task support
      [POWERPC] bestcomm: GenBD task support

Tony Breeds (1):
      [POWERPC] Fix vmemmap warning in init_64.c

Tony Li (1):
      [POWERPC] Add missing semicolon for fsl_pci.c
