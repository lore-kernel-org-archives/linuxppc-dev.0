Return-Path: <linuxppc-dev+bounces-19506-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C605E1073CA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:03:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMBj4fFPz2ynC;
	Wed, 08 Apr 2026 22:02:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649757;
	cv=none; b=dTDwJ3biuYdb5BRLW6QcqeS4E2yfkPPnmGR7fjdmwlvxAZsClnRiOVh95lu/z6YhNgVoxIjrY8hHpqRQfWodLeFxhI4GI0EfE5Ooy8fOCt5giham42Var3Uwx+nNy40WJIc+0NE2046PmTejw8FnyoBZ6XtFFy32YqGBftPLjg/YeikYUjT0Y+L/EKzCl0V+ZQ26dgJIKKDCt31WZKYXwsOXI6/NIBr++gIOsAVxsDqXErkeFcwAdjLz3u9mUsJTOAKC56M+8TmtFweB5XqFe8rZLdCfh3DrP+Ll3VtSxV4sIIkRaBfbLBGH4RdQArtZPZD3OKgOs8P7K9JiVxfv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649757; c=relaxed/relaxed;
	bh=HxF/5xyzxh7moQ/DzCaZduABbVHgNK2NM9rE5Y5cP+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEbfegJvE4WWHWZ9Gm8659fAJbYIF3K0+Oyz0pMTQswe2eiXEM6H+90HVLEoJyUX/Mi0v6mnqE505o+XPrYPcY/K/nVuTLJgkz/8azYi31uOnOSsHbaJtf7qvENS3FkmNWOuf6XFlPL5htas2r8Pp4GxlSKeZzR1eIKXhH6Rm+xEJBKiP+N3TS6UtWGfUHygTNIF3ig348guK9FzqQic+P4Evh6AapsTxkrQBHIrwiuqDYRqBj7wXu76y3pvfYpWdiP0mSfyXFlcKva4is9pglGOC9kJ1iBRtuoDUe3oCz7z6ijua0TUxH955Z8w+7TEPlBuxlPyxwyD8XRpPKpljA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KfiDg+te; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KfiDg+te;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMBh6qP1z2yks
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:36 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so2614497b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649754; x=1776254554; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxF/5xyzxh7moQ/DzCaZduABbVHgNK2NM9rE5Y5cP+w=;
        b=KfiDg+tesd6WxK95pRwbFLCorVmvKrr+btHt4550DB+G9A9nfquPO9/j2nbIn8TBvI
         fF8kk8Tuagq4UqaaBh/BOruU8Glcyt3R6vI0InCuo/P70cw+G23C1XyUNyYikzcLwjAe
         b7eIye+Xl98JxSzDfjQi/0TXTu8MV216gpmeGAFwD1FbEFZP9yR84RRHKNnld8cByVTE
         kr3wtRPJ54/Z8oT67TlpQUvRX08gLADl+1jSsdcZffwRTh6VMEZWq/rM5W9W70/j8Aih
         dZAC03U88iZ8HhXDiDyXpP+HNQxg2P5M9w0VBSgAw5ZVMz2w7Drm8kilRmmJaTaCF+EC
         DNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649754; x=1776254554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HxF/5xyzxh7moQ/DzCaZduABbVHgNK2NM9rE5Y5cP+w=;
        b=ZUZ4Mu33kwSeF4oMYzt+Q3yC8LIJ0G7Xfplt3YckTRZZ3Pk3gn2d0nl0PwjWAfgVKq
         ue0pFFkv2UUjwylTTw9aw+EoT+lRVoT0ZIrAWp5BbH7mMDOvaid0uT9fwwGUZbSp4nUy
         qUUbVIYfJ1LHRM1Cpkx6k+JfWrgbUIyM33zD8z44liUCHP1MYwkxLteqKvdA6tRHXbuN
         uuJXkt1zFNTaS6c+tMUUDpzZWlO8keuasCfoDo/qjRkXnncViSOfRrgzVCyIsd+aJMli
         BIS7ZE0aKB6YUNB4XehxlDqEPm01BNZMEV0A8q5HZaTNQRiMRItPd4TPZgntcSZkYl7n
         HifQ==
X-Gm-Message-State: AOJu0YzH7ZGFLNGHLN7m26PsB6jXcJwUOc0R6s4asDagt6/Ze53kAp07
	YJXF8HltgeFEXB3+b7Racqidc7v7tD3HTHLOU7EleE1hYs3Vcv8niemncd+Aug==
X-Gm-Gg: AeBDiesPbtL6PCVMeym04kNtyMXDFC3RD0ua0mrzewVC9BMTmqhdKSr6GnhcsgfBVQ3
	ujEpCKE1O8KEDdYx2PtOLufIz7v397nLhc9fvyKZcCj0tjzgP9dqoM9WDomLBWiRMrGmg5vfz7N
	Q31/QpTZPM7MBHHq+GdO6kEye7s2KZpE9bEEcnYQqeD6MLOhOYk5OaB2MtzITbKHeNLw3/ogD+x
	3m/6fpsoio/kCIvWKDdZnVfiADC6dkC+hak3ko1LPBIBl1HO9IGXTbmxdidlAAo9ik65RGY8hkh
	IC8gTS4LuWgOw86gWukAUWmxTjEGFFlW0n1rsayxX05QcxPAya4/hg//LVKmKuNwKJfFVbDRSpX
	3oYI76Znp+h+8QQcBQCDwRfwDEoPaZof1K1xOg5NoFY1AsGV819lERyLL5lazx90z5mfGMhkOlM
	AVwQy6ocrPJ6mtfBDKsfWl5kd5pH2z2zr7g1SglShmZiDfxUvbACh/oMY=
X-Received: by 2002:a05:6a00:3e12:b0:82c:7876:a03e with SMTP id d2e1a72fcca58-82d0da8f384mr20097042b3a.17.1775649754432;
        Wed, 08 Apr 2026 05:02:34 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.02.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:33 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 10/10] pseries/papr-hvpipe: Fix error handling in case of init routine fails
Date: Wed,  8 Apr 2026 17:31:40 +0530
Message-ID: <3ff4de80fce72914eff23a169c974786858517e1.1775648406.git.ritesh.list@gmail.com>
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

We have already enabled interrupt sources and enabled hvpipe to received
interrupts, if misc_register() fails, we will destroy the workqueue, but
the HMC might send us a msg via hvpipe which will call, queue work on
the workqueue which might be destroyed.

So instead, let's reverse the order of enabling set_hvpipe_sys_param(1)
and in case of an error let's remove the misc dev by calling
misc_deregister().

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index c708869ca732..b6d0b36915c6 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -785,18 +785,20 @@ static int __init papr_hvpipe_init(void)
 	if (ret)
 		goto out_wq;

-	ret = set_hvpipe_sys_param(1);
+	ret = misc_register(&papr_hvpipe_dev);
 	if (ret)
 		goto out_wq;

-	ret = misc_register(&papr_hvpipe_dev);
+	ret = set_hvpipe_sys_param(1);
 	if (ret)
-		goto out_wq;
+		goto out_misc;

 	pr_info("hvpipe feature is enabled\n");
 	hvpipe_feature = true;
 	return 0;

+out_misc:
+	misc_deregister(&papr_hvpipe_dev);
 out_wq:
 	destroy_workqueue(papr_hvpipe_wq);
 out:
--
2.39.5


