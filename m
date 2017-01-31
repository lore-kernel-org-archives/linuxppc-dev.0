Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCSq42ZzrzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 01:11:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0VE4fnc053797
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:11:07 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28au5g2p4d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:11:07 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 1 Feb 2017 00:11:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4388D2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 01:11:02 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0VEAskq21758114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 01:11:02 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0VEATD8012663
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 01:10:30 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: [PATCH] cxl: fix build when CONFIG_DEBUG_FS=n
Date: Wed,  1 Feb 2017 01:10:00 +1100
Message-Id: <20170131141000.24636-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stub out the debugfs functions so that the build doesn't break when
CONFIG_DEBUG_FS=n.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/debugfs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index 9c06ac8fa5ac..af304ba0dc4e 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -13,6 +13,8 @@
 
 #include "cxl.h"
 
+#ifdef CONFIG_DEBUG_FS
+
 static struct dentry *cxl_debugfs;
 
 void cxl_stop_trace(struct cxl *adapter)
@@ -151,3 +153,50 @@ void cxl_debugfs_exit(void)
 {
 	debugfs_remove_recursive(cxl_debugfs);
 }
+
+#else /* CONFIG_DEBUG_FS */
+
+void cxl_stop_trace(struct cxl *cxl)
+{
+}
+
+void cxl_debugfs_add_adapter_psl_regs(struct cxl *adapter, struct dentry *dir)
+{
+}
+
+void cxl_debugfs_add_adapter_xsl_regs(struct cxl *adapter, struct dentry *dir)
+{
+}
+
+int cxl_debugfs_adapter_add(struct cxl *adapter)
+{
+	return 0;
+}
+
+void cxl_debugfs_adapter_remove(struct cxl *adapter)
+{
+}
+
+void cxl_debugfs_add_afu_psl_regs(struct cxl_afu *afu, struct dentry *dir)
+{
+}
+
+int cxl_debugfs_afu_add(struct cxl_afu *afu)
+{
+	return 0;
+}
+
+void cxl_debugfs_afu_remove(struct cxl_afu *afu)
+{
+}
+
+int __init cxl_debugfs_init(void)
+{
+	return 0;
+}
+
+void cxl_debugfs_exit(void)
+{
+}
+
+#endif /* CONFIG_DEBUG_FS */
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
