Return-Path: <SRS0=PnYa=YZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63338CA9EC9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 08:15:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD575208E3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 08:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OWwQEmBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD575208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 474FPX5wTYzF6W0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 19:15:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=socionext.com (client-ip=210.131.2.79;
 helo=conuserg-12.nifty.com; envelope-from=yamada.masahiro@socionext.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="OWwQEmBq"; 
 dkim-atps=neutral
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474FLL3F4mzF5qK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2019 19:12:57 +1100 (AEDT)
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id xA18BsBO023869;
 Fri, 1 Nov 2019 17:11:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xA18BsBO023869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1572595916;
 bh=k87jkR6FkJFPOR/z5eR3eSaQD14H4HrO88Los1fgxD4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OWwQEmBqJtBONHOI+kqzoJQI4R+sA7iR9sb2oScPbRgvf6U28x2BNYAEr4jzQR9Ax
 5ltA/eXOJUZvjCgF4FGNElAjNbbG7nJQ5A+H9/r20jiz6a3zC9OVYzd1oAb1/njDYK
 yrrDm305qM1vx/9jL0j1DYToeZ3In9qwNG0F5pnwrM/kJ9sI+YCEndtsEv+B4a8Nk6
 wdtXzJ9kcqgBG+e6wJTgotLqbjCpPZVrJksALYACl5uUoARP6dqxcVaO5XbbMKEQcO
 Ip61PjA/oZLV9q40iQoPVYx4uOvuC33hWzya8yguDuSICi4tsaA51w6SRZcEjs8wQd
 xgBT+fTTh/VLA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2 1/3] libfdt: add SPDX-License-Identifier to libfdt wrappers
Date: Fri,  1 Nov 2019 17:11:46 +0900
Message-Id: <20191101081148.23274-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101081148.23274-1-yamada.masahiro@socionext.com>
References: <20191101081148.23274-1-yamada.masahiro@socionext.com>
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These are kernel source code even though they are just two-line wrappers.

Files without explicit license information fall back to GPL-2.0-only,
which is the project default.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 lib/fdt.c            | 1 +
 lib/fdt_empty_tree.c | 1 +
 lib/fdt_ro.c         | 1 +
 lib/fdt_rw.c         | 1 +
 lib/fdt_strerror.c   | 1 +
 lib/fdt_sw.c         | 1 +
 lib/fdt_wip.c        | 1 +
 7 files changed, 7 insertions(+)

diff --git a/lib/fdt.c b/lib/fdt.c
index 97f20069fc37..041f8922a23c 100644
--- a/lib/fdt.c
+++ b/lib/fdt.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt.c"
diff --git a/lib/fdt_empty_tree.c b/lib/fdt_empty_tree.c
index 5d30c58150ad..452221227bf3 100644
--- a/lib/fdt_empty_tree.c
+++ b/lib/fdt_empty_tree.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_empty_tree.c"
diff --git a/lib/fdt_ro.c b/lib/fdt_ro.c
index f73c04ea7be4..9f696d19f060 100644
--- a/lib/fdt_ro.c
+++ b/lib/fdt_ro.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_ro.c"
diff --git a/lib/fdt_rw.c b/lib/fdt_rw.c
index 0c1f0f4a4b13..2a61e9c6dd44 100644
--- a/lib/fdt_rw.c
+++ b/lib/fdt_rw.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_rw.c"
diff --git a/lib/fdt_strerror.c b/lib/fdt_strerror.c
index 8713e3ff4707..4554e5fdac12 100644
--- a/lib/fdt_strerror.c
+++ b/lib/fdt_strerror.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_strerror.c"
diff --git a/lib/fdt_sw.c b/lib/fdt_sw.c
index 9ac7e50c76ce..d3345ca399cf 100644
--- a/lib/fdt_sw.c
+++ b/lib/fdt_sw.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_sw.c"
diff --git a/lib/fdt_wip.c b/lib/fdt_wip.c
index 45b3fc3d3ba1..9674d4c3b115 100644
--- a/lib/fdt_wip.c
+++ b/lib/fdt_wip.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_wip.c"
-- 
2.17.1

