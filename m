Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nJg21M7bzF29J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 16:49:01 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4I6mqQ5090695
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 02:48:59 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j1pwb5w7g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 02:48:59 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 18 May 2018 07:48:57 +0100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] cxl: Disable prefault_mode in Radix mode
Date: Fri, 18 May 2018 12:18:43 +0530
Message-Id: <20180518064843.5087-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Vaibhav Jain <vaibhav@linux.ibm.com>

On Power-8 the AFU attr prefault_mode tried to improve storage fault
performance by prefaulting process segments. However Power-9 radix
mode doesn't have Storage-Segments and prefaulting Pages is too fine
grained.

So this patch updates prefault_mode_store() to not allow any other
value apart from CXL_PREFAULT_NONE when radix mode is enabled.

Cc: <stable@vger.kernel.org>
Fixes: f24be42aab37 ("cxl: Add psl9 specific code")
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl |  4 +++-
 drivers/misc/cxl/sysfs.c                  | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 640f65e79ef1..267920a1874b 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -69,7 +69,9 @@ Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read/write
                 Set the mode for prefaulting in segments into the segment table
-                when performing the START_WORK ioctl. Possible values:
+                when performing the START_WORK ioctl. Only applicable when
+                running under hashed page table mmu.
+                Possible values:
                         none: No prefaulting (default)
                         work_element_descriptor: Treat the work element
                                  descriptor as an effective address and
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 4b5a4c5d3c01..629e2e156412 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -353,12 +353,20 @@ static ssize_t prefault_mode_store(struct device *device,
 	struct cxl_afu *afu = to_cxl_afu(device);
 	enum prefault_modes mode = -1;
 
-	if (!strncmp(buf, "work_element_descriptor", 23))
-		mode = CXL_PREFAULT_WED;
-	if (!strncmp(buf, "all", 3))
-		mode = CXL_PREFAULT_ALL;
 	if (!strncmp(buf, "none", 4))
 		mode = CXL_PREFAULT_NONE;
+	else {
+		if (!radix_enabled()) {
+
+			/* only allowed when not in radix mode */
+			if (!strncmp(buf, "work_element_descriptor", 23))
+				mode = CXL_PREFAULT_WED;
+			if (!strncmp(buf, "all", 3))
+				mode = CXL_PREFAULT_ALL;
+		} else {
+			dev_err(device, "Cannot prefault with radix enabled\n");
+		}
+	}
 
 	if (mode == -1)
 		return -EINVAL;
-- 
2.17.0
