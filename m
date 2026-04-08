Return-Path: <linuxppc-dev+bounces-19499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6283B1073CA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:02:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMB94wSrz2yrD;
	Wed, 08 Apr 2026 22:02:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649729;
	cv=none; b=Vj7ORV8CJe2JpY7vgKL+QCyspSh0JzWmNV1ZvKV5BuYks/UiJRihsxzTJfcOm+cCor1UpssobS5rqs4ZaH08iqxaKNaBvnh5Ih1EPRL//qX6ipgpAnoOMXBwNa421Jdpaq7eViB/ZxeC63IxZU1P+2G37HFBVetJneQj3SSmMaX0yKR6M4J1wxgWy0ddz2/Q4Ty5FqV4lXXJULYBXkheaorEslNLN/CRY14BsHCESObLyqjfj/Mo6ekUyPLWazh762uu1qvKl57eqjvvgu3vPQwPGAy/HKsT8eUWYW6WdrVmesQ2j1yr5vC12YWoPfZY18i6UmKhBFS2jZjP5bsdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649729; c=relaxed/relaxed;
	bh=yT/imSl5xO1+XIbW+YZh2He2MwMtKgkLKK3cHIqMkqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkJUva6JcMa2DLdrftOI45SqkLy1xe5XyzpeoA0ykkw1xxXFtqbc7B9D89V/x7CRHSM0F3jkWc2Z/+lirbLeQv9iXBAQRi2mMV1smcgXhYvuf9u4nFVf0Ep5YTqHr8OOMn+dl9X43IO3II3VVbslRnP8ACk3RDP6nayYN7qF+GCyn8IhKRZFvd5wWwzBpqHoWyMjPV9ELxH1MWVQbjMv9aWMcPGdroRQ9x+tY0KHLrBgE+X+99m1hPI8B+Zczd47T71T0/hym5JDQyiasafe2H9fkXuAHktG8bZXZr0Vvl4igB0f2lEpIFscwxx03rDqAMzfGJssdMNoYz48pEouwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EQozyDCy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EQozyDCy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMB90KNlz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:08 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8296dabef74so5811432b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649726; x=1776254526; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT/imSl5xO1+XIbW+YZh2He2MwMtKgkLKK3cHIqMkqk=;
        b=EQozyDCyliCiBpSLdbTuOx0H6V1Kn3ERbOGZ6MihToq6j3ce3HW8cdQiwKKz19yRKS
         syZkfXf/INa1Pvus07tzPb/kK/AF7AeCe2614C4Qa/QtJlKTLOnqoyojASabuAqWF5KC
         JaD4/TZFx5ezR1qtMLx1iHnxw61vctiYqizf1KM/yEh+u88odyM8ibByRlTs5R3qprU2
         i/UVRiBCLUjpa80a1/EB2sRia6E3x7PsHiPBmOmPcIufohI5/IgAjD7MCn6CLxAxaYSX
         wMq5vyK+baOMFbAQcKe9J2DlNLTCtNgrOVYOFS0eC6lNPq+Rc40lg9vmSprO4/1OS8VD
         gSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649726; x=1776254526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yT/imSl5xO1+XIbW+YZh2He2MwMtKgkLKK3cHIqMkqk=;
        b=j9knSk0t4mrccVsaqHcthSzo5D1ZzNVScP2Qtksz6oh7R411mO7DQBp2gnnUq6afG0
         +wt66PxBQRMzjIEBEyQbMz1PHhmgo2btGWtWFJ2o9zdh9n3WmNam/SUYwT6I4yH4SWCi
         rDSgkgrwQLu9aOw+0GqTXawMH12VTLOqr8GGFwJZbb3pHMRUzq3JrFp/aVOLzhEoBuTN
         D1Ae5u66RYNiLASAqLG7noas8S0A1MoZnaDiy21CHX4uAV50ykjwQrTC2WKCijgA6kEX
         xDgudcaCZT00WqYW7xkQLnfuPUXf5kXpyINvTawFokXYUoCapcqakugTh4k2NVRPCWS7
         irKw==
X-Gm-Message-State: AOJu0Yz7ZtPnbqPu20+6+7m85pBxh7X9rjVypO0p7fC+0wC/OtWVi+so
	DvkrnMykzpglBgmmmcWgDOUvehd4I/Bv62mpVQ+5IiMBIAJvidFl+u4e7SyL8A==
