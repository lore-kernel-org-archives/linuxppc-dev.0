Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C929C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:30:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD1D21773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKPelFoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD1D21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q84f0N00zDq77
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:30:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKPelFoA"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7Jq2rLBzDqS3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:55:39 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id k19so9751707pgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7iW4MbVd77MEAccCwSku/MkHI3UfK1BuasUTDy15CeE=;
 b=VKPelFoATeOAMLDXHM71WKJP1fx5BKtGxHt611mwAijwMzR9+JA8D2nzfsBy0SJuel
 G/yDnfHYIxrNXtgFLXpRjCBvqZ0XP9U8finNLwaQ3Xdcvv9ityPhYwK249rBeLby5BqJ
 icg+DEAQsoUrkrus5XlWAS1PmjIr5niAsIzTecGMdTVzldPmgVqnbRrSFqYISKxx9Gl4
 w2EE4462kGYV8NOWQeiJb+Ize10OABYMj6TvW4p1Uhd4diPhO1H/dVqkITSozmz1YYNa
 ynuH1CY6Jmk7rhcLqGlWorPxCKbAI2Vo1xIdQaHXy61HUZ8Lk8kg5THJ6WoO8+tUGgNd
 5rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7iW4MbVd77MEAccCwSku/MkHI3UfK1BuasUTDy15CeE=;
 b=njjLq3gMuJ3XtFUpoLVqMMM36fTDys2R73VF4kwoordvyOEAT24HEJTsNmxQVHxlpg
 lJrTabDIK1M/pG0X4PkqSVcxKE0l5n0LNO9cGYMQSZjJmaoVOXrs6fIt0etKq+dxApOt
 dh70/xlOkcizuwQB5vO8t3h41pof2LBVsWzNst3Gtwp6BjIDI3izLc7RDEe+cxClRQdj
 15ZkFXtXTfBBiUmOKfx/4G6xbDRjAv4HRit9hOnrV2QKf12VecctFMy4a+JYvBHNGM4O
 erb+K2xs4Wddgpxq8Nxxzt33DgY3zBlji6yrOfYCIwFYRGTYXKZyfuPw+fux9IWQrJpb
 rVVA==
X-Gm-Message-State: APjAAAURpztZZCU4HlL3Ilnb9t7lL8PmNCrFuGHo1Vd4OZWR3E3QPYZ2
 Fx9wCDybejcD5Ws9Z4ssgfg=
X-Google-Smtp-Source: APXvYqz6pSKzIHNtTGWw0dP2F85dG3AG01V01o7LZZuIosaWpzOZGrP+SWYdVVIfHOI8wzeiun9S9Q==
X-Received: by 2002:a65:64d3:: with SMTP id t19mr32475134pgv.57.1556128535732; 
 Wed, 24 Apr 2019 10:55:35 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:55:34 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 12/23] Documentation: ACPI: move acpi-lid.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:52:55 +0800
Message-Id: <20190424175306.25880-13-changbin.du@gmail.com>
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
 .../acpi/acpi-lid.rst}                        | 40 ++++++++++++++-----
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 30 insertions(+), 11 deletions(-)
 rename Documentation/{acpi/acpi-lid.txt => firmware-guide/acpi/acpi-lid.rst} (86%)

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/firmware-guide/acpi/acpi-lid.rst
similarity index 86%
rename from Documentation/acpi/acpi-lid.txt
rename to Documentation/firmware-guide/acpi/acpi-lid.rst
index effe7af3a5af..874ce0ed340d 100644
--- a/Documentation/acpi/acpi-lid.txt
+++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
@@ -1,13 +1,18 @@
-Special Usage Model of the ACPI Control Method Lid Device
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-Copyright (C) 2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
+=========================================================
+Special Usage Model of the ACPI Control Method Lid Device
+=========================================================
 
+:Copyright: |copy| 2016, Intel Corporation
 
