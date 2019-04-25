Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8DAC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:50:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491062088F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUL3wLbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491062088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qhTf6TmMzDqDr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 01:50:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KUL3wLbT"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh4q4x9tzDqWd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:32:11 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id y12so8708269plk.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ydaAtanhe5luQq8qrhQiH95JS2NmsbhYg1m6ekwdf5o=;
 b=KUL3wLbTWkZ/awIyUBXXP9ac/jSSDNu3AYL9u+nQRWFMeHakhphPZ1wxSCkmAqOR8F
 5+Zu5d/LjV9ur73c0TTstD9iFQfbPRxljSjbx/ljhkL/Idm8ucEuEhk4I60ugxbpMI+3
 wGZ5Q/hvtHYcFLIBBPPrS7aD6xXffzHc2QSgdtU8D8MGLTPVX51s1F+aaHJ/j1Bb1SSw
 jsrcnbQYcZ6ByyQdwQPNc8crfWBKu/Bk8vvI8scVR6T3Tw0PP7mS2Jb1NjMHIKGXWL70
 Feoz6FjMeBFHgwqatHYMHvBkhs/KxDvgD/szIbBUVQ2FfhcM/fMQ0vdVWjyncKzg6SwP
 D90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ydaAtanhe5luQq8qrhQiH95JS2NmsbhYg1m6ekwdf5o=;
 b=Hlyn+ovPFTPY40AI7GUNNgVrUcqogCkZjoc+s+F6GkxDQmxGUvarmIHVOKdeCbP0bn
 OJr/d6Tl6cwlYck85QGOUMPEnmig5vOazsrj9SzAQPsd0aR8j5BOnSGReRYIq/wKzu/5
 IAFdCWJGDbDyKSutb74Qoi7kPbKyvkKZyIZMwHtTMac3P5fgYFnjhyjHNkfkTfnQFA7R
 AVlTfv2mwGa5Pg7DiXLd66nEF59PtNX7eYr5Rf9kJrziMlvNfQCR5MDirO8S2jI1s392
 pGeWEHBeU0opK8VazZEK1Y8/O/kTrM8hPL78ZejBaAXG1oGNTcM/jQRLXi+0x/s3F387
 JFAw==
X-Gm-Message-State: APjAAAWED2xxBsCMf+OIANqcdlVAEaZyDMpAdpD9CJvg2nKVuEfTF0AC
 J018QoyD7SvxRGVESIcA7yc=
X-Google-Smtp-Source: APXvYqwm0yZSg35X3LIazXcrJL8hxnm+1neXBMlhHHKv6ctFLzmozDzwjXR32bGKzWRmKzMGEQlCUg==
X-Received: by 2002:a17:902:2c01:: with SMTP id
 m1mr41198162plb.22.1556206329043; 
 Thu, 25 Apr 2019 08:32:09 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:32:08 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 06/24] Documentation: ACPI: move scan_handlers.txt to
 driver-api/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:30:59 +0800
Message-Id: <20190425153117.16057-7-changbin.du@gmail.com>
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

