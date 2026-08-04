Return-Path: <linuxppc-dev+bounces-25396-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AD9C55838
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 23:21:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF8g13kP8z3054;
	Wed, 05 Aug 2026 09:21:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785873333;
	cv=none; b=ezObqP2Zuzd0nrfA8J5HqECkadu15370fonnZZ6436Cvdfpce1OAZ4rK3+oX80cyE2KnugQYwOLk+fjEcWWoxJEO1ok6Nugb243GQpWpkr14+0LDHWmgfKZ4VihHahzhmyJueeSbPA/JwUsavGtwRGw2hrYdMtL7PYYruX7nM1HIeYFM3ebtcqqSUtzCLG1PaLH1gbC+5oVsf9ffIyDHVYx6UmyIccUNCsrO5uPyaQVebJkZn9su4/9cG9N7o8Jr8y0dojNBMmpo2MJQOyjskynYxEcVPjmZeh08v9nNHYSh9oQv2Z19eg+4KGhVV713DrtuvSBdkG/tjGCkDeFBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785873333; c=relaxed/relaxed;
	bh=fkPLBFFBu5YlJOOvUQnGQewzqBSLsCWqPU9nyPRdcoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RZf/elylRuEq1Up0KFiTlc9ppsXwCFFhFwLNZzMXtxtyp4GjgBm/MvqeQkNy4dOdO0PX/7rzfyFs8s6NFpxUtdRo9wVK5iIQq6Pef4ZMjM3brECO25Nhgc5VRVpRYc2vjrMcyCX0zjcriojADwYPFDhCi15yykuYZ0uLqIwvoEDEO9fmE+R1ROacOmUK5XfaPGNtek11AxVOH3VeuUIL1aJTpxJjbcq9SYEwH/l1QFGFt6oyfD93WkJuPBcykS9c3/IkvHMVoeZetGeNg99GfqAW/IBmyDCxvuAJs3WTYtJRXv7lAbiGJ1t5tk6WHeQepnvi1r2hHV1Q0xlpaaT+7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oFx2t90T; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=michail.tatas@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oFx2t90T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=michail.tatas@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF45v2Pbdz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 05:55:30 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-496b7622a83so1247345e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785873326; x=1786478126; darn=lists.ozlabs.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkPLBFFBu5YlJOOvUQnGQewzqBSLsCWqPU9nyPRdcoU=;
        b=oFx2t90T9sVmRvzUwA4/xOYeE/oWDtAyCURyM9FS/EDQsAvXJCpvOOB/gqdYsRXgxC
         Iv8hZ8tB3SxFte2YYzg9pHExwxTvW3wly2eRhBsQe3kRrh5ZsbiU3JUZi5/6V9oRfIgf
         Ww2UAPOwldiNm3VjwpaZD82qnWREi7YPBuxBqgdQWFzT5YKB3miQC7GyKrPGBU5HWGzV
         n2/l9rZsGcV8laBV4iTxQ8ZMBYue9pWOPUXg0IEbiuc5kSRjXKCu7HagCkkjoggZOAEm
         64PWI5lmAlaAQBaXLUudzncAGElnCMabNdBNKgO9mtXjJrc4veCKFClmvBwSQz+Iv3LO
         01Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873326; x=1786478126;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkPLBFFBu5YlJOOvUQnGQewzqBSLsCWqPU9nyPRdcoU=;
        b=kt0B6wS0G9hxpN1mHaVKoantHkppVjTvxcUDKBo45xhF8BkGCaSF7655XwdefJVo3s
         n2YNv/B33YWGuwcjMDK600pvSKQlauLrd9ZBX+nYIZUBPUuDIGIw1mRUheQRem59sEUm
         xKiS3IvX+ObLPnVcE/YdqNVetZY1sl5iQJlAB8+KO9OMETaC9rJL5v6ABTBTP2+8a8Ct
         WF3YlOjrDdvnmrDHHwCHo41BaqstqrYGpVJnwENSLpCq9ykncHjYXIwLj/L2OtcgqV1y
         8D6E6mK8/ssxSriqCZCTbw8m0PAmeUKbXgihV+teB2pueU8gyC7bY60cXl/mMRZgM0hI
         h5dA==
X-Gm-Message-State: AOJu0YxSEyBu4dblKHqmXloO6+oTT/U2VTU/G7CK2V6cKAt4IcjdQpkP
	4fWh1UqhYTQ6BTjbRiWgska99f/6lji3T32SpwuLj9ZSsYBbpe8f+7kY
