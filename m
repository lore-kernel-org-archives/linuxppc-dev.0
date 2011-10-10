Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F887B71BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:07 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/13] Hugetlb for 64-bit Freescale Book3E
Date: Mon, 10 Oct 2011 15:50:35 -0500
Message-Id: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches contains mostly cleanup code that allows
the enablement of hugetlb for 64-bit Freescale BookE processors.
There are also some bits that I dropped from the 32-bit release
that are added back, as they are needed by other implementations.
Otherwise, it's mostly a bunch of code rearrangement, changes
in #include protections, and Kconfig changes.

Cheers,
Becky

 arch/powerpc/configs/corenet32_smp_defconfig |    9 +--
 arch/powerpc/configs/corenet64_smp_defconfig |    6 +-
 arch/powerpc/configs/mpc85xx_defconfig       |    6 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    7 +-
 arch/powerpc/include/asm/hugetlb.h           |   36 ++++++--
 arch/powerpc/include/asm/page_64.h           |    2 +
 arch/powerpc/kernel/setup_64.c               |   10 ++
 arch/powerpc/mm/hugetlbpage-book3e.c         |   15 ++--
 arch/powerpc/mm/hugetlbpage.c                |  116 ++++++++++++++++----------
 arch/powerpc/mm/tlb_low_64e.S                |   36 ++++-----
 arch/powerpc/mm/tlb_nohash.c                 |    2 +-
 arch/powerpc/platforms/Kconfig.cputype       |    4 +-
 12 files changed, 143 insertions(+), 106 deletions(-)
