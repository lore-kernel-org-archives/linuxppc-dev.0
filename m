Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D49412C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 13:05:39 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id bj1so4398402pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 20:05:37 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v3 0/3] powerpc/85xx: introduce corenet_generic machine
Date: Tue, 24 Sep 2013 11:03:14 +0800
Message-Id: <1379991797-29222-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v3:
  - Update the patch 1 according to Scoot's comment.
  - Introduce one new patch to combine the board kernel options into one.

v2:
  - Fold the original patch 2 into patch 1.
  - Update the patch 1 according to Scott and Kumar's comments.
  - Introduce a new patch to rename the corenet_ds.c to corenet_generic.c.

v1:
This patch series introduces a common machine to support p2041rdb, p3041ds,
p4080ds, p5020ds, p5040ds, t4240qds and b4qds to avoid the code duplication.
Boot test on p5020ds and p4080ds.

Kevin Hao (3):
  powerpc/85xx: introduce corenet_generic machine
  powerpc/85xx: rename the corenet_ds.c to corenet_generic.c
  powerpc/85xx: use one kernel option for all the CoreNet_Generic boards

 arch/powerpc/configs/corenet32_smp_defconfig  |   6 +-
 arch/powerpc/configs/corenet64_smp_defconfig  |   5 +-
 arch/powerpc/configs/ppc64e_defconfig         |   2 +-
 arch/powerpc/platforms/85xx/Kconfig           |  87 ++----------
 arch/powerpc/platforms/85xx/Makefile          |   8 +-
 arch/powerpc/platforms/85xx/b4_qds.c          |  97 --------------
 arch/powerpc/platforms/85xx/corenet_ds.c      |  96 --------------
 arch/powerpc/platforms/85xx/corenet_ds.h      |  19 ---
 arch/powerpc/platforms/85xx/corenet_generic.c | 182 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/p2041_rdb.c       |  87 ------------
 arch/powerpc/platforms/85xx/p3041_ds.c        |  89 -------------
 arch/powerpc/platforms/85xx/p4080_ds.c        |  87 ------------
 arch/powerpc/platforms/85xx/p5020_ds.c        |  93 -------------
 arch/powerpc/platforms/85xx/p5040_ds.c        |  84 ------------
 arch/powerpc/platforms/85xx/t4240_qds.c       |  93 -------------
 15 files changed, 195 insertions(+), 840 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/b4_qds.c
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.h
 create mode 100644 arch/powerpc/platforms/85xx/corenet_generic.c
 delete mode 100644 arch/powerpc/platforms/85xx/p2041_rdb.c
 delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c

-- 
1.8.3.1
