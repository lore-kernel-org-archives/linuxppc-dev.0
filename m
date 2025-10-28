Return-Path: <linuxppc-dev+bounces-13391-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D48CCCF9E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Oct 2025 00:50:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwWt12YPrz3fJd;
	Tue, 28 Oct 2025 11:47:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761612425;
	cv=none; b=bGGPIuC6Cw1s1cDsuZr09lkupvfCTD+hj3rmNv7VnxiHN9kh9sioH/c3Sn/j+h+UGDO2l55jMWWCjsJQhuZJdNdvt9VksNlCsdTNogMN83q37e1XWatxy4tywKrT51KDZ6De5fUut3eGveXd25YJnIs64om8yZjkU7DP1jV8aSjQRKwxzTDcFCUnx5Ps9soB1+08bUSLYxirUwZ12NN9w6Gxlj90PKNzPdENIskvq6TtCn1cvohMshPG4q/pgIErdu2fTXhki5nNVPGZD6ai0sLrIwySb+HwINPeZUsD4NjsWe5TgmjTe04rFq84NiCvXSfQCq5F09wJEjd5uYGZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761612425; c=relaxed/relaxed;
	bh=yVog1JmPQq1AS/UVL7zjpUgX0UVPwCD5iHtdu2BZv2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lp44ttLW111UoTtCF3hV0IETPgznoTuefsuetWtD6Fr7fkiQM7FqwwA45H+Mkql2eXEvKBFV3JE7efLXu4+rdw1NSO5/tvwlEAFgaSR11+WwbhoeTbOL5mJ2IruqgHqkQsP9bGP9YfPBx87h1JLI9jcP3tfJaG78GLPUUhpFdevALi/LCJALlnd+zoMozgMjyUAiHWRlAwIEuT6w8iKRx9uxRy0HLntY1xDm+QTlWMKpsMJ64k08T2dn2WkJkcsMvbY7EYW6loFA02JLu16U1oS6Tv7gHHbO5EJY08yEEMtyJ0yQCksoM3kvnFyOjutKDoloTPOuOpkmEn56tj2gTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=tX1rzPoI; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=tX1rzPoI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwWt04mZsz3btL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2025 11:47:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yVog1JmPQq1AS/UVL7zjpUgX0UVPwCD5iHtdu2BZv2o=; b=tX1rzPoI/1o1o090qccKpgmnIE
	QqiR/xhjlRjUmW7P9jea5A6shY5HqE9KAWb7Aqgf2296vLnngrmPdFJsxX3IxxxyWHrjaMn+N16oN
	rkurUHdU0P3hehk92336DnZJ9QnK8zPyusTON5Bbz2ckKFCM4fnyBbkJ/cU1fRgZQHpMGPCCQcQeY
	dutnAhQTWa4V1Ifp8AjvhXoZuQ0T2Jp/GKhtwBw3kZ5rPDZJ35ICGa3HdKklj18biB+1ElMvcIRXL
	kxjqEJOJ3VWSbc3NdfMYVGFKkJSqF0KCaE1zJBpWjyJ2F5k16luWywgXZRm1Z23svR4xtIMDDVYST
	0bX1WSmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqs-00000001ea7-1K8h;
	Tue, 28 Oct 2025 00:46:18 +0000
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
Subject: [PATCH v2 35/50] convert selinuxfs
Date: Tue, 28 Oct 2025 00:45:54 +0000
Message-ID: <20251028004614.393374-36-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
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

Tree has invariant part + two subtrees that get replaced upon each
policy load.  Invariant parts stay for the lifetime of filesystem,
these two subdirs - from policy load to policy load (serialized
on lock_rename(root, ...)).

All object creations are via d_alloc_name()+d_add() inside selinuxfs,
all removals are via simple_recursive_removal().

Turn those d_add() into d_make_persistent()+dput() and that's mostly it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/selinux/selinuxfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f088776dbbd3..eae565358db4 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1205,7 +1205,8 @@ static struct dentry *sel_attach(struct dentry *parent, const char *name,
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
+	dput(dentry);
 	return dentry;
 }
 
@@ -1934,10 +1935,11 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb,
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	inode_lock(sb->s_root->d_inode);
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
 	inc_nlink(sb->s_root->d_inode);
 	inode_unlock(sb->s_root->d_inode);
-	return dentry;
+	dput(dentry);
+	return dentry;	// borrowed
 }
 
 #define NULL_FILE_NAME "null"
@@ -2080,7 +2082,7 @@ static int sel_init_fs_context(struct fs_context *fc)
 static void sel_kill_sb(struct super_block *sb)
 {
 	selinux_fs_info_free(sb);
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 }
 
 static struct file_system_type sel_fs_type = {
-- 
2.47.3


