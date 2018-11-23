Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024B2C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 13:36:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8C820672
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 13:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM+rAQl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8C820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431clq0Kk5zDqWg
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 00:36:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dM+rAQl2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dM+rAQl2"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431chw4TdzzDqWB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2018 00:33:52 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id c123so2693600pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 05:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=lDsJKS1oNLz/0T0+4NfjSFsaxXGbh8mIOnrI7P5Es+4=;
 b=dM+rAQl2gUgSHgd1sdclsZ02HlyaCXQw3qQkN1u47coDUadS2NRwejkIGbLeiZu13f
 gD3amtdF0tQB5QepcdmwFQpH0INGPyDAIEVqo+XIe1HxG+nawsPt2SUq2bsmHQMKMcWd
 4KmcoK8YuQxD5miVw9cfqBPAgIJR/X6Hb/1fXPdFAVNVqrzuS1kziyFt3/oCxHtE0cGd
 QKkEwnql2mGQ9bhGE7OQqYt37ZEgYsG6hQvtYjhCisK29uTteo64znTH5vdBQFpbynhO
 Z+JBhDW5qkINjjWzdzyypERxiYYNitpZG+2RopXM/B9H7/wqxFRboxrRAP3aSLBkjv8m
 T3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lDsJKS1oNLz/0T0+4NfjSFsaxXGbh8mIOnrI7P5Es+4=;
 b=F8ZuBW652GerLJBjSy6nHB3mHCeLF1O2vgvtuY2/bJ+ifFHE1xyKa5MpO9UZ4tkOtV
 LXkU/iD/tvceRMX8G24A2az/FT9fiaTcU24PD0TeNm3L60Qf8u74/iJMQElFpzI9jeVQ
 SCrSvGoPQrhiFxpmySe+u90IYMLytt+62Fa92c+W5PMq3V62uV7BDaxfdtvsbcN1HkBY
 NILUlzKw6YA/GcNfHiNgHMBgGrYy/T/Y3YWYpBW+WzY1j6A5ZasfsScsBM1uQzRUehwQ
 /SK1z1UfGXLFiG4hPO26IZUDut7/nmLnfqtCVtHY4vvqNgBSkC6vbrxoZQ24RMi+kP4u
 Mn5w==
X-Gm-Message-State: AA+aEWZto3ZDF9byk/hIKKIHJO1pCzHBKv3HERW5Nvz+mG08s4Q3abqU
 baW7TQx0ADHDYQte4vb5a7g=
X-Google-Smtp-Source: AJdET5c9TngiJYlm6VKowHdlqL+8rwEppVXR4g+0oDVtg43zOtNU4dhbaD8NBLXnIdJ/Mm6UtP9/Kw==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr14108993pgb.66.1542980030167; 
 Fri, 23 Nov 2018 05:33:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id d68-v6sm61764630pfa.80.2018.11.23.05.33.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 23 Nov 2018 05:33:48 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v2] cpufreq: pmac64: add of_node_put()
Date: Fri, 23 Nov 2018 08:33:40 -0500
Message-Id: <20181123133340.26849-1-tiny.windzz@gmail.com>
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

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
g5_neo2_cpufreq_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes in v2:
-update changelog
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

