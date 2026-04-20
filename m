Return-Path: <linuxppc-dev+bounces-19846-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464A1F557F8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 09:39:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzgRj5pjXz2yqT;
	Mon, 20 Apr 2026 19:39:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776677953;
	cv=none; b=okZOCNaal8OBVP0Soe4xNnP3LiUHIoJG9hEYnT69Y2xBVnTHIxHoZor2Xfy6KCt0eah24jAhT7Ev3c58K/knNQ6+QmzWHDZH584iMS/gvD/BwP3AZX9bb9zhzBVudMjuKOlYYPr2Md2XPnH5SRhoglxPLZo7C1/WT1b4uOpLvLeG0f0LiWSsEzzuzgjChcFBiSfWL2/Cq+8K7odd3W3ntVIeDlX+Re05Uc2nQT2ThVU0BVOW7CvVZQLmOJ9K3vQS/F0y3QxWhUFdMznwwkiCangixjXBATqqeNIN3EHR8Hx9GEecYo45C/BBKXC5u5UiR1nAM4q3Hc0NwemdvZqmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776677953; c=relaxed/relaxed;
	bh=KCVZolkJ/jGGZ3sp1HB4+a9dT+5CyB5mH+bc98lNAj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WL0tv78ZSBs9tOE8dWAYFS89jUjDOKZxgxoWSE5CxXeuR8klUTgZO+0yBW4r8x8uCu9mwWa8Hz280j2dCt7cVZIhyASOlKfbXpd7KnjXZtB5QOp5M7MCK8QYFSRPsKfZbR0g7sjnNpgcILw8q6nc/d7nYm0CT9kJLigoL7qjb0rB0JSzBPeVZXFFLK9g3+uqXWzDUCqU8CeZvtguzq2yILr+y7oQf6cSv35HQXqilY7ErII12k/aQeO+Tokes7XsNH73VOyUHhgVnOdgT22xIE8T3IuirzsmX58q8c0LmKIFmJ1h3j9+vPoXC55IADgxAoUHMkc67wTodDzm3lWWxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q448WtmU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q448WtmU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzgRg53twz2ynn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 19:39:10 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c736261ee8dso918655a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776677948; x=1777282748; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCVZolkJ/jGGZ3sp1HB4+a9dT+5CyB5mH+bc98lNAj8=;
        b=q448WtmUcdboHoDAwPeyv+tliQ6CZMK/5WKuSLASFvn2lvvyG5Tfm22haGV/YE2s+M
         DpQBMIWpxSuI3Baksb5VszWEHp8SxsI7Y1O8ynUFsZCGTWVQ1STj0ja1lOfEsQiYqRBh
         t9IOMLd0qkxaW1ANMmqQ/Kz4DYhTrzWQX/xvWUuOJBX0Mb3aBnkz4s8WB7WdfQltl7ly
         UosMNbi8c6tqyNYWppKYzmoPyDIerbJvcVsg0RKCwi4nv/uyUb54nspWRjjxblObNKIQ
         rEhuNnrwKATbrZT/BK0RQDeIOB36BeVT0jEM9fou3cG9Lmy1PG8jvgSAiXJ89SbpS2Tb
         mOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677948; x=1777282748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCVZolkJ/jGGZ3sp1HB4+a9dT+5CyB5mH+bc98lNAj8=;
        b=qse/NaGxCLNE/8/xMc7KYOo13UpvbiY3NH3c+9CxSy3QqIOsdyv2sp/CiKPWoLQW1p
         1sJfloMSnovjmyTxGgLFQyLqFRUOZYVzqSg6XeZiIzjJQMZDn6FgQX2wMlT2pXnBLI0T
         7iixTsf3YPUwkYWu/0jQ2J9jcl7bWkSVI80cCirB37lckBO9/8lT5+3QQIGQrCWY1JL0
         vr3aYv9e4YAHnRbNXKnNa5ASRDfCzKoVOxdSY/yculW37uB/ir+19Sgl59FLaQsMiRAC
         RaR4SI19kpYQ5Jcubsg/PLFxWCekIWvTQ25jBepxv1cHWPLPVQ2PqMv4crC8aQc38WdY
         nNug==
X-Forwarded-Encrypted: i=1; AFNElJ98Hv7Qv9IBlSM085UKpRnm+ZmkptzPom9tA0DU172xmvYze6Ic7pzpoPIEM7iTb8DsuKZhzRCA6Lc6Src=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbDULiSa5pXpkD1TAdQBPabSIvQ6hCYhJ3EiewlpsjX3q7KlC5
	uasfCKd10izkv7OkB+u65RKekHu84X5arhQGAzJJ8ZbrNgS4TIHGAmuA
X-Gm-Gg: AeBDieshD3zFmh+k3VzGvBYCtP6VJ0aVl7PU8ZBBb9p5yS1lnzmWwUT/aB2m5NK41pQ
	daqjNFD3OrAad4uquqOTnnrp8ZTRaamI+5QBumWwsNNsd3KHH1Wg0qpWlVBDFrQ9Dl5u+4DkVPB
	zkfzK5r7RWaxZ8VPA1oMJSVV7SH4VnEUS3Rn9CxASd5z+zKSeIJvzLxAnF49FsWOMFEGpRyBA9j
	gE2KTUOZcUcxLG2ljL1JAUlEOQqnOgZ75j+wGOu7nEUSJzjTe8k16oLJidizYNJhHFG7d8sXZgT
	qnKEPgSvXDO8VHhJRREkSYWeo2WIEB1ZkbfMZ4QngdKY+TeSdGGPEhV5GbvP0p+Jgq4LgNxbuM2
	TPkldpd2ox2ThLVx9J2FSIbzeotT4K25ukbn7rY+Dc8V4gy0Gzx9UmY1+2LuCIUyA1mpcISYeRh
	UvrgeDA41ZA6s3hJ5u+tW1iFHLfZ9clr/U
X-Received: by 2002:a05:6a00:340e:b0:82a:fc5:fb81 with SMTP id d2e1a72fcca58-82f8c7d109emr13729867b3a.5.1776677947512;
        Mon, 20 Apr 2026 02:39:07 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:2038:6723:d0d:eba3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb33fcsm9681407b3a.33.2026.04.20.02.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:39:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries/papr-hvpipe: fix NULL dereference in handle creation
Date: Mon, 20 Apr 2026 17:38:56 +0800
Message-ID: <20260420093856.123681-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

papr_hvpipe_dev_create_handle() transfers ownership of src_info with
retain_and_null_ptr(src_info) after anon_inode_getfile() succeeds.
However, retain_and_null_ptr() clears src_info immediately, and the
function then still dereferences src_info in the subsequent list_add().

Store the transferred pointer in a separate variable and use that for
the list insertion.

Manually identified during code review.

Fixes: 6d3789d347a7af5c4b0b2da3af47b8d9da607ab2 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..497eb967611b 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -480,6 +480,7 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
 	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	struct hvpipe_source_info *owned_src_info;
 
 	spin_lock(&hvpipe_src_list_lock);
 	/*
@@ -509,7 +510,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	if (fdf.err)
 		return fdf.err;
 
-	retain_and_null_ptr(src_info);
+	owned_src_info = retain_and_null_ptr(src_info);
 	spin_lock(&hvpipe_src_list_lock);
 	/*
 	 * If two processes are executing ioctl() for the same
@@ -520,7 +521,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		spin_unlock(&hvpipe_src_list_lock);
 		return -EALREADY;
 	}
-	list_add(&src_info->list, &hvpipe_src_list);
+	list_add(&owned_src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
 	return fd_publish(fdf);
 }
-- 
2.43.0


