Return-Path: <linuxppc-dev+bounces-20354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4809FF8864
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:12:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Hgg5JGRz30WF;
	Fri, 01 May 2026 14:12:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608751;
	cv=none; b=Dn9pup0r5YFq3VZ1cWsZCfjKxZ69q4nPzpnu2t/0XStDS+u5Tu5V/WpKxD8PBMmbtujCJW7sZJ5jEufdSCyCnsVigqVQaGytx8yqFZqMFljG605gVljaLkc9eBKqAcUV5sgNt6gfKQdZ+GmYnVX6Uh1MM3kbhhD1A0aY0+K+6K5DFwapJ6AmNMze33wYqDNTjL8i6mpE8U06BvywiGfn+3y3/j4OEOuMo6ptj6IkNEG5Ef3TBXesj8R90PBWSkRRhAUsKw6mnUogFQpUzPd2RBuQfLw3u9Knrswn5ptWqitz+VE/IOgTANMvK29pLz9ylGBVZg8UA9aup8lpM3mmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608751; c=relaxed/relaxed;
	bh=dF2w3z4/59cYB6Oy2yDdp9rDcfrHGTFcj+1xeJe6XK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwTnunN99EWS9pktv4cJ48xjFL7Q35MLupI7eyASgU3wFSl4B7wTnx6b20yZqekAJuHa9Le5Ghi+kTgZuf/4FFqofM5Bvpv9kdTi0v3qyXETCdEdN65AYrVh+Vzc3V4Tgy6SwrDUQQzOnN+4r0/r6tW/ICO7irZo79Ok0xBUqGO4zjraMHc0SEzBCbMM9a4Lvtcm/PvP4EQY673YSvKoYiz7L/MihsK8n38ANq31xOgI2Du0DwmzuKuvDcXI/VAeraSzhmMjvrnVO/OrHmHlJJk1SGmEnmjTBv+ISyHZtHbsopN4Hvmd0cp4EoouVuzM+niKZVKEr2daAiLmmWw+Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sGAB6lGb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sGAB6lGb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Hgg0rxHz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:31 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c76c067bc51so598590a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608748; x=1778213548; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF2w3z4/59cYB6Oy2yDdp9rDcfrHGTFcj+1xeJe6XK4=;
        b=sGAB6lGbnrh9quwiyn6i8CgXlkd3Q/RgX9VCV3tXhpYxr2w1KVa6y43Ad5MNIU98oj
         Zis6BAr1mhzdLAC8MQF06qq5WBrE9kcM5ggFGDQvKArcMdxcFxcPasgAuFN4taaho/XN
         O8qPHhTJMYf5Vl8VtC9LwH5O6K4oddtWhA+uT9LrRu1iV63qchtpNtZVoZslsbc4bs+e
         zE8uvtgcwk4oUOSS+0eC408hNtluLjAgAwjIFePnQflBrvJ3q+w837JWU2itKTxL0VIu
         6lCP3FCYt5LEdXqZsdF01HpI1PsV3G1Lyjq/zLEiFMiVCHBwlAISHOBpXOJeXoa+0BeH
         hbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608748; x=1778213548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dF2w3z4/59cYB6Oy2yDdp9rDcfrHGTFcj+1xeJe6XK4=;
        b=mk/5QWJw52JahY4OfNTqfG+90dhc1uReVReYpdbnXNDhC975SOTi7gwiDO+CEUYXrE
         KDHE5QAEL/QA0EEGiV00Us0b2d/kFyCCvcUfzyTO7yeGjYdl6fo/Flrz9xibloxfWtKp
         90S6nugGk0OLASqLk+zKgs6VnG28AGxvsSZeFJV8ehCkDg01ZUGUEuXkzlawEtd7vqou
         9nnjjWTXf10pQXKg9wuluEQ2ekPCS6H8+7I+ReZEjSL4w0+nbAXklv2Vpt5U83UFQ2QY
         I8LhtpO+mmNVj5siytRcnnXG2Dg+6Z1niBoM/qadLNjAs+5XIm9sNlxD0f9U1qwbSwUm
         JJNQ==
X-Gm-Message-State: AOJu0YwMJ5Ri3sh/BWhqjZr86e30kxrHhQx8ZVMqoHc/AgvPvARKjJ7T
	7fJho6oQ5pXvn1R2VZdtSdLr3CyHXtqUeZ1W0lhkAoI9BbQTThtXbOTAeSy5fiog
X-Gm-Gg: AeBDietMqCovFjFyRdn+Fe+0DF9PGE9mMg8WLvxKEA782AtalCN37f8WRUF0+cl+X2F
	V7iMN4o7E0BJsntU8k2d4oQOwBcj1a1uj/CVY3YXJwYjFUgQ/pUcBZmjUtMiRHhZ9uTcI9bUh3W
	/+Amvs9gBkmdSO3V0QfVZgAll/ntQS8gaDuAHS9t8RAg4qucJcI1LfgnzqhnBGZooN1XaSGGtDG
	IP1k+SiOPgQPZRyzyJmLDSl4/QYPlHQGEdDWcARCcNUpfGkhranHFxIgo9Poy67bpvA7boM3Er2
	xcfgAhO8oAkscAg2+/AgK5Q6P7j2K5Hw5IvikkkaioobD6CyGo2X3zn8ffQt9QaOpADTyYsQ/EU
	RmLadZv7RUXVJyCQc3pIqzSULHL35PqBSU/khA02SvOx0il2SkYVT6qQkjEfkgpxQbrzxEQOUyp
	DFX1X1Uemj/3o++TCp9mFkbls0/v8GyWOC5Y5CGROV/tIIkknX3OyirU3kwg0rL6o=
X-Received: by 2002:a05:6a20:5483:b0:395:ce56:4448 with SMTP id adf61e73a8af0-3a3cf68b511mr6112736637.25.1777608748275;
        Thu, 30 Apr 2026 21:12:28 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:27 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/9] pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle()
Date: Fri,  1 May 2026 09:41:42 +0530
Message-ID: <31ad94bc89d44156ee700c5bd006cb47a748e3cb.1777606826.git.ritesh.list@gmail.com>
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

Cc: Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org
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


