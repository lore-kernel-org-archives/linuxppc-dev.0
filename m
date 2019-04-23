Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B97C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 19:44:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0430521773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 19:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oztcbau6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0430521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pYnB1vLHzDqCT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 05:44:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oztcbau6"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTTC3d40zDqD4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:30:39 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id b3so7787568plr.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hv6IafG6PXUChLf829/adbyNwFbqlej4B8eSgkihCvw=;
 b=oztcbau6apuY+tQ1gv1wXtWycyIG1ePkZ3TZUcqYNBtAZPzIrXG3UMDXYog4F5hGGk
 BolSUGeA6YcqjLxwNUjXSaLlg3nR+XvhzJ2Xwb5xtUmA52GMxmCtLtvcI8gBdJpEMWoc
 nsQZl3IAyQ3gKNFd0auG067WG1SBmyGwysYH35NoQufYctcjyjajOzGsaqG8awtI1atB
 LKmodt+SHo4/FGrsKwvNNH9vW4bZ898+CueZ5DnzjhcklwM3QPe+V7vQMT8wu9JhttLw
 T/Qvif5GWKyfvn8ezlf/rKdJDqFE1esdWWloa7yOSR0MMqwQWgDwSvIIW+ACD6lRlrQC
 qyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hv6IafG6PXUChLf829/adbyNwFbqlej4B8eSgkihCvw=;
 b=eeX7GNS+FAp19swe9Wp0WJWeT519V0aVZ4fgTEJtE2+C8jglGHwP5fZNmm4FQWvy8O
 rO6+554gCb/DaqVpzTd7r2qwQ4cDhqa3G4PErYWmMDDRrhjYHtF9ymwBorYJYbv4lbAK
 Eo3+3ZOw5mNo0BX4FTi/Lormn8a+vvmSquf4HE+916BOTF8Cec1F7f4Em70BAzk2+7Nx
 r7tmGl6SA2qjQMQY/9fMGoqxbM4Gj/M9XgR6LK2gEUkvFc5lT8Yo4LZ0r15sdm3mggU5
 QFUO0hd85XHuq9sFy/68zQYQ0pyT8+IihTTXZnmc6Z995zx7FQJIlf6/HxVwWwTpJCLX
 CCfA==
X-Gm-Message-State: APjAAAVyOxh2r5Uy2aAKEwNjx882Tyu1klqhpeAFNC9/1ufiHXpLuOaI
 hUfz+sBkXShgbApFk218Vw0=
X-Google-Smtp-Source: APXvYqyRcQ1bWn1RSbUodd0gmW7wNKgBdvn2k41su9mqh6NFMD3ZM9hb6237tdxgyB260tU9VnKz6w==
X-Received: by 2002:a17:902:c1:: with SMTP id
 a59mr26218800pla.176.1556037036874; 
 Tue, 23 Apr 2019 09:30:36 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.30.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:30:36 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 01/63] Documentation: add Linux ACPI to Sphinx TOC tree
Date: Wed, 24 Apr 2019 00:28:30 +0800
Message-Id: <20190423162932.21428-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:29 +1000
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

Add below index.rst files for ACPI subsystem. More docs will be added later.
  o admin-guide/acpi/index.rst
  o driver-api/acpi/index.rst
  o firmware-guide/index.rst

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/admin-guide/acpi/index.rst    | 10 ++++++++++
 Documentation/admin-guide/index.rst         |  1 +
 Documentation/driver-api/acpi/index.rst     |  7 +++++++
 Documentation/driver-api/index.rst          |  1 +
 Documentation/firmware-guide/acpi/index.rst |  9 +++++++++
 Documentation/firmware-guide/index.rst      | 13 +++++++++++++
 Documentation/index.rst                     | 10 ++++++++++
 7 files changed, 51 insertions(+)
 create mode 100644 Documentation/admin-guide/acpi/index.rst
 create mode 100644 Documentation/driver-api/acpi/index.rst
 create mode 100644 Documentation/firmware-guide/acpi/index.rst
 create mode 100644 Documentation/firmware-guide/index.rst

diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
new file mode 100644
index 000000000000..3e041206089d
--- /dev/null
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -0,0 +1,10 @@
+============
+ACPI Support
+============
+
+Here we document in detail how to interact with various mechanisms in
+the Linux ACPI support.
+
+.. toctree::
+   :maxdepth: 1
+
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 0a491676685e..5b8286fdd91b 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -77,6 +77,7 @@ configure specific aspects of kernel behavior to your liking.
    LSM/index
    mm/index
    perf-security
+   acpi/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
new file mode 100644
index 000000000000..898b0c60671a
--- /dev/null
+++ b/Documentation/driver-api/acpi/index.rst
@@ -0,0 +1,7 @@
+============
+ACPI Support
+============
+
+.. toctree::
+   :maxdepth: 2
+
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index c0b600ed9961..aa87075c7846 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -56,6 +56,7 @@ available subsections can be seen below.
    slimbus
    soundwire/index
    fpga/index
+   acpi/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
new file mode 100644
index 000000000000..0ec7d072ba22
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+ACPI Support
+============
+
+.. toctree::
+   :maxdepth: 1
+
diff --git a/Documentation/firmware-guide/index.rst b/Documentation/firmware-guide/index.rst
new file mode 100644
index 000000000000..5355784ca0a2
--- /dev/null
+++ b/Documentation/firmware-guide/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+The Linux kernel firmware guide
+===============================
+
+This section describes the ACPI subsystem in Linux from firmware perspective.
+
+.. toctree::
+   :maxdepth: 1
+
+   acpi/index
+
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..fdfa85c56a50 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -35,6 +35,16 @@ trying to get it to work optimally on a given system.
 
    admin-guide/index
 
+Firmware-related documentation
+------------------------------
+The following holds information on the kernel's expectations regarding the
+platform firmwares.
+
+.. toctree::
+   :maxdepth: 2
+
+   firmware-guide/index
+
 Application-developer documentation
 -----------------------------------
 
-- 
2.20.1

