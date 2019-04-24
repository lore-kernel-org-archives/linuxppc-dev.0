Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41AFC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:37:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2038721773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKTACeiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2038721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8Dw24DczDqDp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:37:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKTACeiA"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7KM43vdzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:56:07 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id j26so9745918pgl.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NT3z5Vy1lSgmG9M1ZhYNiLgqFGSGEOj1OSZGtZUffjw=;
 b=DKTACeiAHMEXcpp/BT59SzIvBWum7fBCUCzQEh75XfkPNerV6gIRnestwu7B+/EW5Z
 SgujL8qQgVOdUJr03Ay8GXwlbT5AM5K9S3bJuaxuYZzxGXq2gtHjQzSbrWmdgTVR9XkW
 CMJS+Zu260TlPdlgunUGnWZUTfFL8BtG+VX1Wua535E0qw2THDSg4CTsLGX7ZdfAbIYe
 tM2NdqqGQXzSjIMTn0n/RWMBaQpXzWK1UlYec2neTovp9y86I22zDoNOcE1jbuFvnhCS
 NhkzWxXw1YnqQJ1i/q7ezJzV17BVOCD/Cort/6czsHhap9CKLb0pEyvrK4sXwUsat3nH
 aXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NT3z5Vy1lSgmG9M1ZhYNiLgqFGSGEOj1OSZGtZUffjw=;
 b=NDtZ1rjNqSb7OvXrcPpOnulkbHeZnxq1TQESm5yS6FE5abUH/3k7/H6ji7rFqFQmxu
 2brRAXy91yZafWoPsFs4+zlR9NQetkGjWpajJU39GiW3azZ7f0wYTu36/AE0OKa1Q+4T
 O8ZwVSv0K9p1cvLpzs054AE9+CdfG2AOnz0hMyTQVNKfXVlLXRDh6XDY2+vHF1gYKWlc
 y1bBfb86lLLcrc5AsgKxj87IuMeiivUUEzmlL1tbzb/pTeqYJkeGfW/aFheiO5Befif+
 5oGbKudh9w3FEvn43u7GpiyPTMepou9THggyfaIBFPtYzTurlXKlYageQxVslfXWcwX4
 c6ww==
X-Gm-Message-State: APjAAAUWQWtaHO5fIKic/9eC+/jLCdjh2bxxJ20W1Vlp4wW+lx+7W2OM
 WsXbFia3orUAaLHEle5prcotiKnw
X-Google-Smtp-Source: APXvYqziEGHtpdur12Al8wGINIJj18s7h/C3LcwzAk5qLcOSWMi6lPHVaOSTeDTNp2l8w8/N1lIa0Q==
X-Received: by 2002:a65:625a:: with SMTP id q26mr32556691pgv.68.1556128565222; 
 Wed, 24 Apr 2019 10:56:05 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:56:04 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 16/23] Documentation: ACPI: move method-tracing.txt to
 firmware-guide/acpi and convert to rsST
Date: Thu, 25 Apr 2019 01:52:59 +0800
Message-Id: <20190424175306.25880-17-changbin.du@gmail.com>
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
 Documentation/acpi/method-tracing.txt         | 192 --------------
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 .../firmware-guide/acpi/method-tracing.rst    | 238 ++++++++++++++++++
 3 files changed, 239 insertions(+), 192 deletions(-)
 delete mode 100644 Documentation/acpi/method-tracing.txt
 create mode 100644 Documentation/firmware-guide/acpi/method-tracing.rst

