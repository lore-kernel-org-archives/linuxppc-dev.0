Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C038C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 19:52:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67FE21773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 19:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePlgw5d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67FE21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pYyC6hdWzDqQd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 05:52:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ePlgw5d0"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTTx2R8fzDqD4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:31:17 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id 188so7752747pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1xerTm3VfTwwIXo29rsoW7SuRTHKgFB7tOjiZbttFTM=;
 b=ePlgw5d0ij796SpuWMMljIQPe26ujwx2u69aSihHH34H9VNxTBqVqC9JDzOSQffBIf
 FK4fsGn0sv9sj6O4u15d+SBUhQ0ZzlZ/62j4MJtxUv7Ac6cznKZZqSQs/BkQMSGFBTEF
 CVPh4ng3NKkBPO69n5bg/t2NynDmmA1JD/A68xSTqP6w4XGee0EA5M4jUOBClrFKnHru
 bdO+l5eMVhI9w+jSq35mvVzBXGqTAldf6XIvu7FmD6oqKDdmr8Aew2mUCk7p3SmVaJwY
 dRH7tDJlpCEM5qzlwEz/HWdy3izqSy4m/Ft6gXs3fZiHWVOn/kFY9r7+v5UDHssqPnPW
 AC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1xerTm3VfTwwIXo29rsoW7SuRTHKgFB7tOjiZbttFTM=;
 b=HUc0vjGbYJ3kJhmkh9c5zl9+19KOmqO8qM7hljBNMNqO9gtM1GVbYUegqPb6KNr4Ul
 AiYy2OzSUg7/z0LQ7YjvbxFUG1Tdc9WBngz+yjb+6maB5f9ntIpO8A5S/dE0HsVXrLNn
 ggivp3xneEdLkF1xIjxwgNg/ejxxgObNydtwXLTToumbhGKTHahMHdvwKPQHMTQlyGOs
 a0U6KzGWfpFdnNUWKx7zEtL8aJwGAtbaWa7Ss6V5POr/kKX2FYVYUvq1JXOgMhWm8hxv
 hT9ha0JfQqevOtAx9aM00WfeKvvDT99TJlCLxWqvESkGUO+F/msWcHSz0dXE/fDVFDBs
 EtKg==
X-Gm-Message-State: APjAAAWZFn4oQLPaCWcImYjH0jQBj7eFTNaFCIB7tJKc1dRSg0UH4Ksr
 wNy71ItusNgXzN+2Nfo1/wE=
X-Google-Smtp-Source: APXvYqwZa4hivcq2EcEi39jhEWFSWP8AO8b2FQnBlBbgzRJPRFxT5c1A/tYw9BEJSG5Utah0fO9DGA==
X-Received: by 2002:a63:5d45:: with SMTP id o5mr13634575pgm.0.1556037073332;
 Tue, 23 Apr 2019 09:31:13 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.31.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:31:12 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 06/63] Documentation: ACPI: move scan_handlers.txt to
 driver-api/acpi and convert to reST
Date: Wed, 24 Apr 2019 00:28:35 +0800
Message-Id: <20190423162932.21428-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:29 +1000
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
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/driver-api/acpi/index.rst       |  1 +
 .../acpi/scan_handlers.rst}                   | 24 ++++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)
 rename Documentation/{acpi/scan_handlers.txt => driver-api/acpi/scan_handlers.rst} (90%)

diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
index 12649947b19b..ace0008e54c2 100644
--- a/Documentation/driver-api/acpi/index.rst
+++ b/Documentation/driver-api/acpi/index.rst
@@ -6,3 +6,4 @@ ACPI Support
    :maxdepth: 2
 
    linuxized-acpica
+   scan_handlers
diff --git a/Documentation/acpi/scan_handlers.txt b/Documentation/driver-api/acpi/scan_handlers.rst
similarity index 90%
rename from Documentation/acpi/scan_handlers.txt
rename to Documentation/driver-api/acpi/scan_handlers.rst
index 3246ccf15992..7a197b3a33fc 100644
--- a/Documentation/acpi/scan_handlers.txt
+++ b/Documentation/driver-api/acpi/scan_handlers.rst
@@ -1,7 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+==================
 ACPI Scan Handlers
+==================
+
+:Copyright: |copy| 2012, Intel Corporation
 
-Copyright (C) 2012, Intel Corporation
-Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 During system initialization and ACPI-based device hot-add, the ACPI namespace
 is scanned in search of device objects that generally represent various pieces
@@ -30,14 +36,14 @@ to configure that link so that the kernel can use it.
 Those additional configuration tasks usually depend on the type of the hardware
 component represented by the given device node which can be determined on the
 basis of the device node's hardware ID (HID).  They are performed by objects
-called ACPI scan handlers represented by the following structure:
+called ACPI scan handlers represented by the following structure::
 
-struct acpi_scan_handler {
-	const struct acpi_device_id *ids;
-	struct list_head list_node;
-	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
-	void (*detach)(struct acpi_device *dev);
-};
+	struct acpi_scan_handler {
+		const struct acpi_device_id *ids;
+		struct list_head list_node;
+		int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
+		void (*detach)(struct acpi_device *dev);
+	};
 
 where ids is the list of IDs of device nodes the given handler is supposed to
 take care of, list_node is the hook to the global list of ACPI scan handlers
-- 
2.20.1

