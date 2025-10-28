Return-Path: <linuxppc-dev+bounces-13374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFEBCCF9EB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Oct 2025 00:47:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwWsZ2w1Qz3dXh;
	Tue, 28 Oct 2025 11:46:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761612401;
	cv=none; b=Sd+q+NDNAecaKl7FK5UjhAKq3Nifg83eWI7MYva0RTlRFX/EkUsLEHEdACwgR0vSqyyQsiA5yXce4tKbe+rlSwVFL/uZJbC3/cXXP7ydiHXUgiL05TtvxsmnZohVIaHotHLjLZN/CFyqtyv9Xw8xUenCJuqW10NLw9YVI2zmritKx1g7OyRFHJC+Ko3gD5VU6X33mOczJ8b8EMmtu2PCqwCkScYFEaQMuM4JEuoxtoqVKLEfOZixHDdtb8EuQHc+0o3UMZjNHruh1ZSS4y6SvrZp0kZHvl+UU/tVVM9uBdXJQGktfS454kr8NW2nVw/ZbRYZMsLVSbIXclvN7eSQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761612401; c=relaxed/relaxed;
	bh=E7cNvRx/cApjSX66b8FSjJI2fyjXpW5PkYfHFIOF7HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9KARPAGvcS0hXxXzdUaJAtdGp5bHJid2p9uaCRKetLPg9ygwNesejX36m2ODjqHgr29Ta6hgkLNpcL8iTHGE2EnZRfh/iGY42wrIgu2c1elAp2Ar9iCD12eI5o75vuUsVWsRF0lFOKXlO/qhaOleo3ocUYADPwj0YJs6keF9CXzd7iqQBN3DSXpIaUFpugs7zoyuCMzGOtIL80g6D0S0bMi8rT+3yFAHfGL30lA++T9vCAbCxwE5UJpR2SDjq7KyxtAJv59W94PKV5Yj+DkuNKu4L7hJcg77rb2MaWZvGMxdS02YWudDgzADdIiD+AmHI09KMDiRimDovpHt3AzXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=VsVuTNuT; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=VsVuTNuT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwWsR4ryWz3bfX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2025 11:46:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=E7cNvRx/cApjSX66b8FSjJI2fyjXpW5PkYfHFIOF7HU=; b=VsVuTNuTIHc4/BtKRQmf0nDY73
	mWl3Dwzu6X5U8nei1TpyXq2X5yrpxoWybXmkIBZHiLZeQRHMsrlmBN092u9eokVSxIVHiGGfGqAeO
	7qi0K0TSduNTt31COYmzintXgfZyhK7fAg5CVAmj7864qVd0dLe+XTrV9EyiCZDYDyRMnwRCbrTyL
	+f2gJ0BAiNlXB4R7uaB8Kngk2oOAKX1h/Np8qMsm2LPbZpFwdi5xGpH1Kxg/h4/T9ngbozltJyjKI
	W+ucGiqo0W/h+YgF0F4ZrGgk+et564BA8iBO9ZprjWBaJB9l37W++eesJdNfNGR9ET7XB5Py/n4g0
	dXRdClJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqo-00000001eVR-3bCF;
	Tue, 28 Oct 2025 00:46:14 +0000
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
Subject: [PATCH v2 02/50] tracefs: fix a leak in eventfs_create_events_dir()
Date: Tue, 28 Oct 2025 00:45:21 +0000
Message-ID: <20251028004614.393374-3-viro@zeniv.linux.org.uk>
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

If we have LOCKDOWN_TRACEFS, the function bails out - *after*
having locked the parent directory and without bothering to
undo that.  Just check it before tracefs_start_creating()...

Fixes: e24709454c45 "tracefs/eventfs: Add missing lockdown checks"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/tracefs/event_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8705c77a9e75..93c231601c8e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -757,7 +757,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 						const struct eventfs_entry *entries,
 						int size, void *data)
 {
-	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct dentry *dentry;
 	struct eventfs_root_inode *rei;
 	struct eventfs_inode *ei;
 	struct tracefs_inode *ti;
@@ -768,6 +768,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	if (security_locked_down(LOCKDOWN_TRACEFS))
 		return NULL;
 
+	dentry = tracefs_start_creating(name, parent);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-- 
2.47.3


