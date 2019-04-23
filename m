Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9DAC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:19:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542D321850
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4NzplBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542D321850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pZXg4p0WzDqQ5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:18:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="o4NzplBc"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTXc3KM5zDqJN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:33:36 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id o7so5542484pll.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I6tuFAp1pdSIAlsBwQ67ixtSsuAlxWgW/8yFHNcYLS8=;
 b=o4NzplBcTwn356Mpy1NthtSN3lF0bYcgqMOpcJHB+T353A3GAUYpc/kaEpXRYJ6w/B
 VqVUKFwR7OambfUilDbzGzZRqlf6HkbsgR4AGXPyZOqd+DuRCQi060rvfdtzywXwFCj9
 MfEO1bw3qre/hWn4/Ex4BlqLDZPbCnkz3H6mtlpUjJs12hmXREMjImbmMx4o7sPPP7B9
 GnHjrKGYVdxUQ/R6fg0V3tT6fx4CnjJf3YDFsUFSz0/wk6/yJZCk38IQuSQSqcW6mBtb
 arVTGDR9lHyBFcXoYLCBw72qSAYbkKAu97T/afn6x72I6ddbvotxQ6ttY3dCcbPUM3Xp
 n7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I6tuFAp1pdSIAlsBwQ67ixtSsuAlxWgW/8yFHNcYLS8=;
 b=AbkDPwhWQ+qysi1mX+tdtV+qU7wQu6qjDESVGUmBCFzL7PmY0UI/fjHJWk7Mu3l5Jd
 hVafzMbq+yASm85gLHNpwYAw0/nIFCS/AIhI0jyvwOWAyX7CIi+6JIDu3lFkm68inYiv
 AxF2C8QZ68CnZFUp8xVCbzrgpl5+ym0Lesi1hmNkvky4Avd4JQ/45wS3J48xMZr30hjn
 ysNAAjtW/GO+/WxPG8pvo0OIMhlQuN+s12pKyVVhah0un7YPFci3zDyFnUznzZ7WFNOp
 pSTEcXoOtQYqSJPDMbU1cqasUlHTZDjZ+Qa4EOne4Gbgchy9dmhbF+Q1euYZgD/FURpd
 rRdA==
X-Gm-Message-State: APjAAAWoVurFY0WWpqR+gksjI2fwsHd/2m3TGPDfWwGSIOa/Yg7L2I1w
 cr6EXnYZ34a4fpAFEY+DsYU=
X-Google-Smtp-Source: APXvYqys2+DYe1CkhTDZP/jSob4WeHej8CB10XNWQ1l9KDbWzVMk33Bk/JJwDjqpv5cQpc4YgBnvtg==
X-Received: by 2002:a17:902:e407:: with SMTP id
 ci7mr26981474plb.219.1556037214117; 
 Tue, 23 Apr 2019 09:33:34 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.33.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:33:33 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 20/63] Documentation: ACPI: move apei/einj.txt to
 firmware-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 00:28:49 +0800
Message-Id: <20190423162932.21428-21-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
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
 .../acpi/apei/einj.rst}                       | 98 ++++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 53 insertions(+), 46 deletions(-)
 rename Documentation/{acpi/apei/einj.txt => firmware-guide/acpi/apei/einj.rst} (67%)

diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/firmware-guide/acpi/apei/einj.rst
similarity index 67%
rename from Documentation/acpi/apei/einj.txt
rename to Documentation/firmware-guide/acpi/apei/einj.rst
index e550c8b98139..d85e2667155c 100644
--- a/Documentation/acpi/apei/einj.txt
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -1,13 +1,16 @@
-			APEI Error INJection
-			~~~~~~~~~~~~~~~~~~~~
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+APEI Error INJection
+====================
 
 EINJ provides a hardware error injection mechanism. It is very useful
 for debugging and testing APEI and RAS features in general.
 
 You need to check whether your BIOS supports EINJ first. For that, look
-for early boot messages similar to this one:
+for early boot messages similar to this one::
 
-ACPI: EINJ 0x000000007370A000 000150 (v01 INTEL           00000001 INTL 00000001)
+  ACPI: EINJ 0x000000007370A000 000150 (v01 INTEL           00000001 INTL 00000001)
 
 which shows that the BIOS is exposing an EINJ table - it is the
 mechanism through which the injection is done.
@@ -23,11 +26,11 @@ order to see the APEI,EINJ,... functionality supported and exposed by
 the BIOS menu.
 
 To use EINJ, make sure the following are options enabled in your kernel
-configuration:
+configuration::
 
-CONFIG_DEBUG_FS
-CONFIG_ACPI_APEI
-CONFIG_ACPI_APEI_EINJ
+  CONFIG_DEBUG_FS
+  CONFIG_ACPI_APEI
+  CONFIG_ACPI_APEI_EINJ
 
 The EINJ user interface is in <debugfs mount point>/apei/einj.
 
@@ -35,22 +38,22 @@ The following files belong to it:
 
 - available_error_type
 
