Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5TnF08rFzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 12:34:25 +1000 (AEST)
Date: Mon, 10 Jul 2017 03:34:16 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, Jeremy Kerr <jk@ozlabs.org>,
 Linux PPC Development List <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20170710023416.GV10672@ZenIV.linux.org.uk>
References: <20170710121511.1995914e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170710121511.1995914e@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2017 at 12:15:11PM +1000, Stephen Rothwell wrote:
> Hi Al,

> Caused by commit
> 
>   4f9365d9e2e7 ("spufs: Implement show_options")

Obvious incremental follows, will fold and push

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 27a51a60bc33..e210d69beeee 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -608,15 +608,16 @@ static const match_table_t spufs_tokens = {
 static int spufs_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct spufs_sb_info *sbi = spufs_get_sb_info(root->d_sb);
+	struct inode *inode = root->d_inode;
 
-	if (!uid_eq(root->i_uid, GLOBAL_ROOT_UID))
+	if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=%u",
-			   from_kuid_munged(&init_user_ns, root->i_uid));
-	if (!gid_eq(root->i_gid, GLOBAL_ROOT_GID))
+			   from_kuid_munged(&init_user_ns, inode->i_uid));
+	if (!gid_eq(inode->i_gid, GLOBAL_ROOT_GID))
 		seq_printf(m, ",gid=%u",
-			   from_kgid_munged(&init_user_ns, root->i_gid));
-	if (root->i_mode & S_IALLUGO != 0775)
-		seq_printf(m, ",mode=%o", root->i_mode);
+			   from_kgid_munged(&init_user_ns, inode->i_gid));
+	if (inode->i_mode & S_IALLUGO != 0775)
+		seq_printf(m, ",mode=%o", inode->i_mode);
 	if (sbi->debug)
 		seq_puts(m, ",debug");
 	return 0;
