Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x22d.google.com (mail-yh0-x22d.google.com
 [IPv6:2607:f8b0:4002:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E94FE1A019A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 23:33:07 +1100 (AEDT)
Received: by yhl29 with SMTP id 29so8058020yhl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 05:33:04 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 0/9] powerpc: kill PPC_OF
Date: Thu, 12 Mar 2015 20:32:41 +0800
Message-Id: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Finally I got all the acks for these patches. The following two patches in v2
were merged into next now.
	213dce3c17a6 ("tty: kconfig: remove the superfluous dependency on PPC_OF")
	f4e074f20cad ("mmc: kconfig: replace PPC_OF with PPC")

So we may have dependency issue if we put this series into 4.1.

v3: No codes change, just add the acks from Ben and Tomi.

Kevin Hao (9):
  sata_svw: remove the dependency on PPC_OF
  fbdev: aty128fb: replace PPC_OF with PPC
  fbdev: radeon: replace PPC_OF with PPC
  fbdev: imsttfb: remove the dependency on PPC_OF
  fbdev: nvidia: remove the dependency on PPC_OF
  fbdev: riva: remove the dependency on PPC_OF
  fbdev: remove the unnecessary includes of ppc specific header files
  fbdev: kconfig: replace PPC_OF with PPC
  powerpc: kill PPC_OF

 arch/powerpc/Kconfig                     |  3 ---
 arch/powerpc/Kconfig.debug               |  2 +-
 arch/powerpc/kernel/Makefile             |  4 ++--
 drivers/ata/sata_svw.c                   | 11 +----------
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
 17 files changed, 49 insertions(+), 88 deletions(-)

-- 
2.1.0
