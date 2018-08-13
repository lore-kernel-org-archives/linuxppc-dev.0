Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pqV01BBdzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 19:01:39 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7D8sL76102304
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 05:01:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ku3638dmt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 05:01:37 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 13 Aug 2018 10:01:35 +0100
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH] ocxl: Fix access to the AFU Descriptor Data
Date: Mon, 13 Aug 2018 11:01:31 +0200
Message-Id: <1534150891-19394-1-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <christophe_lombard@fr.ibm.cm>

The AFU Information DVSEC capability is a means to extract common,
general information about all of the AFUs associated with a Function
independent of the specific functionality that each AFU provides.

This patch fixes the access to the AFU Descriptor Data indexed by the
AFU Info Index field.

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/ocxl/config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index 2e30de9..de01623 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -280,7 +280,9 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
 	u32 val;
 	int rc, templ_major, templ_minor, len;
 
-	pci_write_config_word(dev, fn->dvsec_afu_info_pos, afu_idx);
+	pci_write_config_word(dev,
+			      fn->dvsec_afu_info_pos + OCXL_DVSEC_AFU_INFO_AFU_IDX,
+			      afu_idx);
 	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_VERSION, &val);
 	if (rc)
 		return rc;
-- 
2.7.4
