Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F42C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 23:30:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7824020811
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 23:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="lPqL797v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7824020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44P8RJ1bTrzDqHq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:30:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.142.92; helo=alln-iport-5.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="lPqL797v"; 
 dkim-atps=neutral
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44P8KS2h40zDq96
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 10:24:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=2052; q=dns/txt; s=iport;
 t=1553037900; x=1554247500;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SN5H8dG2ZC+GgC+3IIQa/5DRYtqOkD5Ef/guLY/vlX0=;
 b=lPqL797v0rBv8fkAvBqZza4qRBAjvZBdPoAgBllVz+nluj8FzhWtQBxG
 +VwsHRfihYBulCtvhgm03UVvseJiLsn3gLGd/LJlHTR3QPRelIhunjqz6
 OuNAJHaYF9lSMk8yArgFN2qZtB8JTizQL7xaAE0BWOpyJSF2Nqgcd0bfW s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AEAAA8eZFc/4cNJK1jGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCEIFrJ4wnpWuBew2EbIRtIjQJDQEBAwEBCQE?=
 =?us-ascii?q?DAm0ohgMBRimBFQESgyKBdQGsD4o1FIEbAYZphEgXgUA/gRGNdAOSHJF8UQm?=
 =?us-ascii?q?CS5BVDBmTXosMkyuBRziBVjMaCBsVgyeQax8zj2sBAQ?=
X-IronPort-AV: E=Sophos;i="5.60,246,1549929600"; d="scan'208";a="247406448"
Received: from alln-core-2.cisco.com ([173.36.13.135])
 by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 19 Mar 2019 23:24:55 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
 by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id
 x2JNOrtW019667; Tue, 19 Mar 2019 23:24:55 GMT
From: Daniel Walker <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
 linuxppc-dev@lists.ozlabs.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 2/4] drivers: of: generic command line support
Date: Tue, 19 Mar 2019 16:24:46 -0700
Message-Id: <20190319232448.45964-3-danielwa@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds support for the generic command line implementation into the
device tree code. This allows some platforms to use the original
CONFIG_CMDLINE implementation, but powerpc platforms can used the newer
generic command line code. As platforms support the generic command line
code they can simply add "select GENERIC_CMDLINE" and delete their
Kconfig options for the current CMDLINE.

Change-Id: Ief473a5ffac01a999b0aba7619f5b63bc4b36ac4
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 drivers/of/fdt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7099c652c6a5..9dc5550697c2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/cmdline.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1102,7 +1103,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
 	 * is set in which case we override whatever was found earlier.
 	 */
-#ifdef CONFIG_CMDLINE
+#if defined(CONFIG_CMDLINE) && !defined(CONFIG_GENERIC_CMDLINE)
 #if defined(CONFIG_CMDLINE_EXTEND)
 	strlcat(data, " ", COMMAND_LINE_SIZE);
 	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
@@ -1113,7 +1114,12 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	if (!((char *)data)[0])
 		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif
-#endif /* CONFIG_CMDLINE */
+#endif /* CONFIG_CMDLINE  && !CONFIG_GENERIC_CMDLINE */
+
+	/* append and prepend any arguments built into the kernel via
+	 * generic cmdline.
+	 */
+	cmdline_add_builtin(data, NULL, COMMAND_LINE_SIZE);
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
-- 
2.19.1