-Abstract:
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-Platforms containing lids convey lid state (open/close) to OSPMs using a
-control method lid device. To implement this, the AML tables issue
+Abstract
+========
+Platforms containing lids convey lid state (open/close) to OSPMs
+using a control method lid device. To implement this, the AML tables issue
 Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
 changed. The _LID control method for the lid device must be implemented to
 report the "current" state of the lid as either "opened" or "closed".
@@ -19,7 +24,8 @@ taken into account. This document describes the restrictions and the
 expections of the Linux ACPI lid device driver.
 
 
-1. Restrictions of the returning value of the _LID control method
+Restrictions of the returning value of the _LID control method
+==============================================================
 
 The _LID control method is described to return the "current" lid state.
 However the word of "current" has ambiguity, some buggy AML tables return
@@ -30,7 +36,8 @@ initial returning value. When the AML tables implement this control method
 with cached value, the initial returning value is likely not reliable.
 There are platforms always retun "closed" as initial lid state.
 
-2. Restrictions of the lid state change notifications
+Restrictions of the lid state change notifications
+==================================================
 
 There are buggy AML tables never notifying when the lid device state is
 changed to "opened". Thus the "opened" notification is not guaranteed. But
@@ -39,18 +46,22 @@ state is changed to "closed". The "closed" notification is normally used to
 trigger some system power saving operations on Windows. Since it is fully
 tested, it is reliable from all AML tables.
 
-3. Expections for the userspace users of the ACPI lid device driver
+Expections for the userspace users of the ACPI lid device driver
+================================================================
 
 The ACPI button driver exports the lid state to the userspace via the
-following file:
+following file::
+
   /proc/acpi/button/lid/LID0/state
+
 This file actually calls the _LID control method described above. And given
 the previous explanation, it is not reliable enough on some platforms. So
 it is advised for the userspace program to not to solely rely on this file
 to determine the actual lid state.
 
 The ACPI button driver emits the following input event to the userspace:
-  SW_LID
+  * SW_LID
+
 The ACPI lid device driver is implemented to try to deliver the platform
 triggered events to the userspace. However, given the fact that the buggy
 firmware cannot make sure "opened"/"closed" events are paired, the ACPI
@@ -59,20 +70,25 @@ button driver uses the following 3 modes in order not to trigger issues.
 If the userspace hasn't been prepared to ignore the unreliable "opened"
 events and the unreliable initial state notification, Linux users can use
 the following kernel parameters to handle the possible issues:
+
 A. button.lid_init_state=method:
    When this option is specified, the ACPI button driver reports the
    initial lid state using the returning value of the _LID control method
    and whether the "opened"/"closed" events are paired fully relies on the
    firmware implementation.
+
    This option can be used to fix some platforms where the returning value
    of the _LID control method is reliable but the initial lid state
    notification is missing.
+
    This option is the default behavior during the period the userspace
    isn't ready to handle the buggy AML tables.
+
 B. button.lid_init_state=open:
    When this option is specified, the ACPI button driver always reports the
    initial lid state as "opened" and whether the "opened"/"closed" events
    are paired fully relies on the firmware implementation.
+
    This may fix some platforms where the returning value of the _LID
    control method is not reliable and the initial lid state notification is
    missing.
@@ -80,6 +96,7 @@ B. button.lid_init_state=open:
 If the userspace has been prepared to ignore the unreliable "opened" events
 and the unreliable initial state notification, Linux users should always
 use the following kernel parameter:
+
 C. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
@@ -89,6 +106,7 @@ C. button.lid_init_state=ignore:
    notifications can be delivered to the userspace when the lid is actually
    opens given that some AML tables do not send "opened" notifications
    reliably.
+
    In this mode, if everything is correctly implemented by the platform
    firmware, the old userspace programs should still work. Otherwise, the
    new userspace programs are required to work with the ACPI button driver.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 1c89888f6ee8..bedcb0b242a2 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -14,3 +14,4 @@ ACPI Support
    DSD-properties-rules
    gpio-properties
    i2c-muxes
+   acpi-lid
\ No newline at end of file
-- 
2.20.1

