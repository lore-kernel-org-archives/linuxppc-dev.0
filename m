Return-Path: <linuxppc-dev+bounces-14245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1B2CCD19A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Nov 2025 05:17:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9Xs93GJgz3cZQ;
	Tue, 18 Nov 2025 16:16:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763442988;
	cv=none; b=RwYNko61/ZYQNC1CNvHau3M5ucRBiyQ7+CxDCrDOzEUSpuDk+0/AP4PbqzhdM/IjTSagoizFwbVGRyElWLGB3Vn2lHIx1PG1Irf8ID93Xoo+a+HiMy/9nTNxt3pWcb0I8mNvkSKKwcGLfl8opCK8NPZ7G9quctDO3B9yp6wd3b7KG3LpvDe7umDN2TvxwZwu14oKwgh2nz/YgZKKKRn3MyXKRwzybcE5PXx8XWxOn9/uH13MBn96J3Qa/tVImE9DGcLABB+zFQXJOKAm+BdmF2j/x0QdIbnqtFmLBoxS4rKG4tauIXhI36mkPxTtlYTzytZ3RSx0SLuZ9kviVBeMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763442988; c=relaxed/relaxed;
	bh=nXGw1nJCnekakkZR178NLSh8+iviODtKUClSm5rridQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCb1A90CFnM8H7k8L+dkpp7n6/uW9YRMQV9AgfUTbqTVIre36uzIssfTrQWJ5V0INUrDwJdeTcwhtOj65d5g0NFTevb8creA/b8cTLJe42rGnOmoWhy+eqtq5jmZ4fY8yCNyXqSuKU4GXOFX9ZFOeBigm3EY7xwPzGqiL6INmm6bSnIV+tKaGdAfjoi6C3WwxDmTzZV8mSsDwC43Uhm7LYGDopsTI6NNVM+R6Vh3Yr2oOkzjy07Q9uipAZ5lpeM9NVzMKK458FGiHUltiwARXkLTgOvq8oy0VwfLV8MzrsfhQ7eTylZh8xkwk6Un0JZCd0KEzPoIo7zVI89oxVvbxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=Vl/3NOTL; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=Vl/3NOTL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9Xry6Vh4z30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2025 16:16:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nXGw1nJCnekakkZR178NLSh8+iviODtKUClSm5rridQ=; b=Vl/3NOTLarYBwB87GqxphHKkQI
	7nr+xrUdOHGzbQvNgPwTh/+ZuDIklH3LjYUAJTNerzga8Stv121nDnS3dDUlEWMDcLUPP0vdvR7CY
	bwy1nf84MahGcCd/mXVTinqlKGe/gh3FEFU4G0XTQY2caZj4q/ktudPogUMWC6fe4UAt6FUnBzwDI
	wlEBeCbvC+oK7xQDjQ7Gp/b5U1/DIQzgr2komhocDqrOpYndVRm6Prd84cwdTe/IF2ZycbvfTJfwh
	/cdvCBu8/rsMTkT9oC8Hh15d+60epPGvbHco9HjSlcLntpJEtmjdXQst25vMXn5ZTu5l4vga99Rih
	xpFUYzEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4U-0000000GEQg-1EYJ;
	Tue, 18 Nov 2025 05:16:06 +0000
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
Subject: [PATCH v4 11/54] convert xenfs
Date: Tue, 18 Nov 2025 05:15:20 +0000
Message-ID: <20251118051604.3868588-12-viro@zeniv.linux.org.uk>
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

entirely static tree, populated by simple_fill_super().  Can switch
to kill_anon_super() without any other changes.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/xen/xenfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
index d7d64235010d..37ea7c5c0346 100644
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -88,7 +88,7 @@ static struct file_system_type xenfs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"xenfs",
 	.init_fs_context = xenfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	kill_anon_super,
 };
 MODULE_ALIAS_FS("xenfs");
 
-- 
2.47.3


