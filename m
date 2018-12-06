Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466CBC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:25:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B872C20868
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld6yLvAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B872C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439fYW6JB8zDr5s
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 02:25:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ld6yLvAL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ld6yLvAL"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439fNc3zQBzDr63
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 02:17:36 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id u18so305591plq.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 07:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/2dX+0Aha8foL6JubseVB3SJwSEDjcsJ1LX+7ne09G8=;
 b=Ld6yLvAL9ePfxK5pHYBZ34kwXdT1XcSHx3q0Ku09t3w5MJWVfzboXFxu5L4YecGUdo
 4eh8iXBNK/xsHwifn2x7gUYOVPAHYIp/DFf8CKLmEFWKr8t+Qg5bLg9KRh7kj6PkbByb
 ls7wPbR5oA2stKnGET/t+ok26KS+/rYVXHR+XYzVY92Sj8cn+C/XKaHrkLdNizStw4OW
 93KkqyiVUTNULUT2Y/YgbwVe1c8XAAfb2U5UMXqnVzeCWInWfsS65cHyq6XRvU5noEx5
 3LVo/QU413JyGRKVKYOlHL3ViRTMhv2I+wfgITP1N3X5z7hozV4mN683nms9CBEfp72G
 zNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/2dX+0Aha8foL6JubseVB3SJwSEDjcsJ1LX+7ne09G8=;
 b=Khi3XyKFU39mEYzYGvxXoMXIUhfkKRL1cCHZECvsMRGlZXJkEiMY3+luK5TS8LSEDD
 wzF20jE9WyME6k6Lt54D2jA8+9/R+18jnjJ0T/JKLAzdBFI1Hr8BqxULkveZZnwsjiyh
 LfrRfwljqlPa9CvgHtlqkNpKQtEwPY5yiIOmM7s7puWdhubfcFQpm8l+0sShM25dJNTs
 HNxAlIe3rikQ1LmgAAyRz8BFssJyht1ibrjSrSOBIqy27ibEuqtJK0AsIjJXHxRnzsp1
 7ls29KWTB6ZEOxrcIHH4ogZoWivPNQN1K+fiw7MWcP4E8MEOEXTnr8t51V1badox5P0S
 CSXA==
X-Gm-Message-State: AA+aEWb+5H16miW3pssSKpv5DyJweCYFlnsBQEwmQjwoMtfHRQ9dPhVF
 Hpum3DCovWQtL6DOrJpocAtTlMuX
X-Google-Smtp-Source: AFSGD/URMuYbFTMJBQc8T+5vxfgMJ0E03a964QE4dANSS3bRO6+MyDxcaJyRrofrH/dWKYI4tt9GUA==
X-Received: by 2002:a17:902:8d8e:: with SMTP id
 v14mr28384636plo.133.1544109454625; 
 Thu, 06 Dec 2018 07:17:34 -0800 (PST)
Received: from 192-168-1-15.tpgi.com.au (60-240-78-224.static.tpgi.com.au.
 [60.240.78.224])
 by smtp.gmail.com with ESMTPSA id v12sm821546pgg.41.2018.12.06.07.17.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:17:33 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/7] powerpc/papr_scm: Fix resource end address
Date: Fri,  7 Dec 2018 02:17:09 +1100
Message-Id: <20181206151714.28494-3-oohall@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206151714.28494-1-oohall@gmail.com>
References: <20181206151714.28494-1-oohall@gmail.com>
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

Fix an off-by-one error in the memory resource range. This resource is
used to determine the address range of the memory to be hot-plugged as
ZONE_DEVICE memory. The current end address results in the kernel
attempting to map an additional memblock and the hypervisor may reject
the mapping resulting in the entire hot-plug failing.

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index ee9372b65ca5..390badd33547 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -296,7 +296,7 @@ static int papr_scm_probe(struct platform_device *pdev)
 
 	/* setup the resource for the newly bound range */
 	p->res.start = p->bound_addr;
-	p->res.end   = p->bound_addr + p->blocks * p->block_size;
+	p->res.end   = p->bound_addr + p->blocks * p->block_size - 1;
 	p->res.name  = pdev->name;
 	p->res.flags = IORESOURCE_MEM;
 
-- 
2.17.2

