Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB3BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:45:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3112E208E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rC7PI+Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3112E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8Q83fxCzDqMr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:45:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rC7PI+Um"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7L31Q9BzDqYh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:56:42 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id y13so9686931pfm.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2sbwg0L9RWIY1yx4og9yDX54LDcD6lm1qQ96G7LSClM=;
 b=rC7PI+Umnb6CVvmFeTKMN7ISacQYIp5JWx7K4j+/MoThvTNXN7DKRPDYZuFRkx+xej
 i0m/SbyBO9wpeuFH4CZdqx+d1RsRX5A3vKccF2xgH0FzdffvCXrm3/kABVs47nkmtaln
 EcKhcVUokYPdQZoTiF9Gg3+or+ZiiYZAh2+HFADT9Qgb+JtdjJV/7YZxzfvBkInJerJh
 rNInXK1LJnOkyWXRdP7XJc6/mONGEuE6LWnaVJNcHp4cuZYpPiSVfBLNQzSruieHcGnT
 mCOAjxpnEUDx49BadZbt5sGCu5y66Jol1LNsT2o/ll4OQb9ja496PorsMm8XSlXZ7FpO
 9gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2sbwg0L9RWIY1yx4og9yDX54LDcD6lm1qQ96G7LSClM=;
 b=tEux8NAic+HEdvuGFdluK3I1LowMdEbw08zpM5L2aE0Bgc80N6QtRs8JOnFQbnmjaw
 SNNv6AWl0+rD4oudedHabTeQ/fz8/IESiDKU8odwircN4FMSsguFRHiGqy+In5VWhB3+
 3J6rsbk7Qgn0JJlmHAaw2CyxPVaKCKq3VMo6pzv6LzcpN8ahSORoUPSWawB+G+YhO+8R
 s9rI3KMNE0nvV/dAzynQ26Sj5yGmdu+g4tJ0QCW69oQUWcyf4STvZDDFcQp28HayFgVN
 EjMdNKcsMVBveoFqEyvlBGigfDGrkn248nm3ojZQkRvZlAHtVgbIPrZfE9aOdx70GK92
 G8uQ==
X-Gm-Message-State: APjAAAU4iE9xFcRBSnMn953p4kgVS+LXN1B0k2JOe2Rr4S2ZD4yqLeJH
 T3ubKyUVRe9V6p0qDrpAsdM=
X-Google-Smtp-Source: APXvYqywpPJKgOpReGTP1RB2uUK+F9Ux/BhvqcLVN+Jg1BljPXHsv5ehNjMc0Jn3B4Fqjhdhhl/qhw==
X-Received: by 2002:a63:d10:: with SMTP id c16mr19643000pgl.156.1556128600687; 
 Wed, 24 Apr 2019 10:56:40 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.56.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:56:39 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 21/23] Documentation: ACPI: move lpit.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:53:04 +0800
Message-Id: <20190424175306.25880-22-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

