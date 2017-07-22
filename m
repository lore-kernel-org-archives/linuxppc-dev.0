Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDwP91ygCzDrDR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 14:57:49 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6M4uus3086680
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 00:57:46 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2buyhrgwbs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 00:57:46 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sat, 22 Jul 2017 00:57:46 -0400
Subject: [PATCH V3 2/6] crypto/nx: Create nx842_configure_crb function
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, benh@kernel.crashing.org, suka@us.ibm.com,
 ddstreet@ieee.org, linuxram@us.ibm.com, npiggin@gmail.com, hbabu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jul 2017 21:57:39 -0700
Mime-Version: 1.0
Message-Id: <1500699459.23205.3.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Configure CRB is moved to nx842_configure_crb() so that it can
be used for icswx and VAS exec functions. VAS function will be
added later with P9 support.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 drivers/crypto/nx/nx-842-powernv.c | 57 +++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 161987698bbc..1bd19e03eb7d 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -358,6 +358,40 @@ static int wait_for_csb(struct nx842_workmem *wmem,
 	return 0;
 }
 
+static int nx842_config_crb(const unsigned char *in, unsigned int inlen,
+			unsigned char *out, unsigned int outlen,
+			struct nx842_workmem *wmem)
+{
+	struct coprocessor_request_block *crb;
+	struct coprocessor_status_block *csb;
+	u64 csb_addr;
+	int ret;
+
+	crb = &wmem->crb;
+	csb = &crb->csb;
+
+	/* Clear any previous values */
+	memset(crb, 0, sizeof(*crb));
+
+	/* set up DDLs */
+	ret = setup_ddl(&crb->source, wmem->ddl_in,
+			(unsigned char *)in, inlen, true);
+	if (ret)
+		return ret;
+
+	ret = setup_ddl(&crb->target, wmem->ddl_out,
+			out, outlen, false);
+	if (ret)
+		return ret;
+
+	/* set up CRB's CSB addr */
+	csb_addr = nx842_get_pa(csb) & CRB_CSB_ADDRESS;
+	csb_addr |= CRB_CSB_AT; /* Addrs are phys */
+	crb->csb_addr = cpu_to_be64(csb_addr);
+
+	return 0;
+}
+
 /**
  * nx842_exec_icswx - compress/decompress data using the 842 algorithm
  *
@@ -397,7 +431,6 @@ static int nx842_exec_icswx(const unsigned char *in, unsigned int inlen,
 	struct coprocessor_status_block *csb;
 	struct nx842_workmem *wmem;
 	int ret;
-	u64 csb_addr;
 	u32 ccw;
 	unsigned int outlen = *outlenp;
 
@@ -411,33 +444,19 @@ static int nx842_exec_icswx(const unsigned char *in, unsigned int inlen,
 		return -ENODEV;
 	}
 
-	crb = &wmem->crb;
-	csb = &crb->csb;
-
-	/* Clear any previous values */
-	memset(crb, 0, sizeof(*crb));
-
-	/* set up DDLs */
-	ret = setup_ddl(&crb->source, wmem->ddl_in,
-			(unsigned char *)in, inlen, true);
-	if (ret)
-		return ret;
-	ret = setup_ddl(&crb->target, wmem->ddl_out,
-			out, outlen, false);
+	ret = nx842_config_crb(in, inlen, out, outlen, wmem);
 	if (ret)
 		return ret;
 
+	crb = &wmem->crb;
+	csb = &crb->csb;
+
 	/* set up CCW */
 	ccw = 0;
 	ccw = SET_FIELD(CCW_CT, ccw, nx842_ct);
 	ccw = SET_FIELD(CCW_CI_842, ccw, 0); /* use 0 for hw auto-selection */
 	ccw = SET_FIELD(CCW_FC_842, ccw, fc);
 
-	/* set up CRB's CSB addr */
-	csb_addr = nx842_get_pa(csb) & CRB_CSB_ADDRESS;
-	csb_addr |= CRB_CSB_AT; /* Addrs are phys */
-	crb->csb_addr = cpu_to_be64(csb_addr);
-
 	wmem->start = ktime_get();
 
 	/* do ICSWX */
-- 
2.11.0
