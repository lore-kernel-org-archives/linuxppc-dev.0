Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBfS0578zDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:36 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBfN6mchz9sRZ
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:31 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 32/41] powerpc/64: Move setting of {i,
 d}cache_bsize to initialize_cache_info()
Date: Tue,  5 Jul 2016 15:04:08 +1000
Message-Id: <1467695057-12431-33-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also remove the completely osbolete comment. We *do* look in the
device-tree.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d8f5f48..16e9ce7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -471,6 +471,10 @@ static void __init initialize_cache_info(void)
 		}
 	}
 
+	/* For use by binfmt_elf */
+	dcache_bsize = ppc64_caches.dline_size;
+	icache_bsize = ppc64_caches.iline_size;
+
 	DBG(" <- initialize_cache_info()\n");
 }
 
@@ -691,15 +695,6 @@ void __init setup_arch(char **cmdline_p)
 {
 	*cmdline_p = boot_command_line;
 
-	/*
-	 * Set cache line size based on type of cpu as a default.
-	 * Systems with OF can look in the properties on the cpu node(s)
-	 * for a possibly more accurate value.
-	 */
-	dcache_bsize = ppc64_caches.dline_size;
-	icache_bsize = ppc64_caches.iline_size;
-
-
 	/* Reserve large chunks of memory for use by CMA for KVM */
 	kvm_cma_reserve();
 
-- 
2.7.4
