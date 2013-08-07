Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E1CE2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:19:57 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: [PATCH v3 0/7] powerpc: enable the relocatable support for fsl booke
 32bit kernel
Date: Wed, 7 Aug 2013 09:18:28 +0800
Message-ID: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
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
Kevin Hao (7):
  powerpc/fsl_booke: protect the access to MAS7
  powerpc/fsl_booke: introduce get_phys_addr function
  powerpc: enable the relocatable support for the fsl booke 32bit kernel
  powerpc/fsl_booke: set the tlb entry for the kernel address in AS1
  powerpc: introduce early_get_first_memblock_info
  powerpc/fsl_booke: make sure PAGE_OFFSET map to memstart_addr for    
    relocatable kernel
  powerpc/fsl_booke: enable the relocatable for the kdump kernel

 arch/powerpc/Kconfig                          |   5 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |   2 +
 arch/powerpc/kernel/head_fsl_booke.S          | 231 ++++++++++++++++++++++++--
 arch/powerpc/kernel/prom.c                    |  41 ++++-
 arch/powerpc/mm/fsl_booke_mmu.c               |  55 ++++++
 arch/powerpc/mm/hugetlbpage-book3e.c          |   3 +-
 arch/powerpc/mm/mmu_decl.h                    |   2 +
 include/linux/of_fdt.h                        |   1 +
 8 files changed, 317 insertions(+), 23 deletions(-)

-- 
1.8.3.1
