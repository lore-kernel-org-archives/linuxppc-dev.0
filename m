Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svflf1t7XzDt1W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 16:43:10 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i85so862951pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 22:43:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3][RFC] powerpc: relative exception tables,
 and build-time sort
Date: Thu, 13 Oct 2016 16:42:52 +1100
Message-Id: <20161013054255.7205-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This implements relative exception tables for powerpc, and converts it
to use build-time sorting. I've tested 64s only so far, but 32-bit seems
to build. Will obviously require some more testing and reviews.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc: EX_TABLE macro for exception tables
  powerpc: relative exception tables
  powerpc: build-time sort exception table

 arch/powerpc/Kconfig                              |   1 +
 arch/powerpc/include/asm/futex.h                  |  14 +-
 arch/powerpc/include/asm/io.h                     |  18 +-
 arch/powerpc/include/asm/linkage.h                |  22 ++
 arch/powerpc/include/asm/module.h                 |   4 -
 arch/powerpc/include/asm/uaccess.h                |  51 ++--
 arch/powerpc/include/asm/word-at-a-time.h         |   5 +-
 arch/powerpc/kernel/kprobes.c                     |   2 +-
 arch/powerpc/kernel/traps.c                       |   2 +-
 arch/powerpc/lib/checksum_32.S                    |  47 ++--
 arch/powerpc/lib/checksum_64.S                    |  20 +-
 arch/powerpc/lib/copy_32.S                        |  56 ++---
 arch/powerpc/lib/copyuser_64.S                    | 271 +++++++++++-----------
 arch/powerpc/lib/copyuser_power7.S                |  21 +-
 arch/powerpc/lib/ldstfp.S                         |  25 +-
 arch/powerpc/lib/sstep.c                          |  15 +-
 arch/powerpc/lib/string.S                         |  11 +-
 arch/powerpc/lib/string_64.S                      |  16 +-
 arch/powerpc/mm/fault.c                           |   2 +-
 arch/powerpc/platforms/embedded6xx/holly.c        |   2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   2 +-
 arch/powerpc/sysdev/fsl_rio.c                     |   7 +-
 arch/powerpc/sysdev/tsi108_pci.c                  |   5 +-
 scripts/sortextable.c                             |   2 +
 24 files changed, 274 insertions(+), 347 deletions(-)

-- 
2.9.3
