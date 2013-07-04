Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E53B2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:54:45 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 0/8] powerpc: enable the relocatable support for fsl booke
 32bit kernel
Date: Thu, 4 Jul 2013 20:54:06 +0800
Message-ID: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
These patches are based on the Ben's next branch. In this version we choose
to do a second relocation if the PAGE_OFFSET is not mapped to the memstart_addr
and we also choose to set the tlb1 entries for the kernel space in address
space 1. With this implementation:
  * We can load the kernel at any place between
     memstart_addr ~ memstart_addr + 768M
  * We can reserve any memory between memstart_addr ~ memstart_addr + 768M
    for a kdump kernel.

I have done a kdump boot on a p2020rdb kernel with the memory reserved by
'crashkernel=32M@320M'.


v1:
Currently the fsl booke 32bit kernel is using the DYNAMIC_MEMSTART relocation
method. But the RELOCATABLE method is more flexible and has less alignment
restriction. So enable this feature on this platform and use it by
default for the kdump kernel.

These patches have passed the kdump boot test on a p2020rdb board.

Kevin Hao (8):
  powerpc/fsl_booke: protect the access to MAS7 with MMU_FTR_BIG_PHYS
  powerpc/fsl_booke: introduce get_phys_addr function
  powerpc: enable the relocatable support for the fsl booke 32bit kernel
  powerpc/fsl_booke: set the tlb entry for the kernel address in AS1
  memblock: introduce the memblock_reinit function
  powerpc: introduce early_get_first_memblock_info
  powerpc/fsl_booke: make sure PAGE_OFFSET map to memstart_addr for    
    relocatable kernel
  powerpc/fsl_booke: enable the relocatable for the kdump kernel

 arch/powerpc/Kconfig                          |   5 +-
 arch/powerpc/kernel/entry_32.S                |   8 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |  14 +-
 arch/powerpc/kernel/head_fsl_booke.S          | 233 ++++++++++++++++++++++++--
 arch/powerpc/kernel/prom.c                    |  24 +++
 arch/powerpc/mm/fsl_booke_mmu.c               |  56 +++++++
 arch/powerpc/mm/hugetlbpage-book3e.c          |   3 +-
 arch/powerpc/mm/mmu_decl.h                    |   2 +
 include/linux/memblock.h                      |   1 +
 include/linux/of_fdt.h                        |   1 +
 mm/memblock.c                                 |  33 ++--
 11 files changed, 340 insertions(+), 40 deletions(-)

-- 
1.8.1.4
