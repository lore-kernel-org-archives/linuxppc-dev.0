Return-Path: <kim.phillips@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sNyjN6cPqzDrhs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 05:08:40 +1000 (AEST)
Date: Tue, 30 Aug 2016 14:08:34 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo
 <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Michael Ellerman <mpe@ellerman.id.au>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland
 <mark.rutland@arm.com>
Subject: [PATCH 1/2] perf_event: remove unused DEBUG_PERF_USE_VMALLOC
Message-Id: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This 'DEBUG'-prefixed version of PERF_USE_VMALLOC is not used anywhere.
It appears to be leftovers from commit 906010b "perf_event: Provide
vmalloc() based mmap() backing" that introduced it.

Not sure what commit cb30711 "perf_event: Don't allow vmalloc() backed
perf on powerpc" was trying to do with it either.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 init/Kconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index cac3f09..934a61f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1707,19 +1707,6 @@ config PERF_EVENTS
 
 	  Say Y if unsure.
 
-config DEBUG_PERF_USE_VMALLOC
-	default n
-	bool "Debug: use vmalloc to back perf mmap() buffers"
-	depends on PERF_EVENTS && DEBUG_KERNEL && !PPC
-	select PERF_USE_VMALLOC
-	help
-	 Use vmalloc memory to back perf mmap() buffers.
-
-	 Mostly useful for debugging the vmalloc code on platforms
-	 that don't require it.
-
-	 Say N if unsure.
-
 endmenu
 
 config VM_EVENT_COUNTERS
-- 
2.9.3
