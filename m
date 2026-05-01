Return-Path: <linuxppc-dev+bounces-20352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3506FF8864
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:12:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6HgW44m1z30FF;
	Fri, 01 May 2026 14:12:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608743;
	cv=none; b=LWasbTgW2DvsAcAk47T6zTE8ielXhk7TcfB/xgi10l5kNRg8o0OzBNWscmvrSxZkcDuwPjzJVpIKA7Cb8VPh7mRiNkchUXqw8JNsb8IQbLpNXOQq7kY8ajfE/NrLDePCaGPXQ4Oa7jSxsssMv//6LRfpm/fWk3xScXtugdDX2sWXVR2ZcDedI3UgfNHDEL1tChrah5m6WoWE67cdCq3Sgrc7VwbLU7vWgLCMxN8qByOHqspzX7EtV9azL54A1PXPwXxSL4tQmtjm330bl/OYewz1R+qH/s4VQxMg8wt46u2LFNwOrJJcJnhvx25gdCgYwm7CWV4NwB5tdkAzPvFYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608743; c=relaxed/relaxed;
	bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj3hWqy3QXCDJjhLi+JNHRCp0JhCeIJbOPKGpJmQXHgL/NHCIeVqXZy2Z+V20/ChRVE8WuTu483VkA0EVza5fFZXstLmtIr40nE1fIo8Wk17j6uHYA8mTFOl5wPFEyephHVbi48AIO3TxE6Q7BB5j7yabf7bFpsEjjie8cT7aERV7Uk5oAc2w0yS2kY6EE/Xti+MoPI6e5KRHqDK95LgTZlVjI9GPmLTnZA7O5L1fwSMBLwC2tzlk9vWmhE54UgeEv5vsewXKh6JBk2rrsN1KgLiP9bpaK7IaKQFMEPLSmAP+VM/RqCSVBAS0EIB3R75WBIownxsjyjsMJrB1lM6bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnZ0cfXQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnZ0cfXQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6HgV4wZPz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:22 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-827270d50d4so1556303b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608740; x=1778213540; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
        b=QnZ0cfXQROWTsIa5+R2sbkf3E3W0evbLs7p+cMSM2MMLHstlquKXWxVzk7EshL9d5r
         SQy6N8ymYrPOagbir8GsHnGYrARTBlF4h+GtnurxaNs5RcyOq0s5+OIwYKX4gbjIe/ew
         /ZEir/A4u1HxUw7SXUgV8tegoLFAr4eUxbCN6Fh0+v9m24+Mpv7HrBS7S/CxFYWR2u4/
         lJ2URJ0Y3/k1jK79seAPOXjZ9fWthigR3L04ISh7EwX5JxFrCnVd/ESbKL5VBX6NAvh8
         WkUgfTYKJGaliIdPjG5FbMcoxtXxJhWssfLmvKQK4ANRaSQ1D/BzSK1+WQeXbTVRJaSI
         Cx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608740; x=1778213540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
        b=f/HoJ02/vnXqyxD/LLK5qWx9894FNAUGZ7vzFBDxPNHHwrBazR8mQ6ZiNHIW4Nt/oM
         0FhOFGUQ+ZJ6NEJPLIux09+tlx/LL6hO7UCB17ISsvz/qY1E2inAbNJ2ggky43vTgr+r
         Hujf1p4fXNc5NvYGb7d+odyJcyDXwPoJadvXdPfPX87gYpTcfqDmBS2vN9zP1pCvywCs
         ga1oZoSehkJ/4HYa2q/eSzc6HuMkVrMnIxx6+gFLkmQTyAiftp+G7AH4gqoL6EKCgv1N
         BooaP8m8FUFYwXVHrGUlVPsSLZf4kn9KkpnboTKUzvxfeUjnPzPlmFw22jUH2tV6ePFr
         tKXA==
