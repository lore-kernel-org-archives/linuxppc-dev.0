Return-Path: <SRS0=PnYa=YZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7877FCA9ECF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 09:00:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A89204FD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 09:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZrEKSkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A89204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 474GNY5zBqzF6gD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 19:59:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NZrEKSkQ"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474GHc4WMwzF6bW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2019 19:55:40 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id e3so1964824plt.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Nov 2019 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wTe2jzZ8R5C+A7bVGiXkR++ypRHCxkGsElzUH7oK6WI=;
 b=NZrEKSkQ7vqNdDUZAM6O3MdculHOtRdiOZ+SxhzugpGiKEoetCu9ZgOUbwFsvqn60F
 bjUh8Vy+kTANqO1WMGgPoi199C8CQ/AGBDkrSuMTPhpChzLGwqqEC6T1HrMoHnTkpKov
 l8RTjMDWQ31q6Nu/LMWANCD9L3KNcm0bb2Nr0Dv6hH25R7zQR6k1RHwsI2Fz6U9ldkLz
 hFlGWQF3wggHU0dMVZeB0JWUsHjkSIzPvnxtpo/Mivn1vLJYHhulQEF5ZpNvxAxTbWdI
 YKxWV3Iuwk7l2r7L+TQjfcPhfwIkD48ENgpHdQa3o0UxLpfcmv22ZVFaq51yt4Gj4nIi
 yrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wTe2jzZ8R5C+A7bVGiXkR++ypRHCxkGsElzUH7oK6WI=;
 b=uAVq1rQHyeQFN2krZapB1l3pUl5WzGPRShK/QaCucXjI7+8D16xy1ZO70LR8JirfS9
 1GU26hljjaP0rhwzUsw3sSTaDUEZhVGTi1AUZRTtZY7yvB+RZDlBgoY/bwEZYZUl6VbI
 YEP26Gd3J0kPFD8DXEwOjr0Du/vmIJ3frxWkwWdqVE63lW01yyfKSOk5ZNQVScnX+PdN
 OdsJtH4AJgLgqsqlfbXcCMtKHyxUpTp6kxWIMe/H9fAq9iURtqmi98G7oSJfUU/mBmGq
 y4M1J8YgdHvAItT+g5FNNn68sEYQIhZOFdNKIw191Itfqrg1qS7OY2+B0ZKUtkYWAVI3
 H67Q==
X-Gm-Message-State: APjAAAUJHkcX3drTlcoVb1cn+zWhmy7nC0WjN0JUqdT+rgXi2RJjJGJe
 7dcZ82GsqvXUZj7r2/L2r+mw/maZaPc=
X-Google-Smtp-Source: APXvYqzs09kYyhRoSn9s6OTnLCkgVA9ZnlTy64wY8kCV85TBvC3wSTBEdkB/Q+biM0NP3DMmF10pMQ==
X-Received: by 2002:a17:902:b404:: with SMTP id x4mr54473plr.1.1572598537254; 
 Fri, 01 Nov 2019 01:55:37 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id q15sm5596078pff.155.2019.11.01.01.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:55:36 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/powernv: Allow manually invoking special reboots
Date: Fri,  1 Nov 2019 19:55:22 +1100
Message-Id: <20191101085522.3055-2-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101085522.3055-1-oohall@gmail.com>
References: <20191101085522.3055-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

OPAL provides several different kinds of reboot for the kernel to use,
namely forcing a full reboot, platform error reboot and MPIPL. Right now
triggering the alternative resets requires some ad-hoc method such as
triggering a kernel crash and hoping the stars align. It's sometimes handy
to be able to trigger one of these resets directly, so add a way to do
that.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 8349860..11fdae8 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -233,6 +233,10 @@ static void  __noreturn pnv_restart(char *cmd)
 			rc = opal_cec_reboot();
 		else if (strcmp(cmd, "full") == 0)
 			rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);
+		else if (strcmp(cmd, "mpipl") == 0)
+			rc = opal_cec_reboot2(OPAL_REBOOT_MPIPL, NULL);
+		else if (strcmp(cmd, "error") == 0)
+			rc = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR, NULL);
 		else
 			rc = OPAL_UNSUPPORTED;
 
-- 
2.9.5

