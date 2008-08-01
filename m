Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6BD15DE446
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 00:14:25 +1000 (EST)
Date: Fri, 1 Aug 2008 18:14:23 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] powerpc: allow to ioremap RAM addresses for kdump
	kernel on ppc32
Message-ID: <20080801141423.GE1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080801141306.GA29127@polina.dev.rtsoft.ru>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While for debugging it is good to catch bogus users of ioremap, but
for kdump support it is more convenient to use ioremap for
copy_oldmem_page() (exactly as we do for PPC64 currently).

The other option is to use kmap_atomic_pfn()*, but it will not work for
kernels compiled without HIGHMEM.

That is, on a board with 256MB RAM and crashkernel=64M@32M case, the
!HIGHMEM capturing kernel maps 0-96M range, which does not include all
the memory needed to capture the dump. And obviously accessing anything
upper than 96M will cause faults.

* http://ozlabs.org/pipermail/linuxppc-dev/2007-November/046747.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/mm/pgtable_32.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index ea50968..3e69b0d 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -194,6 +194,7 @@ __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
 	if (p < 16*1024*1024)
 		p += _ISA_MEM_BASE;
 
+#ifndef CONFIG_CRASH_DUMP
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 * mem_init() sets high_memory so only do the check after that.
@@ -203,6 +204,7 @@ __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
 	}
+#endif
 
 	if (size == 0)
 		return NULL;
-- 
1.5.5.4
