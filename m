Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937BAC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:27:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127D8206A3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjDLz9Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127D8206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q81J405yzDqZS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:27:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rjDLz9Sa"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7JX6mLWzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:55:24 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id o5so5327033pls.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CaQAymN7670xs/t0KNGu5btmxbdCn1nriXbjUUgfR7I=;
 b=rjDLz9SaSKV0ShBN8j5gnJGsloe3W61F1vCfHvg/oeNXhzOiyKWxDyjCfpN1YNU0s2
 nCOSAnR7/eVK1FaJu8oqElOsyyVjvvCI12Jq3BD37RCYV/meqim7pLD4qihd5ZP2Etd1
 VftIk3KV+GEKCwVBfX8vm+Pb0Uj37q7N4e+8lKee7MAjLJFf6GBxSPpRXrAg3fIW788E
 zotBcy2fZxk/MbEyYQ7npmf6M3S5OGSBOl8NLLgj738mW6TeiRnNKJzltX8zBo6V7j5a
 wciit0fHshuTHFuQjOXAI5e/5OoFoTmLYinDYqn9eiOwh/lCx96DTmHKwXEvUoPEgG/h
 mW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CaQAymN7670xs/t0KNGu5btmxbdCn1nriXbjUUgfR7I=;
 b=X4AADFabqzmAY5uTO/2tbee7383hAUZesqp43i9K0D63fSNA268UXXMTiNhcMVSqzf
 kgOadkyHpWt8aSWli3LKmr8E5Mp5ESKZY8GX4/ifaYWqkEMGiLXdwknf14Hqsk6irqE5
 bfNv4Aa3gt2rEnDqp7tsZaA/0mzkCrttp/8pl+auTC2LbWhmwtbLhBZCBN9I/bVmeJhW
 X5Az7wTc5Zmp2mnb6RfObcFRJf0nrroRLWCX9/UkavW7Glr9n0Jg2E2GSzlqUkb6wtz2
 Xrvp3wlaZYy6Zjy6Ou/VonNVjynVqsALOYZj9aBnuAsqsH+FiUpcETDHG/TkIkD9f358
 xZSw==
X-Gm-Message-State: APjAAAVx7kvWVI97C/v/B1/q4EbbxG2Ov/Of5m3Z1dqgzopyxYkzN91O
 ZkxWkiXkPrK8N8LzurLihZs=
X-Google-Smtp-Source: APXvYqwp/3xOkC7K15I8gNCpycVbDjVWOEr7PvNCaNKJldNtuyXAkmwGSBgOaChAhsG1ZewEYrhx6g==
X-Received: by 2002:a17:902:be18:: with SMTP id
 r24mr32696902pls.69.1556128522749; 
 Wed, 24 Apr 2019 10:55:22 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:55:22 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 10/23] Documentation: ACPI: move dsdt-override.txt to
 admin-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:52:53 +0800
Message-Id: <20190424175306.25880-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
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
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../acpi/dsdt-override.rst}                               | 8 +++++++-
 Documentation/admin-guide/acpi/index.rst                  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)
 rename Documentation/{acpi/dsdt-override.txt => admin-guide/acpi/dsdt-override.rst} (56%)

diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/admin-guide/acpi/dsdt-override.rst
similarity index 56%
rename from Documentation/acpi/dsdt-override.txt
rename to Documentation/admin-guide/acpi/dsdt-override.rst
index 784841caa6e6..50bd7f194bf4 100644
--- a/Documentation/acpi/dsdt-override.txt
+++ b/Documentation/admin-guide/acpi/dsdt-override.rst
@@ -1,6 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Overriding DSDT
+===============
+
 Linux supports a method of overriding the BIOS DSDT:
 
-CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
+CONFIG_ACPI_CUSTOM_DSDT - builds the image into the kernel.
 
 When to use this method is described in detail on the
 Linux/ACPI home page:
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index 09e4e81e4fb7..d68e9914c5ff 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -9,3 +9,4 @@ the Linux ACPI support.
    :maxdepth: 1
 
    initrd_table_override
+   dsdt-override
-- 
2.20.1

