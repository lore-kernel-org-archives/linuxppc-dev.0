Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41555C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:59:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3595E20878
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoeLbePD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3595E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qhhY3qdyzDqll
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 01:59:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EoeLbePD"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh5P2cj1zDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:32:41 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id l18so29880pgj.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CaQAymN7670xs/t0KNGu5btmxbdCn1nriXbjUUgfR7I=;
 b=EoeLbePDtb/Yr7j7aqcMDgSLyFG2JcA8uqLWiGExLunJmpV2qOxREsOZ9vM3/w1UnR
 Tz/RkIdPtCvhX4cQQ3yXJZbuOmolFOtacMAN6U1sbUf04z1g6irHZJbdwMLxIah1q8BG
 ldfYTY5vgQI7JD0h0J1kUo6up9aI6ktzMV+VwrdV6CnvB2Aar+SiA5++y/qKmwbW4khL
 6G4cs0pP/UMiydahDBTusIZa/nHIBnpJ9AlhfVOAwCBPo/XYB1YsPKGeavJ5Bg5oLOzm
 kim2O3FLLNbeBqeKFhLoBfOj3CvuHIvkRiQU4ZTP3HBNEz1nLWBZKuRTcbX/ZlXzkF+V
 g2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CaQAymN7670xs/t0KNGu5btmxbdCn1nriXbjUUgfR7I=;
 b=EgBsYA8L8gZ9oMsigeAxqhLb5PcvATnxZG9rBrkI6UnUzFU/Kv5S905dS9ZKvgGQ2r
 3jMYL+gNLIzyn50HzwrIo91s7Bo8mxbZPiw6wYKq4lDeOvANd2SG2+CEMkJ1gvVwBOJN
 t5tcAFx5WqJftpjsXtrGscixdcGH1PYyg8zx7nNRWk7PoKCjpcjvUVPDZ7rKjklkubbr
 TcnkK5tDtpGqkGLiyDHnsB+3uEYe+3zBm/jxxUoZfdzhVjE3X4tNtkEm3DN4zrV6wYyP
 5g6s+VzdIrhTC4LJIaJmNFKYO/pblbr7oHd1Ua0QstICbIX/M5JRUrqPOzM1ELcAYZip
 qZzg==
X-Gm-Message-State: APjAAAV9kBDkxfQbShRSejBvianJrO0neM0uiiDhxWEPEG9wan9QuZ5I
 DyJ5qbvjheVyPUbyhM6ZE60=
X-Google-Smtp-Source: APXvYqwu8IO/JcftwC6o2OO6yOkDsJw7boJEkhDfJjmmT1Gcs9QRkUNd/O8RephW2yg3Vg4Hv5WB6A==
X-Received: by 2002:a65:6205:: with SMTP id d5mr2463274pgv.61.1556206358681;
 Thu, 25 Apr 2019 08:32:38 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:32:37 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 11/24] Documentation: ACPI: move dsdt-override.txt to
 admin-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:31:04 +0800
Message-Id: <20190425153117.16057-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
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

