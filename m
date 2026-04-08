Return-Path: <linuxppc-dev+bounces-19503-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8D9FD5F7A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:02:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMBT1QxDz2ywS;
	Wed, 08 Apr 2026 22:02:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649745;
	cv=none; b=fnP8NyE2CkWKC+dvsrYRIomlkWPng1ceVQpbZ7FRIL/uRNnWoMnExJbI4UzkRFxw8HqsJKyUkO+iXEC+bacYzlgUOL1gN/lvg2oLcTc0fANdOFAthUY77aS54qZZ9PzcBoNe2sXqfC2hHe1lPiwLSEjpl7go9hfyRlhkVHBLH8aKAZ2Vk9BBF3kJRDxLJwAVk2TMnBe9zCYqgTK7nwVoqhKBATgxhXP9pHcLG0ZiwIVnjLyFPtZMXRMnCGAVssnJi09WKwuH+r2kZSZCeZYXX5CInanu46HiUrHwGL+cvwb/OOZoKgdhxYpSSFjMJMScKfrm7jl9ZDbFdNbymhh/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649745; c=relaxed/relaxed;
	bh=SCwuqGPqq1xW71wkNIANtyK3Rl5bXk4EbTq6DUkJUCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3At+9j8i55ufaMemlXpbRF/AQwWkPO2h1N/sFP8QaOzUmr9CdIszUfa4XhcOLWpDxNzsuyUfVSxphEsDN6SpI4sctRtGlKVRuGjhfJ1Jb3HMvTPSof+aZ32YGBEcemoBZmHGeu3iJ79EtVBRexA8Hlqkps0zcdfyv6jrwrQJnxdjA53LPBI49QZSCcjOyL5gdOwTacvGvz5uCwursYUFHYIpzz02OZ8zvky6ydRG68DiZKWmhRde+8CUVmJ4mHYHOnox9KyZ/3udeti0tAauFq5ZfcM9ON5hjAVR9gDZUBIvDUGkfHuKEVLdFymbdhPFhW1JuUPEM6DF4msUNvRAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gT4Qlp9t; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gT4Qlp9t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMBS3t6Lz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:24 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-82cebbdab08so4399251b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649742; x=1776254542; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCwuqGPqq1xW71wkNIANtyK3Rl5bXk4EbTq6DUkJUCM=;
        b=gT4Qlp9tttlq9//QlEbAmVWh/wcdCTEv8UFcf0TREQ72UrH/CGa0R/QoGpwvl/XkoT
         uBdjFiD1sdGfpKtmhn98fWV+0LGAWg6IvjaK8O6LmKd4rla/19I7ht4N7900PpqcR8rm
         d/Bv4dtI6Vmp1UVpBluA4NMY/u0GHGaoiBRfEgvexq2KPCWhhg1PQm0taBosL2msruie
         f4oDBkwjSzRuS+Z2+dhMP9UT3dsgu/AQh/EXNhFKPYyUfsMO1CPBhBKLGRImvCaIiy87
         BPtpsRYPvYJd15V2ZZoFZmFN/1+Tl15+VL3F/q/gaH/cK+w+tQdHkwj8XCu4W+eL+8zj
         Fy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649742; x=1776254542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SCwuqGPqq1xW71wkNIANtyK3Rl5bXk4EbTq6DUkJUCM=;
        b=jK6w3+lsDJblYssZbe28zfs3ENhwbLx99Sro+km4/QX6A4FLCNkbKyJdL3qQvReltt
         dN8E4WjAzsbipW6mapyNXEVAIQ3vg1iJPs8H97WvGjhIXOFxvGDeJA+/iBpwIWsUbL8d
         KumWKESkcB630iYim40pFnqfz9kiHvSciQ/1cTio6l3BzekINgQxVHCF2MaxvunmCWdy
         JpMkIKzgu+gaBUrYDAdiy4/mE3fA62Ty0oKHTOu6fdf+J0Sax9Z55xMXvmkZjKUVq1iM
         BrQWzPPNpY8DkQiPJ8QgLgNe1Z6EcmPXv+mvP5YAdwn5NHmfbCZl9WZ1t6gLW4qGaKnp
         yZVw==