-  This file shows which error types are supported:
-
-  Error Type Value	Error Description
-  ================	=================
-  0x00000001		Processor Correctable
-  0x00000002		Processor Uncorrectable non-fatal
-  0x00000004		Processor Uncorrectable fatal
-  0x00000008		Memory Correctable
-  0x00000010		Memory Uncorrectable non-fatal
-  0x00000020		Memory Uncorrectable fatal
-  0x00000040		PCI Express Correctable
-  0x00000080		PCI Express Uncorrectable fatal
-  0x00000100		PCI Express Uncorrectable non-fatal
-  0x00000200		Platform Correctable
-  0x00000400		Platform Uncorrectable non-fatal
-  0x00000800		Platform Uncorrectable fatal
+  This file shows which error types are supported::
+
+    Error Type Value	Error Description
+    ================	=================
+    0x00000001		Processor Correctable
+    0x00000002		Processor Uncorrectable non-fatal
+    0x00000004		Processor Uncorrectable fatal
+    0x00000008		Memory Correctable
+    0x00000010		Memory Uncorrectable non-fatal
+    0x00000020		Memory Uncorrectable fatal
+    0x00000040		PCI Express Correctable
+    0x00000080		PCI Express Uncorrectable fatal
+    0x00000100		PCI Express Uncorrectable non-fatal
+    0x00000200		Platform Correctable
+    0x00000400		Platform Uncorrectable non-fatal
+    0x00000800		Platform Uncorrectable fatal
 
   The format of the file contents are as above, except present are only
   the available error types.
@@ -73,9 +76,12 @@ The following files belong to it:
   injection. Value is a bitmask as specified in ACPI5.0 spec for the
   SET_ERROR_TYPE_WITH_ADDRESS data structure:
 
-	Bit 0 - Processor APIC field valid (see param3 below).
-	Bit 1 - Memory address and mask valid (param1 and param2).
-	Bit 2 - PCIe (seg,bus,dev,fn) valid (see param4 below).
+    Bit 0
+      Processor APIC field valid (see param3 below).
+    Bit 1
+      Memory address and mask valid (param1 and param2).
+    Bit 2
+      PCIe (seg,bus,dev,fn) valid (see param4 below).
 
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
@@ -121,7 +127,7 @@ BIOS versions based on the ACPI 5.0 specification have more control over
 the target of the injection. For processor-related errors (type 0x1, 0x2
 and 0x4), you can set flags to 0x3 (param3 for bit 0, and param1 and
 param2 for bit 1) so that you have more information added to the error
-signature being injected. The actual data passed is this:
+signature being injected. The actual data passed is this::
 
 	memory_address = param1;
 	memory_address_range = param2;
@@ -131,7 +137,7 @@ signature being injected. The actual data passed is this:
 For memory errors (type 0x8, 0x10 and 0x20) the address is set using
 param1 with a mask in param2 (0x0 is equivalent to all ones). For PCI
 express errors (type 0x40, 0x80 and 0x100) the segment, bus, device and
-function are specified using param1:
+function are specified using param1::
 
          31     24 23    16 15    11 10      8  7        0
 	+-------------------------------------------------+
@@ -152,26 +158,26 @@ documentation for details (and expect changes to this API if vendors
 creativity in using this feature expands beyond our expectations).
 
 
-An error injection example:
+An error injection example::
 
-# cd /sys/kernel/debug/apei/einj
-# cat available_error_type		# See which errors can be injected
-0x00000002	Processor Uncorrectable non-fatal
-0x00000008	Memory Correctable
-0x00000010	Memory Uncorrectable non-fatal
-# echo 0x12345000 > param1		# Set memory address for injection
-# echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
-# echo 0x8 > error_type			# Choose correctable memory error
-# echo 1 > error_inject			# Inject now
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type		# See which errors can be injected
+  0x00000002	Processor Uncorrectable non-fatal
+  0x00000008	Memory Correctable
+  0x00000010	Memory Uncorrectable non-fatal
+  # echo 0x12345000 > param1		# Set memory address for injection
+  # echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
+  # echo 0x8 > error_type			# Choose correctable memory error
+  # echo 1 > error_inject			# Inject now
 
-You should see something like this in dmesg:
+You should see something like this in dmesg::
 
-[22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-[22715.834759] EDAC sbridge MC3: CPU 0: Machine Check Event: 0 Bank 7: 8c00004000010090
-[22715.834759] EDAC sbridge MC3: TSC 0
-[22715.834759] EDAC sbridge MC3: ADDR 12345000 EDAC sbridge MC3: MISC 144780c86
-[22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
-[22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
+  [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
+  [22715.834759] EDAC sbridge MC3: CPU 0: Machine Check Event: 0 Bank 7: 8c00004000010090
+  [22715.834759] EDAC sbridge MC3: TSC 0
+  [22715.834759] EDAC sbridge MC3: ADDR 12345000 EDAC sbridge MC3: MISC 144780c86
+  [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
+  [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
 For more information about EINJ, please refer to ACPI specification
 version 4.0, section 17.5 and ACPI 5.0, section 18.6.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 869badba6d7a..fca854f017d8 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -18,6 +18,7 @@ ACPI Support
    debug
    aml-debugger
    apei/output_format
+   apei/einj
    gpio-properties
    i2c-muxes
    acpi-lid
-- 
2.20.1

