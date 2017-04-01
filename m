Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vwPlT59MHzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Apr 2017 03:01:09 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v31GwkRG009904
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 1 Apr 2017 13:00:56 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29j9h26sab-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Apr 2017 13:00:56 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sat, 1 Apr 2017 13:00:54 -0400
Subject: [PATCH 3/5] crypto/nx: Create nx842_delete_coproc function
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au, mpe@ellerman.id.au, ddstreet@ieee.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 benh@kernel.crashing.org, mikey@neuling.org, suka@us.ibm.com,
 hbabu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 01 Apr 2017 10:00:46 -0700
Mime-Version: 1.0
Message-Id: <1491066046.29552.28.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 3/5] crypto/nx: Create nx842_delete_coproc function

Move deleting coprocessor info upon exit or failure to
nx842_delete_coproc().

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 drivers/crypto/nx/nx-842-powernv.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 4cd6a6f..8737e90 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -597,6 +597,16 @@ static int __init nx842_powernv_probe(struct device_node *dn)
 	return 0;
 }
 
+static void nx842_delete_coproc(void)
+{
+	struct nx842_coproc *coproc, *n;
+
+	list_for_each_entry_safe(coproc, n, &nx842_coprocs, list) {
+		list_del(&coproc->list);
+		kfree(coproc);
+	}
+}
+
 static struct nx842_constraints nx842_powernv_constraints = {
 	.alignment =	DDE_BUFFER_ALIGN,
 	.multiple =	DDE_BUFFER_LAST_MULT,
@@ -656,13 +666,7 @@ static __init int nx842_powernv_init(void)
 
 	ret = crypto_register_alg(&nx842_powernv_alg);
 	if (ret) {
-		struct nx842_coproc *coproc, *n;
-
-		list_for_each_entry_safe(coproc, n, &nx842_coprocs, list) {
-			list_del(&coproc->list);
-			kfree(coproc);
-		}
-
+		nx842_delete_coproc();
 		return ret;
 	}
 
@@ -672,13 +676,8 @@ static __init int nx842_powernv_init(void)
 
 static void __exit nx842_powernv_exit(void)
 {
-	struct nx842_coproc *coproc, *n;
-
 	crypto_unregister_alg(&nx842_powernv_alg);
 
-	list_for_each_entry_safe(coproc, n, &nx842_coprocs, list) {
-		list_del(&coproc->list);
-		kfree(coproc);
-	}
+	nx842_delete_coproc();
 }
 module_exit(nx842_powernv_exit);
-- 
1.8.3.1
