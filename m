Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0w001hxCzDrQQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 13:56:47 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6T3rVKM031296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 23:56:44 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24fj2nqen8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 23:56:44 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 29 Jul 2016 13:56:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C2C702BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 13:56:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6T3udP825690116
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 13:56:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6T3udAF005458
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 13:56:39 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com, kernel-janitors@vger.kernel.org,
 elfring@users.sourceforge.net, julia.lawall@lip6.fr,
 linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: replace loop with for_each_child_of_node(),
 remove unneeded of_node_put()
Date: Fri, 29 Jul 2016 13:55:34 +1000
In-Reply-To: <601fb58c-7aee-91ce-2a3d-7a29787968fc@au1.ibm.com>
References: <601fb58c-7aee-91ce-2a3d-7a29787968fc@au1.ibm.com>
Message-Id: <1469764534-26948-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rewrite the cxl_guest_init_afu() loop in cxl_of_probe() to use
for_each_child_of_node() rather than a hand-coded for loop.

Remove the useless of_node_put(afu_np) call after the loop, where it's
guaranteed that afu_np == NULL.

Reported-by: SF Markus Elfring <elfring@users.sourceforge.net>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Checked the of_node_put() with Fred, he thinks it was probably just left
over from an earlier private version of the code and we can just get rid of
it.
---
 drivers/misc/cxl/of.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
index edc4583..ec175ea 100644
--- a/drivers/misc/cxl/of.c
+++ b/drivers/misc/cxl/of.c
@@ -460,7 +460,7 @@ int cxl_of_probe(struct platform_device *pdev)
 	struct device_node *afu_np = NULL;
 	struct cxl *adapter = NULL;
 	int ret;
-	int slice, slice_ok;
+	int slice = 0, slice_ok = 0;
 
 	pr_devel("in %s\n", __func__);
 
@@ -476,13 +476,13 @@ int cxl_of_probe(struct platform_device *pdev)
 	}
 
 	/* init afu */
-	slice_ok = 0;
-	for (afu_np = NULL, slice = 0; (afu_np = of_get_next_child(np, afu_np)); slice++) {
+	for_each_child_of_node(np, afu_np) {
 		if ((ret = cxl_guest_init_afu(adapter, slice, afu_np)))
 			dev_err(&pdev->dev, "AFU %i failed to initialise: %i\n",
 				slice, ret);
 		else
 			slice_ok++;
+		slice++;
 	}
 
 	if (slice_ok == 0) {
@@ -490,8 +490,6 @@ int cxl_of_probe(struct platform_device *pdev)
 		adapter->slices = 0;
 	}
 
-	if (afu_np)
-		of_node_put(afu_np);
 	return 0;
 }
 
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
