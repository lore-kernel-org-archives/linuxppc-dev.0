Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22d.google.com (mail-yh0-x22d.google.com
 [IPv6:2607:f8b0:4002:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E87031A002B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 23:09:14 +1100 (AEDT)
Received: by yhai57 with SMTP id i57so4205359yha.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:09:12 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 00/11] powerpc: kill PPC_OF
Date: Thu, 26 Feb 2015 20:08:12 +0800
Message-Id: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

v2:
   - Drop the following patches which were already merged.
	be802bf955a1 ("mtd: kconfig: replace PPC_OF with PPC")
	0a4a3529df40 ("gpio: kconfig: replace PPC_OF with PPC")
	c31316cb6c5a ("usb: kconfig: replace PPC_OF with PPC")
	f0b66a2cf68e ("PCI: Add pci_device_to_OF_node() stub for !CONFIG_OF")
   - Add the ack in v1 cycle.
   - Resolve the comments in v1 cycle.

We plan to merge this patch series via the powerpc tree in 4.1 cycle. So please
ack the corresponding patches if you are OK with these changes.

Kevin Hao (11):
  sata_svw: remove the dependency on PPC_OF
  fbdev: aty128fb: replace PPC_OF with PPC
  fbdev: radeon: replace PPC_OF with PPC
  fbdev: imsttfb: remove the dependency on PPC_OF
  fbdev: nvidia: remove the dependency on PPC_OF
  fbdev: riva: remove the dependency on PPC_OF
  fbdev: remove the unnecessary includes of ppc specific header files
  fbdev: kconfig: replace PPC_OF with PPC
  mmc: kconfig: replace PPC_OF with PPC
  tty: kconfig: remove the superfluous dependency on PPC_OF
  powerpc: kill PPC_OF

 arch/powerpc/Kconfig                     |  3 ---
 arch/powerpc/Kconfig.debug               |  2 +-
 arch/powerpc/kernel/Makefile             |  4 ++--
 drivers/ata/sata_svw.c                   | 11 +----------
 drivers/mmc/host/Kconfig                 |  4 ++--
 drivers/tty/serial/Kconfig               |  4 ++--
 drivers/video/fbdev/Kconfig              |  4 ++--
 drivers/video/fbdev/aty/aty128fb.c       |  4 ++--
 drivers/video/fbdev/aty/radeon_base.c    | 24 ++++++++++++------------
 drivers/video/fbdev/aty/radeon_monitor.c | 20 ++++++++++----------
 drivers/video/fbdev/aty/radeon_pm.c      | 16 ++++++++--------
 drivers/video/fbdev/aty/radeonfb.h       |  4 ++--
 drivers/video/fbdev/core/fbmon.c         |  4 ----
 drivers/video/fbdev/imsttfb.c            |  6 +-----
 drivers/video/fbdev/nvidia/Makefile      |  3 +--
 drivers/video/fbdev/nvidia/nv_of.c       |  3 ---
 drivers/video/fbdev/nvidia/nv_proto.h    |  8 --------
 drivers/video/fbdev/nvidia/nvidia.c      |  4 ----
 drivers/video/fbdev/riva/fbdev.c         | 17 +++++++----------
 19 files changed, 53 insertions(+), 92 deletions(-)

-- 
1.9.3
