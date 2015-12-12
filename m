Return-Path: <haren@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C86591A1053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 14:30:40 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 11 Dec 2015 20:30:38 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E3CF91FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 20:18:47 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBC3Ua8t30867602
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 20:30:36 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBC3Uadj020613
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 20:30:36 -0700
Subject: Crypto/nx842: Ignore invalid XER[S0] return error
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au, ddstreet@ieee.org, davem@davemloft.net,
 mpe@ellerman.id.au, pair@us.ibm.com
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Dec 2015 19:30:29 -0800
Message-ID: <1449891029.19568.5.camel@hbabu-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


NX842 coprocessor sets 3rd bit in CR register with XER[S0] which is
nothing to do with NX request. On powerpc, XER[S0] will be set if
overflow in FPU and stays until another floating point operation is
executed. Since this bit can be set with other valuable return status,
ignore this XER[S0] value.

One of other bits (INITIATED, BUSY or REJECTED) will be returned for
any given NX request.

Signed-off-by: Haren Myneni <haren@us.ibm.com>

diff --git a/arch/powerpc/include/asm/icswx.h b/arch/powerpc/include/asm/icswx.h
index 9f8402b..27e588f 100644
--- a/arch/powerpc/include/asm/icswx.h
+++ b/arch/powerpc/include/asm/icswx.h
@@ -164,6 +164,7 @@ struct coprocessor_request_block {
 #define ICSWX_INITIATED		(0x8)
 #define ICSWX_BUSY		(0x4)
 #define ICSWX_REJECTED		(0x2)
+#define ICSWX_XERS0		(0x1)	/* undefined or set from XERSO. */
 
 static inline int icswx(__be32 ccw, struct coprocessor_request_block *crb)
 {
diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 9ef51fa..6bc33ae 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -442,6 +442,16 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
 			     (unsigned int)ccw,
 			     (unsigned int)be32_to_cpu(crb->ccw));
 
+	/*
+	 * NX842 coprocessor sets 3rd bit in CR register with XER[S0].
+	 * Setting XER[S0] happens if overflow in FPU and stays until
+	 * other floating operation is executed. XER[S0] value is nothing
+	 * to NX and no use to user. Since this bit can be set with other
+	 * return values, ignore this error.
+	 */
+	if (ret & ICSWX_XERS0)
+		ret &= ~ICSWX_XERS0;
+
 	switch (ret) {
 	case ICSWX_INITIATED:
 		ret = wait_for_csb(wmem, csb);
@@ -454,10 +464,6 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
 		pr_err_ratelimited("ICSWX rejected\n");
 		ret = -EPROTO;
 		break;
-	default:
-		pr_err_ratelimited("Invalid ICSWX return code %x\n", ret);
-		ret = -EPROTO;
-		break;
 	}
 
 	if (!ret)
