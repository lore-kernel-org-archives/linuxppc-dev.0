Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F139DDE258
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 07:54:08 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mm: fix ENTRIES_PER_PAGEPAGE overflow with 256KB pages
Date: Thu, 11 Sep 2008 01:53:07 +0400
Message-Id: <1221083587-8091-3-git-send-email-yanok@emcraft.com>
In-Reply-To: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ENTRIES_PER_PAGEPAGE define in mm/shmem.c becomes zero if page size is
256KB. This patch fixes this.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 mm/shmem.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 04fb4f1..c603427 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -59,7 +59,7 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
-#define ENTRIES_PER_PAGEPAGE (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
+#define ENTRIES_PER_PAGEPAGE ((unsigned long long)ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
 #define BLOCKS_PER_PAGE  (PAGE_CACHE_SIZE/512)
 
 #define SHMEM_MAX_INDEX  (SHMEM_NR_DIRECT + (ENTRIES_PER_PAGEPAGE/2) * (ENTRIES_PER_PAGE+1))
@@ -519,7 +519,7 @@ static void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long idx;
 	unsigned long size;
-	unsigned long limit;
+	unsigned long long limit;
 	unsigned long stage;
 	unsigned long diroff;
 	struct page **dir;
@@ -535,7 +535,7 @@ static void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end)
 	int punch_hole;
 	spinlock_t *needs_lock;
 	spinlock_t *punch_lock;
-	unsigned long upper_limit;
+	unsigned long long upper_limit;
 
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	idx = (start + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-- 
1.5.6.1
