Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDwQT2fPxzDrPh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 14:58:57 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6M4wsli089951
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 00:58:54 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2buyhrgwyw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 00:58:54 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 22:58:48 -0600
Subject: [PATCH V3 3/6] crypto/nx: Create nx842_delete_coprocs function
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, benh@kernel.crashing.org, suka@us.ibm.com,
 ddstreet@ieee.org, linuxram@us.ibm.com, npiggin@gmail.com, hbabu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jul 2017 21:58:41 -0700
Mime-Version: 1.0
Message-Id: <1500699521.23205.4.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Move deleting coprocessors info upon exit or failure to
nx842_delete_coprocs().

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 drivers/crypto/nx/nx-842-powernv.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 1bd19e03eb7d..67dc06f9b557 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -593,6 +593,16 @@ static int __init nx842_powernv_probe(struct device_node *dn)
 	return 0;
 }
 
+static void nx842_delete_coprocs(void)
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
@@ -652,13 +662,7 @@ static __init int nx842_powernv_init(void)
 
 	ret = crypto_register_alg(&nx842_powernv_alg);
 	if (ret) {
-		struct nx842_coproc *coproc, *n;
-
-		list_for_each_entry_safe(coproc, n, &nx842_coprocs, list) {
-			list_del(&coproc->list);
-			kfree(coproc);
-		}
-
+		nx842_delete_coprocs();
 		return ret;
 	}
 
@@ -668,13 +672,8 @@ module_init(nx842_powernv_init);
 
 static void __exit nx842_powernv_exit(void)
 {
-	struct nx842_coproc *coproc, *n;
-
 	crypto_unregister_alg(&nx842_powernv_alg);
 
-	list_for_each_entry_safe(coproc, n, &nx842_coprocs, list) {
-		list_del(&coproc->list);
-		kfree(coproc);
-	}
+	nx842_delete_coprocs();
 }
 module_exit(nx842_powernv_exit);
-- 
2.11.0
