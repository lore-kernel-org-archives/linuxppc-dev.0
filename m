Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9673ADDF28
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 16:55:37 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mm/shmem.c: fix division by zero
Date: Fri, 19 Dec 2008 08:44:57 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200812190844.57996.yur@emcraft.com>
Cc: wd@denx.de, dzu@denx.de, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, viro@zeniv.linux.org.uk,
	Geert.Uytterhoeven@sonycom.com, hugh@veritas.com,
	akpm@linux-foundation.org, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following patch fixes division by zero, which we have in
shmem_truncate_range() and shmem_unuse_inode(), if use big
PAGE_SIZE values (e.g. 256KB on ppc44x).

With 256KB PAGE_SIZE the ENTRIES_PER_PAGEPAGE constant becomes
too large (0x1.0000.0000), so this patch just changes the types
from 'ulong' to 'ullong' where it's necessary.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
---
 mm/shmem.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0ed0752..99d7c91 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -57,7 +57,7 @@
 #include <asm/pgtable.h>
 
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
-#define ENTRIES_PER_PAGEPAGE (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
+#define ENTRIES_PER_PAGEPAGE ((unsigned long long)ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
 #define BLOCKS_PER_PAGE  (PAGE_CACHE_SIZE/512)
 
 #define SHMEM_MAX_INDEX  (SHMEM_NR_DIRECT + (ENTRIES_PER_PAGEPAGE/2) * (ENTRIES_PER_PAGE+1))
@@ -95,7 +95,7 @@ static unsigned long shmem_default_max_inodes(void)
 }
 #endif
 
-static int shmem_getpage(struct inode *inode, unsigned long idx,
+static int shmem_getpage(struct inode *inode, unsigned long long idx,
 			 struct page **pagep, enum sgp_type sgp, int *type);
 
 static inline struct page *shmem_dir_alloc(gfp_t gfp_mask)
@@ -533,7 +533,7 @@ static void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end)
 	int punch_hole;
 	spinlock_t *needs_lock;
 	spinlock_t *punch_lock;
-	unsigned long upper_limit;
+	unsigned long long upper_limit;
 
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	idx = (start + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
@@ -1175,7 +1175,7 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache
  */
-static int shmem_getpage(struct inode *inode, unsigned long idx,
+static int shmem_getpage(struct inode *inode, unsigned long long idx,
 			struct page **pagep, enum sgp_type sgp, int *type)
 {
 	struct address_space *mapping = inode->i_mapping;
-- 
1.6.0.4
