Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EDF41A09D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 19:10:26 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 453E8140272
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2015 19:10:26 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 4 Feb 2015 18:10:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E05CC3578048
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2015 19:10:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t148AF1333489146
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2015 19:10:23 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1489nFN005010
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2015 19:09:50 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH 2/2] cxl: Fail AFU initialisation if an invalid configuration
 record is found
Date: Wed,  4 Feb 2015 19:09:02 +1100
Message-Id: <1423037342-26753-2-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1423037342-26753-1-git-send-email-imunsie@au.ibm.com>
References: <1423037342-26753-1-git-send-email-imunsie@au.ibm.com>
Cc: mikey <mikey@neuling.org>, Vaibhav Jain <vajain21@in.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

If an AFU claims to have a configuration record but doesn't actually
contain a vendor and device ID, fail the AFU initialisation. Right now
this is just a way of politely letting AFU developers know that they
need to fix their config space, but later on we may expose the AFUs as
actual PCI devices in their own right and don't want to inadvertendly
expose an AFU with a bad config space.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 128481e..f7c01a9 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -599,6 +599,8 @@ static int cxl_read_afu_descriptor(struct cxl_afu *afu)
 
 static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
 {
+	int i;
+
 	if (afu->psa && afu->adapter->ps_size <
 			(afu->pp_offset + afu->pp_size*afu->max_procs_virtualised)) {
 		dev_err(&afu->dev, "per-process PSA can't fit inside the PSA!\n");
@@ -608,6 +610,13 @@ static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
 	if (afu->pp_psa && (afu->pp_size < PAGE_SIZE))
 		dev_warn(&afu->dev, "AFU uses < PAGE_SIZE per-process PSA!");
 
+	for (i = 0; i < afu->crs_num; i++) {
+		if ((cxl_afu_cr_read32(afu, i, 0) == 0)) {
+			dev_err(&afu->dev, "ABORTING: AFU configuration record %i is invalid\n", i);
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.1.4
