Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 370E5DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 11:10:58 +1100 (EST)
Date: Wed, 12 Nov 2008 11:10:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Theodore Ts'o" <tytso@mit.edu>, <adilger@sun.com>
Subject: [PATCH] ext4: fix some s64 printing warnings
Message-Id: <20081112111049.68c604ff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-ext4@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A powerpc ppc64_defconfig build of Linus' current tree produces these
warnings:

fs/ext4/balloc.c: In function 'ext4_has_free_blocks':
fs/ext4/balloc.c:617: warning: format '%lld' expects type 'long long int', but argument 2 has type 's64'
fs/ext4/inode.c: In function 'ext4_print_free_blocks':
fs/ext4/inode.c:1833: warning: format '%lld' expects type 'long long int', but argument 2 has type 's64'
fs/ext4/inode.c:1835: warning: format '%lld' expects type 'long long int', but argument 2 has type 's64'

Fix them up with the usual casts.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/ext4/balloc.c |    2 +-
 fs/ext4/inode.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index d2003cd..9ce2fcd 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -614,7 +614,7 @@ int ext4_has_free_blocks(struct ext4_sb_info *sbi, s64 nblocks)
 		if (dirty_blocks < 0) {
 			printk(KERN_CRIT "Dirty block accounting "
 					"went wrong %lld\n",
-					dirty_blocks);
+					(long long)dirty_blocks);
 		}
 	}
 	/* Check whether we have space after
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be21a5a..2a3804e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1830,9 +1830,9 @@ static void ext4_print_free_blocks(struct inode *inode)
 			ext4_count_free_blocks(inode->i_sb));
 	printk(KERN_EMERG "Free/Dirty block details\n");
 	printk(KERN_EMERG "free_blocks=%lld\n",
-			percpu_counter_sum(&sbi->s_freeblocks_counter));
+			(long long)percpu_counter_sum(&sbi->s_freeblocks_counter));
 	printk(KERN_EMERG "dirty_blocks=%lld\n",
-			percpu_counter_sum(&sbi->s_dirtyblocks_counter));
+			(long long)percpu_counter_sum(&sbi->s_dirtyblocks_counter));
 	printk(KERN_EMERG "Block reservation details\n");
 	printk(KERN_EMERG "i_reserved_data_blocks=%lu\n",
 			EXT4_I(inode)->i_reserved_data_blocks);
-- 
1.5.6.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
