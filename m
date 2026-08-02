Return-Path: <linuxppc-dev+bounces-25204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F938C55171
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2026 15:52:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCknv1055z2yh4;
	Mon, 03 Aug 2026 01:52:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785685923;
	cv=none; b=MrUx7uWkaQ2ps1DRtS0ZbOULnltov02fETG2fksTIq+DWtlkGXKsoxiP197nTuTpw5PhNQcdyB5yB8FwRV5kE51LTDYSlJ+altSw7HOmABKYLcZq66rdxWz5RpD2NtkxhamlExEVpqxvu298OWV6fLzhCcEBsT99HwdkGDH3yO32ddBDraz+3sBnOo/mzFCmccAHxuFRzZEH/A2IAq+TuB0EsKXvsFylTbk2wOMPM+a4yPYBZPJOWTsguZ8LmqTlIheptcoymNCsyqNKxVIcJy9QTMC32v4Cl1cZve861voennOYfRlq6y2JwHpJTmoN1tEUjK9KIXtHN4tON+gESA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785685923; c=relaxed/relaxed;
	bh=20iCHKJp7OzhDwFhNpDZDaIQepjQbmnx6YteI+4ch3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XYlz/2QQfSuaaB4wlO1zR9KQcu3I5+z2E73K5PXnVhGd3QKviYv+BqL9mNFfgizrHOpZFCUAWKocyhiISo4Di/uwfef9coP4VZ+gEfHIG4ylElkatpUBMWYBZQWdZZealzZ2q4xE2mIlN2ynnXiK83yeaq6NzOK3VbIsyQyDhH+rJeHcdTDhYwDLyfOzupzCJhon1sJxxVey5gd5Ac6qm+KqW9sBzuyOmU/w48ko7/y2CRZ3NE2oXJehSJKI5rUzisIAfEVzRuFrhfLFSXMB9Y1x7P3EbHsHR/mjNG16avCJQdIxQoFwC/Bd4XXCT/490/KQnjcWNL1fQ/5rTzMAAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Frir8NSP; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Frir8NSP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+moonafterrain.outlook.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCknt1nztz30Qv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 01:52:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DE0A60DEC;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AAB4C2BD00;
	Sun,  2 Aug 2026 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785685914;
	bh=eVXM7QowylgrgD+vcRMf0idml36/gIDDYuz2MC7clJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Frir8NSPaKOz5yWyhazR4f8aMsKwU667Q529WBjhoHljUoiQRbRuUxNSxoxJ5KpXR
	 UNuXFhZ6kCPEuLGxktM81XgczYAA8lgk/98MumZk+2KT2ZoWIyGyKYprTqD/CGQHSG
	 A+/zPa4DwdDI0zOFqfWNNCdsJYpc7AkoGSWoFaIO9OPn04J2pCtofp4TLjFaHzPoHu
	 yDSKWQzZg/XNb1h9+C5AJJpyH9lXKNz6sp4zehVmmRF60Oe/Vbc1T8LQo0BhCL1CLM
	 dSE0OgZj1khr5rpaIkz7FEX1pISTbunOujpm+DuZAmX+Ye9AMNR28MKvvlRfZAbl1P
	 NhvDC1uTvZMdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86A3C55184;
	Sun,  2 Aug 2026 15:51:53 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sun, 02 Aug 2026 23:51:43 +0800
Subject: [PATCH 5/6] powerpc/spufs: fix deadlock on gang creation failure
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-fixes-v1-5-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
In-Reply-To: <20260802-fixes-v1-0-7368423440f4@outlook.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Mackerras <paulus@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=sNBdhSvUH4Nc3dR73ItBK/i22i57aFEVzgsW9ggCOvU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPz0Gclb/hnZ73M34u+Z98Hd5tv8zilH/im72ka++
 tOTstn0f29HKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATOTdaoZ/Zuu1/l+XiNMx
 UrZ9kXfhSUREkWY3o9Zz6b5TZ59vFrbOYGToDXcT3+ZlMS+zZcIE09yLzc1na74u/ahmVyiW43m
 ibQsvAE8LS9o=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

do_spu_create() enters spufs with the parent directory's i_rwsem held
for write, taken as I_MUTEX_PARENT by start_creating_user_path() and
dropped only by end_creating_path(). When spufs_gang_open() fails inside
that window, spufs_create_gang() cleans up by calling unuse_gang().

The gang was just created, so gang->alive drops to 0 and unuse_gang()
proceeds to simple_recursive_removal(), which takes the parent inode's
i_rwsem as I_MUTEX_CHILD. This leads to the task blocking on an rwsem it
already holds, leaving the spufs directory write-locked. The other two
callers of unuse_gang() do not hold the parent lock: spufs_gang_close()
runs from ->release, and spufs_dir_close() drops the parent lock first.

Tell unuse_gang() which context it is called from, and use
locked_recursive_removal() when the parent is already held. This matches
spufs_rmdir(), which spufs_create_context() already uses for the same
cleanup under the same lock.

Fixes: c134deabf478 ("spufs: fix gang directory lifetimes")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index c2b15c30f7c0..998512409552 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -175,7 +175,8 @@ static int spufs_fill_dir(struct dentry *dir,
 	return 0;
 }
 
-static void unuse_gang(struct dentry *dir)
+/* @parent_locked: caller holds dir->d_parent's i_rwsem as I_MUTEX_PARENT */
+static void unuse_gang(struct dentry *dir, bool parent_locked)
 {
 	struct inode *inode = dir->d_inode;
 	struct spu_gang *gang = SPUFS_I(inode)->i_gang;
@@ -187,8 +188,12 @@ static void unuse_gang(struct dentry *dir)
 		dead = !--gang->alive;
 		inode_unlock(inode);
 
-		if (dead)
-			simple_recursive_removal(dir, NULL);
+		if (dead) {
+			if (parent_locked)
+				locked_recursive_removal(dir, NULL);
+			else
+				simple_recursive_removal(dir, NULL);
+		}
 	}
 }
 
@@ -204,7 +209,7 @@ static int spufs_dir_close(struct inode *inode, struct file *file)
 	spufs_rmdir(parent, dir);
 	inode_unlock(parent);
 
-	unuse_gang(dir->d_parent);
+	unuse_gang(dir->d_parent, false);
 	return dcache_dir_close(inode, file);
 }
 
@@ -483,7 +488,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 static int spufs_gang_close(struct inode *inode, struct file *file)
 {
-	unuse_gang(file->f_path.dentry);
+	unuse_gang(file->f_path.dentry, false);
 	return dcache_dir_close(inode, file);
 }
 
@@ -520,7 +525,7 @@ static int spufs_create_gang(struct inode *inode,
 	if (!ret) {
 		ret = spufs_gang_open(&path);
 		if (ret < 0)
-			unuse_gang(dentry);
+			unuse_gang(dentry, true);
 	}
 	return ret;
 }

-- 
2.51.2



