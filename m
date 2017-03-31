Return-Path: <srs0=lfg8=3i=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvV6J1MFyzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:16 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vvV6H6ZYyz8sxx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:15 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vvV6G5Lr5z9s2s
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 16:14:14 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2V5DqwA111515
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:09 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29hafh5s5r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:09 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 23:14:08 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/11] Move GET_FIELD/SET_FIELD to vas.h
Date: Thu, 30 Mar 2017 22:13:36 -0700
In-Reply-To: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1490937224-29149-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the GET_FIELD and SET_FIELD macros to vas.h as VAS and other
users of VAS, including NX-842 can use those macros.

There is a lot of related code between the VAS/NX kernel drivers
and skiboot. For consistency switch the order of parameters in
SET_FIELD to match the order in skiboot.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Reviewed-by: Dan Streetman <ddstreet@ieee.org>
---

Changelog[v3]
	- Fix order of parameters in nx-842 driver.
---
 arch/powerpc/include/uapi/asm/vas.h | 8 ++++++++
 drivers/crypto/nx/nx-842-powernv.c  | 7 ++++---
 drivers/crypto/nx/nx-842.h          | 5 -----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/vas.h b/arch/powerpc/include/uapi/asm/vas.h
index ddfe046..21249f5 100644
--- a/arch/powerpc/include/uapi/asm/vas.h
+++ b/arch/powerpc/include/uapi/asm/vas.h
@@ -22,4 +22,12 @@
 #define VAS_THRESH_FIFO_GT_QTR_FULL	2
 #define VAS_THRESH_FIFO_GT_EIGHTH_FULL	3
 
+/*
+ * Get/Set bit fields
+ */
+#define GET_FIELD(m, v)		(((v) & (m)) >> MASK_LSH(m))
+#define MASK_LSH(m)		(__builtin_ffsl(m) - 1)
+#define SET_FIELD(m, v, val)	\
+		(((v) & ~(m)) | ((((typeof(v))(val)) << MASK_LSH(m)) & (m)))
+
 #endif /* _UAPI_MISC_VAS_H */
diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 1710f80..3abb045 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -22,6 +22,7 @@
 
 #include <asm/prom.h>
 #include <asm/icswx.h>
+#include <asm/vas.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dan Streetman <ddstreet@ieee.org>");
@@ -424,9 +425,9 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
 
 	/* set up CCW */
 	ccw = 0;
-	ccw = SET_FIELD(ccw, CCW_CT, nx842_ct);
-	ccw = SET_FIELD(ccw, CCW_CI_842, 0); /* use 0 for hw auto-selection */
-	ccw = SET_FIELD(ccw, CCW_FC_842, fc);
+	ccw = SET_FIELD(CCW_CT, ccw, nx842_ct);
+	ccw = SET_FIELD(CCW_CI_842, ccw, 0); /* use 0 for hw auto-selection */
+	ccw = SET_FIELD(CCW_FC_842, ccw, fc);
 
 	/* set up CRB's CSB addr */
 	csb_addr = nx842_get_pa(csb) & CRB_CSB_ADDRESS;
diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index a4eee3b..30929bd 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -100,11 +100,6 @@ static inline unsigned long nx842_get_pa(void *addr)
 	return page_to_phys(vmalloc_to_page(addr)) + offset_in_page(addr);
 }
 
-/* Get/Set bit fields */
-#define MASK_LSH(m)		(__builtin_ffsl(m) - 1)
-#define GET_FIELD(v, m)		(((v) & (m)) >> MASK_LSH(m))
-#define SET_FIELD(v, m, val)	(((v) & ~(m)) | (((val) << MASK_LSH(m)) & (m)))
-
 /**
  * This provides the driver's constraints.  Different nx842 implementations
  * may have varying requirements.  The constraints are:
-- 
2.7.4
