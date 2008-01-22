Return-Path: <jengelh@computergmbh.de>
Received: from sovereign.computergmbh.de (sovereign.computergmbh.de
	[85.214.69.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43B02DDECF
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:59:05 +1100 (EST)
Date: Tue, 22 Jan 2008 20:43:09 +0100 (CET)
From: Jan Engelhardt <jengelh@computergmbh.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC]: constify function pointer tables
In-Reply-To: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
Message-ID: <Pine.LNX.4.64.0801222042360.5722@fbirervta.pbzchgretzou.qr>
References: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jan Engelhardt <jengelh@computergmbh.de>
---
 arch/powerpc/kernel/setup-common.c           |    2 +-
 arch/powerpc/platforms/cell/spufs/inode.c    |    2 +-
 arch/powerpc/platforms/pseries/hvCall_inst.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2de00f8..57d4f28 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -296,7 +296,7 @@ static void c_stop(struct seq_file *m, void *v)
 {
 }
 
-struct seq_operations cpuinfo_op = {
+const struct seq_operations cpuinfo_op = {
 	.start =c_start,
 	.next =	c_next,
 	.stop =	c_stop,
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index c0e968a..d99fcda 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -110,7 +110,7 @@ spufs_new_file(struct super_block *sb, struct dentry *dentry,
 		const struct file_operations *fops, int mode,
 		struct spu_context *ctx)
 {
-	static struct inode_operations spufs_file_iops = {
+	static const struct inode_operations spufs_file_iops = {
 		.setattr = spufs_setattr,
 	};
 	struct inode *inode;
diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index eae51ef..3631a4f 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -71,7 +71,7 @@ static int hc_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-static struct seq_operations hcall_inst_seq_ops = {
+static const struct seq_operations hcall_inst_seq_ops = {
         .start = hc_start,
         .next  = hc_next,
         .stop  = hc_stop,
-- 
1.5.3.4
