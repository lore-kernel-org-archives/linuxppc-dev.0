Return-Path: <SRS0=/+OH=4Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942EEC3F2CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 05:59:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436C2246A0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 05:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTClaJRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436C2246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TJkq286NzDrMJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 16:58:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=TTClaJRS; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TJg816mzzDrFC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2020 16:55:47 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id j7so819300plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2020 21:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=K4R793wlk3OMQcTGTmVkqO8V/TfCUC1nFa9LOzJKhOI=;
 b=TTClaJRSPeEH5l2uCigsy0LEbVnvtmwGQ66mjjYuoGUdAptgVU+m9vM5l+EKllPBum
 luEVwxMRkc/qMTZnG47jycxLQ0DTQkLtShMEeUeAdHunG4yesucQnmgzhP9av5V/utZp
 jky1EXKLQy88ST5Dt899uWhSh6SBqQ/Cz0addr9cQLE6Oux97VGtMsK/1vk3AW1LvOb4
 4R9+LtRU/J40dRYrVIyEP+O9juHLHHaAVGbPPdq1MPqY+h3lw+n5RE9vy8zF3MIBPvul
 NFzkK38tcGtlCaLngbzCaTzNCSLJt633TtEadO9ozPZjLASzSpdYTELt2GoafyHDywXO
 tT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=K4R793wlk3OMQcTGTmVkqO8V/TfCUC1nFa9LOzJKhOI=;
 b=OUyBlC3gL4wDb6d6wQBHYe1bTNGMKWldwrW10KR5ylO2f9CmSuYVny7OpIuvSm4CGf
 SaRkAJS1+hsCzs+u3fvwWMYFJefl5lcs/tYbVfRkC6v8TQhLxGWpjXiPX9hwj0A+NGip
 duhujcba6rURCHlz4DVCaGY7eFcFMuMc4TMbuuUv+eBsE/vdVYqOo8B1+SEI9jpFs2Cx
 8ER6ZsSFl4NcRYS2bg8j/f+254QpE31JdDIoX8Cnt/wxX1hQc6CSchlPswBP//lMP0b+
 yuGqcl3p7obRWyaqeeUEGVbh1iE6CsZ+K4gUIHBHFuj6ljgGcsC5+mCs+FqXiqhMypQ7
 4RXw==
X-Gm-Message-State: APjAAAXmw7z9Fk10B0Q/GsOA3BIT8N/A2P7/DY8fL8mv13hq0yURw02A
 yQKMX5QK6n5s0WTcIvbcsHzQmOY=
X-Google-Smtp-Source: APXvYqwM4tayrZ9x+lk5R6uvwN10SxlVKsAHe3tOCbcvXG8BcyLhs+WQZnsIzUf4GJ8lh+Xe9YnHJg==
X-Received: by 2002:a17:902:142:: with SMTP id
 60mr2450068plb.115.1582869345926; 
 Thu, 27 Feb 2020 21:55:45 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h4sm4350370pgq.20.2020.02.27.21.55.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Feb 2020 21:55:45 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/of: coding style cleanup
Date: Fri, 28 Feb 2020 13:53:11 +0800
Message-Id: <1582869192-9284-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582869192-9284-1-git-send-email-kernelfans@gmail.com>
References: <1582869192-9284-1-git-send-email-kernelfans@gmail.com>
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
Cc: kexec@lists.infradead.org, Pingfan Liu <kernelfans@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: kexec@lists.infradead.org
---
 arch/powerpc/kernel/of_property.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/of_property.c b/arch/powerpc/kernel/of_property.c
index e56c832..c6abf7e 100644
--- a/arch/powerpc/kernel/of_property.c
+++ b/arch/powerpc/kernel/of_property.c
@@ -5,16 +5,18 @@
 #include <linux/slab.h>
 
 struct property *new_property(const char *name, const int length,
-				     const unsigned char *value, struct property *last)
+		const unsigned char *value, struct property *last)
 {
 	struct property *new = kzalloc(sizeof(*new), GFP_KERNEL);
 
 	if (!new)
 		return NULL;
 
-	if (!(new->name = kstrdup(name, GFP_KERNEL)))
+	new->name = kstrdup(name, GFP_KERNEL);
+	if (!new->name)
 		goto cleanup;
-	if (!(new->value = kmalloc(length + 1, GFP_KERNEL)))
+	new->value = kmalloc(length + 1, GFP_KERNEL);
+	if (!new->value)
 		goto cleanup;
 
 	memcpy(new->value, value, length);
-- 
2.7.5

