Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A9F192C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 18:13:00 +1100 (EST)
Received: by mail-pd0-f172.google.com with SMTP id g10so6004895pdj.31
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 23:12:57 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 00/10] powerpc: enable the relocatable support for fsl
 booke 32bit kernel
Date: Tue, 24 Dec 2013 15:12:02 +0800
Message-Id: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
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
  - Fix the bug when booting above 64M.
  - Rebase onto v3.13-rc5
  - Pass the following test on a p5020ds board:
       boot kernel at 0x5000000 and 0x9000000
       kdump test with kernel option "crashkernel=64M@80M"

v3:
The main changes include:
  * Drop the patch 5 in v2 (memblock: introduce the memblock_reinit function)
  * Change to use the 64M boot init tlb.

Please refer to the comment section of each patch for more detail.

This patch series passed the kdump test with kernel option "crashkernel=64M@32M"
and "crashkernel=64M@80M" on a p2020rdb board.

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
---
Kevin Hao (10):
  powerpc/fsl_booke: protect the access to MAS7
  powerpc/fsl_booke: introduce get_phys_addr function
  powerpc: introduce macro LOAD_REG_ADDR_PIC
  powerpc: enable the relocatable support for the fsl booke 32bit kernel
  powerpc/fsl_booke: set the tlb entry for the kernel address in AS1
  powerpc: introduce early_get_first_memblock_info
  powerpc/fsl_booke: introduce map_mem_in_cams_addr
  powerpc/fsl_booke: make sure PAGE_OFFSET map to memstart_addr for
    relocatable kernel
  powerpc/fsl_booke: smp support for booting a relocatable kernel above
    64M
  powerpc/fsl_booke: enable the relocatable for the kdump kernel

 arch/powerpc/Kconfig                          |   5 +-
 arch/powerpc/include/asm/ppc_asm.h            |  13 ++
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |   2 +
 arch/powerpc/kernel/head_fsl_booke.S          | 266 +++++++++++++++++++++++---
 arch/powerpc/kernel/prom.c                    |  41 +++-
 arch/powerpc/mm/fsl_booke_mmu.c               |  72 ++++++-
 arch/powerpc/mm/hugetlbpage-book3e.c          |   3 +-
 arch/powerpc/mm/mmu_decl.h                    |   2 +
 arch/powerpc/mm/tlb_nohash_low.S              |   4 +-
 include/linux/of_fdt.h                        |   1 +
 10 files changed, 370 insertions(+), 39 deletions(-)

-- 
1.8.3.1
