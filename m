Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6267F47502
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:09:11 +1100 (EST)
Date: Wed, 17 Dec 2008 23:09:10 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/7] powerpc/32: Allow to ioremap RAM addresses for kdump
	kernel
Message-ID: <20081217200910.GD4624@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While for debugging it is good to catch bogus users of ioremap,
though for kdump support it is more convenient to use ioremap for
copy_oldmem_page() (exactly as we do for PPC64 currently).

Note that copy_oldmem_page() calls __ioremap with flags set to '0',
so it should be safe with the regard to the caches.

The other option is to use kmap_atomic_pfn()[1], but it will not work
for kernels compiled without HIGHMEM.

That is, on a board with 256MB RAM and crashkernel=64M@32M case, the
!HIGHMEM capturing kernel maps 0-96M range, which does not include all
the memory needed to capture the dump. And, obviously, accessing
anything upper than 96M will cause faults.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2007-November/046747.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/mm/pgtable_32.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 3414724..cd56097 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -173,6 +173,7 @@ __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
 	if (p < 16*1024*1024)
 		p += _ISA_MEM_BASE;
 
+#ifndef CONFIG_CRASH_DUMP
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 * mem_init() sets high_memory so only do the check after that.
@@ -182,6 +183,7 @@ __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
 	}
+#endif
 
 	if (size == 0)
 		return NULL;
-- 
1.5.6.5
