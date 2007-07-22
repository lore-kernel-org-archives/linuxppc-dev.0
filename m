Return-Path: <viro@ftp.linux.org.uk>
Date: Sun, 22 Jul 2007 08:10:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] ppc64 mismerge
Message-ID: <20070722071035.GS21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jk@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Mismerge in
commit 8b6f50ef1d5cc86b278eb42bc91630fad455fb10
Author: Jeremy Kerr <jk@ozlabs.org>
Date:   Sat Jul 21 04:37:51 2007 -0700
    spufs: make signal-notification files readonly for NOSCHED contexts

structs got duplicated.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index c2aaec5..4100ddc 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -941,13 +941,6 @@ static const struct file_operations spufs_signal1_nosched_fops = {
 	.mmap = spufs_signal1_mmap,
 };
 
-static const struct file_operations spufs_signal1_nosched_fops = {
-	.open = spufs_signal1_open,
-	.release = spufs_signal1_release,
-	.write = spufs_signal1_write,
-	.mmap = spufs_signal1_mmap,
-};
-
 static int spufs_signal2_open(struct inode *inode, struct file *file)
 {
 	struct spufs_inode_info *i = SPUFS_I(inode);
@@ -1083,13 +1076,6 @@ static const struct file_operations spufs_signal2_nosched_fops = {
 	.mmap = spufs_signal2_mmap,
 };
 
-static const struct file_operations spufs_signal2_nosched_fops = {
-	.open = spufs_signal2_open,
-	.release = spufs_signal2_release,
-	.write = spufs_signal2_write,
-	.mmap = spufs_signal2_mmap,
-};
-
 static void spufs_signal1_type_set(void *data, u64 val)
 {
 	struct spu_context *ctx = data;
