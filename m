Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DAFC4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 19:59:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A252820848
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 19:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="WorphciW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A252820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44B0d42qYSzDqLp
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 06:59:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.75; helo=rcdn-iport-4.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="WorphciW"; 
 dkim-atps=neutral
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B0Xm2P2WzDqVl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 06:56:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=6284; q=dns/txt; s=iport;
 t=1551470168; x=1552679768;
 h=from:to:cc:subject:date:message-id;
 bh=ejfe+zt9ErNfKNh/OTJQKBYbiElkJK7JbVSAPrqvZwE=;
 b=WorphciWyKk+req9onEIJR+/r4seInpAmeL0oovFuM5VKjKH1TndtNXN
 b/dMC/g5L2TgyHioB/3RyyuWM//B4S4Th6i3gqmqMjgBt7BF0iGHYooiV
 R74WDlyM5T3Nl9zmbrJYDBf0qotf4HD0PO3n7c0wKQ9pvEA99F6898zJv M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AmAAC/inlc/5NdJa1kHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBggSBayeMIqV3FIFnDYRshCMiNAkNAQMBAQMBAwJtKIZKKQR?=
 =?us-ascii?q?9CAwTgyKBdQGsfoovFId0hEMXgUA/gRGHWIYcAowWl2QJgkCQLwIXkyGdJoF?=
 =?us-ascii?q?HOIFWMxoIGxWDJ4IoF44ePzONfSqCIwEB?=
X-IronPort-AV: E=Sophos;i="5.58,428,1544486400"; d="scan'208";a="526979946"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
 by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Mar 2019 19:44:34 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
 by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id
 x21JiWLj018182; Fri, 1 Mar 2019 19:44:34 GMT
From: Daniel Walker <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] add generic builtin command line
Date: Fri,  1 Mar 2019 19:44:29 +0000
Message-Id: <1551469472-53043-2-git-send-email-danielwa@cisco.com>
X-Mailer: git-send-email 2.7.4
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
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
Cc: Maksym Kokhan <maksym.kokhan@globallogic.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, xe-linux-external@cisco.com,
 Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This code allows architectures to use a generic builtin command line.
The state of the builtin command line options across architecture is
diverse. On x86 and mips they have pretty much the same code and the
code prepends the builtin command line onto the boot loader provided
one. On powerpc there is only a builtin override and nothing else.

The code in this commit unifies the mips and x86 code into a generic
header file under the CONFIG_GENERIC_CMDLINE option. When this
option is enabled the architecture can call the cmdline_add_builtin()
to add the builtin command line.

[maksym.kokhan@globallogic.com: fix cmdline_add_builtin() macro]
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 include/linux/cmdline.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 init/Kconfig            | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 include/linux/cmdline.h

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 000000000000..126fa52f55d2
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+
+/*
+ *
+ * Copyright (C) 2015. Cisco Systems, Inc.
+ *
+ * Generic Append/Prepend cmdline support.
+ */
+
+#if defined(CONFIG_GENERIC_CMDLINE) && defined(CONFIG_CMDLINE_BOOL)
+
+#ifndef CONFIG_CMDLINE_OVERRIDE
+/*
+ * This function will append or prepend a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dest: The destination of the final appended/prepended string
+ * @src: The starting string or NULL if there isn't one.
+ * @tmp: temporary space used for prepending
+ * @length: the maximum length of the strings above.
+ */
+static inline void
+_cmdline_add_builtin(char *dest, char *src, char *tmp, unsigned long length)
+{
+	if (src != dest && src != NULL) {
+		strlcpy(dest, " ", length);
+		strlcat(dest, src, length);
+	}
+
+	strlcat(dest, " ", length);
+
+	if (sizeof(CONFIG_CMDLINE_APPEND) > 1)
+		strlcat(dest, CONFIG_CMDLINE_APPEND, length);
+
+	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {
+		strlcpy(tmp, CONFIG_CMDLINE_PREPEND, length);
+		strlcat(tmp, " ", length);
+		strlcat(tmp, dest, length);
+		strlcpy(dest, tmp, length);
+	}
+}
+
+#define cmdline_add_builtin_section(dest, src, length, section) 	    \
+{									    \
+	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {			    \
+		static char cmdline_tmp_space[length] section;	            \
+		_cmdline_add_builtin(dest, src, cmdline_tmp_space, length); \
+	} else {							    \
+		_cmdline_add_builtin(dest, src, NULL, length);		    \
+	}								    \
+}
+#else
+#define cmdline_add_builtin_section(dest, src, length, section) 	   \
+{									   \
+	strlcpy(dest, CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND,    \
+		length);						   \
+}
+#endif /* !CONFIG_CMDLINE_OVERRIDE */
+
+#else
+#define cmdline_add_builtin_section(dest, src, length, section) {          \
+	if (src != NULL)						   \
+		strlcpy(dest, src, length);				   \
+}
+#endif /* CONFIG_GENERIC_CMDLINE */
+
+#define cmdline_add_builtin(dest, src, length) \
+	cmdline_add_builtin_section(dest, src, length, __initdata)
+
+#endif /* _LINUX_CMDLINE_H */
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..b59e856511e1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1775,6 +1775,75 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+config GENERIC_CMDLINE
+	bool
+
+if GENERIC_CMDLINE
+
+config CMDLINE_BOOL
+	bool "Built-in kernel command line"
+	help
+	  Allow for specifying boot arguments to the kernel at
+	  build time.  On some systems (e.g. embedded ones), it is
+	  necessary or convenient to provide some or all of the
+	  kernel boot arguments with the kernel itself (that is,
+	  to not rely on the boot loader to provide them.)
+
+	  To compile command line arguments into the kernel,
+	  set this option to 'Y', then fill in the
+	  the boot arguments in CONFIG_CMDLINE.
+
+	  Systems with fully functional boot loaders (i.e. non-embedded)
+	  should leave this option set to 'N'.
+
+config CMDLINE_APPEND
+	string "Built-in kernel command string append"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, this string is appended to it to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config CMDLINE_PREPEND
+	string "Built-in kernel command string prepend"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, this string is prepended to it to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config CMDLINE_OVERRIDE
+	bool "Built-in command line overrides boot loader arguments"
+	depends on CMDLINE_BOOL
+	help
+	  Set this option to 'Y' to have the kernel ignore the boot loader
+	  command line, and use ONLY the built-in command line. In this case
+	  append and prepend strings are concatenated to form the full
+	  command line.
+
+	  This is used to work around broken boot loaders.  This should
+	  be set to 'N' under normal conditions.
+
+endif
+
 endmenu		# General setup
 
 source "arch/Kconfig"
-- 
2.14.1

