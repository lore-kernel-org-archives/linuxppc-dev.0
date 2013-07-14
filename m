Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>
Subject: [PATCH RFC v2 0/5] MPC512x DMA slave s/g support, OF DMA lookup
Date: Sun, 14 Jul 2013 14:01:56 +0200
Message-Id: <1373803321-11628-1-git-send-email-gsi@denx.de>
In-Reply-To: <1373642781-32631-1-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
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

this series
- introduces slave s/g support (that's support for DMA transfers which
  involve peripherals in contrast to mem-to-mem transfers)
- adds device tree based lookup support for DMA channels
- combines floating patches and related feedback which already covered
  several aspects of what the suggested LPB driver needs, to demonstrate
  how integration might be done
- carries Q&D SD card support to enable another DMA client during test,
  while this patch needs to get dropped upon pickup

changes since v1:
- re-order mpc8308 related code paths for improved readability, no
  change in behaviour, introduction of symbolic channel names here
  already
- squash 'execute() start condition' and 'terminate all' into the
  introduction of 'slave s/g prep' and 'device control' support; refuse
  s/g lists with more than one item since slave support is operational
  yet proper s/g support is missing (can get addressed later)
- always start transfers from software on MPC8308 as there are no
  external request lines for peripheral flow control
- drop dt-bindings header file and symbolic channel names in OF nodes

known issues:
- it's yet to get confirmed whether MPC8308 can use slave support or
  whether the DMA controller's driver shall actively reject it, the
  information that's available so far suggests that peripheral transfers
  to IP bus attached I/O is useful and shall not get blocked right away
- currently encoded constraints do work for SD card and LPB test suite
  (all known DMA clients ATM), but will need more tuning or support for
  automatic adjustment for transfers of arbitrary length

oh, and I'd like to get feedback on whether attribution handling is
appropriate, as I had to squash patches from several authors to not
break bisectability (compilation had worked, but the code had not run
successfully on all previously supported hardware)

Alexander, when you pickup this series and improve slave s/g support and
adjust it for more general use, you have my OK to incorporate and
further adjust the parts that I've contributed


Alexander Popov (1):
  dma: mpc512x: add support for peripheral transfers

Gerhard Sittig (3):
  dma: mpc512x: re-order mpc8308 specific instructions
  dma: mpc512x: register for device tree channel lookup
  HACK mmc: mxcmmc: enable clocks for the MPC512x

Lars-Peter Clausen (1):
  dma: of: Add common xlate function for matching by channel id

 .../devicetree/bindings/dma/mpc512x-dma.txt        |   55 +++++
 arch/powerpc/boot/dts/mpc5121.dtsi                 |    1 +
 drivers/dma/mpc512x_dma.c                          |  237 +++++++++++++++++---
 drivers/dma/of-dma.c                               |   47 ++++
 drivers/mmc/host/mxcmmc.c                          |   41 ++--
 include/linux/of_dma.h                             |    4 +
 6 files changed, 344 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

-- 
1.7.10.4
