Return-Path: <linuxppc-dev+bounces-19436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEF8FEEF50
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpYd1mk2z2ymg;
	Wed, 08 Apr 2026 00:32:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572325;
	cv=none; b=bTazJydSCXbyp3rWp9WHyoy73DFTBNnW2M9bZW3R8nZWStedej+qWJTFTVvxbEBfXCco3+Cs0Szi/BSzZe2+kkdCTgnbSNEAKr6z4V3wKvBE6lGHhHQVO6Zpi4xTWHSnK01n2QRLO+lbkmh414NLfGaVsOcI4Is6Qxe8zjKojDSl4bSN238tW3wF8gD1dcSHA7T+n6tqcrgy2bpvUfIwhpvY92JeAyyxES3udXBtZY5O5MiAekCB0RTrODpPP+xggFTJgknCkurFcSrt6SYrzph5PbGnCs1SkU4WyR5JNCAgRcgWtJ2SjdbigQPPm4z/89sYCKCMHrNeTXvXEDfZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572325; c=relaxed/relaxed;
	bh=aWlqSctU1ZNN/z0ZDozfOPMSEatR6CHgCywrgmA5uDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnJS6saX6LNhWUUMuqMTjG86GQNzKHyfxeFWxaP4cpbCgYZu51bJ/sOMvllXJuzN01kYIIiaPv6r0l2iyO9g7cYSWmdYEKAUKipYPhHTq+MMHsMaMj1FJ8YoJcisdgQGXp/GIPIjJEI2mOetf9e5UQTM/l7ybZY8Zi8seEETizOYmjg3qt5nIej6u070w49THv41fVveVToJRLyQHYPq7WyFgrJgUsE+xxwSpwXQNKzTotVOaqTq28d/n8nGu6ot6KlLeOStBJK/o3Ex0Q4SdVab+OHs3RPo5H02r2QN4yFa2Prmi3CIH5Jm74flOUIkKLmvw0IrDLYRDo3JqP15YA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LO8GJy2J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LO8GJy2J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpYc0mZXz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:32:04 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2b23fcf90b2so50188845ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572321; x=1776177121; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWlqSctU1ZNN/z0ZDozfOPMSEatR6CHgCywrgmA5uDE=;
        b=LO8GJy2JC5Gy+bL0x4LdYknaljIbUvwucunaVXdmHtijFPSTJyszNJJr1wRPbGKkp8
         B1JPq1hmGryYtL0B1IWIYafOWBvEs9Nl4bU9VrWZ40zTGrhhSVebqhI3PyRIskCuPVO+
         jaG+S2D8YMI4u/KJABuaYPT5997QTYePsOgEyeb8DG6F0SijvHXJP7YXb5ZSotOGtVZd
         3eIZjyqq8FR2B5+qQNeGQ1gq7xJBji1cRFUfyVzLEZ8f6Ozj6k28Q0FlN+olmec3QPh3
         5RodNfhpqEjKK3YeIx2rcDTz3TTV2tlNrs9fNAaH6V8oV0fPD7q0rNE+ybpf6BKNPzBE
         45lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572321; x=1776177121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWlqSctU1ZNN/z0ZDozfOPMSEatR6CHgCywrgmA5uDE=;
        b=MqfwF+9/TspIX8pKaa2YM1qCxgVL7Nj6Fo7EbNPfufyNXh5R/FlqHeReq5uBsqsiR+
         zf7TtRQbRJPhKt1NiUKSWKY2NvqI/xZP58wfL/OV5L3ZoHSOo+ysJV1VZt7x022rfXh9
         o22bwaOIHvFKPfeGnXRGyen0IrrdgtcsXo+vo5dfbBucwBeWGqGHTdIaopCDcxRNSVhW
         5F8I1T6/OZhx3nsY2nze/1CGrBH5G9Kihmsc3w+xTrmYrqcVOeQ8n0OpEgiXEOW2hoT7
         Iw51OrEwLkYrSjxWvdCXNQp2AgyPx1S1XLIchIni2HsV1yXQwAJNHJVRI9UuzujCQTAT
         LScw==
X-Gm-Message-State: AOJu0YyLzaNsRsnGke8Le8/Hz+5NjJbJrbhiEH1yuao0GONr3LLWzdu/
	nLHhtCOz0+DeT38xVgoPyNI8o4ucGBdOai/Nov7tKVFpsRpvraS6GAo649pe/Q==
