Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qP79b4RzTzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 06:29:39 +1100 (AEDT)
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 14 Mar 2016 19:29:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id A6A5517D805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 19:30:04 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2EJTYi98519954
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 19:29:34 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2EJTX4Q010416
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2016 15:29:33 -0400
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH next] cxl: Allow PSL timebase to not sync
Date: Mon, 14 Mar 2016 20:29:32 +0100
Message-Id: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1457981703-23801-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CXL driver synchronizes the PSL timebase with the CAPP during
initialization. If it can't synchronize, then the driver currently
fails and the cxl adapter is not usable. That behavior is a bit
extreme for the time being, as some adapters are known to have
troubles syncing their PSL timebase and there are no known use of it.

Introduce a psl_timebase module parameter to control whether PSL
timebase is required or not. Default is to allow initializaton even if
syncing failed.
Default behavior will be changed when current issues with some cxl
adapters are resolved.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---

Same as before, but this patch applies on 'next'

 drivers/misc/cxl/cxl.h  | 1 +
 drivers/misc/cxl/main.c | 4 ++++
 drivers/misc/cxl/pci.c  | 7 +++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 38e21cf..84b563c 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -27,6 +27,7 @@
 #include <uapi/misc/cxl.h>
 
 extern uint cxl_verbose;
+extern uint cxl_psl_timebase;
 
 #define CXL_TIMEOUT 5
 
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index ae68c32..0344010 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -32,6 +32,10 @@ uint cxl_verbose;
 module_param_named(verbose, cxl_verbose, uint, 0600);
 MODULE_PARM_DESC(verbose, "Enable verbose dmesg output");
 
+uint cxl_psl_timebase;
+module_param_named(psl_timebase, cxl_psl_timebase, uint, 0600);
+MODULE_PARM_DESC(psl_timebase, "Require PSL timebase synchronization");
+
 const struct cxl_backend_ops *cxl_ops;
 
 int cxl_afu_slbia(struct cxl_afu *afu)
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 2844e97..02fd1f8 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1144,8 +1144,11 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON)))
 		goto err;
 
-	if ((rc = cxl_setup_psl_timebase(adapter, dev)))
-		goto err;
+	if ((rc = cxl_setup_psl_timebase(adapter, dev))) {
+		if (cxl_psl_timebase)
+			goto err;
+		pr_err("PSL: Timebase sync: ignoring error\n");
+	}
 
 	if ((rc = cxl_native_register_psl_err_irq(adapter)))
 		goto err;
-- 
1.9.1
