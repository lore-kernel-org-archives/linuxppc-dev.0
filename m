Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>
Subject: [PATCH RFC 0/8] MPC512x DMA slave s/g support, OF DMA lookup
Date: Fri, 12 Jul 2013 17:26:13 +0200
Message-Id: <1373642781-32631-1-git-send-email-gsi@denx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

blurb is below the stats

Alexander Popov (1):
  powerpc: mpc512x_dma: add support for data transfers between memory
    and i/o memory

Gerhard Sittig (6):
  dma: mpc512x: fix start condition in execute()
  dma: mpc512x: support 'terminate all' control request
  dts: mpc512x: prepare for preprocessor support
  dma: mpc512x: use symbolic specifiers for DMA channels
  dma: mpc512x: register for device tree channel lookup
  HACK mmc: mxcmmc: enable clocks for the MPC512x

Lars-Peter Clausen (1):
  dma: of: Add common xlate function for matching by channel id

 .../devicetree/bindings/dma/mpc512x-dma.txt        |   55 ++++++
 arch/powerpc/boot/dts/ac14xx.dts                   |    2 +-
 arch/powerpc/boot/dts/include/dt-bindings          |    1 +
 arch/powerpc/boot/dts/mpc5121.dtsi                 |    7 +-
 arch/powerpc/boot/dts/mpc5121ads.dts               |    2 +-
 arch/powerpc/boot/dts/pdm360ng.dts                 |    2 +-
 drivers/dma/mpc512x_dma.c                          |  181 +++++++++++++++++++-
 drivers/dma/of-dma.c                               |   47 +++++
 drivers/mmc/host/mxcmmc.c                          |   41 +++--
 include/dt-bindings/dma/mpc512x-dma.h              |   21 +++
 include/linux/of_dma.h                             |    4 +
 11 files changed, 336 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
 create mode 120000 arch/powerpc/boot/dts/include/dt-bindings
 create mode 100644 include/dt-bindings/dma/mpc512x-dma.h


this series
- introduces slave s/g support (that's support for DMA transfers which
  involve peripherals in contrast to mem-to-mem transfers)
- adds device tree based lookup support for DMA channels
- combines floating patches and related feedback which already covered
  several aspects of what the suggested LPB driver needs, to demonstrate
  how integration might be done


Alexander, I'd suggest that you pickup this series and
- squash part 2 (start condition) and optionally part 3 (terminate all)
  into part 1 (your slave s/g introduction)
- drop part 8 (SD card demo) as it was already NAKed and will be
  obsolete with correct COMMON_CLK support, but was useful during test
  to have one more DMA client on the MPC512x platform
- put your SCLPC support on top of the then OF capable DMA driver
- please leave the preprocessor support for DTS files separate from the
  DMA related DTS part, as it will be part of another series as well
  (clocks) or might get picked up separately for its being useful or
  even a dependency in other ways (GPIOs, interrupts)

Lars, there is a checkpatch warning about a line longer than 80
characters in the common xlate part -- I didn't dare to change your
submission, and the part included here is verbatim from your patchwork
2331091 (original submission) and 2555701 (resend), is there a followup
which you can provide or point us to?

Arnd, this version addresses your concerns in Anatolij's earlier
submissions:
- the DMA controller really maps peripheral requesters 1:1 to DMA
  channels, there's no other mapping or flexibility involved
- OF registration in the DMA controller's driver now is non-fatal for
  compatibility with older device trees
- the device tree binding is documented (even if it's in line with the
  generic DMA binding, being explicit is good, I guess)

Vinod, would you take these DMA related patches when Alexander's updated
version has passed review?  That's what I understood from Lars so far.


the series is based on v3.10, each step in the series was build-tested,
the series' result including the mxcmmc hack was run-tested with the
commands below, moving 170MB of data and using DMA during transfers, the
numbers translate to 1.6MB/s throughput for the SD card and some 62.5KB
per DMA IRQ on average (does this help verify plausibility?)

  $ find /media/mmcblk0p1/ -type f | xargs time wc
    ...
    532086   3032411 173164032 total
  real    1m 47.41s
  user    0m 8.08s
  sys     0m 1.69s
  $ grep -i dma /proc/interrupts 
   65:       2716      IPIC Level     mpc512x_dma
  $ grep -i mmc /proc/interrupts 
   20:       5489      IPIC Level     mxc-mmc

-- 
1.7.10.4
