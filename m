Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3A8C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 23:50:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EB5204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 23:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EB5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44V4Vn3qrBzDqGh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 10:50:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44V4Sc1SfLzDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 10:48:16 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F90A3024564;
 Wed, 27 Mar 2019 23:48:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com
 [10.10.121.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 071E560FDE;
 Wed, 27 Mar 2019 23:48:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 60/68] vfs: Convert spufs to use the new mount API
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Date: Wed, 27 Mar 2019 23:48:12 +0000
Message-ID: <155373049224.7602.3464702692521988864.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 27 Mar 2019 23:48:14 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, Jeremy Kerr <jk@ozlabs.org>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert the spufs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeremy Kerr <jk@ozlabs.org>
cc: Arnd Bergmann <arnd@arndb.de>
cc: linuxppc-dev@lists.ozlabs.org
---

 arch/powerpc/platforms/cell/spufs/inode.c |  207 ++++++++++++++++-------------
 1 file changed, 116 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index db329d4bf1c3..f951a7fe4e3c 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -23,6 +23,8 @@
 
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/fsnotify.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
@@ -33,7 +35,6 @@
 #include <linux/pagemap.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
-#include <linux/parser.h>
 
 #include <asm/prom.h>
 #include <asm/spu.h>
@@ -43,7 +44,7 @@
 #include "spufs.h"
 
 struct spufs_sb_info {
-	int debug;
+	bool debug;
 };
 
 static struct kmem_cache *spufs_inode_cache;
@@ -593,16 +594,27 @@ long spufs_create(struct path *path, struct dentry *dentry,
 }
 
 /* File system initialization */
+struct spufs_fs_context {
+	kuid_t	uid;
+	kgid_t	gid;
+	umode_t	mode;
+};
+
 enum {
-	Opt_uid, Opt_gid, Opt_mode, Opt_debug, Opt_err,
+	Opt_uid, Opt_gid, Opt_mode, Opt_debug,
+};
+
+static const struct fs_parameter_spec spufs_param_specs[] = {
+	fsparam_u32	("gid",				Opt_gid),
+	fsparam_u32oct	("mode",			Opt_mode),
+	fsparam_u32	("uid",				Opt_uid),
+	fsparam_flag	("debug",			Opt_debug),
+	{}
 };
 
-static const match_table_t spufs_tokens = {
-	{ Opt_uid,   "uid=%d" },
-	{ Opt_gid,   "gid=%d" },
-	{ Opt_mode,  "mode=%o" },
-	{ Opt_debug, "debug" },
-	{ Opt_err,    NULL  },
+static const struct fs_parameter_description spufs_fs_parameters = {
+	.name		= "spufs",
+	.specs		= spufs_param_specs,
 };
 
 static int spufs_show_options(struct seq_file *m, struct dentry *root)
@@ -623,47 +635,41 @@ static int spufs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static int
-spufs_parse_options(struct super_block *sb, char *options, struct inode *root)
-{
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token, option;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, spufs_tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return 0;
-			root->i_uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(root->i_uid))
-				return 0;
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return 0;
-			root->i_gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(root->i_gid))
-				return 0;
-			break;
-		case Opt_mode:
-			if (match_octal(&args[0], &option))
-				return 0;
-			root->i_mode = option | S_IFDIR;
-			break;
-		case Opt_debug:
-			spufs_get_sb_info(sb)->debug = 1;
-			break;
-		default:
-			return 0;
-		}
+static int spufs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct spufs_fs_context *ctx = fc->fs_private;
+	struct spufs_sb_info *sbi = fc->s_fs_info;
+	struct fs_parse_result result;
+	kuid_t uid;
+	kgid_t gid;
+	int opt;
+
+	opt = fs_parse(fc, &spufs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return invalf(fc, "Unknown uid");
+		ctx->uid = uid;
+		break;
+	case Opt_gid:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			return invalf(fc, "Unknown gid");
+		ctx->gid = gid;
+		break;
+	case Opt_mode:
+		ctx->mode = result.uint_32 & S_IALLUGO;
+		break;
+	case Opt_debug:
+		sbi->debug = true;
+		break;
 	}
