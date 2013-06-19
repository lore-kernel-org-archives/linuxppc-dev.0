Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E1962C031E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 19:21:11 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/4] powerpc: enable relocatable support for 6xx
Date: Wed, 19 Jun 2013 17:20:00 +0800
Message-ID: <1371633604-4491-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series enables the relocatable support for 6xx boards.
With these patches:
  * the kernel can boot from any address between 0x10000 ~ 0x2000000
  * kdump is workable
  * a single kernel image can be used as boot or kdump kernel

Boot test on a mpc8260 board. Also passed the build test for the
following configurations:
	ppc40x_defconfig
        ppc64e_defconfig
        ppc64_defconfig
        corenet32_smp_defconfig
        corenet64_smp_defconfig
        ppc44x_defconfig
	pmac32_defconfig
	pq2fads_defconfig
	mpc5200_defconfig
        pseries_defconfig

---
Kevin Hao (4):
  powerpc: enable relocatable support for 6xx
  powerpc: move the exception trampoline helper functions to a separate
    file
  powerpc: s/kdump/exception/ for the exception trampoline functions
  powerpc: make the kernel bootable from non 0 address for 6xx

 arch/powerpc/Kconfig                            |   4 +-
 arch/powerpc/include/asm/exception_trampoline.h |  35 ++++++++
 arch/powerpc/include/asm/kdump.h                |  32 --------
 arch/powerpc/include/asm/page.h                 |   2 +-
 arch/powerpc/kernel/Makefile                    |   1 +
 arch/powerpc/kernel/crash_dump.c                |  41 ----------
 arch/powerpc/kernel/exception_trampoline.c      |  82 +++++++++++++++++++
 arch/powerpc/kernel/head_32.S                   | 103 ++++++++++++++++++++++++
 arch/powerpc/kernel/prom.c                      |   4 +-
 arch/powerpc/kernel/prom_init_check.sh          |   2 +-
 arch/powerpc/kernel/setup_32.c                  |   3 +-
 arch/powerpc/kernel/setup_64.c                  |   4 +-
 arch/powerpc/mm/ppc_mmu_32.c                    |   7 +-
 13 files changed, 232 insertions(+), 88 deletions(-)
 create mode 100644 arch/powerpc/include/asm/exception_trampoline.h
 create mode 100644 arch/powerpc/kernel/exception_trampoline.c

-- 
1.8.1.4


Thanks,
Kevin
