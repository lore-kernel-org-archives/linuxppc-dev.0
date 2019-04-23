Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA6C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 19:54:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B644821773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 19:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjVTVMA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B644821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pYzp6j0MzDqQT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 05:53:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KjVTVMA+"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTV32YXWzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:31:23 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id y12so5213776plk.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z9Aq19FQiDXcRtSj5P6rKh+DiG01WgKftvX0KyN8OgY=;
 b=KjVTVMA+ZvC2wQYsH7B1kORjqpOj8MQikSPGGXHSBFG/okNfaWiMyuU9YIg98yWILA
 8R4O/2L2Gt+JcKrzE2jWnbGVcug3aluX30wsmsCcH15zT+vQWzjmyXJ2jJeFafRjpYH7
 yRXxamuov3ycUcTj33vaDLP67UpgQ+nNYaPtLMQh13bouAGML4C/h0uQiPfuRn4fnkK6
 ewm15Iz/6JGlgwJK9tet8bJqN6l46IMeEiGmpLhCka7JksEWKgsA8xU0VpJ06TOmTIVD
 weBpF02JU5hzU1Op+SEdOZUefBb1AjTUcDkXN7M+FyaXjuzsXm4zJrpNF3EMTS92fGDq
 Axrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z9Aq19FQiDXcRtSj5P6rKh+DiG01WgKftvX0KyN8OgY=;
 b=aprRP5+ih4AH0LjrbGCiU4kQD5f/uPP7xcIbZhYN2Z/bCumCvNr6M2ev/cx8lWbmXF
 G/E07zV9IiRlZBvzr1sIvGdgyT6Wz7yZ0aiuHhDX02uMeOFDMclZvLuGA0rwy3xttwRb
 iuX3PmBtGdHSYavVIY6ntr/OttIzZyohuBAtQCADsib4z50xE1LNkI47VteeVWXbTqBl
 Y9Bg5KlDrKUj9uTypwOwRheuUAAeaWc5XQicOP/wdGWyup2QQt/YE3BC/EaxyBoX0Y/z
 LGKyc6cbRXQSg8UsODEDeaeEqneWnnFHg3JQjgwv3QKTTsDRydiZVGElxlPZ6qBIk6+h
 QSOg==
X-Gm-Message-State: APjAAAVS0LrPPDhxPDDRWfzQnXTe9MwkCZBffWhmvzu/F/cWNih0YHWn
 HC5saPB667ex12OLzP1mjjo=
X-Google-Smtp-Source: APXvYqyedsi2U8ftySv9IxrDFm+WkUW43vfLhaGdL6fCZ1sYA6MoafoCCefyp5bNSyFgVrlbbMQYfg==
X-Received: by 2002:a17:902:b10c:: with SMTP id
 q12mr27686211plr.254.1556037081532; 
 Tue, 23 Apr 2019 09:31:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.31.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:31:20 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 07/63] Documentation: ACPI: move DSD-properties-rules.txt
 to firmware-guide/acpi and covert to reST
Date: Wed, 24 Apr 2019 00:28:36 +0800
Message-Id: <20190423162932.21428-8-changbin.du@gmail.com>
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

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .../acpi/DSD-properties-rules.rst}            | 21 +++++++++++--------
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 13 insertions(+), 9 deletions(-)
 rename Documentation/{acpi/DSD-properties-rules.txt => firmware-guide/acpi/DSD-properties-rules.rst} (88%)

diff --git a/Documentation/acpi/DSD-properties-rules.txt b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
similarity index 88%
rename from Documentation/acpi/DSD-properties-rules.txt
rename to Documentation/firmware-guide/acpi/DSD-properties-rules.rst
index 3e4862bdad98..4306f29b6103 100644
--- a/Documentation/acpi/DSD-properties-rules.txt
+++ b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
@@ -1,8 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
 _DSD Device Properties Usage Rules
-----------------------------------
+==================================
 
 Properties, Property Sets and Property Subsets
-----------------------------------------------
+==============================================
 
 The _DSD (Device Specific Data) configuration object, introduced in ACPI 5.1,
 allows any type of device configuration data to be provided via the ACPI
@@ -18,7 +21,7 @@ specific type) associated with it.
 
 In the ACPI _DSD context it is an element of the sub-package following the
 generic Device Properties UUID in the _DSD return package as specified in the
-Device Properties UUID definition document [1].
+Device Properties UUID definition document [1]_.
 
 It also may be regarded as the definition of a key and the associated data type
 that can be returned by _DSD in the Device Properties UUID sub-package for a
@@ -33,14 +36,14 @@ Property subsets are nested collections of properties.  Each of them is
 associated with an additional key (name) allowing the subset to be referred
 to as a whole (and to be treated as a separate entity).  The canonical
 representation of property subsets is via the mechanism specified in the
-Hierarchical Properties Extension UUID definition document [2].
+Hierarchical Properties Extension UUID definition document [2]_.
 
 Property sets may be hierarchical.  That is, a property set may contain
 multiple property subsets that each may contain property subsets of its
 own and so on.
 
 General Validity Rule for Property Sets
----------------------------------------
+=======================================
 
 Valid property sets must follow the guidance given by the Device Properties UUID
 definition document [1].
@@ -73,7 +76,7 @@ suitable for the ACPI environment and consequently they cannot belong to a valid
 property set.
 
 Property Sets and Device Tree Bindings
---------------------------------------
+======================================
 
 It often is useful to make _DSD return property sets that follow Device Tree
 bindings.
@@ -91,7 +94,7 @@ expected to automatically work in the ACPI environment regardless of their
 contents.
 
 References
-----------
+==========
 
-[1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
-[2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
+.. [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+.. [2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 868bd25a3398..0e05b843521c 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -10,3 +10,4 @@ ACPI Support
    namespace
    enumeration
    osi
+   DSD-properties-rules
-- 
2.20.1

