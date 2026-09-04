Return-Path: <linuxppc-dev+bounces-26592-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2FDC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:10:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNHF20c3z2yvP;
	Sat, 05 Sep 2026 16:10:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788525958;
	cv=none; b=mJ2b3ufITDfRYbjt6ncXz9pJjJdT+2kkSFvjfIrWnftm2BSjqutzERhW4JH8XjrFx7Pu3bkCJpYZ2MrKtSE0dAxHuH1lv9SM2uKJlpaN2JZ+erSJRus6CY8Xsuu6ZuHpODJQyDC/a16mHipkVam8UKgKow8kI+qxy4FJ1gtt2Fd1GVxmbd84tFpeHexYh1ra1OJwfhZjJUmxo4vo34+pL+JZ/o+g8tlujVERcf2VxwDKnB4iuthYIcPOhBbz+xXipDYurBl7j5lwGxiI1oZ0HkM3SRINUV9mRfjP5lGkkDdM+utUM7JHeAn+O4oCV6FGgkGWtYREJB1fO+D/A7jQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788525958; c=relaxed/relaxed;
	bh=5CKWYHFFj2+Ay68a1spLAYVC7QQVQgeLpgvyjnrg6qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBW5xVp5e8quvlpls6EHmShdBxbMwO6Hp9l/xKUeAKF5Wodv51s2XXrEmYv7r8hlvhZMoKw+Jj6GTOtyUdS8tnwyLLMzOH1/fMxNDpeJO/8r9X6XITBbLZkxUmeA743fZgMc0ozI1QOD6/n7Quyxu2gzafgrRWgQFkIZfmskjMN5hsnRMQzKQlfreH8Hr/caRULeeGPMKcz0Huohi1IWwegXEwrFedq7rCVOK18Nocl9fxwl0s49n1vtLbQLzC/i/3TUf2zgbTZ/G6qyyxU+hFvg2nD3eeX/XYNEIWCviZMOkYWOgfKun+rqOE4uWl9trTU2jy7nqutcXZlePwLHBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HHsXjjVU; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HHsXjjVU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbx5x1fKFz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 22:45:57 +1000 (AEST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-43b7e186a0cso491146fac.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525954; x=1789130754; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CKWYHFFj2+Ay68a1spLAYVC7QQVQgeLpgvyjnrg6qw=;
        b=HHsXjjVU9SFlbChyYu84Fm4fm5nLSXIvuWhlhxM3q1A5UhkDWS8jQrhFxpQsPCQ1nV
         iU/vuMlTk4uLSiBzQhsDOyL7Ppb/VZiK1/IcKNd89DD/3dSq9Bc6MftTAmPcN3o9e2by
         3lUhVeKCYmIYwmTAE9R/okyQWPPWiez2aqcQnTMTR5lS30oTZHxPWDd74w68pfxq2OVf
         +BE/HFvyBUY8GuVtVJlWiWBVWXxL56FvIWlXNb92hN8X4WMP5qxhWn7rngSvbZi+YCVW
         BNfW19hYFot8CuD1Y6XLZIhpBcgm9Vwt5pZK6tVEWDukujWUiMBltzp1pAj0pqKgFH23
         P/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525954; x=1789130754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5CKWYHFFj2+Ay68a1spLAYVC7QQVQgeLpgvyjnrg6qw=;
        b=RCrsG6adVoewSMDsLrin9Is6HkXwRz1h8ZSKCVNpHsUycfiKTGwFUEnoolNp7hh9kA
         90XL0f8pDvrBZl3ClvMZgqosxC1lT+SvwbLJxaEIqrk76r0GSm4LFx9puFhDjAzWztvQ
         kTTri++pU2wetbJ9LwU/g2ORKCgDg6Kp3AJJ+yUnzwq5M/wCb+nUlqn8JPfG5QXQXlxP
         qEJvlJZVPrQDOVC76838G48QNbTxAj7QGwEt1FoIev8m5XR1NZOA9jwnPJYuoi0rkWFm
         gp1iLnl7B8PRFJyaNzjtLGtbsPMJqHMBvxyjeJYveSnkWaTnDJNBVE1sURbr7BnDc5ic
         znRA==
X-Forwarded-Encrypted: i=1; AKwUvBwjMuYRCUdl40AJOEDZVqZ9qPTB5ltyO1uCXf4Uv5FuKmrvgMQQiYKE5iAZUlVsodFLGQlz0BUDKpeqDHM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lTb/9J2q4YbuQAGgaK6rbmIrh87+qTPKhEKkaQKBRXJYue8yHp
	MiY562SwoCktOqv4S5HHDwoLX4+1a128rmgPGRFEiFK0R4PL+UVBjtgnkihEi/cPynI=
X-Gm-Gg: AYBFou0RFO/T4SDWGfiXQXlYzf02fPwUzZvV0ZhKmZGpVCOvGIQvIm7Lwh/oFYW4HCw
	8O9SY9tezZQEyhijzLWLg7aLRo3XifHma+jmqet85AjKL7sERVWgsMs4sB9w47pHSB/ZIu7AqhP
	Q0Fp1tfvm9X9dsHX7YnkDXzpZNOBDpbBYgsgOHtUn5zBEgcCL5iVouLM9KfdPnldzQv+aJXPz7/
	59zwUItxrHIMs1KhVnqvOmWd11Ne0AfzRAPHH833wkTCNeGqMZpJ75jU+BNzqL6HbcIC+tQ2f/W
	/k7SCxUcY8Nds7w3LSs55UL6ZqtS2BE3aJbPIjNqWhi1U7wBUQQWzoSadriLb7/EjSBHCHRWR5f
	aS3vHJFVXtncnvzu8PI/dtvGxJsxAMxwIjftThChPQvbq9xu8+5cdDq2waAxTffdIi6B/X/3WfM
	Ri8PbilofBwJEe2NOb1KTRN/VgnGfzX4c8Da5HMx072Ho4NHY4g05k5kxSXjOERIDAMulq3zqj7
	6/aNCQrKbeTEMs=
X-Received: by 2002:a05:6820:858e:20b0:6b7:e065:c4f9 with SMTP id 006d021491bc7-6b7e065c573mr613694eaf.57.1788525954014;
        Fri, 04 Sep 2026 05:45:54 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm6477419c88.13.2026.09.04.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:45:53 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] macintosh: fix repeated word 'up' in comment
Date: Fri,  4 Sep 2026 18:15:37 +0530
Message-ID: <20260904124540.7652-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904124540.7652-1-hemanth.selam@gmail.com>
References: <20260904124540.7652-1-hemanth.selam@gmail.com>
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

Drop the second 'up', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/macintosh/mediabay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 36070c6586d1..c5115b88beb6 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -331,7 +331,7 @@ static void keylargo_mb_un_reset_ide(struct media_bay_info* bay)
 
 static inline void set_mb_power(struct media_bay_info* bay, int onoff)
 {
-	/* Power up up and assert the bay reset line */
+	/* Power up and assert the bay reset line */
 	if (onoff) {
 		bay->ops->power(bay, 1);
 		bay->state = mb_powering_up;
-- 
2.48.1


