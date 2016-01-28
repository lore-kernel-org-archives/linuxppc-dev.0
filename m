Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1880B1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 13:40:11 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/4] powerpc: Memory hotplug cleanups
Date: Thu, 28 Jan 2016 13:41:02 +1100
Message-Id: <1453948866-22808-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are some fairly straightforward cleanups to the memory hotplug
paths on powerpc.  Mostly it deals with more graceful handling of
failure cases.

This series is a soft prerequisite for my patches for HPT resizing on
pseries.

David Gibson (4):
  arch/powerpc: Clean up error handling for htab_remove_mapping
  arch/powerpc: Handle removing maybe-present bolted HPTEs
  arch/powerpc: Clean up memory hotplug failure paths
  arch/powerpc: Split hash page table sizing heuristic into a helper

 arch/powerpc/include/asm/machdep.h    |  2 +-
 arch/powerpc/include/asm/mmu-hash64.h |  3 ++
 arch/powerpc/mm/hash_utils_64.c       | 66 +++++++++++++++++++++--------------
 arch/powerpc/mm/init_64.c             | 47 ++++++++++++++++---------
 arch/powerpc/mm/mem.c                 | 10 ++++--
 arch/powerpc/platforms/pseries/lpar.c |  7 ++--
 6 files changed, 88 insertions(+), 47 deletions(-)

-- 
2.5.0
