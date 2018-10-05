Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C61C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:43:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DADE20834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD1oZyd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DADE20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RHFq2m0MzF3K4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:43:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VD1oZyd6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VD1oZyd6"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGc36DYVzF3FT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:14:27 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id u12-v6so1302759pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1eIq+bpAJjW92EtiaqYATBx5CfeVYNbB6/35CF3TsEg=;
 b=VD1oZyd6nZR5s6eoeZziT7Q/Ua+T8neq0Su8P0DImQMz3a+/1O63Jk034001UHACeV
 IHbJnfBq58HIHGH7UOFxisD8zJ8H4v+VgTVzR1bTCSyxOwg3LWrfu9LNEmJuBdri1ET4
 NH88d9H7ORpxIp6fuxYKIll13miXNBuMiTm6pVyJJ6qWaPzG0p7pc52Vp8Y8aPh/1qYr
 VYVjjueaaer0maZGtBNiEZmc/yhnch2bud6Dld9CcNbN7mDi1wS2T4iCtV+2wu2VgE4/
 LZLhPkmOWKUoVThhgRAq/VKZraeu0xaTDkpyEc+frBQQF1h9YBgS85hW//IUfThe71WK
 0ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1eIq+bpAJjW92EtiaqYATBx5CfeVYNbB6/35CF3TsEg=;
 b=aqUc3hvvX13VrdOK5UXYguuAdgJ/PGUeL/NkosxC+FZmmtmZguhq6GVwqCq24atiYu
 fuzF1ddDzhkBr2OPqwt5ZOGtyKjkDiNbvAffFG2D9Jar19HPYs2nEuEbnXXAJu12WbzP
 jyZ++FSZ2nnFkyLrZQDzm891SYZBl7fOX8+FjtPuGAC574ABkz+65/HrHihCmUSULJXw
 sUeRm1qkKVnfdBrrR4wJq4c9Kpht6HcIdnfp0h1qeN51aOz4AcRmTNWm0YSwRT6d/B8W
 Zimluvnc6hk1oe5fPeitT+pAP4gDToHL5cFHUqRV0f5Hlb33sFSwMaVeHLhlUu5/zWLh
 mO5g==
X-Gm-Message-State: ABuFfogrD014/JHDVi20qFZifwT61Tgq5pvDA5Nj4XzWMp8KXtlxbUyf
 WaFbD9hylWZUUITwuVJ8T9Y=
X-Google-Smtp-Source: ACcGV604c4MC54e8MAXqw2eowfRjQIppMKzaL9j5NUOQvRQtOIKfJm8S+4u7TalFkxz8KVMNAKpjLw==
X-Received: by 2002:a62:41d6:: with SMTP id
 g83-v6mr9907768pfd.44.1538712865912; 
 Thu, 04 Oct 2018 21:14:25 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 04 Oct 2018 21:14:25 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 11/16] of: overlay: test case of two fragments adding same node
Date: Thu,  4 Oct 2018 21:12:42 -0700
Message-Id: <1538712767-30394-12-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

Multiple overlay fragments adding or deleting the same node is not
supported.  An attempt to do so results in an incorrect devicetree.
The node name will be munged for the second add.

After adding this patch, the unittest messages will show:

   Duplicate name in motor-1, renamed to "controller#1"
   OF: overlay: of_overlay_apply() err=0
   ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
   ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed

   ...

   ### dt-test ### end of unittest - 210 passed, 1 failed

The incorrect (munged) node name "controller#1" can be seen in the
/proc filesystem:

   $ pwd
   /proc/device-tree/testcase-data-2/substation@100/motor-1
   $ ls
   compatible    controller    controller#1  name          phandle       spin
   $ ls controller
   power_bus
   $ ls controller#1
   power_bus_emergency

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest-data/Makefile                  |  1 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  | 28 ++++++++++++++++++++++
 drivers/of/unittest.c                              |  5 ++++
 3 files changed, 34 insertions(+)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 013d85e694c6..166dbdbfd1c5 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_12.dtb.o \
 			    overlay_13.dtb.o \
 			    overlay_15.dtb.o \
+			    overlay_bad_add_dup_node.dtb.o \
 			    overlay_bad_phandle.dtb.o \
 			    overlay_bad_symbol.dtb.o \
 			    overlay_base.dtb.o
diff --git a/drivers/of/unittest-data/overlay_bad_add_dup_node.dts b/drivers/of/unittest-data/overlay_bad_add_dup_node.dts
new file mode 100644
index 000000000000..145dfc3b1024
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_bad_add_dup_node.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/*
+ * &electric_1/motor-1 and &spin_ctrl_1 are the same node:
+ *   /testcase-data-2/substation@100/motor-1
+ *
+ * Thus the new node "controller" in each fragment will
+ * result in an attempt to add the same node twice.
+ * This will result in an error and the overlay apply
+ * will fail.
+ */
+
+&electric_1 {
+
+	motor-1 {
+		controller {
+			power_bus = < 0x1 0x2 >;
+		};
+	};
+};
+
+&spin_ctrl_1 {
+		controller {
+			power_bus_emergency = < 0x101 0x102 >;
+		};
+};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 722537e14848..471b8eb6e842 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2147,6 +2147,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_12);
 OVERLAY_INFO_EXTERN(overlay_13);
 OVERLAY_INFO_EXTERN(overlay_15);
+OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
@@ -2169,6 +2170,7 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_12, 0),
 	OVERLAY_INFO(overlay_13, 0),
 	OVERLAY_INFO(overlay_15, 0),
+	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
 	{}
@@ -2413,6 +2415,9 @@ static __init void of_unittest_overlay_high_level(void)
 	unittest(overlay_data_apply("overlay", NULL),
 		 "Adding overlay 'overlay' failed\n");
 
+	unittest(overlay_data_apply("overlay_bad_add_dup_node", NULL),
+		 "Adding overlay 'overlay_bad_add_dup_node' failed\n");
+
 	unittest(overlay_data_apply("overlay_bad_phandle", NULL),
 		 "Adding overlay 'overlay_bad_phandle' failed\n");
 
-- 
Frank Rowand <frank.rowand@sony.com>

