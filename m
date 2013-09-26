Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BA742C0353
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:42:51 +1000 (EST)
Received: by mail-pb0-f47.google.com with SMTP id rr4so431081pbb.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 18:42:48 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 0/3] powerpc/85xx: introduce corenet_generic machine
Date: Thu, 26 Sep 2013 09:42:25 +0800
Message-Id: <1380159748-10559-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v4:
  - Update the patch 3 according to Scott's comment. 

v3:
  - Update the patch 1 according to Scott's comment.
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
 arch/powerpc/platforms/85xx/Kconfig           | 101 ++------------
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
 15 files changed, 196 insertions(+), 853 deletions(-)
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
