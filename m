Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttgdW52F5zDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 17:19:42 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v046IeRY032840
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 01:19:40 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27rkvyqgkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 01:19:40 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 16:19:37 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 456D02CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 17:19:35 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v046JZ4o7143900
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 17:19:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v046JYwm027825
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 17:19:35 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, frederic.barrat@fr.ibm.com,
 Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie <ianmunsi@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>
Subject: [RESEND] cxl: Force psl data-cache flush during device shutdown
Date: Wed,  4 Jan 2017 11:48:52 +0530
Message-Id: <20170104061852.18512-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This change adds a force psl data cache flush during device shutdown
callback. This should reduce a possibility of psl holding a dirty
cache line while the CAPP is being reinitialized, which may result in
a UE [load/store] machine check error.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Resend: Fixed the author ident.
---
 drivers/misc/cxl/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 80a87ab..73432e7 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1610,6 +1610,9 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
 	cxl_sysfs_adapter_remove(adapter);
 	cxl_debugfs_adapter_remove(adapter);
 
+	/* Flush adapter datacache as its about to be removed */
+	cxl_data_cache_flush(adapter);
+
 	cxl_deconfigure_adapter(adapter);
 
 	device_unregister(&adapter->dev);
-- 
2.9.3