X-Gm-Gg: AeBDieslRGFWblCCCspPT98ZiQNEPYFjggFTUlFjBgbdcoiJq8lDdnWFuNo63ihcy0T
	juecMrLXDbswhwyAujyHh8Ru6EWPCUt9FQKc8Y9rt6fQp8V044u58BmlQAAiM5V7WP8Ju/0H/5E
	7hY9dkwIxyiogxyljVQllh6qh110kADHrpvBSTHcOvk5q0a5sJ2pk416lkEkZT3djOb/bEQ4zIO
	dx5B8Tog9eED4jGnzMI8aPbzDqv3S2YBXg3wABsNb3sd3zEmR+SfNg80FEXgXz3cMwVdTsco/Q8
	vHFo5qU2tu/YEdBUELnk/ab1cngA/rNiEEBz/eMxMubzEA1L0z1fXkAnkjHChBF+uraD7lAjlZG
	jW03hyrmx++DrdvaZDgW3g+43L+96Rm0e4dEAGTaeh1sN6boPfxo+P4WV/R8UgllYRfu4YTbDj5
	YvJXP37vXziiHS+z695cPW/oIbFICnIO/KGhIsCuSUrbzo
X-Received: by 2002:a05:6a00:4613:b0:81e:e09d:2687 with SMTP id d2e1a72fcca58-82d0da27ab5mr20793609b3a.1.1775649725987;
        Wed, 08 Apr 2026 05:02:05 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.02.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:05 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 03/10] pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle()
Date: Wed,  8 Apr 2026 17:31:33 +0530
Message-ID: <0843d293fa00a345f156977534e5cb666f1d8bcd.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775648406.git.ritesh.list@gmail.com>
References: <cover.1775648406.git.ritesh.list@gmail.com>
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

commit 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()"),
changed the create handle to FD_PREPARE(), but it caused kernel
null-ptr-deref because after call to retain_and_null_ptr(src_info),
src_info is re-used for adding it to the global list.

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

Now, the error handling with FD_PREPARE's file cleanup and __free(kfree) auto
cleanup is getting too convoluted. This is mainly because we need to
ensure only 1 user get the srcID handle. To simplify this, we allocate
prepare the src_info in the beginning and add it to the global list
under a spinlock after checking that no duplicates exist.

This simplify the error handling where if the FD_ADD fails, we can
simply remove the src_info from the list and consume any pending msg in
hvpipe to be cleared, after src_info became visible in the global list.

Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Reported-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 57 ++++++++++----------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 3392874ebdf6..402781299497 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -480,23 +480,10 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
-	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	struct hvpipe_source_info *src_info;
+	int fd;
 	unsigned long flags;
 
-	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
-	/*
-	 * Do not allow more than one process communicates with
-	 * each source.
-	 */
-	src_info = hvpipe_find_source(srcID);
-	if (src_info) {
-		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
-		pr_err("pid(%d) is already using the source(%d)\n",
-				src_info->tsk->pid, srcID);
-		return -EALREADY;
-	}
-	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
-
 	src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
 	if (!src_info)
 		return -ENOMEM;
@@ -505,26 +492,42 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);
 
-	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
-		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
-				      (void *)src_info, O_RDWR));
-	if (fdf.err)
-		return fdf.err;
-
-	retain_and_null_ptr(src_info);
-	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	/*
-	 * If two processes are executing ioctl() for the same
-	 * source ID concurrently, prevent the second process to
-	 * acquire FD.
+	 * Do not allow more than one process communicates with
+	 * each source.
 	 */
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	if (hvpipe_find_source(srcID)) {
 		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+		pr_err("pid(%d) could not get the source(%d)\n",
+				src_info->tsk->pid, srcID);
+		kfree(src_info);
 		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
 	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
-	return fd_publish(fdf);
+
+	fd = FD_ADD(O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
+				      (void *)src_info, O_RDWR));
+	if (fd < 0) {
+		spin_lock_irqsave(&hvpipe_src_list_lock, flags);
+		list_del(&src_info->list);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
+		/*
+		 * if we fail to add FD, that means no userspace program is
+		 * polling. In that case if there is a msg pending because the
+		 * interrupt was fired after the src_info was added to the
+		 * global list, then let's consume it here, to unblock the
+		 * hvpipe
+		 */
+		if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE)
+			hvpipe_rtas_recv_msg(NULL, 0);
+		kfree(src_info);
+		return fd;
+	}
+
+	return fd;
 }
 
 /*
-- 
2.39.5


