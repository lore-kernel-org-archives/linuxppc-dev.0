Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5TM40XP0zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 12:15:12 +1000 (AEST)
Date: Mon, 10 Jul 2017 12:15:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, David Howells
 <dhowells@redhat.com>, Jeremy Kerr <jk@ozlabs.org>, Linux PPC Development
 List <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20170710121511.1995914e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Al,

After merging the vfs tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/platforms/cell/spufs/inode.c: In function 'spufs_show_options':
arch/powerpc/platforms/cell/spufs/inode.c:612:18: error: 'struct dentry' has no member named 'i_uid'
  if (!uid_eq(root->i_uid, GLOBAL_ROOT_UID))
                  ^
arch/powerpc/platforms/cell/spufs/inode.c:614:43: error: 'struct dentry' has no member named 'i_uid'
       from_kuid_munged(&init_user_ns, root->i_uid));
                                           ^
arch/powerpc/platforms/cell/spufs/inode.c:615:18: error: 'struct dentry' has no member named 'i_gid'
  if (!gid_eq(root->i_gid, GLOBAL_ROOT_GID))
                  ^
arch/powerpc/platforms/cell/spufs/inode.c:617:43: error: 'struct dentry' has no member named 'i_gid'
       from_kgid_munged(&init_user_ns, root->i_gid));
                                           ^
arch/powerpc/platforms/cell/spufs/inode.c:618:10: error: 'struct dentry' has no member named 'i_mode'
  if (root->i_mode & S_IALLUGO != 0775)
          ^
arch/powerpc/platforms/cell/spufs/inode.c:619:33: error: 'struct dentry' has no member named 'i_mode'
   seq_printf(m, ",mode=%o", root->i_mode);
                                 ^

Caused by commit

  4f9365d9e2e7 ("spufs: Implement show_options")

A bit hard to revert this, so I added the below patch for now ... please
fix it up.

Also, isn't this a bit late for this merge window?

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 10 Jul 2017 11:05:31 +1000
Subject: [PATCH] disable the spufs show options for now

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 27a51a60bc33..fafbf88326d8 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -609,6 +609,7 @@ static int spufs_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct spufs_sb_info *sbi = spufs_get_sb_info(root->d_sb);
 
+#if 0
 	if (!uid_eq(root->i_uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=%u",
 			   from_kuid_munged(&init_user_ns, root->i_uid));
@@ -617,6 +618,7 @@ static int spufs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, root->i_gid));
 	if (root->i_mode & S_IALLUGO != 0775)
 		seq_printf(m, ",mode=%o", root->i_mode);
+#endif
 	if (sbi->debug)
 		seq_puts(m, ",debug");
 	return 0;
-- 
2.13.2

-- 
Cheers,
Stephen Rothwell
