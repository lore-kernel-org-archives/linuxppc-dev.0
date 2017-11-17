Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydLZd3bxhzDrD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 12:47:05 +1100 (AEDT)
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, arbab@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, mhocko@suse.com, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, mgorman@techsingularity.net
Subject: [PATCH v1] mm: relax deferred struct page requirements
Date: Thu, 16 Nov 2017 20:46:01 -0500
Message-Id: <20171117014601.31606-1-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
as all the page initialization code is in common code.

Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
does not really use hotplug memory functionality. So, we can remove this
requirement as well.

This patch allows to use deferred struct page initialization on all
platforms with memblock allocator.

Tested on x86, arm64, and sparc. Also, verified that code compiles on
PPC with CONFIG_MEMORY_HOTPLUG disabled.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/powerpc/Kconfig | 1 -
 arch/s390/Kconfig    | 1 -
 arch/x86/Kconfig     | 1 -
 mm/Kconfig           | 7 +------
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cb782ac1c35d..1540348691c9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -148,7 +148,6 @@ config PPC
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 863a62a6de3c..525c2e3df6f5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -108,7 +108,6 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
 	select ARCH_SAVE_PAGE_KEYS if HIBERNATION
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index df3276d6bfe3..00a5446de394 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -69,7 +69,6 @@ config X86
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
diff --git a/mm/Kconfig b/mm/Kconfig
index 9c4bdddd80c2..c6bd0309ce7a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -639,15 +639,10 @@ config MAX_STACK_SIZE_MB
 
 	  A sane initial value is 80 MB.
 
-# For architectures that support deferred memory initialisation
-config ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
-	bool
-
 config DEFERRED_STRUCT_PAGE_INIT
 	bool "Defer initialisation of struct pages to kthreads"
 	default n
-	depends on ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
-	depends on NO_BOOTMEM && MEMORY_HOTPLUG
+	depends on NO_BOOTMEM
 	depends on !FLATMEM
 	help
 	  Ordinarily all struct pages are initialised during early boot in a
-- 
2.15.0
