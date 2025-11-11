Return-Path: <linuxppc-dev+bounces-14066-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD38CCFA18
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Nov 2025 07:00:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d5HQ44QRwz3fQv;
	Tue, 11 Nov 2025 17:56:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762844204;
	cv=none; b=APKmfCF8TnubN7PwoVy2XuhmIQF7hp814iQ2wsUZzvEiQHr4pIQblptHxZaVZvmqOQchO6BvW/OWL0H4oJNkEVExLt93PpLm+GEdd9BE1yyUzzAS8A6OpCWWI/st5cM6kyxzMJ/iUguTuVMf8d6DOw+zoAdY+znDKnuIyrSPk85fUnfjwRVuvHVA+YOrLFc/KeKG0Z2kY/ID4hNR4LIVRgBjRNKg+F3+hf7yL1HlI0hTBEwBxwPcqiBm4PElDafgPO9n7wjYUmTAEpme34LQOU0U+KTcCyE4kXUX4cgGHrCAq2hZxVbrFDBIUOHp98j88A2t7VIMjctbNLO9k+MpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762844204; c=relaxed/relaxed;
	bh=eoHAGF5loUqH0LAFPRC8F4kXyPuIEz0vDtopK5rWb5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDaoFKCnyo9QsVKBeggFxNdocE3I5HD4rsqnrxRez69cAat1fx+WvZUPBV7HAB4G+acU1iFmGKUYxc8xXW/6QlDO/BMKAWnDTDlNKAEjDyuZiiYXpC4o2wn6q053lUPPs5W8epY1UFJ8puH9PkCUn/e204Hu680WixRgnyf9Z/4HkywD/J7ubuEDT59K4+Qbl59/k+WFl9KoHdJIF8q4R5sGjC2GS8F96vW6HD4IeG8NmIARfMVFoypO7JYcQ/GFI4/biHpIMLVehnlYRuv8XJS45474brmS2MQfNVN+J9/4x+s6v0PQRGUDUEdXZeYRScfTfHXhVRgvOQrW2TcyRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=XqMCp+ks; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=XqMCp+ks;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d5HQ33WBqz301X
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2025 17:56:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eoHAGF5loUqH0LAFPRC8F4kXyPuIEz0vDtopK5rWb5o=; b=XqMCp+ksCwtHsAxc3vOlMm2BUc
	Crr7QM0NFZWC+h5EJiUX7b0C4eorZyJDxSelasJeNRilwOKqX1onn9TmLulW/PLZTAbTtuBBe9026
	IXlnGKv8naAwkRak7PIahFF/jhRL/KVz1lNDiwxRlkCfDrG2RoyjemrjuACPkd5lHVt49BDGwtaAS
	DlcF+c5z2DoUdglLan7F9XNJ9OH5AJ2S53oe8R3vudDUMMA1pdyGSpqAFireguyYxE0m907oc75Ep
	3HsdFESeGr7wgdHVftqHeVTX0VrtHc0zQWVSj6D1dLR1tjerFHNGzTpWrp3HD7o3YiPcxrvQQRDyI
	kxOdGCEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHl-0000000Bwzq-3whg;
	Tue, 11 Nov 2025 06:55:25 +0000
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
Subject: [PATCH v3 28/50] binderfs_binder_ctl_create(): kill a bogus check
Date: Tue, 11 Nov 2025 06:54:57 +0000
Message-ID: <20251111065520.2847791-29-viro@zeniv.linux.org.uk>
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