X-Gm-Message-State: AOJu0Yz4mS7l4er2ZxtKQB05y6L8rAqVRdOgsZ2vS17klokVIRySSBaK
	g0gdETM3+Z4WF0dId77gA2oW7IZPm8TWt9SNk10UVG2JiqQf1rLlYfjcP3ZLOb5z
X-Gm-Gg: AeBDiet4l7tzmWoNfnQxwJ1MWgjm6+nlfEau6vOvJ+dlDs6iKn8d1ieIZY8UtFM9KbL
	L8V20+fG2+WeRlos4JL8/7vDA/Trt4Mol3uqDvvkY2gcqofGgRyWFJDsJEuKD4t1h6XB8UU+Ue0
	oCXwFoiQn2pI3vgc+L3aaxE1+oGHhd5vL6HASXYHwXMz+a8fCu/WaLb6UTZUHgj5/MFVjai+tuU
	npEVwl5N+WDil8umJy6nzCkF/PsY4x41iaEkvS+zT9tdh/aAnUpByjwonq5cAGjX0vfAw+yc74f
	/mrL793kLQ/YjiWTSouMxj7YmHmJKHlpaWH9RUs6l1DGJ64wTX+VL8z7AvGmJLTSUZa2O4SObsE
	lzmbL0k4qHSCdfbJmy+nZHHET15ve+oSaEQdxQonN/iLM4qJwJzyl+4f+a4f1Jy/rKlWK1H9BsG
	Fw+JxwnE4XSzdF3xdhgknGwYezowq3M69Ev8QsyPmQEcO/VGVqPZ2oMhCcrHKy7TU=
X-Received: by 2002:a05:6a00:1c9e:b0:824:adf4:5a2f with SMTP id d2e1a72fcca58-834fdc5c2admr6357028b3a.43.1777608739583;
        Thu, 30 Apr 2026 21:12:19 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:18 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/9] pseries/papr-hvpipe: Fix race with interrupt handler
Date: Fri,  1 May 2026 09:41:40 +0530
Message-ID: <e4ed435c44fc191f2eb23c7907ba6f72f193e6aa.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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

While executing ->ioctl handler or ->release handler, if an interrupt
fires on the same cpu, then we can enter into a deadlock.

This patch fixes both these handlers to take spin_lock_irq{save|restore}
versions of the lock to prevent this deadlock.

Cc: stable@vger.kernel.org
Fixes: 814ef095f12c9 ("powerpc/pseries: Add papr-hvpipe char driver for HVPIPE interfaces")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..c41d45e1986d 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -444,13 +444,14 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 				struct file *file)
 {
 	struct hvpipe_source_info *src_info;
+	unsigned long flags;
 
 	/*
 	 * Hold the lock, remove source from src_list, reset the
 	 * hvpipe status and release the lock to prevent any race
 	 * with message event IRQ.
 	 */
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	src_info = file->private_data;
 	list_del(&src_info->list);
 	file->private_data = NULL;
@@ -461,10 +462,10 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	 */
 	if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE) {
 		src_info->hvpipe_status = 0;
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		hvpipe_rtas_recv_msg(NULL, 0);
 	} else
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 
 	kfree(src_info);
 	return 0;
@@ -480,20 +481,21 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
 	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	unsigned long flags;
 
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	/*
 	 * Do not allow more than one process communicates with
 	 * each source.
 	 */
 	src_info = hvpipe_find_source(srcID);
 	if (src_info) {
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		pr_err("pid(%d) is already using the source(%d)\n",
 				src_info->tsk->pid, srcID);
 		return -EALREADY;
 	}
-	spin_unlock(&hvpipe_src_list_lock);
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 
 	src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
 	if (!src_info)
@@ -510,18 +512,18 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		return fdf.err;
 
 	retain_and_null_ptr(src_info);
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	/*
 	 * If two processes are executing ioctl() for the same
 	 * source ID concurrently, prevent the second process to
 	 * acquire FD.
 	 */
 	if (hvpipe_find_source(srcID)) {
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
-	spin_unlock(&hvpipe_src_list_lock);
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 	return fd_publish(fdf);
 }
 
-- 
2.39.5


