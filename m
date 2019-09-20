Return-Path: <SRS0=Loi+=XP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B6BC3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Sep 2019 16:33:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28AA2086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Sep 2019 16:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdmXUSoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28AA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ZfQs59QgzF3b7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Sep 2019 02:33:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=nishadkamdar@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FdmXUSoY"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Zf6M5B94zF3XK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2019 02:18:42 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id y10so2101889plp.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2019 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=LzFrqPQBDwdXmQkSuu8KsIj5oRAPGrw4JRLMdlkzg/s=;
 b=FdmXUSoYQVg4zFefv12JxYtGNAaoDsOdUsRjf9g6/5FNTQ7wRh5WH+BpMjuSVKNvXI
 UxS7ihGz7Yy6lQl5dtcuaFGCjkTDEV29U6eGY9hjgG+TkzxBXZWkzb/e+OpeR/y5zsM1
 7MP/ocSY6EgCG/5xtTxcHbGCxCNdktO+F+2wVPpPognyAjPkixpst1Nq5oYMhAuCRVnP
 N7nD9QbfSZ2+qnc1SwUbQ7ov7tZ639c0YIQHu4WIitYSMrbkon2Zi1xXILmJjESkRb8S
 VtuMoD+Ip4dx/DzUzDLnONK1EzMB6PWgLq5uRJHFAlgBvxBswwRYoATBD8duB0K3N+fo
 jg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=LzFrqPQBDwdXmQkSuu8KsIj5oRAPGrw4JRLMdlkzg/s=;
 b=NuMpuCRX9ePhc8kCO2FDD3saCxTlFZsNQbOIN+2vwBA204OZoZuB5pqsUvvXvpcUTP
 DXq+UPz5pgtylzapjYks65uMz/1MXiYl7iYEjpha0S35pbumSN2+57yrOd3JyDv1Ez6J
 cgpBn54llpddAT1x7ez9c2gSfZSAQ1pZa7dXxgnFghsW7+asor6cdyiM93PsaPkHEKI7
 N/EEVj9IiSzUK99KW8bFpa3UoS71qGc8ucYDS9/UKCRJ/rCYNLMNs5Sws1UvklPDiYgw
 7PEZQQV/5G1IiqCcHwmJgoJSUn+mtR81xktnvOCR6wQA3+XkboOo0mfAh9s+DXQifyRa
 WjIw==
X-Gm-Message-State: APjAAAUAhXlpndEROP006f2Sj8wdJawmaYoAQ2T7tUhQRKAEIQc27/l4
 QrwYTLTTZzEW1z2CgvdEGSY=
X-Google-Smtp-Source: APXvYqxwjCVURm9DK7zOJITte1sP/f6LHs0VLXylGM1ogKUzVMvMZepcrd+bCdCxyw0K5KRu5fjf/w==
X-Received: by 2002:a17:902:9a92:: with SMTP id
 w18mr17524414plp.255.1568996318341; 
 Fri, 20 Sep 2019 09:18:38 -0700 (PDT)
Received: from nishad ([106.51.235.3])
 by smtp.gmail.com with ESMTPSA id e192sm3526981pfh.83.2019.09.20.09.18.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Sep 2019 09:18:37 -0700 (PDT)
Date: Fri, 20 Sep 2019 21:48:30 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Royer <seroyer@linux.ibm.com>, Joe Perches <joe@perches.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ocxl: Use the correct style for SPDX License Identifier
Message-ID: <20190920161826.GA6894@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch corrects the SPDX License Identifier style
in header files for Open Coherent Accelerator (OCXL) compatible device
drivers. For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/misc/ocxl/ocxl_internal.h | 2 +-
 drivers/misc/ocxl/trace.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 97415afd79f3..345bf843a38e 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _OCXL_INTERNAL_H_
 #define _OCXL_INTERNAL_H_
diff --git a/drivers/misc/ocxl/trace.h b/drivers/misc/ocxl/trace.h
index 024f417e7e01..17e21cb2addd 100644
--- a/drivers/misc/ocxl/trace.h
+++ b/drivers/misc/ocxl/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM ocxl
-- 
2.17.1