X-Gm-Gg: AeBDietdp1JbyxcVQ7ddM4FzlXykRaZJzRsoGcYCyJqakPgyO6Nbr86FGX3ZUrN4s6V
	yMzYcF20f9PrscuG1O2UdV7p++HqyOTVHY5p67HuZZ796nRhovKY88wBoI+Z5NNxy14cuoJHur1
	Tz2GcW42I+vqaV+rZ7na+3EMvtN7STIizW41W0w/OVoM5JUf6Iamy7qOlLO0ShzDc5LBLZtHuOE
	/vte8f6u+SXVPYa1Z1zH0K58MV8o2SoCAvuXf7zPJ7UeQKipsr9rm3w2mlwETqpP0apCFERQRcJ
	wZD1unMV94RQgDOTx2bNCmvB2vY7bqVVM20kFtgWI6feF3Hi8O55isiWSLVis7k5ugiealSMr1v
	Y5Bx8Cfdx7PlbYVs9PAYaSUUrtLIiQZwz9loQsWBfQpEnsmAGMdB4T09PemV1nFdNIEEiOXEIA2
	zJsEWeAe6tFTJeF1y8j/f3aaqpVgjCodoVABXD7Y6mYqb9l2wlwrEWkrRQL76k
X-Received: by 2002:a17:903:3b84:b0:2b2:4728:aa6f with SMTP id d9443c01a7336-2b2818016cemr160584395ad.26.1775572321227;
        Tue, 07 Apr 2026 07:32:01 -0700 (PDT)
Received: from Mac.localdomain.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm181201525ad.78.2026.04.07.07.31.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 07:32:00 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [RFC v1 1/6] pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle
Date: Tue,  7 Apr 2026 20:01:35 +0530
Message-ID: <5984bd91ad6d3541d08dc9f3c99e6de0214dbfcc.1775569027.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775569027.git.ritesh.list@gmail.com>
References: <cover.1775569027.git.ritesh.list@gmail.com>
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

Getting the following kernel panic in papr_hvpipe_dev_create_handle()
when trying to add src_info to the list.
 Kernel attempted to write user page (0) - exploit attempt? (uid: 0)
 BUG: Kernel NULL pointer dereference on write at 0x00000000
 Faulting instruction address: 0xc0000000001b44a0
 Oops: Kernel access of bad area, sig: 11 [#1]
 ...
 Call Trace:
 papr_hvpipe_dev_ioctl+0x1f4/0x48c (unreliable)
 sys_ioctl+0x528/0x1064
 system_call_exception+0x128/0x360
 system_call_vectored_common+0x15c/0x2ec

The error handling with FD_PREPARE's file cleanup and __free(kfree) auto
cleanup is getting too convoluted. This is mainly because we need to
ensure only 1 user get the srcID handle. To simplify this, we allocate
prepare the src_info in the beginning and add it to the global list
under a spinlock after checking that no duplicates exist.

This simplify the error handling where if the FD_ADD fails, we can
simply remove the src_info from the list.

Cc: Christian Brauner <brauner@kernel.org>
Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Reported-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 50 +++++++++-----------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..ef10f5a5a4fa 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -479,21 +479,8 @@ static const struct file_operations papr_hvpipe_handle_ops = {

 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
-	struct hvpipe_source_info *src_info __free(kfree) = NULL;
-
-	spin_lock(&hvpipe_src_list_lock);
-	/*
-	 * Do not allow more than one process communicates with
-	 * each source.
-	 */
-	src_info = hvpipe_find_source(srcID);
-	if (src_info) {
-		spin_unlock(&hvpipe_src_list_lock);
-		pr_err("pid(%d) is already using the source(%d)\n",
-				src_info->tsk->pid, srcID);
-		return -EALREADY;
-	}
-	spin_unlock(&hvpipe_src_list_lock);
+	struct hvpipe_source_info *src_info;
+	int fd;

 	src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
 	if (!src_info)
@@ -503,26 +490,33 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);

-	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
-		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
-				      (void *)src_info, O_RDWR));
-	if (fdf.err)
-		return fdf.err;
-
-	retain_and_null_ptr(src_info);
-	spin_lock(&hvpipe_src_list_lock);
 	/*
-	 * If two processes are executing ioctl() for the same
-	 * source ID concurrently, prevent the second process to
-	 * acquire FD.
+	 * Do not allow more than one process communicates with
+	 * each source.
 	 */
-	if (hvpipe_find_source(srcID)) {
+	spin_lock(&hvpipe_src_list_lock);
+	if(hvpipe_find_source(srcID)) {
 		spin_unlock(&hvpipe_src_list_lock);
+		pr_err("pid(%d) could not get the source(%d)\n",
+				src_info->tsk->pid, srcID);
+		kfree(src_info);
 		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
-	return fd_publish(fdf);
+
+	fd = FD_ADD(O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
+				      (void *)src_info, O_RDWR));
+	if (fd < 0) {
+		spin_lock(&hvpipe_src_list_lock);
+		list_del(&src_info->list);
+		spin_unlock(&hvpipe_src_list_lock);
+		kfree(src_info);
+		return fd;
+	}
+
+	return fd;
 }

 /*
--
2.39.5


