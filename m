Return-Path: <linuxppc-dev+bounces-13402-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3C9CCF9E5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Oct 2025 00:51:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwWth1Q9yz3fTY;
	Tue, 28 Oct 2025 11:47:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761612460;
	cv=none; b=Gs7/rDXX5XQffLIQjJsUf7bomMudn/n4b/sBuCeSp9PV1Yhm3Royj5foj6EGsfkgX0ClhEUmet5MUYWnlnosN5XW44p5JjP0pFJ6Jqoy9TdhNyd+RORDbd0UEiFF0UG+PfxzuMLy2FSXUiiYakoOjD/wLO60EL3BCLs5/Ik8oS9b68no/c0UOG0wY4I+yChDkxPEEw5GoSqNVptYZUeaD8EItSIkezeP/2XdpjoNkok4LCj/ZxaQhdBIgJSu7lfb8d/msUcxiZPetPAlvUWSfyUdnq2a63KVp1VwgwAdP1Vwwz256y38KeRgK1fwI8StXD7cJKNpEbd2qntBTK2Iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761612460; c=relaxed/relaxed;
	bh=4Quy3Z9YUR2p7/o0BhLPqipVcn+3o5MzKrJ0FbjbabQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxsfBu4MaiDD0nNiDNikxoT6Y7nWVqIV+MoFtu3/uTiWT6TcJCuvwYkKiK2o0uN5voZ9Q8eQaH2K4yyhnzc8aEQW2SHGP2BcTM8OGs6JwM4s26JnkGQMhasAXa25sWjis0eYzmMAlYOyEWEvR8fU6ZUKMggMLnLo2D2UioN8x/BPL6fQih8Ex2Wqd9NWqNnVcB2Go47TdeJj9qMeU5iA8P/r5ctEpNInwAaVBnDVUKICA64QVuTh8pwHY0Qf5Fjle7HijX6fhLGsaNzvk1jjrhGw0MHsF1MllsV9fR2mwDBKsyy0ENOLprStK/gz9JSgXCOK6xeJ7fxCxJlZY2QWzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=RshzQwww; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=RshzQwww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwWtf09bxz3c5y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2025 11:47:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4Quy3Z9YUR2p7/o0BhLPqipVcn+3o5MzKrJ0FbjbabQ=; b=RshzQwwwhIM4JqS6JZxrRB6SRi
	sXnRpYSIo5COA7j41rIr+FZs7mPLff7B9ySvdiZZ5lxVK1g06AvmaXhv70p6toFwyWll9CLH8n+FE
	Bq5eaBQZ5p6VPRqN6KqAKsQstjhS1pRI2XyGASAUKmqRbjLp5H6jxFr8YgIzLixZkt4ZM99eScusG
	ZvniTtZpZZ5rRgkDy7NGh6LoHz5GnEDif1NgRBV7e2R6k1CpekKobidov/xXX9HqS+xxsxzqpESLf
	1sTR9kt2IXyvCjxM42Ti0MKZ44e35LMsuOuX1BoVt3Um7IFuEeybntNtMTJWIiADZ/bjaKcxTyo3J
	de8RuQdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqp-00000001eWn-2xv8;
	Tue, 28 Oct 2025 00:46:15 +0000
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
Subject: [PATCH v2 10/50] configfs, securityfs: kill_litter_super() not needed
Date: Tue, 28 Oct 2025 00:45:29 +0000
Message-ID: <20251028004614.393374-11-viro@zeniv.linux.org.uk>
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

These are guaranteed to be empty by the time they are shut down;
both are single-instance and there is an internal mount maintained
for as long as there is any contents.

Both have that internal mount pinned by every object in root.

In other words, kill_litter_super() boils down to kill_anon_super()
for those.

Reviewed-by: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/mount.c | 2 +-
 security/inode.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 456c4a2efb53..4929f3431189 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -116,7 +116,7 @@ static struct file_system_type configfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "configfs",
 	.init_fs_context = configfs_init_fs_context,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= kill_anon_super,
 };
 MODULE_ALIAS_FS("configfs");
 
diff --git a/security/inode.c b/security/inode.c
index 43382ef8896e..bf7b5e2e6955 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -70,7 +70,7 @@ static struct file_system_type fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	kill_anon_super,
 };
 
 /**
-- 
2.47.3


