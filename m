Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF952C04EBC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 12:58:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561AD20672
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 12:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdbgmrMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561AD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zm2p67p2zF3Wr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 23:57:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdbgmrMC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdbgmrMC"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zlyy31YXzF3GJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 23:54:34 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id b7so960256pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 04:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=P/3VXg8b0/4qPYj4Pzh+gl0+DIckFaNnC0YLvJ86HAM=;
 b=BdbgmrMCK9QQDDwZaR89+Oeydl2jh6Rskdd6w6Un+ny/zC95QQTPnqTC/5b2nmXEFG
 lyf+U6ks0r5WVDj63Shna1DNOPO4M/NiBC8iCAxBwBaffDSuz8oKWaVbR0/1vFVs7wGf
 dtEIjauD0uyQnk8NzVAY2djyCY5xqC90I+wjQLdELPGv564IsvFnjH5GFzfuG/SMKXPz
 zv2RgVfBQ1AwiXjfbZ/CDo4mcTy2v9eUCJWen8KGfKRYS7ywx7gei9Ng9ffTJAbTNWdh
 dRHm1zv6rjT7POhMUc1BL8kosypSBYBTCe1O8WHnAsML86OKILmhssw6MrZop49AMz3y
 yhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=P/3VXg8b0/4qPYj4Pzh+gl0+DIckFaNnC0YLvJ86HAM=;
 b=G44Mqrb61KB4PidcIQkquutRgmkj47ki9iu0N1cpG7lKGI41QRS18brSLGhtWttfF4
 9UBwQqK0eUmRoI1oc+9XcZTNjVrr27Qd7S22Dyls8WuXT9ZAULmKYFJKLR+Fe9EV489Q
 f+jiBD2noCrmTfsFPKFwqnKfyJtP4H+aAj3g8EHgfIKud4fA7JuGbsSei1alJ4g01AuO
 betqpuIXO2G7IiQJFBzgNn8whs3r07+M//P/AqeP0OaEzSQi942RcWNkgS/MdxlA3dVI
 oqkuFPyAxSg7Us+qRnkQiFb14WefX0rBlY51oD8zSuFk/EhCvnQ+KyYl/lj+h5Q2sXRQ
 iuVg==
X-Gm-Message-State: AA+aEWYu3fF3IuAeSuSgUpfxnwCQcaC4XhN9bezFaetEahCBQCvNygjY
 ctUX6qcdy41ZDfl1vfwUw/4=
X-Google-Smtp-Source: AFSGD/VkkW0lTT545K+a1nU7mFd15HQLWJTtf6yT/OKOWVbrAtCOPjrcEqIDEg/82465TRbpqCKTIw==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr1761215pgo.221.1542718471646; 
 Tue, 20 Nov 2018 04:54:31 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id j64-v6sm17959447pfc.43.2018.11.20.04.54.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 20 Nov 2018 04:54:29 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] cpufreq: pmac64: add of_node_put()
Date: Tue, 20 Nov 2018 07:54:09 -0500
Message-Id: <20181120125409.19314-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

use of_node_put to release the refcount of node.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/pmac64-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index be623dd7b9f2..1d32a863332d 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -411,6 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
 		pfunc_vdnap0_complete =
 			pmf_find_function(root, "slewing-done");
+		of_node_put(root);
 		if (pfunc_set_vdnap0 == NULL ||
 		    pfunc_vdnap0_complete == NULL) {
 			pr_err("Can't find required platform function\n");
-- 
2.17.0

