Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxqST62BgzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 16:23:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8K6NLoU126842
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 02:23:35 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3jqy0vje-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 02:23:35 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 20 Sep 2017 16:23:33 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8K6NVFA34275468
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 16:23:31 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8K6NXAf023732
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 16:23:33 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: [PATCH] cxl: Provide debugfs access to PSL_DEBUG/XSL_DEBUG registers
Date: Wed, 20 Sep 2017 11:53:22 +0530
Message-Id: <20170920062322.6582-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Access to PSL/XSL_DEBUG registers on the adapter provides easy access
to the debug facilities provided by PSL/XSL. So this patch adds two
new files (debug, xsl-debug) to the cxl-adapter specific debugfs
folder located at /sys/kernel/debugfs/cxl/card<n>, which will provide
direct r/w access to corrosponding debug registers in the adapter
config-space.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h     | 1 +
 drivers/misc/cxl/debugfs.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b1afeccbb97f..2c10b536427a 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -100,6 +100,7 @@ static const cxl_p1_reg_t CXL_XSL_FEC       = {0x0158};
 static const cxl_p1_reg_t CXL_XSL_DSNCTL    = {0x0168};
 /* PSL registers - CAIA 2 */
 static const cxl_p1_reg_t CXL_PSL9_CONTROL  = {0x0020};
+static const cxl_p1_reg_t CXL_XSL9_DBG      = {0x0130};
 static const cxl_p1_reg_t CXL_XSL9_DSNCTL   = {0x0168};
 static const cxl_p1_reg_t CXL_PSL9_FIR1     = {0x0300};
 static const cxl_p1_reg_t CXL_PSL9_FIR2     = {0x0308};
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
index eae9d749f967..10ff569c1272 100644
--- a/drivers/misc/cxl/debugfs.c
+++ b/drivers/misc/cxl/debugfs.c
@@ -65,6 +65,10 @@ void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir)
 	debugfs_create_io_x64("fir2", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR2));
 	debugfs_create_io_x64("fir_cntl", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR_CNTL));
 	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_TRACECFG));
+	debugfs_create_io_x64("debug", 0600, dir,
+			      _cxl_p1_addr(adapter, CXL_PSL9_DEBUG));
+	debugfs_create_io_x64("xsl-debug", 0600, dir,
+			      _cxl_p1_addr(adapter, CXL_XSL9_DBG));
 }
 
 void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir)
-- 
2.13.5
