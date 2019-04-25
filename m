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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DBAC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:07:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604D220651
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDd2MK1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604D220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qhsQ4mWFzDqZB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 02:07:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lDd2MK1R"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qh5r0r70zDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:33:04 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id l18so30384pgj.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VpX7F8/8x7KQ3d4aSKya8qsEnETmNBHRHBKInuxFpFI=;
 b=lDd2MK1R/m44/mCy0kf4pa9RHEkAkCFgtZKUrxtGrUQ4GJ8biiMz5gS4OZuMPiqP2Y
 NzoU3UAC4Bg4orD/u/NWaaNkkzL2l9YlNrssUXSFifbE7teCAH51QjLSgsfmyDsHT3EI
 9eeKOma3WwXrQMKcdnm2wqwiL3Rcb44YLDfCD5usZJlgesfvaVVjoyXhvVRNFeCuocL0
 vbJtvUKCuSTnhJ2vQCG5waZUghcOJDuZKdHHgxN1+DCFYqpCJjWrD229rPVr1XdEKWRO
 rL5i422f2/TiBbHRYKotSfRhKibg2f/MautBidGV7FliYobIkFk1XnbxGu2W/Uggthn6
 NoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VpX7F8/8x7KQ3d4aSKya8qsEnETmNBHRHBKInuxFpFI=;
 b=fylpw41KeSXEG9wcfvBJWVT6OtQoVWq+3VmIdgRyYHTj4aEQF07bid5pLU+nshyrTp
 lULCmUsRu4n6qAxQ9RdMKL/fmTzbfw6OiMec0dW1oc08fdsZU4C3O8lpcQ7hsXlxjQXt
 ZRPU63gyQr95va6nbLCLprAS4AAapGnTEy/p7IBO+KXZulvNysOHdz0aR7jMJzwTeD/E
 gBiJUGZ6tLwNvVjh/nVRcbS/ehB2D1p0cdxtyZmBGCaNSvHDXaVi5qzEaZd6bKR61NE5
 Xdt962dbRBZxOFmJjNE/yKY2p3BMdgH1zNnx9FWMMEBXXFHNfZUspfYPsEokY3fEP65G
 TDbQ==
X-Gm-Message-State: APjAAAWEY7R7SjBxGqx6ztAu1VeKlOx2J3bWXBx8lXh7uUq1MbzQE/hY
 H1I2gArd2opnCLGu/X4iagc=
X-Google-Smtp-Source: APXvYqwTaGWYpz3+bQAqBffJVPAR6u0jiBtaVeD1ln1YqX5J8SEMNVaEQrfyyGfBjnr8JY4nJBOhIg==
X-Received: by 2002:a63:6581:: with SMTP id
 z123mr38512069pgb.243.1556206382322; 
 Thu, 25 Apr 2019 08:33:02 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 08:33:01 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: rjw@rjwysocki.net,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 15/24] Documentation: ACPI: move
 dsd/data-node-references.txt to firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:31:08 +0800
Message-Id: <20190425153117.16057-16-changbin.du@gmail.com>
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
 .../acpi/dsd/data-node-references.rst}        | 36 ++++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 21 insertions(+), 16 deletions(-)
 rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (71%)

diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
similarity index 71%
rename from Documentation/acpi/dsd/data-node-references.txt
rename to Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index c3871565c8cf..1351984e767c 100644
--- a/Documentation/acpi/dsd/data-node-references.txt
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -1,9 +1,12 @@
-Copyright (C) 2018 Intel Corporation
-Author: Sakari Ailus <sakari.ailus@linux.intel.com>
-
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
+===================================
 Referencing hierarchical data nodes
------------------------------------
+===================================
+
+:Copyright: |copy| 2018 Intel Corporation
+:Author: Sakari Ailus <sakari.ailus@linux.intel.com>
 
 ACPI in general allows referring to device objects in the tree only.
 Hierarchical data extension nodes may not be referred to directly, hence this
@@ -28,13 +31,14 @@ extension key.
 
 
 Example
--------
+=======
 
-	In the ASL snippet below, the "reference" _DSD property [2] contains a
-	device object reference to DEV0 and under that device object, a
-	hierarchical data extension key "node@1" referring to the NOD1 object
-	and lastly, a hierarchical data extension key "anothernode" referring to
-	the ANOD object which is also the final target node of the reference.
+In the ASL snippet below, the "reference" _DSD property [2] contains a
+device object reference to DEV0 and under that device object, a
+hierarchical data extension key "node@1" referring to the NOD1 object
+and lastly, a hierarchical data extension key "anothernode" referring to
+the ANOD object which is also the final target node of the reference.
+::
 
 	Device (DEV0)
 	{
@@ -75,15 +79,15 @@ Example
 	    })
 	}
 
-Please also see a graph example in graph.txt .
+Please also see a graph example in :doc:`graph`.
 
 References
-----------
+==========
 
 [1] Hierarchical Data Extension UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
-    referenced 2018-07-17.
+<http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+referenced 2018-07-17.
 
 [2] Device Properties UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
-    referenced 2016-10-04.
+<http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+referenced 2016-10-04.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index f81cfbcb6878..6d4e0df4f063 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -9,6 +9,7 @@ ACPI Support
 
    namespace
    dsd/graph
+   dsd/data-node-references
    enumeration
    osi
    method-customizing
-- 
2.20.1

