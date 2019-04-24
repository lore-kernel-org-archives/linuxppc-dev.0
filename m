Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44836C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:43:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF2720684
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUZxXuMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8NJ5gNrzDqbB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:43:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUZxXuMH"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7Kv04qzzDq9S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:56:35 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id f6so9734554pgs.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0U3DN21jJSHjryo32FyL3BVOe7dtJ75E6Tjlu2mOfww=;
 b=nUZxXuMHmHZjTQe7hXTfvhdb6ZxSf4CDP9pLxD2VyjX1+Ci95iAR6w4C5zKJ9QFXco
 fw4zxblIgzZjSY+Aq/PY2bd9axwQcCCgAZj2fLB7mKS7L5DXbxQ66Ok47p8qhUObY6VN
 JKG5YshwCAWFmhAaCH27cfw3rEBBAVQdtSCNliWDvnWxkImR6mmtR6afo1NIu7b5ArbG
 wkJ4NuWTJiD/2lGGcA03tEazAgNa3Zd1UN38HJRwRMkwNUFDQ+CR0tAQPzi1XjyIAlAd
 pgQeUWuiRue7c77EfrPqKT3bMDbuL5P7SN1OH3IGYNnC5HlMr6VHVTTL2tMnrikIrXA1
 f1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0U3DN21jJSHjryo32FyL3BVOe7dtJ75E6Tjlu2mOfww=;
 b=SejfDceiyibz1QqHgcD7Q8yhe3fVYU/6yFVh8disYqu/TCZklTMGltjkc5ZPN0k7/7
 SDhi6MZko8vFaAm8NfokVTsih44wTGcTuXEu2lbJvdnLAmTBssCU0L8P0rPxA0bOhKfU
 mXsK5hKbSq2q+v5QZBWEQdusZo49uSIOQ+kr5rd3Jb4yKIVgoRa9KP+F5R3gHmBtqFB5
 V3QGuk7TrOJH5PnyKHPUc1/FyIMX4CMmDhas2DWcG1+a9KpP/Kqz79H2qf3pNTsOX5v5
 sKUFFxzgH9QoIdD9Yx8VqwJ/SZSwKq/CJPpdtIup/H0lBuegSjZ8ruI/Ylwj0xEmd9p8
 KO9g==
X-Gm-Message-State: APjAAAWr9fKNSHVMMnFpCA9sHsoxaHRpTiFei7KHi0y09CWNyfw4F+zU
 QngM/g28AqvDu5wcMJDsHSA=
X-Google-Smtp-Source: APXvYqzUKdtoZrrcHYf0m3S+m3GOQIyalLZXRUiP86e3g6c/QnoG4upYiUZoi+K8ppKg6A8GFvSsJg==
X-Received: by 2002:a62:6444:: with SMTP id y65mr35093192pfb.56.1556128592689; 
 Wed, 24 Apr 2019 10:56:32 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.56.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:56:31 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 20/23] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:53:03 +0800
Message-Id: <20190424175306.25880-21-changbin.du@gmail.com>
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
---
 .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
 Documentation/admin-guide/acpi/index.rst      |  1 +
 2 files changed, 40 insertions(+), 32 deletions(-)
 rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)

diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
similarity index 51%
rename from Documentation/acpi/cppc_sysfs.txt
rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
index f20fb445135d..a4b99afbe331 100644
--- a/Documentation/acpi/cppc_sysfs.txt
+++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
@@ -1,5 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-	Collaborative Processor Performance Control (CPPC)
+==================================================
+Collaborative Processor Performance Control (CPPC)
+==================================================
+
+CPPC
+====
 
 CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
 performance of a logical processor on a contigious and abstract performance
@@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
 
 http://uefi.org/specifications
 
-Some of the CPPC registers are exposed via sysfs under:
-
-/sys/devices/system/cpu/cpuX/acpi_cppc/
-
-for each cpu X
+Some of the CPPC registers are exposed via sysfs under::
 
---------------------------------------------------------------------------------
+  /sys/devices/system/cpu/cpuX/acpi_cppc/
 
-$ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
-/sys/devices/system/cpu/cpu0/acpi_cppc/:
-total 0
--r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
--r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
--r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
+for each cpu X::
 
---------------------------------------------------------------------------------
+  $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
+  /sys/devices/system/cpu/cpu0/acpi_cppc/:
+  total 0
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
 
 * highest_perf : Highest performance of this processor (abstract scale).
-* nominal_perf : Highest sustained performance of this processor (abstract scale).
+* nominal_perf : Highest sustained performance of this processor
+  (abstract scale).
 * lowest_nonlinear_perf : Lowest performance of this processor with nonlinear
   power savings (abstract scale).
 * lowest_perf : Lowest performance of this processor (abstract scale).
@@ -48,22 +51,26 @@ total 0
 * feedback_ctrs : Includes both Reference and delivered performance counter.
   Reference counter ticks up proportional to processor's reference performance.
   Delivered counter ticks up proportional to processor's delivered performance.
-* wraparound_time: Minimum time for the feedback counters to wraparound (seconds).
+* wraparound_time: Minimum time for the feedback counters to wraparound
+  (seconds).
 * reference_perf : Performance level at which reference performance counter
   accumulates (abstract scale).
 
---------------------------------------------------------------------------------
 
-		Computing Average Delivered Performance
+Computing Average Delivered Performance
+=======================================
+
+Below describes the steps to compute the average performance delivered by
+taking two different snapshots of feedback counters at time T1 and T2.
+
+  T1: Read feedback_ctrs as fbc_t1
+      Wait or run some workload
 
-Below describes the steps to compute the average performance delivered by taking
-two different snapshots of feedback counters at time T1 and T2.
+  T2: Read feedback_ctrs as fbc_t2
 
-T1: Read feedback_ctrs as fbc_t1
-    Wait or run some workload
-T2: Read feedback_ctrs as fbc_t2
+::
 
-delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
-reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
+  delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
+  reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
 
-delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
+  delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index d68e9914c5ff..9049a7b9f065 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -10,3 +10,4 @@ the Linux ACPI support.
 
    initrd_table_override
    dsdt-override
+   cppc_sysfs
-- 
2.20.1

