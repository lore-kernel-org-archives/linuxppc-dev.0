Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500E4C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:47:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5892077C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm5NvPU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5892077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qhQy2YZ8zDqZT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 01:47:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sm5NvPU8"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh4k2xMfzDqWd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:32:06 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id n2so10523pgg.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CxZMZUAr4JsWLXOP74o9WB/6Sh8wLgv5YMYKwlqYUA4=;
 b=sm5NvPU8zL7DBup/LxDZgnGkk7GJcUjWldf6UyLFSwgAnycDksLNLv4T4ZkrQt2exk
 uejVyhlVY5RDS7AYQGSdV5M2ZN8MpFJdSrX+GKERj8dywKEMkPPYrC1G8g9WckiT4BUp
 o78BzjObbDEqYt2nX8B0LpwkUkVKUyRs7bzfmUzedrDBrWPynQ2TYre555xla0zLP+iM
 3FGqoMVHwKkKaNCL4PzeQ1n9+jT+JN5it/gwkZyzpjIsI4Rf7M2kzlQBy55kouIBZw9Z
 k6FRCIfk2t6vSn1+7gZPDVL5XkPs8FlvsZnYz9WKij6P8HOp49TUDTfplUCzTExCcy8l
 nhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CxZMZUAr4JsWLXOP74o9WB/6Sh8wLgv5YMYKwlqYUA4=;
 b=kOX6cwd8VEl5u+44aQT6JEBo79/JePjL5EwlJRqBRBaXQZw3nryAEHpccA7qhWoJKP
 Zo03YV5I7ywTTIapwUwmOZ9giOXJXcs1Nz+uerstfGyC9tRZ8dC6/orVbjBR1HAE9OKq
 3+xMEXtHFY3SMMDWannk36tC4Hh6wFOr5mLDy4H+Vn48zs5h2DmueJre8onMvqMfVRyH
 5yXjPJMJA9+bcSlMhs3sx/QI5VHUdpm+XLAGcvtMEv4+gJbpViPuTSvos41iuLRkobhO
 VKsIo/mNcqODjXbTVDhbnEljbP31+7lC08U0IqDuUH6/n+GRHA4WzWCVENpXdmisxbmZ
 Ty0Q==
X-Gm-Message-State: APjAAAX5xA0cTXM5OcDr4Uni81Cko9MKWxlNSnE1BODA1JVymk6WPzrI
 cm9DEy5q0CPgKeAYjRLLFMU=
X-Google-Smtp-Source: APXvYqzlJ9orPoVXkVoGb6Go6SjF1PrssHFjNQWUwYJwSdsu3WYJ6/gS429gq9jrWCXlI7WKJ75ONw==
X-Received: by 2002:aa7:8c86:: with SMTP id p6mr15001808pfd.37.1556206323769; 
 Thu, 25 Apr 2019 08:32:03 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.31.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:32:03 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 05/24] Documentation: ACPI: move linuxized-acpica.txt to
 driver-api/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:30:58 +0800
Message-Id: <20190425153117.16057-6-changbin.du@gmail.com>
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
 Documentation/driver-api/acpi/index.rst       |   1 +
 .../acpi/linuxized-acpica.rst}                | 109 ++++++++++--------
 2 files changed, 64 insertions(+), 46 deletions(-)
 rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (80%)

diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
index 898b0c60671a..12649947b19b 100644
--- a/Documentation/driver-api/acpi/index.rst
+++ b/Documentation/driver-api/acpi/index.rst
@@ -5,3 +5,4 @@ ACPI Support
 .. toctree::
    :maxdepth: 2
 
+   linuxized-acpica
diff --git a/Documentation/acpi/linuxized-acpica.txt b/Documentation/driver-api/acpi/linuxized-acpica.rst
similarity index 80%
rename from Documentation/acpi/linuxized-acpica.txt
rename to Documentation/driver-api/acpi/linuxized-acpica.rst
index 3ad7b0dfb083..0ca8f1538519 100644
--- a/Documentation/acpi/linuxized-acpica.txt
+++ b/Documentation/driver-api/acpi/linuxized-acpica.rst
@@ -1,31 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+============================================================
 Linuxized ACPICA - Introduction to ACPICA Release Automation
+============================================================
 
-Copyright (C) 2013-2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
+:Copyright: |copy| 2013-2016, Intel Corporation
 
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-Abstract:
 
+Abstract
+========
 This document describes the ACPICA project and the relationship between
 ACPICA and Linux.  It also describes how ACPICA code in drivers/acpi/acpica,
 include/acpi and tools/power/acpi is automatically updated to follow the
 upstream.
 
+ACPICA Project
+==============
 
-1. ACPICA Project
-
-   The ACPI Component Architecture (ACPICA) project provides an operating
-   system (OS)-independent reference implementation of the Advanced
-   Configuration and Power Interface Specification (ACPI).  It has been
-   adapted by various host OSes.  By directly integrating ACPICA, Linux can
-   also benefit from the application experiences of ACPICA from other host
-   OSes.
+The ACPI Component Architecture (ACPICA) project provides an operating
+system (OS)-independent reference implementation of the Advanced
+Configuration and Power Interface Specification (ACPI).  It has been
+adapted by various host OSes.  By directly integrating ACPICA, Linux can
+also benefit from the application experiences of ACPICA from other host
+OSes.
 
-   The homepage of ACPICA project is: www.acpica.org, it is maintained and
-   supported by Intel Corporation.
+The homepage of ACPICA project is: www.acpica.org, it is maintained and
+supported by Intel Corporation.
 
-   The following figure depicts the Linux ACPI subsystem where the ACPICA
-   adaptation is included:
+The following figure depicts the Linux ACPI subsystem where the ACPICA
+adaptation is included::
 
       +---------------------------------------------------------+
       |                                                         |
