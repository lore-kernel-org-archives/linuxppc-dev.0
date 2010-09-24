Return-Path: <shaggy@linux.vnet.ibm.com>
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/2] powerpc/47x TLB optimization patches
Date: Fri, 24 Sep 2010 13:01:35 -0500
Message-Id: <1285351297-9999-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two patches reduce the frequency that the tlb caches are flushed in
hardware.  Both the normal tlb cache and the "shadow" tlb cache, which
separates the tlbs for data and instruction access (dTLB and iTLB).

Dave Kleikamp (2):
  476: Set CCR2[DSTI] to prevent isync from flushing shadow TLB
  ppc: lazy flush_tlb_mm for nohash architectures

 arch/powerpc/include/asm/reg_booke.h  |    4 +
 arch/powerpc/kernel/head_44x.S        |   25 ++++++
 arch/powerpc/mm/mmu_context_nohash.c  |  154 ++++++++++++++++++++++++++++++---
 arch/powerpc/mm/mmu_decl.h            |    8 ++
 arch/powerpc/mm/tlb_nohash.c          |   28 +++++-
 arch/powerpc/mm/tlb_nohash_low.S      |   14 +++-
 arch/powerpc/platforms/44x/Kconfig    |    7 ++
 arch/powerpc/platforms/44x/misc_44x.S |   26 ++++++
 8 files changed, 249 insertions(+), 17 deletions(-)

-- 
1.7.2.2
