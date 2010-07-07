Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 06/18] spufs: use llseek in all file operations
Date: Wed,  7 Jul 2010 23:40:08 +0200
Message-Id: <1278538820-1392-7-git-send-email-arnd@arndb.de>
In-Reply-To: <1278538820-1392-1-git-send-email-arnd@arndb.de>
References: <1278538820-1392-1-git-send-email-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>,
	linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	John Kacur <jkacur@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The default for llseek is changing, so we need
explicit operations everywhere.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/platforms/cell/spufs/file.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 1a40da9..d2980bd 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -154,6 +154,7 @@ static const struct file_operations __fops = {				\
 	.release = spufs_attr_release,					\
 	.read	 = spufs_attr_read,					\
 	.write	 = spufs_attr_write,					\
+	.llseek  = generic_file_llseek,					\
 };
 
 
@@ -521,6 +522,7 @@ static const struct file_operations spufs_cntl_fops = {
 	.release = spufs_cntl_release,
 	.read = simple_attr_read,
 	.write = simple_attr_write,
+	.llseek	= generic_file_llseek,
 	.mmap = spufs_cntl_mmap,
 };
 
@@ -714,6 +716,7 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_mbox_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_mbox_read,
+	.llseek	= no_llseek,
 };
 
 static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
@@ -743,6 +746,7 @@ static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_mbox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_mbox_stat_read,
+	.llseek = no_llseek,
 };
 
 /* low-level ibox access function */
@@ -863,6 +867,7 @@ static const struct file_operations spufs_ibox_fops = {
 	.read	= spufs_ibox_read,
 	.poll	= spufs_ibox_poll,
 	.fasync	= spufs_ibox_fasync,
+	.llseek = no_llseek,
 };
 
 static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
@@ -890,6 +895,7 @@ static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_ibox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_ibox_stat_read,
+	.llseek = no_llseek,
 };
 
 /* low-level mailbox write */
@@ -1011,6 +1017,7 @@ static const struct file_operations spufs_wbox_fops = {
 	.write	= spufs_wbox_write,
 	.poll	= spufs_wbox_poll,
 	.fasync	= spufs_wbox_fasync,
+	.llseek = no_llseek,
 };
 
 static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
@@ -1038,6 +1045,7 @@ static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_wbox_stat_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_wbox_stat_read,
+	.llseek = no_llseek,
 };
 
 static int spufs_signal1_open(struct inode *inode, struct file *file)
@@ -1166,6 +1174,7 @@ static const struct file_operations spufs_signal1_fops = {
 	.read = spufs_signal1_read,
 	.write = spufs_signal1_write,
 	.mmap = spufs_signal1_mmap,
+	.llseek = no_llseek,
 };
 
 static const struct file_operations spufs_signal1_nosched_fops = {
@@ -1173,6 +1182,7 @@ static const struct file_operations spufs_signal1_nosched_fops = {
 	.release = spufs_signal1_release,
 	.write = spufs_signal1_write,
 	.mmap = spufs_signal1_mmap,
+	.llseek = no_llseek,
 };
 
 static int spufs_signal2_open(struct inode *inode, struct file *file)
@@ -1305,6 +1315,7 @@ static const struct file_operations spufs_signal2_fops = {
 	.read = spufs_signal2_read,
 	.write = spufs_signal2_write,
 	.mmap = spufs_signal2_mmap,
+	.llseek = no_llseek,
 };
 
 static const struct file_operations spufs_signal2_nosched_fops = {
@@ -1312,6 +1323,7 @@ static const struct file_operations spufs_signal2_nosched_fops = {
 	.release = spufs_signal2_release,
 	.write = spufs_signal2_write,
 	.mmap = spufs_signal2_mmap,
+	.llseek = no_llseek,
 };
 
 /*
@@ -1451,6 +1463,7 @@ static const struct file_operations spufs_mss_fops = {
 	.open	 = spufs_mss_open,
 	.release = spufs_mss_release,
 	.mmap	 = spufs_mss_mmap,
+	.llseek  = no_llseek,
 };
 
 static int
@@ -1508,6 +1521,7 @@ static const struct file_operations spufs_psmap_fops = {
 	.open	 = spufs_psmap_open,
 	.release = spufs_psmap_release,
 	.mmap	 = spufs_psmap_mmap,
+	.llseek  = no_llseek,
 };
 
 
@@ -1871,6 +1885,7 @@ static const struct file_operations spufs_mfc_fops = {
 	.fsync	 = spufs_mfc_fsync,
 	.fasync	 = spufs_mfc_fasync,
 	.mmap	 = spufs_mfc_mmap,
+	.llseek  = no_llseek,
 };
 
 static int spufs_npc_set(void *data, u64 val)
@@ -2111,7 +2126,7 @@ static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_mbox_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_mbox_info_read,
-	.llseek  = generic_file_llseek,
+	.llseek = no_llseek,
 };
 
 static ssize_t __spufs_ibox_info_read(struct spu_context *ctx,
@@ -2151,7 +2166,7 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_ibox_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_ibox_info_read,
-	.llseek  = generic_file_llseek,
+	.llseek = no_llseek,
 };
 
 static ssize_t __spufs_wbox_info_read(struct spu_context *ctx,
@@ -2194,7 +2209,7 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_wbox_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_wbox_info_read,
-	.llseek  = generic_file_llseek,
+	.llseek = no_llseek,
 };
 
 static ssize_t __spufs_dma_info_read(struct spu_context *ctx,
@@ -2246,6 +2261,7 @@ static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_dma_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_dma_info_read,
+	.llseek = no_llseek,
 };
 
 static ssize_t __spufs_proxydma_info_read(struct spu_context *ctx,
@@ -2299,6 +2315,7 @@ static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
 static const struct file_operations spufs_proxydma_info_fops = {
 	.open = spufs_info_open,
 	.read = spufs_proxydma_info_read,
+	.llseek = no_llseek,
 };
 
 static int spufs_show_tid(struct seq_file *s, void *private)
@@ -2585,6 +2602,7 @@ static const struct file_operations spufs_switch_log_fops = {
 	.read		= spufs_switch_log_read,
 	.poll		= spufs_switch_log_poll,
 	.release	= spufs_switch_log_release,
+	.llseek		= no_llseek,
 };
 
 /**
-- 
1.7.1
