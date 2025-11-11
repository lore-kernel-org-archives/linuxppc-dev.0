Return-Path: <linuxppc-dev+bounces-14062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859D7CCF9E3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Nov 2025 07:00:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d5HPS5GpPz3fM5;
	Tue, 11 Nov 2025 17:56:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762844172;
	cv=none; b=UazfPK4IeuvwMT0Awxt44dOzpYZcAhS+euFixDk0QwBLzDevNtHo4fwa3g9qn036lopNCOCIojrBMWVKtvtr/zPNzDjSs0u3R7evmEvdb4OIRWOwO+EQzoKzxr2um8eq0OzM82Cp5LbKoac2wxYkvxOLtCQvA6xeC9fQR+Tf7dANF6n8tJtexV2Mv7U0NTi/AiUD+qJiJPKM2zkwYrbEvLwlobRImleJnT3l4aRhTmYgsK9+e3+we5brevwVjKGRqDP2Ov0k5ZULINu51HB1A5R+jApJLq1Xk51nzogjrQExTOzoPF9vIq1JbqvxGmP2BOCs73F65hCXExdB8hmiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762844172; c=relaxed/relaxed;
	bh=OHt/Ew+g7B0pNZwOTBE8VBfCIPUfQxC19aVy8itf040=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+CZajZ44mAR/sjvJbEDytYW5wdu6XmpHxvcsFqVrcxPFsVmM9O9wYLZZxunrZGWSqskJy6twbt2nUabMcrE0py9YbnnX8B6KSiEGCrludlkYGDXTHblWV0qatpkhYSogY2mVlFI/bMK+BVErNQY5ketFC0mScY6vjjhkbSiWydUeMx4AlfjHNaVUK6ECBltt3wllMF7BtoF64/ApCvQ6XrywgQtIwti2MFsLKQZXM6eZ3JPfAheqhRRYrTox84T+r0UR4WxU67p8MmxapsYAeiVw9bA7Ev8G8RsS/dzdhmqCpiVgcSDDkMrW4NaUsuq/W6sF+wAJsNHc3IjiXR/Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=R4NIhkG0; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=R4NIhkG0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d5HPR5QcCz3fL6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2025 17:56:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OHt/Ew+g7B0pNZwOTBE8VBfCIPUfQxC19aVy8itf040=; b=R4NIhkG0/V2mLVIyhcwusQ9nft
	8PZeZikDf6DfjU8btWRu2gDdgdWAWufZgJAle4MZacBlTpu2VZUM/bXqtHmYL2zuE8JBljJcITK5A
	ugGpjTf5V8wyuS4R3+1VZc7ZTTmixykTU3IcImNAEiuz6ATWp7kqFS1iITWbp8J6MWXKVKfkbf40O
	UgnGSBuhf3W3cUjZllApd4FxBfdfgJhXFyUxxC21kqutXFs51ZBuYxbsOaTS+L7EJy5FRp6bVMD3n
	0k/LUFpYm857/BMdvbI7VmNwc4MB+zYeIIM04sRhDT2NxMSMLKzbaSSQ5BeV4XHeiUn2/fcWdnrkX
	a3YFAoGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHk-0000000Bwyp-1RVQ;
	Tue, 11 Nov 2025 06:55:24 +0000
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
	bpf@vger.kernel.org
Subject: [PATCH v3 20/50] convert debugfs
Date: Tue, 11 Nov 2025 06:54:49 +0000
Message-ID: <20251111065520.2847791-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
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

similar to tracefs - simulation of normal codepath for creation,
simple_recursive_removal() for removal.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 661a99a7dfbe..682120fdbb17 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -329,7 +329,7 @@ static struct file_system_type debug_fs_type = {
 	.name =		"debugfs",
 	.init_fs_context = debugfs_init_fs_context,
 	.parameters =	debugfs_param_specs,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	kill_anon_super,
 };
 MODULE_ALIAS_FS("debugfs");
 
@@ -405,16 +405,15 @@ static struct dentry *debugfs_start_creating(const char *name,
 
 static struct dentry *failed_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	dput(dentry);
+	simple_done_creating(dentry);
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 	return ERR_PTR(-ENOMEM);
 }
 
 static struct dentry *end_creating(struct dentry *dentry)
 {
-	inode_unlock(d_inode(dentry->d_parent));
-	return dentry;
+	simple_done_creating(dentry);
+	return dentry; // borrowed
 }
 
 static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
@@ -456,7 +455,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	DEBUGFS_I(inode)->raw = real_fops;
 	DEBUGFS_I(inode)->aux = (void *)aux;
 
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
 	return end_creating(dentry);
 }
@@ -602,7 +601,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return end_creating(dentry);
@@ -649,7 +648,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	DEBUGFS_I(inode)->automount = f;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
 	return end_creating(dentry);
@@ -704,7 +703,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
 	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	return end_creating(dentry);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
-- 
2.47.3


