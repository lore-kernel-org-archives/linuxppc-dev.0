Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBKkb32F3zDrGv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 09:48:55 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6HNmpTY124473
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 19:48:53 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2brrfenkg4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 19:48:52 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Mon, 17 Jul 2017 17:48:52 -0600
Subject: [PATCH V2 4/6] crypto/nx: Add nx842_add_coprocs_list function
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, herbert@gondor.apana.org.au
Cc: ddstreet@ieee.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, benh@kernel.crashing.org,
 mikey@neuling.org, suka@us.ibm.com, hbabu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 Jul 2017 16:48:43 -0700
Mime-Version: 1.0
Message-Id: <1500335323.995.13.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Updating coprocessor list is moved to nx842_add_coprocs_list().
This function will be used for both icswx and VAS functions.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 drivers/crypto/nx/nx-842-powernv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 67dc06f9b557..829b5cad0043 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -550,6 +550,14 @@ static int nx842_powernv_decompress(const unsigned char *in, unsigned int inlen,
 				      wmem, CCW_FC_842_DECOMP_CRC);
 }
 
+static inline void nx842_add_coprocs_list(struct nx842_coproc *coproc,
+					int chipid)
+{
+	coproc->chip_id = chipid;
+	INIT_LIST_HEAD(&coproc->list);
+	list_add(&coproc->list, &nx842_coprocs);
+}
+
 static int __init nx842_powernv_probe(struct device_node *dn)
 {
 	struct nx842_coproc *coproc;
@@ -576,11 +584,9 @@ static int __init nx842_powernv_probe(struct device_node *dn)
 	if (!coproc)
 		return -ENOMEM;
 
-	coproc->chip_id = chip_id;
 	coproc->ct = ct;
 	coproc->ci = ci;
-	INIT_LIST_HEAD(&coproc->list);
-	list_add(&coproc->list, &nx842_coprocs);
+	nx842_add_coprocs_list(coproc, chip_id);
 
 	pr_info("coprocessor found on chip %d, CT %d CI %d\n", chip_id, ct, ci);
 
-- 
2.11.0
