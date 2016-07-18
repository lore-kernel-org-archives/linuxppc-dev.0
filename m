Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtGJT0kFvzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 18:18:00 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6I8DXD1091704
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 04:17:58 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24827edynw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 04:17:57 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 18 Jul 2016 18:17:55 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8EA9A2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 18:17:52 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6I8Hqct15663322
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 18:17:52 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6I8HqWG027200
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 18:17:52 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, ukrishn@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com, felix@linux.vnet.ibm.com
Subject: [PATCH] cxl: add option to enable -DDEBUG
Date: Mon, 18 Jul 2016 18:17:37 +1000
Message-Id: <1468829857-821-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Developers working on AFUs and AFU drivers often find it useful to see the
pr_devel() and dev_dbg() messages from cxl. Give them an easy way to enable
-DDEBUG by adding a Kconfig option, CONFIG_CXL_DEBUG.

Inspired-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/Kconfig  | 12 ++++++++++++
 drivers/misc/cxl/Makefile |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index b75cf83..88ad9f1 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -36,3 +36,15 @@ config CXL_BIMODAL
 	help
 	  Select this option to enable support for bi-modal CAPI cards, such as
 	  the Mellanox CX-4.
+
+config CXL_DEBUG
+	bool "Enable additional CXL debug output"
+	depends on CXL
+	default n
+	help
+	  Select this option to enable additional debug output from the cxl
+	  driver. This may be useful if you're developing or debugging a CAPI
+	  Accelerator Function Unit or cxl-dependent device driver, but is
+	  generally not useful for end users.
+
+	  If unsure, say N.
diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 8a55c1a..620b132 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,5 +1,6 @@
 ccflags-y			:= $(call cc-disable-warning, unused-const-variable)
 ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
+ccflags-$(CONFIG_CXL_DEBUG)	+= -DDEBUG
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