-	return 1;
+
+	return 0;
 }
 
 static void spufs_exit_isolated_loader(void)
@@ -697,79 +703,98 @@ spufs_init_isolated_loader(void)
 	printk(KERN_INFO "spufs: SPU isolation mode enabled\n");
 }
 
-static int
-spufs_create_root(struct super_block *sb, void *data)
+static int spufs_create_root(struct super_block *sb, struct fs_context *fc)
 {
+	struct spufs_fs_context *ctx = fc->fs_private;
 	struct inode *inode;
-	int ret;
 
-	ret = -ENODEV;
 	if (!spu_management_ops)
-		goto out;
+		return -ENODEV;
 
-	ret = -ENOMEM;
-	inode = spufs_new_inode(sb, S_IFDIR | 0775);
+	inode = spufs_new_inode(sb, S_IFDIR | ctx->mode);
 	if (!inode)
-		goto out;
+		return -ENOMEM;
 
+	inode->i_uid = ctx->uid;
+	inode->i_gid = ctx->gid;
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	SPUFS_I(inode)->i_ctx = NULL;
 	inc_nlink(inode);
 
-	ret = -EINVAL;
-	if (!spufs_parse_options(sb, data, inode))
-		goto out_iput;
-
-	ret = -ENOMEM;
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
-		goto out;
-
+		return -ENOMEM;
 	return 0;
-out_iput:
-	iput(inode);
-out:
-	return ret;
 }
 
-static int
-spufs_fill_super(struct super_block *sb, void *data, int silent)
-{
-	struct spufs_sb_info *info;
-	static const struct super_operations s_ops = {
-		.alloc_inode = spufs_alloc_inode,
-		.destroy_inode = spufs_destroy_inode,
-		.statfs = simple_statfs,
-		.evict_inode = spufs_evict_inode,
-		.show_options = spufs_show_options,
-	};
-
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
+static const struct super_operations spufs_ops = {
+	.alloc_inode	= spufs_alloc_inode,
+	.destroy_inode	= spufs_destroy_inode,
+	.statfs		= simple_statfs,
+	.evict_inode	= spufs_evict_inode,
+	.show_options	= spufs_show_options,
+};
 
+static int spufs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = SPUFS_MAGIC;
-	sb->s_op = &s_ops;
-	sb->s_fs_info = info;
+	sb->s_op = &spufs_ops;
 
-	return spufs_create_root(sb, data);
+	return spufs_create_root(sb, fc);
+}
+
+static int spufs_get_tree(struct fs_context *fc)
+{
+	return vfs_get_super(fc, vfs_get_single_super, spufs_fill_super);
 }
 
-static struct dentry *
-spufs_mount(struct file_system_type *fstype, int flags,
-		const char *name, void *data)
+static void spufs_free_fc(struct fs_context *fc)
 {
-	return mount_single(fstype, flags, data, spufs_fill_super);
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations spufs_context_ops = {
+	.free		= spufs_free_fc,
+	.parse_param	= spufs_parse_param,
+	.get_tree	= spufs_get_tree,
+};
+
+static int spufs_init_fs_context(struct fs_context *fc)
+{
+	struct spufs_fs_context *ctx;
+	struct spufs_sb_info *sbi;
+
+	ctx = kzalloc(sizeof(struct spufs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		goto nomem;
+
+	sbi = kzalloc(sizeof(struct spufs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		goto nomem_ctx;
+
+	ctx->uid = current_uid();
+	ctx->gid = current_gid();
+	ctx->mode = 0755;
+
+	fc->s_fs_info = sbi;
+	fc->ops = &spufs_context_ops;
+	return 0;
+
+nomem_ctx:
+	kfree(ctx);
+nomem:
+	return -ENOMEM;
 }
 
 static struct file_system_type spufs_type = {
 	.owner = THIS_MODULE,
 	.name = "spufs",
-	.mount = spufs_mount,
+	.init_fs_context = spufs_init_fs_context,
+	.parameters	= &spufs_fs_parameters,
 	.kill_sb = kill_litter_super,
 };
 MODULE_ALIAS_FS("spufs");

