Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6768AC4321A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:09:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D642088F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLwildLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D642088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qhw06xsmzDqSy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 02:09:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uLwildLU"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh5y3wX4zDqWc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:33:10 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id 188so86316pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4ANYEStqupVcUyOOdEhP27CWqrM1IUuJpSYFn0ATO6g=;
 b=uLwildLUiX2Qpmo1OeBl52m1gj/udEIf3v8IeWQYzPyzPUkGtQLZ1wA5qkxnzVYxrP
 NOqokNVG4sWZyNwlePEt4atI8Cd7dkpK5RH1IigZDSap0rRotfWFLZrDGsNm6Jirp065
 IswmXzQ5GV4HXS2VJYg1SnEldFzy7KpihRmecvWqI0ZXLYcRM62Zi1tfshNj4j9DttzZ
 QNjApsZGe4Nqt+rIXUgk8Fu7ruV9LWJDkcH5kVJGqtIbNDXtPRp/D6Y44nZxxaXtU1uo
 XZt6FTn2qm9+QiOdU/lHAQt20CgFDuJgB3AabolVSn5DEiZUnphV4nKNdvX95ROQshyr
 Fe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4ANYEStqupVcUyOOdEhP27CWqrM1IUuJpSYFn0ATO6g=;
 b=RQ647s01en9OYfZ7IYdYDzwCJnhf7NEpU/tP9moyRvHogvYhcpnkecJlDWRMxax5ty
 IIOwC1Cysl3FcWIcQ+p+X+d/MZDc9MfBdsAqq3MumvLAq7tisLh/hK9inYOd5c8PimhD
 yV1y0GsDpvujKfQPU15PerYx/7qKK9qIac6m41tddYPLQWD9ldQs7GMuMtslS2h9oN7F
 X1s6Rg0aIGHZHLlxUtDRF1yLhrrtvA7ggXKkXU2p7N4p6CX6csdVbvmgypDNsf15xv8g
 YR09v567YVk57GC7ZD1cwPSVHYqGAMjr/MMeom4LiOAQOW28POBdLj5CljAe4iJhmQ08
 BRrw==
X-Gm-Message-State: APjAAAVVFkKxi/F+vY4Igpx5KFIdVYLQE12Z7/2f71K6LFsSSUWpNUgh
 QXNa5TFCQIj3nxyigcVqCyk=
X-Google-Smtp-Source: APXvYqwxd1QTHDY2bcx7OWGQ+ic9X7jIyj3kAcVia5AyEq8KmdboilFetDUGCiVT7/TmxaoimxP4Sw==
X-Received: by 2002:a63:ee15:: with SMTP id e21mr8826591pgi.180.1556206388245; 
 Thu, 25 Apr 2019 08:33:08 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.33.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:33:07 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 16/24] Documentation: ACPI: move debug.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:31:09 +0800
Message-Id: <20190425153117.16057-17-changbin.du@gmail.com>
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
 .../acpi/debug.rst}                           | 31 ++++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |  3 +-
 2 files changed, 19 insertions(+), 15 deletions(-)
 rename Documentation/{acpi/debug.txt => firmware-guide/acpi/debug.rst} (91%)

diff --git a/Documentation/acpi/debug.txt b/Documentation/firmware-guide/acpi/debug.rst
similarity index 91%
rename from Documentation/acpi/debug.txt
rename to Documentation/firmware-guide/acpi/debug.rst
index 65bf47c46b6d..1a152dd1d765 100644
--- a/Documentation/acpi/debug.txt
+++ b/Documentation/firmware-guide/acpi/debug.rst
@@ -1,18 +1,21 @@
-			ACPI Debug Output
+.. SPDX-License-Identifier: GPL-2.0
 
+=================
+ACPI Debug Output
+=================
 
 The ACPI CA, the Linux ACPI core, and some ACPI drivers can generate debug
 output.  This document describes how to use this facility.
 
 Compile-time configuration
---------------------------
+==========================
 
 ACPI debug output is globally enabled by CONFIG_ACPI_DEBUG.  If this config
 option is turned off, the debug messages are not even built into the
 kernel.
 
 Boot- and run-time configuration
---------------------------------
+================================
 
 When CONFIG_ACPI_DEBUG=y, you can select the component and level of messages
 you're interested in.  At boot-time, use the acpi.debug_layer and
@@ -21,7 +24,7 @@ debug_layer and debug_level files in /sys/module/acpi/parameters/ to control
 the debug messages.
 
 debug_layer (component)
------------------------
+=======================
 
 The "debug_layer" is a mask that selects components of interest, e.g., a
 specific driver or part of the ACPI interpreter.  To build the debug_layer
@@ -33,7 +36,7 @@ to /sys/module/acpi/parameters/debug_layer.
 
 The possible components are defined in include/acpi/acoutput.h and
 include/acpi/acpi_drivers.h.  Reading /sys/module/acpi/parameters/debug_layer
-shows the supported mask values, currently these:
+shows the supported mask values, currently these::
 
     ACPI_UTILITIES                  0x00000001
     ACPI_HARDWARE                   0x00000002
@@ -65,7 +68,7 @@ shows the supported mask values, currently these:
     ACPI_PROCESSOR_COMPONENT        0x20000000
 
 debug_level
------------
+===========
 
 The "debug_level" is a mask that selects different types of messages, e.g.,
 those related to initialization, method execution, informational messages, etc.
@@ -81,7 +84,7 @@ to /sys/module/acpi/parameters/debug_level.
 
 The possible levels are defined in include/acpi/acoutput.h.  Reading
 /sys/module/acpi/parameters/debug_level shows the supported mask values,
-currently these:
+currently these::
 
     ACPI_LV_INIT                    0x00000001
     ACPI_LV_DEBUG_OBJECT            0x00000002
@@ -113,9 +116,9 @@ currently these:
     ACPI_LV_EVENTS                  0x80000000
 
 Examples
---------
+========
 
-For example, drivers/acpi/bus.c contains this:
+For example, drivers/acpi/bus.c contains this::
 
     #define _COMPONENT              ACPI_BUS_COMPONENT
     ...
@@ -127,22 +130,22 @@ statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
 definition.)
 
 Enable all AML "Debug" output (stores to the Debug object while interpreting
-AML) during boot:
+AML) during boot::
 
     acpi.debug_layer=0xffffffff acpi.debug_level=0x2
 
-Enable PCI and PCI interrupt routing debug messages:
+Enable PCI and PCI interrupt routing debug messages::
 
     acpi.debug_layer=0x400000 acpi.debug_level=0x4
 
-Enable all ACPI hardware-related messages:
+Enable all ACPI hardware-related messages::
 
     acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
 
-Enable all ACPI_DB_INFO messages after boot:
+Enable all ACPI_DB_INFO messages after boot::
 
     # echo 0x4 > /sys/module/acpi/parameters/debug_level
 
-Show all valid component values:
+Show all valid component values::
 
     # cat /sys/module/acpi/parameters/debug_layer
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 6d4e0df4f063..a45fea11f998 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -14,6 +14,7 @@ ACPI Support
    osi
    method-customizing
    DSD-properties-rules
+   debug
    gpio-properties
    i2c-muxes
-   acpi-lid
\ No newline at end of file
+   acpi-lid
-- 
2.20.1

