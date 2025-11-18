Return-Path: <linuxppc-dev+bounces-14239-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BB6CCD19A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Nov 2025 05:17:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9Xs55nCSz3bwF;
	Tue, 18 Nov 2025 16:16:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763442985;
	cv=none; b=Jhv/LSLcjXk9o2XVC+0Lja3obVKlaAhWYr+NtaJ7Mk/BG8wDpjxj7+7LA186emX+4iqBqEOXBx/sSd3UQFBEVArHAB3f3XtX4R7lRkygO1TOTkM1/vRC48qg/31pE/QIasOmlC/rCVVXdmmjvnC9S/k7w1hTGP1/ZkvpVTi9hboOA7ASdIYbEIIOhI47Hj3pMhYkG36qm23ttzOxrVb8spiOrZeMT69c1wp43fF5IWo2qeYgqfL4Iclz3y+4huZVp1I0IwkAzOVsYl0deau/k7ANtW8ESaNR2O8DlvVYpBjYvCBxidBR8wiZ8p/Ay5kJj6QxevcQWAzOo4+6A4uEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763442985; c=relaxed/relaxed;
	bh=eoHAGF5loUqH0LAFPRC8F4kXyPuIEz0vDtopK5rWb5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFuu6+fBMkbVzhXFwSDtP+rhVXOfBGHHeUKMwrOnWq9fCz+GG2DCIGcCPL2XUC9MAwQHijEZujzY6hppZJ0RP2zdlVgd+ZYDI2JhpW3RLprBx2eVqdGTAl655yxVGu6H661YpJldIWi5wFRHZK4dpxh4RKvoZji6KOlMRrkS/61D7J+rFBOkUcJ2pFbAaYwldRq6GT1FnCmImU6nVmHbqOR4FqNN1qb3C2PbdUFTgBslztcA1WDM/TQXsopu4of4gRkti2eIwr4iP4JfQPb68ohPMr22In5bYvjYLA15AlC1HxeGxbgBfnfAkpzpA4UognyVB1JBQZveTH/bBsGzpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=f82OFm7F; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=f82OFm7F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9Xry2Mvbz30V2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2025 16:16:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eoHAGF5loUqH0LAFPRC8F4kXyPuIEz0vDtopK5rWb5o=; b=f82OFm7FvazKYJYDPR56+WvVrq
	Dj+gC8HySiz+YAUbtJL3dko4sirA2yyl3o0FsOZ9C5gPoeBshzb4xWNGR7mx5ndW+pcT0XXW0PTVA
	1TdD3rRO4XfqYu4IR0qNpSgFvWmn69s6hBWs8H1HSLAVur0wqfCUAb/l9kFK9MJQPvsAVZ/QRPuI/
	owlmwWB4SXiXlhgGLf8wVKr1cD1r6MfuwfesIPeZVcu2CllkQ7zErPM1f/l2l/YQojOTgvgL4PbRY
	K6Eo7MWrGR49DBEjSc4+hMfJ2JYiCa+ZoPNrcs4NBhyUR/9rNJc7ltq2YHT8otRnbYDs9xo7mRhmC
	/Whn4W5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4W-0000000GEST-0Krw;
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
Subject: [PATCH v4 28/54] binderfs_binder_ctl_create(): kill a bogus check
Date: Tue, 18 Nov 2025 05:15:37 +0000
Message-ID: <20251118051604.3868588-29-viro@zeniv.linux.org.uk>
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

It's called once, during binderfs mount, right after allocating
root dentry.  Checking that it hadn't been already called is
only obfuscating things.

Looks like that bogosity had been copied from devpts...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binderfs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index a7b0a773d47f..8253e517ab6c 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -397,12 +397,6 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	if (!device)
 		return -ENOMEM;
 
-	/* If we have already created a binder-control node, return. */
-	if (info->control_dentry) {
-		ret = 0;
-		goto out;
-	}
-
 	ret = -ENOMEM;
 	inode = new_inode(sb);
 	if (!inode)
-- 
2.47.3


