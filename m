Return-Path: <linuxppc-dev+bounces-19497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE60C1073CA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:02:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMB13glsz2ynW;
	Wed, 08 Apr 2026 22:02:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649721;
	cv=none; b=c7vXU9BSaCjFVgjHEABGCt0K4TvDd4TG6wPhnMOSXDWWWZTr/FhwA3ihXhQUq8BshlVG6JXTQTsVmSr1e7EEbEzolavPwmvycNqJOUtw/EeTJTHrPJeBx1UdSbg0SysJ8U6Ne9EfPCB4JbipwrLF4eseCts7FTB5Xje36jpiHkp2KeEhOiOA1oGByJ0bpoTrxZ3eQWpB1LG2mPEqEI/eW/5h6wNpsfXUpFrfvVLL+N7IbH2eXyRaviik4F9nmlU8OJFtmL35Kw3Y6Op0MaPT/ZSCazFbIUpK32wccky5U1SxkL7ez6nERDBOCA6m3lZy5NpAa9r75/PnY/gq9vGxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649721; c=relaxed/relaxed;
	bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LArZEXhsneAzGRmzbVk2rj/KpdLxFzQF5jgHUwD9tkOcUzlH8957gQTCT6VL2Hb8sBxMnZyl99cj5CW78eB3kH+bwcv9Ma+VPCyQ7KT01NPEgtfLz/T1BDd4RdseYevi+/f+yBxrGbTcvOxpzHkNGaYF0xE00Oq22lSSrCJZ43QU6B7iRZejNbA+RnWxAGH8bnmuvDmstblc7/QISUWIKLYbHz3b61M2MoRDNiqGbOfNnDdqg+fLz5itPT7aLx4ZdbEtTpMIal8hzFHF6lVNR2A8YXTl0NoC6Mg9iEWu9eaIzJE+Y1NRP22anbVy7ISJgf1el2lwSnrPgXl+KHEx0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VKMJ0UQ+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VKMJ0UQ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMB06LLCz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:00 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82cf636dac8so2851611b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649718; x=1776254518; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
        b=VKMJ0UQ+2UORNL7CouFZrGNEcwQAoWVyknK/No4LqUrC92NF/EcJ8nRleuTN/4J40T
         8pM3Aq7U/JFRH9044R3v1CKlBLyed/cZSQSKxUWeFfQ1WjTk5sSpGskQUQJXVuW1vGAZ
         8cXd+ysMOcQ8gKTqAI2xmwoF7YdZstyH0qYJ7uon7O9vVzy1qTJdOg3Cd45v2AN5CJTm
         7PU8nXXeo7aotUF7U4AibX0+NgLnfeKBwVcDcWPCuekIZeILDgB5qtTk63Ku+ckrL6xT
         i5m+eeZWqFi/VWGojwSsfdNRM7l13H7UeiYIkRSrTtRAfeY6ZTcncmoc/Z4qFWPv0r2w
         Mi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649718; x=1776254518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
        b=BRMC6NuDsZ3KyHICgxZAvoyyI98miUX1RDa4Vy+6IAd+/OABJC5H1W2I4WgMyaWP/M
         0MbCGFT154cdOkzDgscsQ9kTvWILQDyYTnsCoKPoOsYS6YkPzHq2Eh7R46LeFBBjubP9
         E0ekUEIL0jPdu7ivUCaBLx5TuArhkJDfcs4ITKREzL6Mr7aOnZf/H0q5+3hPPYGREGhR
         fDYLymSAEclzJL2h3VtpmAvxLsV2neJ8TcS+uqzNMKsiec9VSGbro9y/fxGncJCCUNJu
         RcBOCEHc4XCoLQdV+QcWqJQ1poZLcAzGAHl/kj/3ug/zIJwimpyPEDryrdgV2xi2MvCd
         N7XA==
X-Gm-Message-State: AOJu0YxlOXQBkScWrpvDUrcnfXQ0sErwVTSsdWJSika/yg+hCVhiDOmO
	NWB15f9uSb00FuQHmOsyVZki2fdYJmxwIESAycIB7kI2YRcGa5nDGIsPx5SOMg==
X-Gm-Gg: AeBDievczDM1GwDNaDcLEzkrsxb8the5LEGZ86Y6157+HSlQe6r4xk7P0eo1aTUfxBu
	x1Dwv9mK+HZ+qAoRhtX45Hn50mVlZI3MkUoeCo8xjcn+nCsPR0MRhEL3nQvwxOHzbaifFzHRmkM
	PyJqvl858HAXAZqPv82DxlZEcDD4ELR1BxoFdCHS/DBo9VwMWL79yIqNMHJpZ5MrdvB+FsOaKZ4
	X8Ocvx5T0DD32fUbSwln5AQHPBBhs7w36LOkShRFckHnzuHhPHPU78IGRwjLHwriNEsv3manmSI
	EikYjrtMC0JP4cIOsonKFKPZwzUgYqegBQB/0vTqkvilYnjX4BwK/6HjlrhCr2ZMjH0zWfHstKw
	we3xLI/xZHz+yE0uVGEeOXkbvPCzaLPkvd/k2Wr4GUJ3OZYv7OXufMiuk07CPqFA51rTaZe+M0+
	hDenFTRLpd7E98/I+luXCRw2tSZgWTO378hcCqJg0yPS5n
X-Received: by 2002:a05:6a00:92a9:b0:82c:ed02:a242 with SMTP id d2e1a72fcca58-82d0dc05906mr20919689b3a.52.1775649718138;
        Wed, 08 Apr 2026 05:01:58 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.01.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:01:57 -0700 (PDT)
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
Subject: [RFC v2 01/10] pseries/papr-hvpipe: Fix race with interrupt handler
Date: Wed,  8 Apr 2026 17:31:31 +0530
Message-ID: <54c52b89a626627aa57191b67a3ee22710b46f7f.1775648406.git.ritesh.list@gmail.com>
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


