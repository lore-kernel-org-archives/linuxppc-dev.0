Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w01kL28CNzDqJw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 00:12:42 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v37E418E058851
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 10:12:32 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29p5rqwpxw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 10:12:32 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 15:12:30 +0100
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH V4 1/7] cxl: Read vsec perst load image
Date: Fri,  7 Apr 2017 16:11:53 +0200
In-Reply-To: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1491574319-11852-2-git-send-email-clombard@linux.vnet.ibm.com>
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
index b27ea98..1f4c351 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1332,6 +1332,7 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
 	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
 	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
+	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
 
 	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
 	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
-- 
2.7.4