@@ -71,21 +77,27 @@ upstream.
 
                  Figure 1. Linux ACPI Software Components
 
-   NOTE:
+.. note::
     A. OS Service Layer - Provided by Linux to offer OS dependent
        implementation of the predefined ACPICA interfaces (acpi_os_*).
+       ::
+
          include/acpi/acpiosxf.h
          drivers/acpi/osl.c
          include/acpi/platform
          include/asm/acenv.h
     B. ACPICA Functionality - Released from ACPICA code base to offer
        OS independent implementation of the ACPICA interfaces (acpi_*).
+       ::
+
          drivers/acpi/acpica
          include/acpi/ac*.h
          tools/power/acpi
     C. Linux/ACPI Functionality - Providing Linux specific ACPI
        functionality to the other Linux kernel subsystems and user space
        programs.
+       ::
+
          drivers/acpi
          include/linux/acpi.h
          include/linux/acpi*.h
@@ -95,24 +107,27 @@ upstream.
        ACPI subsystem to offer architecture specific implementation of the
        ACPI interfaces.  They are Linux specific components and are out of
        the scope of this document.
+       ::
+
          include/asm/acpi.h
          include/asm/acpi*.h
          arch/*/acpi
 
-2. ACPICA Release
+ACPICA Release
+==============
 
-   The ACPICA project maintains its code base at the following repository URL:
-   https://github.com/acpica/acpica.git. As a rule, a release is made every
-   month.
+The ACPICA project maintains its code base at the following repository URL:
+https://github.com/acpica/acpica.git. As a rule, a release is made every
+month.
 
-   As the coding style adopted by the ACPICA project is not acceptable by
-   Linux, there is a release process to convert the ACPICA git commits into
-   Linux patches.  The patches generated by this process are referred to as
-   "linuxized ACPICA patches".  The release process is carried out on a local
-   copy the ACPICA git repository.  Each commit in the monthly release is
-   converted into a linuxized ACPICA patch.  Together, they form the monthly
-   ACPICA release patchset for the Linux ACPI community.  This process is
-   illustrated in the following figure:
+As the coding style adopted by the ACPICA project is not acceptable by
+Linux, there is a release process to convert the ACPICA git commits into
+Linux patches.  The patches generated by this process are referred to as
+"linuxized ACPICA patches".  The release process is carried out on a local
+copy the ACPICA git repository.  Each commit in the monthly release is
+converted into a linuxized ACPICA patch.  Together, they form the monthly
+ACPICA release patchset for the Linux ACPI community.  This process is
+illustrated in the following figure::
 
     +-----------------------------+
     | acpica / master (-) commits |
@@ -153,7 +168,7 @@ upstream.
 
                 Figure 2. ACPICA -> Linux Upstream Process
 
-   NOTE:
+.. note::
     A. Linuxize Utilities - Provided by the ACPICA repository, including a
        utility located in source/tools/acpisrc folder and a number of
        scripts located in generate/linux folder.
@@ -170,19 +185,20 @@ upstream.
    following kernel configuration options:
    CONFIG_ACPI/CONFIG_ACPI_DEBUG/CONFIG_ACPI_DEBUGGER
 
-3. ACPICA Divergences
+ACPICA Divergences
+==================
 
-   Ideally, all of the ACPICA commits should be converted into Linux patches
-   automatically without manual modifications, the "linux / master" tree should
-   contain the ACPICA code that exactly corresponds to the ACPICA code
-   contained in "new linuxized acpica" tree and it should be possible to run
-   the release process fully automatically.
+Ideally, all of the ACPICA commits should be converted into Linux patches
+automatically without manual modifications, the "linux / master" tree should
+contain the ACPICA code that exactly corresponds to the ACPICA code
+contained in "new linuxized acpica" tree and it should be possible to run
+the release process fully automatically.
 
-   As a matter of fact, however, there are source code differences between
-   the ACPICA code in Linux and the upstream ACPICA code, referred to as
-   "ACPICA Divergences".
+As a matter of fact, however, there are source code differences between
+the ACPICA code in Linux and the upstream ACPICA code, referred to as
+"ACPICA Divergences".
 
-   The various sources of ACPICA divergences include:
+The various sources of ACPICA divergences include:
    1. Legacy divergences - Before the current ACPICA release process was
       established, there already had been divergences between Linux and
       ACPICA. Over the past several years those divergences have been greatly
@@ -213,11 +229,12 @@ upstream.
       rebased on the ACPICA side in order to offer better solutions, new ACPICA
       divergences are generated.
 
-4. ACPICA Development
+ACPICA Development
+==================
 
-   This paragraph guides Linux developers to use the ACPICA upstream release
-   utilities to obtain Linux patches corresponding to upstream ACPICA commits
-   before they become available from the ACPICA release process.
+This paragraph guides Linux developers to use the ACPICA upstream release
+utilities to obtain Linux patches corresponding to upstream ACPICA commits
+before they become available from the ACPICA release process.
 
    1. Cherry-pick an ACPICA commit
 
@@ -225,7 +242,7 @@ upstream.
    you want to cherry pick must be committed into the local repository.
 
    Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
-   from the ACPICA local repository:
+   from the ACPICA local repository::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -240,7 +257,7 @@ upstream.
    changes that haven't been applied to Linux yet.
 
    You can generate the ACPICA release series yourself and rebase your code on
-   top of the generated ACPICA release patches:
+   top of the generated ACPICA release patches::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -254,7 +271,7 @@ upstream.
    3. Inspect the current divergences
 
    If you have local copies of both Linux and upstream ACPICA, you can generate
-   a diff file indicating the state of the current divergences:
+   a diff file indicating the state of the current divergences::
 
    # git clone https://github.com/acpica/acpica
    # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1