diff --git a/Documentation/acpi/method-tracing.txt b/Documentation/acpi/method-tracing.txt
deleted file mode 100644
index 0aba14c8f459..000000000000
--- a/Documentation/acpi/method-tracing.txt
+++ /dev/null
@@ -1,192 +0,0 @@
-ACPICA Trace Facility
-
-Copyright (C) 2015, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
-
-
-Abstract:
-
-This document describes the functions and the interfaces of the method
-tracing facility.
-
-1. Functionalities and usage examples:
-
-   ACPICA provides method tracing capability. And two functions are
-   currently implemented using this capability.
-
-   A. Log reducer
-   ACPICA subsystem provides debugging outputs when CONFIG_ACPI_DEBUG is
-   enabled. The debugging messages which are deployed via
-   ACPI_DEBUG_PRINT() macro can be reduced at 2 levels - per-component
-   level (known as debug layer, configured via
-   /sys/module/acpi/parameters/debug_layer) and per-type level (known as
-   debug level, configured via /sys/module/acpi/parameters/debug_level).
-
-   But when the particular layer/level is applied to the control method
-   evaluations, the quantity of the debugging outputs may still be too
-   large to be put into the kernel log buffer. The idea thus is worked out
-   to only enable the particular debug layer/level (normally more detailed)
-   logs when the control method evaluation is started, and disable the
-   detailed logging when the control method evaluation is stopped.
-
-   The following command examples illustrate the usage of the "log reducer"
-   functionality:
-   a. Filter out the debug layer/level matched logs when control methods
-      are being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "enable" > trace_state
-   b. Filter out the debug layer/level matched logs when the specified
-      control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method" > /sys/module/acpi/parameters/trace_state
-   c. Filter out the debug layer/level matched logs when the specified
-      control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method-once" > /sys/module/acpi/parameters/trace_state
-   Where:
-      0xXXXXXXXX/0xYYYYYYYY: Refer to Documentation/acpi/debug.txt for
-			     possible debug layer/level masking values.
-      \PPPP.AAAA.TTTT.HHHH: Full path of a control method that can be found
-			    in the ACPI namespace. It needn't be an entry
-			    of a control method evaluation.
-
-   B. AML tracer
-
-   There are special log entries added by the method tracing facility at
-   the "trace points" the AML interpreter starts/stops to execute a control
-   method, or an AML opcode. Note that the format of the log entries are
-   subject to change:
-     [    0.186427]   exdebug-0398 ex_trace_point        : Method Begin [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
-     [    0.186630]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905c88:If] execution.
-     [    0.186820]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:LEqual] execution.
-     [    0.187010]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905a20:-NamePath-] execution.
-     [    0.187214]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905a20:-NamePath-] execution.
-     [    0.187407]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905f60:One] execution.
-     [    0.187594]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905f60:One] execution.
-     [    0.187789]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905cc0:LEqual] execution.
-     [    0.187980]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:Return] execution.
-     [    0.188146]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905f60:One] execution.
-     [    0.188334]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905f60:One] execution.
-     [    0.188524]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905cc0:Return] execution.
-     [    0.188712]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905c88:If] execution.
-     [    0.188903]   exdebug-0398 ex_trace_point        : Method End [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
-
-   Developers can utilize these special log entries to track the AML
-   interpretion, thus can aid issue debugging and performance tuning. Note
-   that, as the "AML tracer" logs are implemented via ACPI_DEBUG_PRINT()
-   macro, CONFIG_ACPI_DEBUG is also required to be enabled for enabling
-   "AML tracer" logs.
-
-   The following command examples illustrate the usage of the "AML tracer"
-   functionality:
-   a. Filter out the method start/stop "AML tracer" logs when control
-      methods are being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "enable" > trace_state
-   b. Filter out the method start/stop "AML tracer" when the specified
-      control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method" > trace_state
-   c. Filter out the method start/stop "AML tracer" logs when the specified
-      control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method-once" > trace_state
-   d. Filter out the method/opcode start/stop "AML tracer" when the
-      specified control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "opcode" > trace_state
-   e. Filter out the method/opcode start/stop "AML tracer" when the
-      specified control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "opcode-opcode" > trace_state
-
-  Note that all above method tracing facility related module parameters can
-  be used as the boot parameters, for example:
-      acpi.trace_debug_layer=0x80 acpi.trace_debug_level=0x10 \
-      acpi.trace_method_name=\_SB.LID0._LID acpi.trace_state=opcode-once
-
-2. Interface descriptions:
-
-   All method tracing functions can be configured via ACPI module
-   parameters that are accessible at /sys/module/acpi/parameters/:
-
-   trace_method_name
-	The full path of the AML method that the user wants to trace.
-	Note that the full path shouldn't contain the trailing "_"s in its
-	name segments but may contain "\" to form an absolute path.
-
-   trace_debug_layer
-	The temporary debug_layer used when the tracing feature is enabled.
-	Using ACPI_EXECUTER (0x80) by default, which is the debug_layer
-	used to match all "AML tracer" logs.
-
-   trace_debug_level
-	The temporary debug_level used when the tracing feature is enabled.
-	Using ACPI_LV_TRACE_POINT (0x10) by default, which is the
-	debug_level used to match all "AML tracer" logs.
-
-   trace_state
-	The status of the tracing feature.
-	Users can enable/disable this debug tracing feature by executing
-	the following command:
-	    # echo string > /sys/module/acpi/parameters/trace_state
-	Where "string" should be one of the following:
-	"disable"
-	    Disable the method tracing feature.
-	"enable"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during any method
-	    execution will be logged.
-	"method"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during method execution
-	    of "trace_method_name" will be logged.
-	"method-once"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during method execution
-	    of "trace_method_name" will be logged only once.
-	"opcode"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during method/opcode
-	    execution of "trace_method_name" will be logged.
-	"opcode-once"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during method/opcode
-	    execution of "trace_method_name" will be logged only once.
-	Note that, the difference between the "enable" and other feature
-        enabling options are:
-	1. When "enable" is specified, since
-	   "trace_debug_layer/trace_debug_level" shall apply to all control
-	   method evaluations, after configuring "trace_state" to "enable",
-	   "trace_method_name" will be reset to NULL.
-	2. When "method/opcode" is specified, if
-	   "trace_method_name" is NULL when "trace_state" is configured to
-	   these options, the "trace_debug_layer/trace_debug_level" will
-	   apply to all control method evaluations.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index a45fea11f998..287a7cbd82ac 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -13,6 +13,7 @@ ACPI Support
    enumeration
    osi
    method-customizing
+   method-tracing
    DSD-properties-rules
    debug
    gpio-properties
diff --git a/Documentation/firmware-guide/acpi/method-tracing.rst b/Documentation/firmware-guide/acpi/method-tracing.rst
new file mode 100644
index 000000000000..d0b077b73f5f
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/method-tracing.rst
@@ -0,0 +1,238 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=====================
+ACPICA Trace Facility
+=====================
+
+:Copyright: |copy| 2015, Intel Corporation
+:Author: Lv Zheng <lv.zheng@intel.com>
+
+
+Abstract
+========
+This document describes the functions and the interfaces of the
+method tracing facility.
+
+Functionalities and usage examples
+==================================
+
+ACPICA provides method tracing capability. And two functions are
+currently implemented using this capability.
+
+Log reducer
+-----------
+
+ACPICA subsystem provides debugging outputs when CONFIG_ACPI_DEBUG is
+enabled. The debugging messages which are deployed via
+ACPI_DEBUG_PRINT() macro can be reduced at 2 levels - per-component
+level (known as debug layer, configured via
+/sys/module/acpi/parameters/debug_layer) and per-type level (known as
+debug level, configured via /sys/module/acpi/parameters/debug_level).
+
+But when the particular layer/level is applied to the control method
+evaluations, the quantity of the debugging outputs may still be too
+large to be put into the kernel log buffer. The idea thus is worked out
+to only enable the particular debug layer/level (normally more detailed)
+logs when the control method evaluation is started, and disable the
+detailed logging when the control method evaluation is stopped.
+
+The following command examples illustrate the usage of the "log reducer"
+functionality:
+
+a. Filter out the debug layer/level matched logs when control methods
+   are being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0xXXXXXXXX" > trace_debug_layer
+      # echo "0xYYYYYYYY" > trace_debug_level
+      # echo "enable" > trace_state
+
+b. Filter out the debug layer/level matched logs when the specified
+   control method is being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0xXXXXXXXX" > trace_debug_layer
+      # echo "0xYYYYYYYY" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "method" > /sys/module/acpi/parameters/trace_state
+
+c. Filter out the debug layer/level matched logs when the specified
+   control method is being evaluated for the first time::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0xXXXXXXXX" > trace_debug_layer
+      # echo "0xYYYYYYYY" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "method-once" > /sys/module/acpi/parameters/trace_state
+
+Where:
+   0xXXXXXXXX/0xYYYYYYYY
+     Refer to Documentation/acpi/debug.txt for possible debug layer/level
+     masking values.
+   \PPPP.AAAA.TTTT.HHHH
+     Full path of a control method that can be found in the ACPI namespace.
+     It needn't be an entry of a control method evaluation.
+
+AML tracer
+----------
+
+There are special log entries added by the method tracing facility at
+the "trace points" the AML interpreter starts/stops to execute a control
+method, or an AML opcode. Note that the format of the log entries are
+subject to change::
+
+   [    0.186427]   exdebug-0398 ex_trace_point        : Method Begin [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
+   [    0.186630]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905c88:If] execution.
+   [    0.186820]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:LEqual] execution.
+   [    0.187010]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905a20:-NamePath-] execution.
+   [    0.187214]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905a20:-NamePath-] execution.
+   [    0.187407]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905f60:One] execution.
+   [    0.187594]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905f60:One] execution.
+   [    0.187789]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905cc0:LEqual] execution.
+   [    0.187980]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:Return] execution.
+   [    0.188146]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905f60:One] execution.
+   [    0.188334]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905f60:One] execution.
+   [    0.188524]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905cc0:Return] execution.
+   [    0.188712]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905c88:If] execution.
+   [    0.188903]   exdebug-0398 ex_trace_point        : Method End [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
+
+Developers can utilize these special log entries to track the AML
+interpretion, thus can aid issue debugging and performance tuning. Note
+that, as the "AML tracer" logs are implemented via ACPI_DEBUG_PRINT()
+macro, CONFIG_ACPI_DEBUG is also required to be enabled for enabling
+"AML tracer" logs.
+
+The following command examples illustrate the usage of the "AML tracer"
+functionality:
+
+a. Filter out the method start/stop "AML tracer" logs when control
+   methods are being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "enable" > trace_state
+
+b. Filter out the method start/stop "AML tracer" when the specified
+   control method is being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "method" > trace_state
+
+c. Filter out the method start/stop "AML tracer" logs when the specified
+   control method is being evaluated for the first time::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "method-once" > trace_state
+
+d. Filter out the method/opcode start/stop "AML tracer" when the
+   specified control method is being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "opcode" > trace_state
+
+e. Filter out the method/opcode start/stop "AML tracer" when the
+   specified control method is being evaluated for the first time::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "opcode-opcode" > trace_state
+
+Note that all above method tracing facility related module parameters can
+be used as the boot parameters, for example::
+
+   acpi.trace_debug_layer=0x80 acpi.trace_debug_level=0x10 \
+   acpi.trace_method_name=\_SB.LID0._LID acpi.trace_state=opcode-once
+
+
+Interface descriptions
+======================
+
+All method tracing functions can be configured via ACPI module
+parameters that are accessible at /sys/module/acpi/parameters/:
+
+trace_method_name
+  The full path of the AML method that the user wants to trace.
+
+  Note that the full path shouldn't contain the trailing "_"s in its
+  name segments but may contain "\" to form an absolute path.
+
+trace_debug_layer
+  The temporary debug_layer used when the tracing feature is enabled.
+
+  Using ACPI_EXECUTER (0x80) by default, which is the debug_layer
+  used to match all "AML tracer" logs.
+
+trace_debug_level
+  The temporary debug_level used when the tracing feature is enabled.
+
+  Using ACPI_LV_TRACE_POINT (0x10) by default, which is the
+  debug_level used to match all "AML tracer" logs.
+
+trace_state
+  The status of the tracing feature.
+
+  Users can enable/disable this debug tracing feature by executing
+  the following command::
+
+   # echo string > /sys/module/acpi/parameters/trace_state
+
+Where "string" should be one of the following:
+
+"disable"
+  Disable the method tracing feature.
+
+"enable"
+  Enable the method tracing feature.
+  
+  ACPICA debugging messages matching "trace_debug_layer/trace_debug_level"
+  during any method execution will be logged.
+
+"method"
+  Enable the method tracing feature.
+
+  ACPICA debugging messages matching "trace_debug_layer/trace_debug_level"
+  during method execution of "trace_method_name" will be logged.
+
+"method-once"
+  Enable the method tracing feature.
+
+  ACPICA debugging messages matching "trace_debug_layer/trace_debug_level"
+  during method execution of "trace_method_name" will be logged only once.
+
+"opcode"
+  Enable the method tracing feature.
+
+  ACPICA debugging messages matching "trace_debug_layer/trace_debug_level"
+  during method/opcode execution of "trace_method_name" will be logged.
+
+"opcode-once"
+  Enable the method tracing feature.
+
+  ACPICA debugging messages matching "trace_debug_layer/trace_debug_level"
+  during method/opcode execution of "trace_method_name" will be logged only
+  once.
+
+Note that, the difference between the "enable" and other feature
+enabling options are:
+
+1. When "enable" is specified, since
+   "trace_debug_layer/trace_debug_level" shall apply to all control
+   method evaluations, after configuring "trace_state" to "enable",
+   "trace_method_name" will be reset to NULL.
+2. When "method/opcode" is specified, if
+   "trace_method_name" is NULL when "trace_state" is configured to
+   these options, the "trace_debug_layer/trace_debug_level" will
+   apply to all control method evaluations.
-- 
2.20.1

