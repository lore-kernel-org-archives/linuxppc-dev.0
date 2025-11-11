Return-Path: <linuxppc-dev+bounces-14034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C803CCFA18
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Nov 2025 06:56:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d5HNx31HRz30G9;
	Tue, 11 Nov 2025 17:55:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762844145;
	cv=none; b=lVqX1hCVs8dmHp2GSG17JTzyObercCKOoKNt2ZiWP9o9hJV7TRH6gDMKL0T/JlqOzvyy4AHdQR42nqhOA1T7Vm1PnLVh4ZzF3rlTaV4cTZsyQlR+S9YQPNPmJPoF/2gdeCnxppHvZ44U4aEV6QIZ6Ig+hn6A66R5Yu6D1449r23YKqQ8STsDRlyaqI0hqg7T3Q+Xcq9mb1F31du8VHyMlgBHTVnJ9YK/Al+ymL4ICjfAVgGy4Gi+WX2pA4oETcAy1LA1clsVH7c0uadRHsG3Nq4u0ePPXqLnHJR5seWH2OwVMONLwtyCgEEbsLFhcwSnC+GRVOqcrUWXQobKKyej8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762844145; c=relaxed/relaxed;
	bh=wF5oceMSXViySxysMkUNPeCJ07Zgu8R8pwpIbBxZfJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RllGLvaGf4QfgNgDRlQJMvGWpTn0wZCQ7w70oku4lVmxupw1z1CtXuEcD+9wL3rUA0McD+R00kDznMTXJ5dSVHE0YboDrkeGqEqwFn/TrbTuTy3ovZErifwAhOdHnu5av3bi9ZppbcoyyKrbt8I6I5KPyYkvVQu2C4FpGDj3mT+v9LOghPO4SRfqbogbPmJukj7R0J6OO7Ea6yva7CS6PNfBZL9dpFiph9l4KTVh2JvdoAThDFRYQ2IKfpOg91kgsVZWfF5Dk2hGs7T60H3WDxSbruSvyapPOtXagfYCUMFUbEDtWf8MNmr+aoHJYsqYdp7J/DPxn3Ro3eU9c69eCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=pRTnXVSg; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=pRTnXVSg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d5HNn6B6Nz2yvT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2025 17:55:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wF5oceMSXViySxysMkUNPeCJ07Zgu8R8pwpIbBxZfJs=; b=pRTnXVSgUjFI8ImpwcWRs2NMh9
	PFUB/rFfJMse8H1zKY/AzzCdA2oV8bZDris1DAFKFZqtO3YHL4tRpSYLEYxnh8E9jlpw2sGe9HC1T
	tLsOi/41iwWjSplOT1bV6lFUVLYPqtr2QXrPbX5pBOLL+qv/IRTp0oZmfLRSBmaC93y4gH31y0wjO
	FZeqysA7uYYi6Nw2xD3brd7wX8oQhacLslti2lTkswwKq3GVQNeumXjHnvqiUHP6rSYbvdjo7CmJu
	WmA/vNvp44re4mPKX0YQqMZGPWh+E6TUY33USiEi56cRQZg76TMvhpYfwtVaAkb6VxamSf2qnX6xe
	jciupEjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHo-0000000Bx8B-2Ydn;
	Tue, 11 Nov 2025 06:55:28 +0000
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
Subject: [PATCH v3 39/50] convert gadgetfs
Date: Tue, 11 Nov 2025 06:55:08 +0000
Message-ID: <20251111065520.2847791-40-viro@zeniv.linux.org.uk>
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

same as functionfs

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/legacy/inode.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index bcc25f13483f..62566a8e7451 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1989,17 +1989,20 @@ static int gadgetfs_create_file (struct super_block *sb, char const *name,
 	struct dentry	*dentry;
 	struct inode	*inode;
 
-	dentry = d_alloc_name(sb->s_root, name);
-	if (!dentry)
-		return -ENOMEM;
-
 	inode = gadgetfs_make_inode (sb, data, fops,
 			S_IFREG | (default_perm & S_IRWXUGO));
-	if (!inode) {
-		dput(dentry);
+	if (!inode)
 		return -ENOMEM;
+
+	dentry = simple_start_creating(sb->s_root, name);
+	if (IS_ERR(dentry)) {
+		iput(inode);
+		return PTR_ERR(dentry);
 	}
-	d_add (dentry, inode);
+
+	d_make_persistent(dentry, inode);
+
+	simple_done_creating(dentry);
 	return 0;
 }
 
@@ -2096,7 +2099,7 @@ static void
 gadgetfs_kill_sb (struct super_block *sb)
 {
 	mutex_lock(&sb_mutex);
-	kill_litter_super (sb);
+	kill_anon_super (sb);
 	if (the_device) {
 		put_dev (the_device);
 		the_device = NULL;
-- 
2.47.3