X-Gm-Message-State: AOJu0Yy/d+uuM/PFI/os6IshoC1RPY1OpUgtKyD//4e0sJVFx3GHncLK
	ujV+2UfLTwoCPk48xmmrL9jb65VMZFNUplZPPBsohFhswH4bY4vdnJy41HLUdQ==
X-Gm-Gg: AeBDieuK9FtuzYnDDfV2e4yaIWYNBWwQwT0YXaGPBNv6rGS+KQbsmT08nQsW0G9DfAi
	VDKdisplTdSvmxRyJ+wFkod9lTRJWHM2Ro0uaHNqEN0JmhtfrutitA/QwhNYhvtXCrxqdzfQlca
	TJb5HZp9cuK13M6vG23yB6HyHsDiDaOXhtTRCD94o3+vI8K0mPObxONjg1DrwhEU/38G34VO+0Q
	hP3NdYhRCvImtdPC2Cv1dccGLJEPKU5X1RVPRbQ7R/DAIc2iM9eFZIYocKBjxnqKVJSUcoLZO35
	J9Zv96PlHViobdua19/Lxm3fwFiGe7N2+PxkEag78fdp+dLdGW5xM+CPT5oQ312uDZYfJKUtB+h
	OmzXEvTp+V8EzOlc7B3MD3Sdfm1fexvfVRS2SPI0D29N4ABZ3GSA0AT3Oj0ayHz/jpV0//QDIvH
	f8Lc8jitJb7mgxQx09QWUgxVqGEfjnuEuqDqf/9v3c6cJU
X-Received: by 2002:a05:6a00:8e09:b0:827:3e19:574a with SMTP id d2e1a72fcca58-82d0db97457mr21444881b3a.42.1775649741673;
        Wed, 08 Apr 2026 05:02:21 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.02.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:20 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 07/10] pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
Date: Wed,  8 Apr 2026 17:31:37 +0530
Message-ID: <78feef3c4670f9de041e7e835b4451d42eb2d39a.1775648406.git.ritesh.list@gmail.com>
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

Simplify hvpipe_rtas_recv_msg() by removing three levels of nesting...
if (!ret)
    if (buf)
	if (size < bytes_written)
... this refactoring of the function bails out to "out:" label first, in case
of any error. This simplifies the init flow.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 52 ++++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 41958ed8ee97..ac2c4b42b373 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -190,34 +190,34 @@ static int hvpipe_rtas_recv_msg(char __user *buf, int size)
 		return -ENOMEM;
 	}

-	ret = rtas_ibm_receive_hvpipe_msg(work_area, &srcID,
-					&bytes_written);
-	if (!ret) {
-		/*
-		 * Recv HVPIPE RTAS is successful.
-		 * When releasing FD or no one is waiting on the
-		 * specific source, issue recv HVPIPE RTAS call
-		 * so that pipe is not blocked - this func is called
-		 * with NULL buf.
-		 */
-		if (buf) {
-			if (size < bytes_written) {
-				pr_err("Received the payload size = %d, but the buffer size = %d\n",
-					bytes_written, size);
-				bytes_written = size;
-			}
-			if (copy_to_user(buf,
-					rtas_work_area_raw_buf(work_area),
-					bytes_written))
-				ret = -EFAULT;
-			else
-				ret = bytes_written;
-		}
-	} else {
-		pr_err("ibm,receive-hvpipe-msg failed with %d\n",
-				ret);
+	/*
+	 * Recv HVPIPE RTAS is successful.
+	 * When releasing FD or no one is waiting on the
+	 * specific source, issue recv HVPIPE RTAS call
+	 * so that pipe is not blocked - this func is called
+	 * with NULL buf.
+	 */
+	ret = rtas_ibm_receive_hvpipe_msg(work_area, &srcID, &bytes_written);
+	if (ret) {
+		pr_err("ibm,receive-hvpipe-msg failed with %d\n", ret);
+		goto out;
 	}

+	if (!buf)
+		goto out;
+
+	if (size < bytes_written) {
+		pr_err("Received the payload size = %d, but the buffer size = %d\n",
+				bytes_written, size);
+		bytes_written = size;
+	}
+
+	if (copy_to_user(buf, rtas_work_area_raw_buf(work_area), bytes_written))
+		ret = -EFAULT;
+	else
+		ret = bytes_written;
+
+out:
 	rtas_work_area_free(work_area);
 	return ret;
 }
--
2.39.5


