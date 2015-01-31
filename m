Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22b.google.com (mail-yh0-x22b.google.com
 [IPv6:2607:f8b0:4002:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB6B01A0E46
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:12 +1100 (AEDT)
Received: by mail-yh0-f43.google.com with SMTP id 29so12994402yhl.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:09 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/15] powerpc: kill PPC_OF
Date: Sat, 31 Jan 2015 21:47:30 +0800
Message-Id: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series tries to kill the PPC_OF.

Kevin Hao (15):
  PCI: introduce pci_device_to_OF_node() for !CONFIG_OF
  sata_svw: remove the dependency on PPC_OF
  fbdev: aty128fb: replace PPC_OF with PPC
  fbdev: radeon: replace PPC_OF with PPC
  fbdev: imsttfb: remove the dependency on PPC_OF
  fbdev: nvidia: remove the dependency on PPC_OF
  fbdev: riva: remove the dependency on PPC_OF
  fbdev: remove the unnecessary includes of ppc specific header files
  fbdev: kconfig: replace PPC_OF with PPC
  gpio: kconfig: replace PPC_OF with PPC
  mmc: kconfig: replace PPC_OF with PPC
  mtd: kconfig: replace PPC_OF with PPC
  tty: kconfig: remove the superfluous dependency on PPC_OF
  usb: kconfig: replace PPC_OF with PPC
  powerpc: kill PPC_OF

 arch/powerpc/Kconfig                     |  3 ---
 arch/powerpc/Kconfig.debug               |  2 +-
 arch/powerpc/kernel/Makefile             |  4 ++--
 drivers/ata/sata_svw.c                   | 11 +----------
 drivers/gpio/Kconfig                     |  2 +-
 drivers/mmc/host/Kconfig                 |  4 ++--
 drivers/mtd/nand/Kconfig                 |  2 +-
 drivers/tty/serial/Kconfig               |  4 ++--
 drivers/usb/host/Kconfig                 |  8 ++++----
 drivers/video/fbdev/Kconfig              |  4 ++--
 drivers/video/fbdev/aty/aty128fb.c       |  4 ++--
 drivers/video/fbdev/aty/radeon_base.c    | 24 ++++++++++++------------
 drivers/video/fbdev/aty/radeon_monitor.c | 20 ++++++++++----------
 drivers/video/fbdev/aty/radeon_pm.c      | 16 ++++++++--------
 drivers/video/fbdev/aty/radeonfb.h       |  4 ++--
 drivers/video/fbdev/core/fbmon.c         |  4 ----
 drivers/video/fbdev/imsttfb.c            |  4 ----
 drivers/video/fbdev/nvidia/Makefile      |  3 +--
 drivers/video/fbdev/nvidia/nv_of.c       |  3 ---
 drivers/video/fbdev/nvidia/nv_proto.h    |  8 --------
 drivers/video/fbdev/nvidia/nvidia.c      |  4 ----
 drivers/video/fbdev/riva/fbdev.c         | 17 +++++++----------
 include/linux/pci.h                      |  2 ++
 23 files changed, 60 insertions(+), 97 deletions(-)

-- 
1.9.3
