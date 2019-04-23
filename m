Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E1C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:10:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8879217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt8pyqoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8879217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pZMM3hSMzDqQv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:10:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kt8pyqoD"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTX85YTCzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:33:12 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id f36so7780622plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ih5M3QLxnb62pgqDr7hpYz5eBp19cTzipgGgFqxkNiM=;
 b=Kt8pyqoDrio4nglOfbc63xLM04imtzDPf1kAED5tpX4Un9eIhp1u+Zwq3IV9s7q3P4
 6Pf69S5sboDetZA19EScrqLkn4pcJM6rKqflc0LbQeoJTZj8jkuolCZPVPGB+D64Oupd
 e/T4b4kyfNrpOKnXR0wt6PISyse2L301IZ1yJMTxvh0jqzrYGhaHDEjhZR1hg9u0BqZC
 qQaFjyvWQ4FDJRYHifT9He2C21F1MVgMvTzYYAnM/pPKDtgMR3rAHe66PZLYWoDt7F6X
 Rvf+cPFp016T1Fx9gcqc76fPIM9tbWmJRHLdpMkq7SY0l61VFO7rg1nUV2RPyw6zvLuZ
 QUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ih5M3QLxnb62pgqDr7hpYz5eBp19cTzipgGgFqxkNiM=;
 b=TPHm1f5NFE/1qkLQeBoHgZh7zF4Ampd816RuqaXXfA8aw/GjPlxHjjVuYt15/XW6aP
 VmGFnzBsPNyAhH+fOGcan72N07eM1+fyivRehU+014OC25QfPjd7XvwRwOKIv4DRphXO
 s1IDtUl7GE3hGQ8bD48oS8ACIkzbS3SWaEPKFquApm3ku+WwAverF+AJEY562FxgBhO1
 mHG487dW79dK/bXWt0yYfUv+OqWZyhQDjdyk2pf4TqtsOkb3ulQffzpAPRAu/iIMGdDY
 UDLy4ao+fj4dm3MgxmOuuwgBgXDtUYfHnbxusfPTFymSPx7RCSCZQw+zLeB1A34adP3l
 XX+g==
X-Gm-Message-State: APjAAAUj7nn61a6quaHHHnUls7cElqdLqf+npJMt5bk5EoARjwlqgZLV
 penwsaO9DOqdsc5Oi4TlP1o=
X-Google-Smtp-Source: APXvYqz2351U8JYGkC70RJiWFxVOtOtb+mgupX7ofrB1hfadbFjWn3RoR2DYdSHUtpZVMnwYgJ2/tA==
X-Received: by 2002:a17:902:7d91:: with SMTP id
 a17mr27021449plm.338.1556037190838; 
 Tue, 23 Apr 2019 09:33:10 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.33.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:33:10 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 18/63] Documentation: ACPI: move aml-debugger.txt to
 firmware-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 00:28:47 +0800
Message-Id: <20190423162932.21428-19-changbin.du@gmail.com>
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
 Documentation/acpi/aml-debugger.txt           | 66 ----------------
 .../firmware-guide/acpi/aml-debugger.rst      | 75 +++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 3 files changed, 76 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/acpi/aml-debugger.txt
 create mode 100644 Documentation/firmware-guide/acpi/aml-debugger.rst

diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
deleted file mode 100644
index 75ebeb64ab29..000000000000
--- a/Documentation/acpi/aml-debugger.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-The AML Debugger
-
-Copyright (C) 2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
-
-
-This document describes the usage of the AML debugger embedded in the Linux
-kernel.
-
-1. Build the debugger
-
-   The following kernel configuration items are required to enable the AML
-   debugger interface from the Linux kernel:
-
-   CONFIG_ACPI_DEBUGGER=y
-   CONFIG_ACPI_DEBUGGER_USER=m
-
-   The userspace utilities can be built from the kernel source tree using
-   the following commands:
-
-   $ cd tools
-   $ make acpi
-
-   The resultant userspace tool binary is then located at:
-
-     tools/power/acpi/acpidbg
-
-   It can be installed to system directories by running "make install" (as a
-   sufficiently privileged user).
-
-2. Start the userspace debugger interface
-
-   After booting the kernel with the debugger built-in, the debugger can be
-   started by using the following commands:
-
-   # mount -t debugfs none /sys/kernel/debug
-   # modprobe acpi_dbg
-   # tools/power/acpi/acpidbg
-
-   That spawns the interactive AML debugger environment where you can execute
-   debugger commands.
-
-   The commands are documented in the "ACPICA Overview and Programmer Reference"
-   that can be downloaded from
-
-   https://acpica.org/documentation
-
-   The detailed debugger commands reference is located in Chapter 12 "ACPICA
-   Debugger Reference".  The "help" command can be used for a quick reference.
-
-3. Stop the userspace debugger interface
-
-   The interactive debugger interface can be closed by pressing Ctrl+C or using
-   the "quit" or "exit" commands.  When finished, unload the module with:
-
-   # rmmod acpi_dbg
-
-   The module unloading may fail if there is an acpidbg instance running.
-
-4. Run the debugger in a script
-
-   It may be useful to run the AML debugger in a test script. "acpidbg" supports
-   this in a special "batch" mode.  For example, the following command outputs
-   the entire ACPI namespace:
-
-   # acpidbg -b "namespace"
diff --git a/Documentation/firmware-guide/acpi/aml-debugger.rst b/Documentation/firmware-guide/acpi/aml-debugger.rst
new file mode 100644
index 000000000000..a889d43bc6c5
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/aml-debugger.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+================
+The AML Debugger
+================
+
+:Copyright: |copy| 2016, Intel Corporation
+:Author: Lv Zheng <lv.zheng@intel.com>
+
+
+This document describes the usage of the AML debugger embedded in the Linux
+kernel.
+
+1. Build the debugger
+=====================
+
+The following kernel configuration items are required to enable the AML
+debugger interface from the Linux kernel::
+
+   CONFIG_ACPI_DEBUGGER=y
+   CONFIG_ACPI_DEBUGGER_USER=m
+
+The userspace utilities can be built from the kernel source tree using
+the following commands::
+
+   $ cd tools
+   $ make acpi
+
+The resultant userspace tool binary is then located at::
+
+   tools/power/acpi/acpidbg
+
+It can be installed to system directories by running "make install" (as a
+sufficiently privileged user).
+
+2. Start the userspace debugger interface
+=========================================
+
+After booting the kernel with the debugger built-in, the debugger can be
+started by using the following commands::
+
+   # mount -t debugfs none /sys/kernel/debug
+   # modprobe acpi_dbg
+   # tools/power/acpi/acpidbg
+
+That spawns the interactive AML debugger environment where you can execute
+debugger commands.
+
+The commands are documented in the "ACPICA Overview and Programmer Reference"
+that can be downloaded from
+
+https://acpica.org/documentation
+
+The detailed debugger commands reference is located in Chapter 12 "ACPICA
+Debugger Reference".  The "help" command can be used for a quick reference.
+
+3. Stop the userspace debugger interface
+========================================
+
+The interactive debugger interface can be closed by pressing Ctrl+C or using
+the "quit" or "exit" commands.  When finished, unload the module with::
+
+   # rmmod acpi_dbg
+
+The module unloading may fail if there is an acpidbg instance running.
+
+4. Run the debugger in a script
+===============================
+
+It may be useful to run the AML debugger in a test script. "acpidbg" supports
+this in a special "batch" mode.  For example, the following command outputs
+the entire ACPI namespace::
+
+   # acpidbg -b "namespace"
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 287a7cbd82ac..e9f253d54897 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -16,6 +16,7 @@ ACPI Support
    method-tracing
    DSD-properties-rules
    debug
+   aml-debugger
    gpio-properties
    i2c-muxes
    acpi-lid
-- 
2.20.1

