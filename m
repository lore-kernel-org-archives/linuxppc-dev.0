Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E6B5B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 05:55:55 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] Hugetlb for 32-bit FSL PowerPC BookE
Date: Tue, 28 Jun 2011 14:54:43 -0500
Message-Id: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
Cc: wli@holomorphy.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement HugeTLB for 32-bit BookE PowerPC.  There is also some 
infrastructure in place for 64-bit BookE as well from David Gibson;
I'm not sure if we want to include this at this time or not.  I have
only been able to build test the 64-bit configurations.  Ben, let
me know how you want to proceed here.

The bulk of this patch series is powerpc-specific, but there
are a couple of minor fixes to the generic fs and mm code included,
hence the cross-post.

Note that to use this fully some modifications to libhugetlbfs
are required; I expect to publish those shortly.

Diffstat below.

Cheers,
Becky

arch/powerpc/Kconfig                   |    3 +-
arch/powerpc/include/asm/hugetlb.h     |   63 +++++-
arch/powerpc/include/asm/mmu-book3e.h  |    7 +
arch/powerpc/include/asm/mmu-hash64.h  |    3 +-
arch/powerpc/include/asm/mmu.h         |   23 ++-
arch/powerpc/include/asm/page.h        |   31 +++-
arch/powerpc/include/asm/page_64.h     |   11 -
arch/powerpc/include/asm/pte-book3e.h  |    3 +
arch/powerpc/kernel/head_fsl_booke.S   |  133 ++++++++++--
arch/powerpc/kernel/smp.c              |    4 +
arch/powerpc/mm/Makefile               |    1 +
arch/powerpc/mm/hash_utils_64.c        |    3 -
arch/powerpc/mm/hugetlbpage-book3e.c   |  121 ++++++++++
arch/powerpc/mm/hugetlbpage.c          |  379 ++++++++++++++++++++++++++++----
arch/powerpc/mm/init_32.c              |    9 +
arch/powerpc/mm/mem.c                  |   17 ++-
arch/powerpc/mm/mmu_context_nohash.c   |    5 +
arch/powerpc/mm/pgtable.c              |    3 +-
arch/powerpc/mm/tlb_low_64e.S          |   24 +-
arch/powerpc/mm/tlb_nohash.c           |   52 +++++-
arch/powerpc/platforms/Kconfig.cputype |    4 +-
fs/hugetlbfs/inode.c                   |    2 +-
include/linux/hugetlb.h                |    3 +
mm/hugetlb.c                           |    8 +-
24 files changed, 803 insertions(+), 109 deletions(-)
