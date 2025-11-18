Return-Path: <linuxppc-dev+bounces-14264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB9DCED247
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Nov 2025 05:19:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9XsR6T5Zz3fKt;
	Tue, 18 Nov 2025 16:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763443000;
	cv=none; b=DdSJMic3GhAmACxUWeDCeWqrntNzcOu+RSMf/azfJXzfzlRIcd0J1PhLg3+Lw4DO17qVSX8Nm/3dSsiSaihvitk9jqff3YL4eQSvqsQUvzRX1US1iVcIVbZ7gn/LqUNd8m/yaGEzba9FL+IkZ9tWyw+YyufD1Tj3IkDfT7mxRlpHRoACS734y9Mx+AoYms8840qniawrENwa64ozqchi00dfcKVggzepCD0gekuXxgX0EKHpTi0qmjd/WJUQOGN2Dvh6PLqWUFMBadXk+zZwInp+2Cf1XkazVsVDbTVoObp+lsdVMu1SyRJ0I1eeU/5HNHJ2OCYP743WuyXNTOvRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763443000; c=relaxed/relaxed;
	bh=EGEc3asPoO0BSFThbWpOoQFbGckDO1h86OnlmAxWxbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW0f5oNA47UdYRkxt8M1/XApORDcXuolqN4K/dgAUxfu/2G6yXgGKaokisBNo2VHfRwDah4ZNJnEjN0wKPjiivKeMQi6dZmOR5cUAAL7B9uhE4le+GF9EULBIwyxveNLI5hHAm3ADGm7O23ay5DmQD7D2bIkY5Z/7e4i0wqbHTNMkzWqZMBre3o531HkDRpSx2jpQSKboflDl5vJjKQ21gdzSBrw7gRacKkqHf/z8X+bblcmHcjMrUPw7FHNJv4eenjZ15shuUCd3O8I4MG2wXa0JmYzJQBUktRYRsMCO+w4TEQSbtl1nO8k98NTIZuKBXjewkZW8vN0svfTfvS0Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=qfAn7jn5; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=qfAn7jn5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9Xs04wQzz30Yb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2025 16:16:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EGEc3asPoO0BSFThbWpOoQFbGckDO1h86OnlmAxWxbE=; b=qfAn7jn5dVpc+8HYRW2PUrosYN
	3GyMgetrQNMDWIBRpoqaUBQ0b+RFMDBY7AmEWMJ/1ToP+BTNE23iXsKfKcAptmf8/ZEjXo4+5u52n
	CkyMVH2xjlmc1or6jRdhCAyYReRS4tsSZWL19CwyiR4xi2AGqmOMGPpqXNRxR+gu8H6VV3puDZHkD
	V/dnp1+9cq/0hW+scBmASeTBkXX27NsmuIQDBgWSiY1otP/WfkiiyHP2WuFbXeJTkvwqKG6b5Fqyd
	7/+XjHcQQcwfS6akaWW4RNqIYsWEL3XqSQWLc/logPlJp7jGMwMmRr8P2vBtBI0hvpJCQmrfvAmuC
	Yh5+ixHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4W-0000000GESX-0eve;
	Tue, 18 Nov 2025 05:16:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org,
	clm@meta.com
Subject: [PATCH v4 29/54] convert binderfs
Date: Tue, 18 Nov 2025 05:15:38 +0000
Message-ID: <20251118051604.3868588-30-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Objects are created either by d_alloc_name()+d_add() (in
binderfs_ctl_create()) or by simple_start_creating()+d_instantiate().
Removals are by simple_recurisive_removal().

Switch d_add()/d_instantiate() to d_make_persistent() + dput().
Voila - kill_litter_super() is not needed anymore.

Fold dput()+unlocking the parent into simple_done_creating(), while
we are at it.

NOTE: return value of binderfs_create_file() is borrowed; it may get
stored in proc->binderfs_entry.  See binder_release()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binderfs.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 8253e517ab6c..a28d0511960e 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -189,9 +189,9 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 		goto err;
 	}
 	inode->i_private = device;
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	fsnotify_create(root->d_inode, dentry);
-	inode_unlock(d_inode(root));
+	simple_done_creating(dentry);
 
 	binder_add_device(device);
 
@@ -432,7 +432,8 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 
 	inode->i_private = device;
 	info->control_dentry = dentry;
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
+	dput(dentry);
 
 	return 0;
 
@@ -479,19 +480,16 @@ struct dentry *binderfs_create_file(struct dentry *parent, const char *name,
 	sb = parent_inode->i_sb;
 	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
 	if (!new_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-ENOMEM);
-		goto out;
+		simple_done_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	new_inode->i_fop = fops;
 	new_inode->i_private = data;
-	d_instantiate(dentry, new_inode);
+	d_make_persistent(dentry, new_inode);
 	fsnotify_create(parent_inode, dentry);
-
-out:
-	inode_unlock(parent_inode);
-	return dentry;
+	simple_done_creating(dentry);
+	return dentry; // borrowed
 }
 
 static struct dentry *binderfs_create_dir(struct dentry *parent,
@@ -510,21 +508,18 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
 	sb = parent_inode->i_sb;
 	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
 	if (!new_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-ENOMEM);
-		goto out;
+		simple_done_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	new_inode->i_fop = &simple_dir_operations;
 	new_inode->i_op = &simple_dir_inode_operations;
 
 	set_nlink(new_inode, 2);
-	d_instantiate(dentry, new_inode);
+	d_make_persistent(dentry, new_inode);
 	inc_nlink(parent_inode);
 	fsnotify_mkdir(parent_inode, dentry);
-
-out:
-	inode_unlock(parent_inode);
+	simple_done_creating(dentry);
 	return dentry;
 }
 
@@ -740,7 +735,7 @@ static void binderfs_kill_super(struct super_block *sb)
 	 * During inode eviction struct binderfs_info is needed.
 	 * So first wipe the super_block then free struct binderfs_info.
 	 */
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 
 	if (info && info->ipc_ns)
 		put_ipc_ns(info->ipc_ns);
-- 
2.47.3


