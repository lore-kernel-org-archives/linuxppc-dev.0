Return-Path: <haren@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39F441A0146
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Dec 2015 22:31:07 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sun, 13 Dec 2015 04:31:05 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D83943E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Dec 2015 04:30:51 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBDBUpgR31457518
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Dec 2015 04:30:51 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBDBUpWp029097
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Dec 2015 04:30:51 -0700
Subject: [PATCH] crypto/nx842: Mask XERS0 bit in return value
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au, segher@kernel.crashing.org, ddstreet@ieee.org,
 davem@davemloft.net, pair@us.ibm.com, mpe@ellerman.id.au
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 13 Dec 2015 03:30:41 -0800
Message-ID: <1450006242.19568.11.camel@hbabu-laptop>
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
nothing to do with NX request. Since this bit can be set with other
valuable return status, mast this bit.

One of other bits (INITIATED, BUSY or REJECTED) will be returned for
any given NX request.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/icswx.h   |    1 +
 drivers/crypto/nx/nx-842-powernv.c |   12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

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
index 9ef51fa..6e105e8 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -442,6 +442,14 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
 			     (unsigned int)ccw,
 			     (unsigned int)be32_to_cpu(crb->ccw));
 
+	/*
+	 * NX842 coprocessor sets 3rd bit in CR register with XER[S0].
+	 * XER[S0] is the integer summary overflow bit which is nothing
+	 * to do NX. Since this bit can be set with other return values,
+	 * mask this bit.
+	 */
+	ret &= ~ICSWX_XERS0;
+
 	switch (ret) {
 	case ICSWX_INITIATED:
 		ret = wait_for_csb(wmem, csb);
@@ -454,10 +462,6 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
 		pr_err_ratelimited("ICSWX rejected\n");
 		ret = -EPROTO;
 		break;
-	default:
-		pr_err_ratelimited("Invalid ICSWX return code %x\n", ret);
-		ret = -EPROTO;
-		break;
 	}
 
 	if (!ret)
-- 
1.7.0.4
