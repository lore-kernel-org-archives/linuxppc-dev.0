Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 523A52C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:44:30 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 00/31] add COMMON_CLK support for PowerPC MPC512x
Date: Tue,  6 Aug 2013 22:43:40 +0200
Message-Id: <1375821851-31609-1-git-send-email-gsi@denx.de>
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this series
- fixes several drivers that are used in the MPC512x platform (UART,
  SPI, ethernet, PCI, USB, CAN, NAND flash, video capture) in how they
  handle clocks (appropriately acquire and setup them, hold references
  during use, release clocks after use)
- introduces support for the common clock framework (CCF, COMMON_CLK
  Kconfig option) in the PowerPC based MPC512x platform, which brings
  device tree based clock lookup as well

although the series does touch several subsystems -- tty (serial), spi,
net (can, fs_enet), mtd (nfc), usb, i2c, media (viu), and dts -- all of
the patches are strictly clock related or trivial

it appears most appropriate to take this series through either the clk
or the powerpc trees after it has passed review and other subsystem
maintainers ACKed the clock setup related driver modifications

the series passes 'checkpatch.pl --strict' except for one warning which
cannot get resolved, since that either breaks compilation (the data type
is preset by the clk-provider.h API) or requires a cast which shadows
real mismatches:

  WARNING: static const char * array should probably be static const char * const
  #431: FILE: arch/powerpc/platforms/512x/clock-commonclk.c:334:
  +static const char *parent_names_mux0[] = {

  total: 0 errors, 1 warnings, 0 checks, 807 lines checked

each step in the series was build and run tested (with a display that is
attached to the DIU as well as SPI, with an SPI attached NOR flash, with
multiple UART ports such that one is not the boot console, with EEPROMs
attached to I2C, with an SD card, booting from network)


changes in v4:
- remove explicit devm_clk_put() calls as these will occur implicitly
  upon device release (01/31, 02/31, 03/31, 04/31, 05/31, 06/31, 08/31,
  09/31, 27/31)
- split the PSC (SPI, UART) and MSCAN (CAN) related MCLK subtrees into
  separate 'ipg'/'bdlc' gated clock items for register access as well as
  the 'mclk' clock subtrees that apply to bitrates -- this eliminates
  the need for "shared gates" and further reduces clock pre-enable
  workarounds (11/31, 15/31, 17/31, 18/31, 20/31, 21/31, 22/31, 27/31)
- further adjust the CAN clock driver, fix an incomplete error code path
  in the network device open callback (11/31), only enable the bitrate
  clock when the network device is open (27/31)
- remove debug output in the clock tree setup when introducing the
  platform's clock driver, there already is CONFIG_COMMON_CLK_DEBUG to
  retrieve more complete information (17/31)
- remove an "enums don't work here" comment in the dt-bindings header
  file (15/31)
- reword and update commit messages (body and/or subject) where
  appropriate (03/31, 04/31, 05/31, 06/31, 08/31, 09/31, 11/31, 12/31,
  17/31, 20/31, 21/31, 22/31, 27/31, 28/31, 30/31, 31/31)
- add 'Reviewed-By' attributes which were received for v3

changes in v3:
- rebase the series against v3.11-rc2
- re-ordered the series to first address all general clock handling
  concerns in existing drivers, before introducing common clock support
  in the platform's clock driver
- slightly rework the SPI (01/31), UART (02/31), and PSC FIFO (23/31)
  clock handling in comparison to v2 which introduced those fixes
  (devm_{get,put}_clk() calls, fewer goto labels in error paths)
- fix and improve clock handling (balance allocation and release of
  clocks, check for errors during setup) in all of the other drivers
  which this series has touched before in naive ways: USB (03/31), NAND
  flash (04/31), video capture (05/31), I2C (06/31), ethernet (08/31),
  PCI (09/31), CAN (11/31)
- silence a build warning in the ethernet driver (07/31)
- eliminate all PPC_CLOCK references, use 'per' clock names for NAND
  flash (25/31) and VIU (26/31) as well
- unbreak CAN operation for the period between introducing common clock
  support in the platform's clock driver and introducing common clock
  support in the CAN peripheral driver as well as providing clock specs
  in the device tree (provide clkdev aliases for SYS and REF)
- improve common clock support for CAN (devm_{get,put}_clk() calls,
  check enable() errors, keep a reference to used clocks, disable and
  put clocks after use)
- reworded several commit messages to better reflect the kind of change
  and because fixes were applied before adding common infrastructure
  support
- point to individual numbered patches of the series in the list of
  changes for v2 as well

changes in v2:
- cleanup of the UART (02/24) and SPI (01/24) clock handling before the
  introduction of common clock support for the platform, as incomplete
  clock handling becomes fatal or more dangerous later (which in turn
  changes the context of the "device tree lookup only" followup patch
  later)
- reordered the sequence of patches to keep the serial communication
  related parts together (UART, SPI, and PSC FIFO changes after common
  clock support was introduced, which have become 11-14/24 now)
- updated commit messages for the clock API use cleanup in the serial
  communication drivers, updated comments and reworded commit messages
  in the core clock driver to expand on the pre-enable workaround and
  clkdev registration (09/24)
- keep a reference to the PSC FIFO clock during use instead of looking
  up the clock again in the uninit() routine (14/24)
- remove the clkdev.h header file inclusion directive with the removal
  of the clkdev registration call (13/24)


Gerhard Sittig (31):
  spi: mpc512x: cleanup clock API use
  serial: mpc512x: cleanup clock API use
  USB: fsl-mph-dr-of: cleanup clock API use
  mtd: mpc5121_nfc: cleanup clock API use
  [media] fsl-viu: cleanup clock API use
  i2c: mpc: cleanup clock API use
  fs_enet: silence a build warning (unused variable)
  fs_enet: cleanup clock API use
  powerpc/fsl-pci: improve clock API use
  net: can: mscan: add a comment on reg to idx mapping
  net: can: mscan: improve clock API use
  powerpc: mpc512x: array decl for MCLK registers in CCM
  clk: wrap I/O access for improved portability
  dts: mpc512x: prepare for preprocessor support
  dts: mpc512x: introduce dt-bindings/clock/ header
  dts: mpc512x: add clock related device tree specs
  clk: mpc512x: introduce COMMON_CLK for MPC512x
  dts: mpc512x: add clock specs for client lookups
  clk: mpc512x: don't pre-enable FEC and I2C clocks
  spi: mpc512x: switch to CCF names in clock lookup
  serial: mpc512x: switch to CCF names in clock lookup
  clk: mpc512x: remove PSC (UART, SPI) compat workarounds
  serial: mpc512x: setup the PSC FIFO clock as well
  USB: fsl-mph-dr-of: remove now obsolete clock lookup name
  mtd: mpc5121_nfc: remove now obsolete clock lookup name
  [media] fsl-viu: remove now obsolete clock lookup name
  net: can: mscan: add common clock support for mpc512x
  powerpc/mpc512x: improve DIU related clock setup
  clk: mpc512x: switch to COMMON_CLK, remove PPC_CLOCK
  net: can: mscan: remove non-CCF code for MPC512x
  clk: mpc512x: remove remaining migration workarounds

 arch/powerpc/boot/dts/ac14xx.dts                   |    9 +-
 arch/powerpc/boot/dts/include/dt-bindings          |    1 +
 arch/powerpc/boot/dts/mpc5121.dtsi                 |  110 ++-
 arch/powerpc/boot/dts/mpc5121ads.dts               |    2 +-
 arch/powerpc/boot/dts/pdm360ng.dts                 |    2 +-
 arch/powerpc/include/asm/mpc5121.h                 |   18 +-
 arch/powerpc/platforms/512x/Kconfig                |    2 +-
 arch/powerpc/platforms/512x/Makefile               |    3 +-
 arch/powerpc/platforms/512x/clock-commonclk.c      |  716 +++++++++++++++++++
 arch/powerpc/platforms/512x/clock.c                |  753 --------------------
 arch/powerpc/platforms/512x/mpc512x_shared.c       |  165 +++--
 arch/powerpc/sysdev/fsl_pci.c                      |   22 +
 drivers/clk/clk-divider.c                          |    6 +-
 drivers/clk/clk-gate.c                             |    6 +-
 drivers/clk/clk-mux.c                              |    6 +-
 drivers/i2c/busses/i2c-mpc.c                       |   24 +
 drivers/media/platform/fsl-viu.c                   |   23 +-
 drivers/mtd/nand/mpc5121_nfc.c                     |   21 +-
 drivers/net/can/mscan/mpc5xxx_can.c                |  281 +++++---
 drivers/net/can/mscan/mscan.c                      |   27 +-
 drivers/net/can/mscan/mscan.h                      |    3 +
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |   21 +-
 drivers/spi/spi-mpc512x-psc.c                      |   60 +-
 drivers/tty/serial/mpc52xx_uart.c                  |  179 ++++-
 drivers/usb/host/fsl-mph-dr-of.c                   |   27 +-
 include/dt-bindings/clock/mpc512x-clock.h          |   69 ++
 include/linux/clk-provider.h                       |   33 +
 include/linux/fs_enet_pd.h                         |    3 +
 28 files changed, 1534 insertions(+), 1058 deletions(-)
 create mode 120000 arch/powerpc/boot/dts/include/dt-bindings
 create mode 100644 arch/powerpc/platforms/512x/clock-commonclk.c
 delete mode 100644 arch/powerpc/platforms/512x/clock.c
 create mode 100644 include/dt-bindings/clock/mpc512x-clock.h


# uname -srm
Linux 3.11.0-rc4-00031-gb38a1de ppc
# cat /sys/kernel/debug/clk/clk_summary
   clock                        enable_cnt  prepare_cnt  rate
---------------------------------------------------------------------
 ac97                           0           0            24567000
 spdif_rx_in                    0           0            0
 spdif_tx_in                    0           0            0
 psc_mclk_in                    0           0            25000000
 dummy                          1           1            0
 osc                            1           1            25000000
    ref                         1           1            25000000
       sys                      6           6            320000000
          spdif-mux0            0           0            320000000
             spdif-en0          0           0            320000000
                spdif_mclk_div  0           0            80000000
                   spdif_mclk   0           0            80000000
          mscan3-mux0           0           0            320000000
             mscan3-en0         0           0            320000000
                mscan3_mclk_div 0           0            80000000
                   mscan3_mclk  0           0            80000000
          mscan2-mux0           0           0            320000000
             mscan2-en0         0           0            320000000
                mscan2_mclk_div 0           0            80000000
                   mscan2_mclk  0           0            80000000
          mscan1-mux0           0           0            320000000
             mscan1-en0         0           0            320000000
                mscan1_mclk_div 0           0            16000000
                   mscan1_mclk  0           0            16000000
          mscan0-mux0           0           0            320000000
             mscan0-en0         0           0            320000000
                mscan0_mclk_div 0           0            16000000
                   mscan0_mclk  0           0            16000000
          psc11-mux0            0           0            320000000
             psc11-en0          0           0            320000000
                psc11_mclk_div  0           0            80000000
                   psc11_mclk   0           0            80000000
          psc10-mux0            0           0            320000000
             psc10-en0          0           0            320000000
                psc10_mclk_div  0           0            80000000
                   psc10_mclk   0           0            80000000
          psc9-mux0             0           0            320000000
             psc9-en0           0           0            320000000
                psc9_mclk_div   0           0            80000000
                   psc9_mclk    0           0            80000000
          psc8-mux0             0           0            320000000
             psc8-en0           0           0            320000000
                psc8_mclk_div   0           0            80000000
                   psc8_mclk    0           0            80000000
          psc7-mux0             1           1            320000000
             psc7-en0           1           1            320000000
                psc7_mclk_div   1           1            80000000
                   psc7_mclk    1           1            80000000
          psc6-mux0             0           0            320000000
             psc6-en0           0           0            320000000
                psc6_mclk_div   0           0            80000000
                   psc6_mclk    0           0            80000000
          psc5-mux0             1           1            320000000
             psc5-en0           1           1            320000000
                psc5_mclk_div   1           1            80000000
                   psc5_mclk    1           1            80000000
          psc4-mux0             1           1            320000000
             psc4-en0           1           1            320000000
                psc4_mclk_div   1           1            80000000
                   psc4_mclk    1           1            80000000
          psc3-mux0             1           1            320000000
             psc3-en0           1           1            320000000
                psc3_mclk_div   1           1            80000000
                   psc3_mclk    2           2            80000000
          psc2-mux0             0           0            320000000
             psc2-en0           0           0            320000000
                psc2_mclk_div   0           0            80000000
                   psc2_mclk    0           0            80000000
          psc1-mux0             0           0            320000000
             psc1-en0           0           0            320000000
                psc1_mclk_div   0           0            80000000
                   psc1_mclk    0           0            80000000
          psc0-mux0             0           0            320000000
             psc0-en0           0           0            320000000
                psc0_mclk_div   0           0            80000000
                   psc0_mclk    0           0            80000000
          ddr-ug                1           1            160000000
             ddr                1           1            160000000
          csb                   4           4            160000000
             viu                0           0            160000000
             iim                0           0            160000000
             usb2               0           0            160000000
             usb1               0           0            160000000
             axe                0           0            160000000
             pci-ug             0           0            26666666
                pci             0           0            26666666
             mbx-bus-ug         0           0            80000000
                mbx-bus         0           0            80000000
                mbx-ug          0           0            80000000
                   mbx          0           0            80000000
                   mbx-3d-ug    0           0            80000000
                      mbx-3d    0           0            80000000
             e300               1           1            400000000
             diu-x4             1           1            640000000
                diu-ug          1           1            2509803
                   diu          2           2            2509803
             sdhc-x4            1           1            640000000
                sdhc-ug         1           1            53333333
                   sdhc-2       0           0            53333333
                   sdhc         1           1            53333333
             ips                12          12           80000000
                spdif           0           0            80000000
                bdlc            2           2            80000000
                i2c             3           3            80000000
                mem             1           1            80000000
                fec             1           1            80000000
                sata            0           0            80000000
                psc-fifo        1           1            80000000
                psc11           0           0            80000000
                psc10           0           0            80000000
                psc9            0           0            80000000
                psc8            0           0            80000000
                psc7            1           1            80000000
                psc6            0           0            80000000
                psc5            1           1            80000000
                psc4            1           1            80000000
                psc3            1           1            80000000
                psc2            0           0            80000000
                psc1            0           0            80000000
                psc0            0           0            80000000
                pata            0           0            80000000
                lpc-ug          1           1            40000000
                   lpc          1           1            40000000
                nfc-ug          0           0            40000000
                   nfc          0           0            40000000

-- 
1.7.10.4
