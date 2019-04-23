Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489FEC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:25:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDDB208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM3hq3uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDDB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pZgc3yqHzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:25:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="IM3hq3uO"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTXz4lFBzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:33:55 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id l18so7739368pgj.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4xTrnLrO59umJmSOvr4epn2M5miwC5OKlGYVuirCoC0=;
 b=IM3hq3uOs4nXIMqaVCPkR+wmGVqnUYUAe2kfzxLiWVFI16Po9dzRGA2HEL3HTkFS0Y
 yIRE1YfFsBZWwKLtF7pxM2H6HTLfiI0ecsylitlE0QrTK0PBvM1CSbxFDnOM+JvHatdf
 SV28RxH4G2Z5bsYXMGcsUAbc1qqgAXv3yZdORTxV4D7NP97bqoQed6Qxa/UqCR2ZMR2z
 0irvdt100pc8mJM//h6u3lDSti3tCpE7DKg9Kyt6yiWkAqvOQpAVP9/ak2hcHY7RB9YV
 MOplj8bdzATistWqkFYsXOssi0OqMMCXspkn+JIXz2agpujc4ykwxK0apEBNF4k1xB9W
 m0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4xTrnLrO59umJmSOvr4epn2M5miwC5OKlGYVuirCoC0=;
 b=neEhh8wpJ3NmXdq8MhDBwl0pSy/DnAxsv0VxZW6wulCgLGnojDjGWvSCoEheoxpYXO
 R8ca+g+rRFUX5MND9Aix+VeFsnUKAJZiSOviymWDlBPRwXuw6qnfdA6WQVnCwti9185h
 H+NUVUGsxcUo/xcn6/S1ZQWxJeFztEWkvArI0tvsEIHCsZdm0ogCDR3D6fWFiiWZ+7mS
 7UhykWeFoYlBgb4gOAaX9S0A3rXCwl8S3ZUjVQyhJ6XCwANtquR0M2an5IyDPdGZExNL
 WbkGIOFz3Y1GVGkLlw0rrXtcafwj4hrjHB8SR9V7uNbNb+iO7q88juNKx5LXdxE2jo6D
 MJhw==
X-Gm-Message-State: APjAAAWWiL0NNVmmTKm11GVpOm2q9W9FmvycgFEmCNrZ8tWEjGo1u/nN
 GNiqoIcLaIwSFH9YNgWs03M=
X-Google-Smtp-Source: APXvYqzCN4JlnPcIBBixsCPKXX8eA6Ikw06oVo5Ar9KruZby+Z0pOXPDt6n8BU3DR0OKk9a/I0AbTA==
X-Received: by 2002:a65:6202:: with SMTP id d2mr25646108pgv.176.1556037233885; 
 Tue, 23 Apr 2019 09:33:53 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.33.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:33:53 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 22/63] Documentation: ACPI: move lpit.txt to
 firmware-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 00:28:51 +0800
Message-Id: <20190423162932.21428-23-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:30 +1000
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
 Documentation/firmware-guide/acpi/index.rst    |  1 +
 .../lpit.txt => firmware-guide/acpi/lpit.rst}  | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename Documentation/{acpi/lpit.txt => firmware-guide/acpi/lpit.rst} (68%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index fca854f017d8..0e60f4b7129a 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -22,3 +22,4 @@ ACPI Support
    gpio-properties
    i2c-muxes
    acpi-lid
+   lpit
diff --git a/Documentation/acpi/lpit.txt b/Documentation/firmware-guide/acpi/lpit.rst
similarity index 68%
rename from Documentation/acpi/lpit.txt
rename to Documentation/firmware-guide/acpi/lpit.rst
index b426398d2e97..aca928fab027 100644
--- a/Documentation/acpi/lpit.txt
+++ b/Documentation/firmware-guide/acpi/lpit.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Low Power Idle Table (LPIT)
+===========================
+
 To enumerate platform Low Power Idle states, Intel platforms are using
 “Low Power Idle Table” (LPIT). More details about this table can be
 downloaded from:
@@ -8,13 +14,15 @@ Residencies for each low power state can be read via FFH
 
 On platforms supporting S0ix sleep states, there can be two types of
 residencies:
-- CPU PKG C10 (Read via FFH interface)
-- Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
+
+  - CPU PKG C10 (Read via FFH interface)
+  - Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
 
 The following attributes are added dynamically to the cpuidle
-sysfs attribute group:
-	/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
-	/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
+sysfs attribute group::
+
+  /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
+  /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
 
 The "low_power_idle_cpu_residency_us" attribute shows time spent
 by the CPU package in PKG C10
-- 
2.20.1

