Return-Path: <diana.craciun@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RvPl09njzF35Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 23:52:25 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, leoyang.li@nxp.com,
 bharat.bhushan@nxp.com, Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH v3 0/6] powerpc/fsl: Speculation barrier for NXP PowerPC Book3E
Date: Fri, 13 Jul 2018 16:52:09 +0300
Message-Id: <1531489935-17473-1-git-send-email-diana.craciun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement barrier_nospec for NXP PowerPC Book3E processors.

Diana Craciun (6):
  Disable the speculation barrier from the command line
  Document nospectre_v1 kernel parameter.
  Make stf barrier PPC_BOOK3S_64 specific.
  Enable cpu vulnerabilities reporting for NXP PPC BOOK3E
  Add barrier_nospec implementation for NXP PowerPC Book3E
  powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit
    platforms

 Documentation/admin-guide/kernel-parameters.txt |  4 +++
 arch/powerpc/Kconfig                            |  7 ++++-
 arch/powerpc/include/asm/barrier.h              | 12 ++++++---
 arch/powerpc/include/asm/setup.h                |  6 ++++-
 arch/powerpc/kernel/Makefile                    |  3 ++-
 arch/powerpc/kernel/entry_32.S                  | 10 +++++++
 arch/powerpc/kernel/module.c                    |  4 ++-
 arch/powerpc/kernel/security.c                  | 17 +++++++++++-
 arch/powerpc/kernel/setup-common.c              |  2 ++
 arch/powerpc/kernel/vmlinux.lds.S               |  4 ++-
 arch/powerpc/lib/feature-fixups.c               | 35 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/setup.c          |  1 -
 arch/powerpc/platforms/pseries/setup.c          |  1 -
 13 files changed, 94 insertions(+), 12 deletions(-)

--
History:

v2 --> v3
- addressed review comments
- included the 32bit sanitization in the same patch series

v1 --> v2
- added implementation for cpu_show_spectre_x functions
- the mitigation is no longer enabled through device tree options

2.5.5
