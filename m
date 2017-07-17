Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBKfM6zFQzDrF5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 09:45:15 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6HNiO13042590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 19:45:13 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bs4j9njnp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 19:45:13 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Mon, 17 Jul 2017 19:45:12 -0400
Subject: [PATCH V2 1/6] crypto/nx842: Rename nx842_powernv_function as
 icswx function
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, herbert@gondor.apana.org.au
Cc: ddstreet@ieee.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, benh@kernel.crashing.org,
 mikey@neuling.org, suka@us.ibm.com, hbabu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 Jul 2017 16:45:02 -0700
Mime-Version: 1.0
Message-Id: <1500335102.995.8.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Rename nx842_powernv_function to nx842_powernv_exec.
nx842_powernv_exec points to nx842_exec_icswx and
will be point to VAS exec function which will be added later
for P9 NX support.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 drivers/crypto/nx/nx-842-powernv.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 3abb045cdba7..161987698bbc 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -54,7 +54,11 @@ struct nx842_coproc {
 
 /* no cpu hotplug on powernv, so this list never changes after init */
 static LIST_HEAD(nx842_coprocs);
-static unsigned int nx842_ct;
+static unsigned int nx842_ct;	/* used in icswx function */
+
+static int (*nx842_powernv_exec)(const unsigned char *in,
+				unsigned int inlen, unsigned char *out,
+				unsigned int *outlenp, void *workmem, int fc);
 
 /**
  * setup_indirect_dde - Setup an indirect DDE
@@ -355,7 +359,7 @@ static int wait_for_csb(struct nx842_workmem *wmem,
 }
 
 /**
- * nx842_powernv_function - compress/decompress data using the 842 algorithm
+ * nx842_exec_icswx - compress/decompress data using the 842 algorithm
  *
  * (De)compression provided by the NX842 coprocessor on IBM PowerNV systems.
  * This compresses or decompresses the provided input buffer into the provided
@@ -385,7 +389,7 @@ static int wait_for_csb(struct nx842_workmem *wmem,
  *   -ETIMEDOUT	hardware did not complete operation in reasonable time
  *   -EINTR	operation was aborted
  */
-static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
+static int nx842_exec_icswx(const unsigned char *in, unsigned int inlen,
 				  unsigned char *out, unsigned int *outlenp,
 				  void *workmem, int fc)
 {
@@ -489,13 +493,13 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
  * @workmem: working memory buffer pointer, size determined by
  *           nx842_powernv_driver.workmem_size
  *
- * Returns: see @nx842_powernv_function()
+ * Returns: see @nx842_powernv_exec()
  */
 static int nx842_powernv_compress(const unsigned char *in, unsigned int inlen,
 				  unsigned char *out, unsigned int *outlenp,
 				  void *wmem)
 {
-	return nx842_powernv_function(in, inlen, out, outlenp,
+	return nx842_powernv_exec(in, inlen, out, outlenp,
 				      wmem, CCW_FC_842_COMP_CRC);
 }
 
@@ -517,13 +521,13 @@ static int nx842_powernv_compress(const unsigned char *in, unsigned int inlen,
  * @workmem: working memory buffer pointer, size determined by
  *           nx842_powernv_driver.workmem_size
  *
- * Returns: see @nx842_powernv_function()
+ * Returns: see @nx842_powernv_exec()
  */
 static int nx842_powernv_decompress(const unsigned char *in, unsigned int inlen,
 				    unsigned char *out, unsigned int *outlenp,
 				    void *wmem)
 {
-	return nx842_powernv_function(in, inlen, out, outlenp,
+	return nx842_powernv_exec(in, inlen, out, outlenp,
 				      wmem, CCW_FC_842_DECOMP_CRC);
 }
 
@@ -625,6 +629,8 @@ static __init int nx842_powernv_init(void)
 	if (!nx842_ct)
 		return -ENODEV;
 
+	nx842_powernv_exec = nx842_exec_icswx;
+
 	ret = crypto_register_alg(&nx842_powernv_alg);
 	if (ret) {
 		struct nx842_coproc *coproc, *n;
-- 
2.11.0
