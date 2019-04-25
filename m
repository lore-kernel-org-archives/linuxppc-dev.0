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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90266C43218
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8625A20651
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPzMGLlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8625A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qj181P7ZzDqgw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 02:14:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OPzMGLlO"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh6G0k17zDqWd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:33:26 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id z5so100254pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SiNk3x+W/BJ3dxXGT9anGpXBInjJatxrO4dxNV7Y5gk=;
 b=OPzMGLlOARPY2cG9nPBcD320RyElIGwznb0vbjTW3Vz4xNJbHPqnawn3yra9NnLjOM
 23iafwCOM5xBWVPtwnFJBXKLeDozafkKMUiQdR2clZkE1yjXROlTW213rAe+Qr6Kp34m
 EMzlcfMEhvt2NMms52jgJTb5Gf7ILlVz5YmM2/Ho6Zajxxi5kmc4pcNuanspWVpS9AtG
 0z6awoBru6FJoalGp3QxFPvg7p4DYzzPsWdvWrWU62d5N/oLcSd5sBDcnXTq3Gspf5os
 oISwywVg+Ea9N+/Jo2VfjUzfnNom6hJue3Z4YbvbwG/OgZZ+oS9pbdkjiVPpGeLhTeiT
 4ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SiNk3x+W/BJ3dxXGT9anGpXBInjJatxrO4dxNV7Y5gk=;
 b=iY+A0UW7crSPFif5UODYUGYTIUYQG+xgTjDef3gZ04hcf4Gc26QBUhN8wtRIILjg64
 WJqn2KsCrGpshp8IBvcg7bPmAzCp26FYg5hTT6Di5C9TxBrGXrM14BZ+c4AkGiCmxXpX
 i0295P3U02nETLbClF1Yejuou/sMDJWYTIdiAG5EJAXluy8brlboyouFl0n7iy8W5+XE
 CAcft22N90FM1yhdgcAytKCpmi+k4FMVdRmdCVnSA1U87fM/tEg6cfWqxF2EJvqrTx6h
 oLXeYyITJ5sf9pNTBADKItfytCe7tkUSHXnALyoMyt4jHt04YBwqRcsmChU2d8tzk4Oe
 T1fQ==
X-Gm-Message-State: APjAAAXwNtosHrCwGzYmJiA1stu2rRyEfrMXMmsfRwRU1ZFwecgF4LvD
 WqcjEuQN0fkuloPxgZr8O1I=
X-Google-Smtp-Source: APXvYqzfbke8vxzy2xzMUC1R20hz9OOeC10ULwX5vi07cpuyw3J9zWHUHa3mhL5NjaskoQ1CfzUhYw==
X-Received: by 2002:a62:424f:: with SMTP id p76mr40746220pfa.141.1556206400995; 
 Thu, 25 Apr 2019 08:33:20 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.33.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:33:20 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 18/24] Documentation: ACPI: move aml-debugger.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:31:11 +0800
Message-Id: <20190425153117.16057-19-changbin.du@gmail.com>
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

