Return-Path: <linuxppc-dev+bounces-19438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959A9FEEF49
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpYn0ZLbz2yZ3;
	Wed, 08 Apr 2026 00:32:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572333;
	cv=none; b=CUbBq1eeqpHr5wSSHz+bHYy76ZlPZTqhgTAjJdfxu64vTssPm6sbZ+F0+0ZIatNlLSyN7eKzs9JSoIZKT2iumYptWRS4aMYVmh9rDuLxvLrueBsL4T9rm0wUtuf4wQDY1pT9ZAK1TOjI1SLClbs4j9DvizRXKZQy1XGtB8WAXwKxgYLoHWMyuhSvJxiGQv3QfdSYKR2woE8/4/GOrI1OoXZtggT1CHhH88rDFVLd9xH+JfczqRXb0srr8rh2Ii5LSCFuycjr5CcOuQlG/OS6Akqb/CAgYzR0fr4zEEB3L3GELkCz4W18CeoMI4YTDYm7hfnaM4gcLjSrVGFeCotD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572333; c=relaxed/relaxed;
	bh=fS3FVRjX3+s9MHoE+khprd5qCb8Si71RJNdFfwJc+pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGX29nLcPd+nPPSDM3LHvtmoU6w0wosG74IvkFn1f5ZDqMrdfL5P1x/PCeEppI3DpYtGa7MVXfuuDL7cRrzJrEyjIXZMGbO1oKFUQXvRXQb8pNiPPmxLwmr0Tce4ncn4EP4Bl9banvsXyWplC1BYX2sgy5oFHbah2s1jwpjguY5K1sFPmuxD1T7hg8fHeafKC95QhOoH17REeR1JSZuoCPxprIfvfihggTpVbUu3nL4yY6KBd5eOE5iHy9xmbM+V/Q6GkuDFdXHtvBtOJyXZ4ay1btiuabDeA4rzt3/14V8L6kMqlN0CSXOFb15JBVnyIs3QJOLmF9b+OJmWWYLheg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=shJED1kH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=shJED1kH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpYm25DZz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:32:12 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b23f90f53aso46091015ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572329; x=1776177129; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS3FVRjX3+s9MHoE+khprd5qCb8Si71RJNdFfwJc+pc=;
        b=shJED1kHSCbwmduXBYJdGN7s44l7rrj3S/ETodQZlg6ejOVtQRHndDZIwkM0xAQcXq
         H6w/ikymFtD5r4cTBIWVCnEgdTFfz42hO+dNVUxup/WxVevGe6oyRg8staz6Rt5vswmL
         54MsX6599A2ZGmcOWA3F2jZj1dUja4n1gTlMaz/LjUDKk7M3xD20wF8VGLvJIu74Plhb
         7RWjbhochTUpqcU1j3F4DPn41gUUQqqjZQy6TtOc5JUFWU7rRrHiHZxlGQT0PmNXcato
         1kNCcSDviF/y263HxpxmBulnL69PX9EKXRQClkccXEJQN0AyQ2nWSw7Bp5epfndR1rTv
         L5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572329; x=1776177129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fS3FVRjX3+s9MHoE+khprd5qCb8Si71RJNdFfwJc+pc=;
        b=FkMf+U2lMZ0ZvOc4sPnX7lCdIXEUbdsUvuwrQn4bfqnRQ2SRxx9jz/1oyWwzgGgQo8
         W/soavDawXhlXKQn8RxR85it860T4HysLgKx2a2mUTzso2ADrQGR5Wl7mxEIFfv9LLyY
         hZPM3ZEezIvjDlepUepGnMaZPCjFQ2mJh3f1BfRY66mMDiz9e9ho026+80QJYqLQIBr0
         u9bxr9aw8iFgntO5G+o8DE/snlYz6OajxZ4pe5neMgTeqgPF7hGMOdI5uT8jTKa7c4iQ
         E0Ux+U0h3fw3jTX7wJkqJDit/5zIFu71y/xrKWtcEIQHc3ju2TW+sDodrkxqvx7+F3Ty
         RMRg==
X-Gm-Message-State: AOJu0YweLvwHanlX9btvTZywu8paScEc2PutxY2n8xmBMIN49WhMUkAL
	gjkJbXS3VFU7CFFVHDbNCG8jZAbtr4mhiCtWFCAGdhBhK84hePuQ7FjZSMqd6A==
X-Gm-Gg: AeBDietFx0UWkGbr1GsNQxuBwj8qzLbrMMEFtl8YqJEKKIaRK9msdWd6SDudSLqN+B5
	UZQ3DOQXtc+ja0H3yla9IEcut8RaGFjK22YBFUIKxL5dQSRWo/XMnCaJJgxgIzdI8EGcWVsgCWo
	Lc36C9xSXr6jWenmYkg4XNP5CC1yUbTeoTnhkyCDYfKxa4SsqHpyh5Us5NflSsvNYOFH0w1haaS
	J8f71AgWb/fSSY0j/lzOZ0rZSepdbCyq9QE5b3UALbBdDJz7xKKacobZZ7+4BdRzdmcOjn4ZL1a
	3al1vbJZ0Nd+47iVj48Bbv0IdyB5gcf0y+eiKnbul0Di9Dd05LxJGwfjUxcHQazvFk65rpUjhGY
	v9ij9qT8oFOMVY4DvUHjYpoipKV0NQKuE7aoUM8tMHYNjME0pkFMj0RYLPA4My5Pid7Kz0V9Rom
	TgctNudXGCXIQn6VvJPrpvM1NIorRKEm4dK4HGqSN+9NGwpMnUGPkcPa9adGVf
X-Received: by 2002:a17:903:1b70:b0:2b0:bebb:1081 with SMTP id d9443c01a7336-2b281799025mr198432295ad.28.1775572329159;
        Tue, 07 Apr 2026 07:32:09 -0700 (PDT)
Received: from Mac.localdomain.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm181201525ad.78.2026.04.07.07.32.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 07:32:08 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v1 3/6] pseries/papr-hvpipe: Simplify spin_unlock() usage in papr_hvpipe_handle_release
Date: Tue,  7 Apr 2026 20:01:37 +0530
Message-ID: <4217692a276ccae03f764f746e3607757277cbda.1775569027.git.ritesh.list@gmail.com>
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

Once the src_info is removed from the global list, no one can access it.
This simplies the usage of spin_unlock() in papr_hvpipe_handle_release()

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index fffebbae113c..57ec50e3e883 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -455,6 +455,7 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	src_info = file->private_data;
 	list_del(&src_info->list);
 	file->private_data = NULL;
+	spin_unlock(&hvpipe_src_list_lock);
 	/*
 	 * If the pipe for this specific source has any pending
 	 * payload, issue recv HVPIPE RTAS so that pipe will not
@@ -462,10 +463,8 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	 */
 	if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE) {
 		src_info->hvpipe_status = 0;
-		spin_unlock(&hvpipe_src_list_lock);
 		hvpipe_rtas_recv_msg(NULL, 0);
-	} else
-		spin_unlock(&hvpipe_src_list_lock);
+	}
 
 	kfree(src_info);
 	return 0;
-- 
2.39.5


