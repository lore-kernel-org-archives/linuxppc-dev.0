Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2l6h63jszDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 01:25:00 +1000 (AEST)
Subject: [PATCH 07/14] spufs: Implement show_options
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
 linux-kernel@vger.kernel.org
Date: Wed, 05 Jul 2017 16:24:56 +0100
Message-ID: <149926829650.20611.7487998328479640331.stgit@warthog.procyon.org.uk>
In-Reply-To: <149926824154.20611.6104595541055328700.stgit@warthog.procyon.org.uk>
References: <149926824154.20611.6104595541055328700.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement the show_options superblock op for spufs as part of a bid to get
rid of s_options and generic_show_options() to make it easier to implement
a context-based mount where the mount options can be passed individually
over a file descriptor.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeremy Kerr <jk@ozlabs.org>
cc: linuxppc-dev@lists.ozlabs.org
---

 arch/powerpc/platforms/cell/spufs/inode.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index d8af9bc0489f..27a51a60bc33 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -605,6 +605,23 @@ static const match_table_t spufs_tokens = {
 	{ Opt_err,    NULL  },
 };
 
+static int spufs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct spufs_sb_info *sbi = spufs_get_sb_info(root->d_sb);
+
+	if (!uid_eq(root->i_uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+			   from_kuid_munged(&init_user_ns, root->i_uid));
+	if (!gid_eq(root->i_gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+			   from_kgid_munged(&init_user_ns, root->i_gid));
+	if (root->i_mode & S_IALLUGO != 0775)
+		seq_printf(m, ",mode=%o", root->i_mode);
+	if (sbi->debug)
+		seq_puts(m, ",debug");
+	return 0;
+}
+
 static int
 spufs_parse_options(struct super_block *sb, char *options, struct inode *root)
 {
@@ -724,11 +741,9 @@ spufs_fill_super(struct super_block *sb, void *data, int silent)
 		.destroy_inode = spufs_destroy_inode,
 		.statfs = simple_statfs,
 		.evict_inode = spufs_evict_inode,
-		.show_options = generic_show_options,
+		.show_options = spufs_show_options,
 	};
 
-	save_mount_options(sb, data);
-
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
