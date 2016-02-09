Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AF1D1A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 14:31:43 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: mpe@ellerman.id.au,
	paulus@samba.org,
	benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/4] powerpc/mm: Cleanups to hotplug memory path
Date: Tue,  9 Feb 2016 13:32:39 +1000
Message-Id: <1454988763-5580-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cleanups to the (guest side) memory hotplug paths came up in the
context of allowing hash page table resizing for PAPR guests.
However, they stand on their own and can improve reporting of several
error conditions that could already happen.

Please apply.

David Gibson (4):
  powerpc/mm: Clean up error handling for htab_remove_mapping
  powerpc/mm: Handle removing maybe-present bolted HPTEs
  powerpc/mm: Clean up memory hotplug failure paths
  powerpc/mm: Split hash page table sizing heuristic into a helper

 arch/powerpc/include/asm/machdep.h    |  2 +-
 arch/powerpc/include/asm/mmu-hash64.h |  3 ++
 arch/powerpc/mm/hash_utils_64.c       | 73 ++++++++++++++++++++++-------------
 arch/powerpc/mm/init_64.c             | 47 ++++++++++++++--------
 arch/powerpc/mm/mem.c                 | 10 ++++-
 arch/powerpc/platforms/pseries/lpar.c |  9 +++--
 6 files changed, 96 insertions(+), 48 deletions(-)

-- 
2.5.0
