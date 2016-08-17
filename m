Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDdRw2fHyzDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:43:08 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sDdRv56xgz9sRB
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2016 15:43:07 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 07/10] powerpc/64: Build L1 cache shape info for userspace
Date: Wed, 17 Aug 2016 15:39:14 +1000
Message-Id: <1471412357-3477-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
References: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have all the necessary information available we can
build the L1 cache shape info to be passed down to userspace via
the ELF AUX vectors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d36b6f4..2079e2e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -382,6 +382,34 @@ void smp_release_cpus(void)
 }
 #endif /* CONFIG_SMP || CONFIG_KEXEC */
 
+static long format_cache_shape(u32 size, u32 sets, u32 lsize)
+{
+	long result = 0;
+	u32 log2size = __ilog2(lsize);
+	u32 ways;
+
+	if (size == 0 || sets == 0)
+		return -1;
+	if (sets == 1)
+		ways = 0;
+	else
+		ways = size / (lsize * sets);
+	if (ways < 0x2ff)
+		result |= ways;
+	else
+		result |= 0x2ff;
+	if (log2size < 0xf)
+		result |= (log2size << 10);
+	else
+		result |= 0x3c00;
+	if (size >= 1024)
+		result |= (size >> 10) << 14;
+	else
+		result |= 0xfffffc000ul;
+
+	return result;
+}
+
 /*
  * Initialize some remaining members of the ppc64_caches and systemcfg
  * structures
@@ -487,6 +515,12 @@ void __init initialize_cache_info(void)
 	/* For use by binfmt_elf */
 	dcache_bsize = ppc64_caches.dblock_size;
 	icache_bsize = ppc64_caches.iblock_size;
+	il1cache_shape = format_cache_shape(ppc64_caches.isize,
+					    ppc64_caches.isets,
+					    ppc64_caches.iline_size);
+	dl1cache_shape = format_cache_shape(ppc64_caches.dsize,
+					    ppc64_caches.dsets,
+					    ppc64_caches.dline_size);
 
 	DBG(" <- initialize_cache_info()\n");
 }
-- 
2.7.4
