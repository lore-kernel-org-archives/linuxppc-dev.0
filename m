Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BA6E1A02EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 16:27:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] perf_event: Don't allow vmalloc backed perf on powerpc
Date: Mon,  4 May 2015 16:26:39 +1000
Message-Id: <1430720799-18426-1-git-send-email-mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, acme@ghostprotocols.net,
 sukadev@linux.vnet.ibm.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc the perf event interrupt is not masked when interrupts are
disabled, allowing it to function as an NMI.

This causes problems if perf is using vmalloc. If we take a page fault
on the vmalloc region the fault handler will fail the page fault because
it detects we are coming in from an NMI (see do_hash_page()).

We don't actually need or want vmalloc backed perf so just disable it on
powerpc.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index dc24dec60232..81050e4d9941 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1637,7 +1637,7 @@ config PERF_EVENTS
 config DEBUG_PERF_USE_VMALLOC
 	default n
 	bool "Debug: use vmalloc to back perf mmap() buffers"
-	depends on PERF_EVENTS && DEBUG_KERNEL
+	depends on PERF_EVENTS && DEBUG_KERNEL && !PPC
 	select PERF_USE_VMALLOC
 	help
 	 Use vmalloc memory to back perf mmap() buffers.
-- 
2.1.0
