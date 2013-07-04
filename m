Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A58612C0412
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:55:36 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: [PATCH v2 5/8] memblock: introduce the memblock_reinit function
Date: Thu, 4 Jul 2013 20:54:11 +0800
Message-ID: <1372942454-25191-6-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linux-mm@kvack.org,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the current code, the data used by memblock are initialized
statically. But in some special cases we may scan the memory twice.
So we should have a way to reinitialize these data before the second
time.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
A new patch in v2.

 include/linux/memblock.h |  1 +
 mm/memblock.c            | 33 +++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f388203..9d55311 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -58,6 +58,7 @@ int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_free(phys_addr_t base, phys_addr_t size);
 int memblock_reserve(phys_addr_t base, phys_addr_t size);
 void memblock_trim_memory(phys_addr_t align);
+void memblock_reinit(void);
 
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index c5fad93..9406ce6 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -23,23 +23,36 @@
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 
-struct memblock memblock __initdata_memblock = {
-	.memory.regions		= memblock_memory_init_regions,
-	.memory.cnt		= 1,	/* empty dummy entry */
-	.memory.max		= INIT_MEMBLOCK_REGIONS,
-
-	.reserved.regions	= memblock_reserved_init_regions,
-	.reserved.cnt		= 1,	/* empty dummy entry */
-	.reserved.max		= INIT_MEMBLOCK_REGIONS,
+#define INIT_MEMBLOCK {							\
+	.memory.regions		= memblock_memory_init_regions,		\
+	.memory.cnt		= 1,	/* empty dummy entry */		\
+	.memory.max		= INIT_MEMBLOCK_REGIONS,		\
+									\
+	.reserved.regions	= memblock_reserved_init_regions,	\
+	.reserved.cnt		= 1,	/* empty dummy entry */		\
+	.reserved.max		= INIT_MEMBLOCK_REGIONS,		\
+									\
+	.current_limit		= MEMBLOCK_ALLOC_ANYWHERE,		\
+}
 
-	.current_limit		= MEMBLOCK_ALLOC_ANYWHERE,
-};
+struct memblock memblock __initdata_memblock = INIT_MEMBLOCK;
 
 int memblock_debug __initdata_memblock;
 static int memblock_can_resize __initdata_memblock;
 static int memblock_memory_in_slab __initdata_memblock = 0;
 static int memblock_reserved_in_slab __initdata_memblock = 0;
 
+void __init memblock_reinit(void)
+{
+	memset(memblock_memory_init_regions, 0,
+				sizeof(memblock_memory_init_regions));
+	memset(memblock_reserved_init_regions, 0,
+				sizeof(memblock_reserved_init_regions));
+
+	memset(&memblock, 0, sizeof(memblock));
+	memblock = (struct memblock) INIT_MEMBLOCK;
+}
+
 /* inline so we don't get a warning when pr_debug is compiled out */
 static __init_memblock const char *
 memblock_type_name(struct memblock_type *type)
-- 
1.8.1.4
