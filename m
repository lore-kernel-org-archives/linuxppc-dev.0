Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 230291A0672
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Dec 2014 03:11:01 +1100 (AEDT)
Received: by mail-wi0-f179.google.com with SMTP id ex7so4500254wid.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Dec 2014 08:10:57 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH] misc: cxl: sysfs.c:  Remove unused function
Date: Sat, 20 Dec 2014 17:13:44 +0100
Message-Id: <1419092024-6701-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function mmio_size_show() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/misc/cxl/sysfs.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index ce7ec06..0431ec3 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -102,17 +102,6 @@ static struct device_attribute afu_master_attrs[] = {
 
 /*********  AFU attributes  **************************************************/
 
-static ssize_t mmio_size_show(struct device *device,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	struct cxl_afu *afu = to_cxl_afu(device);
-
-	if (afu->pp_size)
-		return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->pp_size);
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->adapter->ps_size);
-}
-
 static ssize_t reset_store_afu(struct device *device,
 			       struct device_attribute *attr,
 			       const char *buf, size_t count)
-- 
1.7.10.4
