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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8333CC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:39:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F5321773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU1VC6HG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F5321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8Gp48lfzDqLF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:38:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fU1VC6HG"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7KT0njYzDqXC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:56:13 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id b3so9661601plr.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SiNk3x+W/BJ3dxXGT9anGpXBInjJatxrO4dxNV7Y5gk=;
 b=fU1VC6HGHYfYZuJvnjhMKmgzBWwP+nRp6UQItGoT7Pddcrrj7P9UvEScGXMCX0MPAE
 N1kQOWrKjY9I7K8AHjvQUJCl5J9jFmn0NBrTvSH/fES0XMDmj11tCPQRZbOiPSim3BwG
 Y2VWtytyJy21IryxI7t7S88bGHw3Jtl/+e1IKsGpc3d7xMk7duyG2VQ81cEr4n5Wt+Ey
 OAtrU5BRQL+IUb8/WTeR7zTNSykqwouyincrxm/aNd/MjGaRiWXERbJqMHcQ1W8zFA4D
 kcrubnIQ20CekKds5fdflSsZtM2Su8yXDgDV1VMKT/f0F08l3JSRAbTR7oqsRlhbuJrL
 ZC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SiNk3x+W/BJ3dxXGT9anGpXBInjJatxrO4dxNV7Y5gk=;
 b=TefTHqHpCPvXEUzWaFrANUdFdqgPvVSV2ON8zV8p3O8PiAhSqLBIWiYzSjqpdOMe7T
 iTJotXPJiuykfh30rHOSh1CkMPiKU1VtHlfS3C3erk07qb8vbc4kGAwNE/ipHLBvgaQC
 8uvQ9Ee08GfBEhpnG0W8XUeKIXDbB7KD/NBlkSGLq+ULPOl8P4WA2slE817bbZwLBzz0
 qKobuBq5JO78hz97kUFaaskmk82KDyLvFgLUWsUzqBsv3Ad8nv4/gknKceSU7jmwMHOF
 Lg1ZU6XnnZmzT2ubCKo6v4Ti3yDH8n4qV0ImXPPiET57d1RwcxmnwgjwKiAfx61Je3B8
 9YGQ==
X-Gm-Message-State: APjAAAXJwmOAOUmt6Pxk1JRyJlmJ9td1HK/jdELH2nBT2d1MCG+IlFJ0
 UQ14PlLQ0nttSeZ7/y6YcVc=
X-Google-Smtp-Source: APXvYqwgZX6+jtEhxKCQSKMqzZ7iL6m64NxAllNsDMVg3l7V5O+EaMpe7PYzDy72lEM/M7mUw6AXog==
X-Received: by 2002:a17:902:7241:: with SMTP id
 c1mr12932479pll.326.1556128571112; 
 Wed, 24 Apr 2019 10:56:11 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.56.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Apr 2019 10:56:10 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 17/23] Documentation: ACPI: move aml-debugger.txt to
 firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:53:00 +0800
Message-Id: <20190424175306.25880-18-changbin.du@gmail.com>
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

