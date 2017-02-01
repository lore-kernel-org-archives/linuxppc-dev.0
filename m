Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD9Bx3lJrzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 04:30:49 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v11HSgC4011369
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 12:30:46 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ba37gyhv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 12:30:46 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 1 Feb 2017 17:30:44 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CFACD2190019
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 17:29:46 +0000 (GMT)
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH 1/7] cxl: Read vsec perst load image
Date: Wed,  1 Feb 2017 18:30:07 +0100
In-Reply-To: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1485970213-25532-2-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This bit is used to cause a flash image load for programmable
CAIA-compliant implementation. If this bit is set to ‘0’, a power
cycle of the adapter is required to load a programmable CAIA-com-
pliant implementation from flash.
This field will be used by the following patches.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 80a87ab..853925b 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1323,6 +1323,7 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
 	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
 	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
+	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
 
 	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
 	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
-- 
2.7.4