X-Gm-Gg: AR+sD10Si8UYKwEUQN69rpk3ca6S5ZWL6cI6Rnmj9EyxcVQrMu0xnN8CtMJ1M009jj0
	NAZhBnajnre523mcaRPNbg66u78OwO15B+X25XI+7ytHODdKtKynegc4+EbCVcUr1tidGR0wBB5
	+wkQoTwzCX8Rj+3Z3crL/P6hWr22AO8Gl50vgFXFsOwyISKv+/SqEE/GS1rhMEZPcD8Tc8dVjsC
	5qn0AEvQE9LloEJ9qISNxNUHsBdjAHE2I1dLrFsFMOAHdq5hrjKHzAKTSe4GQugJjyBDF8NIOQW
	ugkEI7AzqKSUifEx3Jyw5+3nmO41OhcWZehS68w1Fq8K5KopFgK2CQqC4Fzk5FHA6eyKUh9aEa4
	O/8zjw5iB9k+mYjWsd6bf9aMLZExPDfMZwK4TEfFwlJOveKkKa4MBu6Lg8l4JhAirCe3vNtzH8F
	wj+Vpbu/Tgo0GRLGnqpM9to9yrv/FYpFQW8L6THc+SpLXTc0X84lbockNJm9klZ2zJFgO+mnccW
	KR6JrBVv0uOixOn96bveU/1
X-Received: by 2002:a05:600c:12c8:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-4994e7baae6mr5923955e9.10.1785873326056;
        Tue, 04 Aug 2026 12:55:26 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm29898965e9.15.2026.08.04.12.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:55:25 -0700 (PDT)
Date: Tue, 4 Aug 2026 22:55:23 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, chleroy@kernel.org,
	atrajeev@linux.ibm.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries/htmdump: Fix leak in htmdump_init_debugfs
Message-ID: <anJDq-JckR6j-6EJ@michalis-linux>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If any allocation fails during init all previous allocations are
leaked and the debugfs directory is left.
Fix by freeing the allocations that have already happened and also
remove the directory that has been created.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 arch/powerpc/platforms/pseries/htmdump.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/htmdump.c b/arch/powerpc/platforms/pseries/htmdump.c
index 489a80e87082..f33941b80ada 100644
--- a/arch/powerpc/platforms/pseries/htmdump.c
+++ b/arch/powerpc/platforms/pseries/htmdump.c
@@ -527,28 +527,28 @@ static int htmdump_init_debugfs(void)
 	htm_status_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!htm_status_buf) {
 		pr_err("Failed to allocate htmstatus buf\n");
-		return -ENOMEM;
+		goto htm_status_buf_err;
 	}
 
 	/* Debugfs interface file to present System Processor Configuration */
 	htm_info_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!htm_info_buf) {
 		pr_err("Failed to allocate htm info buf\n");
-		return -ENOMEM;
+		goto htm_info_buf_err;
 	}
 
 	/* Debugfs interface file to present HTM capabilities */
 	htm_caps_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!htm_caps_buf) {
 		pr_err("Failed to allocate htm caps buf\n");
-		return -ENOMEM;
+		goto htm_caps_buf_err;
 	}
 
 	/* Memory to present HTM system memory configuration */
 	htm_mem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!htm_mem_buf) {
 		pr_err("Failed to allocate htm mem buf\n");
-		return -ENOMEM;
+		goto htm_mem_buf_err;
 	}
 
 	debugfs_create_file("htmstatus", 0400, htmdump_debugfs_dir, htm_status_buf, &htmstatus_fops);
@@ -557,6 +557,17 @@ static int htmdump_init_debugfs(void)
 	debugfs_create_file("htmsystem_mem", 0400, htmdump_debugfs_dir, htm_mem_buf, &htmsystem_mem_fops);
 
 	return 0;
+
+htm_mem_buf_err:
+	kfree(htm_caps_buf);
+htm_caps_buf_err:
+	kfree(htm_info_buf);
+htm_info_buf_err:
+	kfree(htm_status_buf);
+htm_status_buf_err:
+	debugfs_remove_recursive(htmdump_debugfs_dir);
+	kfree(htm_buf);
+	return -ENOMEM;
 }
 
 static int __init htmdump_init(void)
-- 
2.43.0


