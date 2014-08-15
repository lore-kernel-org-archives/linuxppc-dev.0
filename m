Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A42A1A003C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Aug 2014 07:46:52 +1000 (EST)
Date: Fri, 15 Aug 2014 16:07:56 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <1234993482.57039.1408136876321.JavaMail.zimbra@xes-inc.com>
Subject: [PATCH 2/2] fsl_ifc: Support all 8 IFC chip selects
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale's QorIQ T Series processors support 8 IFC chip selects
within a memory map backward compatible with previous P Series
processors which supported only 4 chip selects.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 include/linux/fsl_ifc.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
index 84d60cb..62762ff 100644
--- a/include/linux/fsl_ifc.h
+++ b/include/linux/fsl_ifc.h
@@ -29,7 +29,7 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 
-#define FSL_IFC_BANK_COUNT 4
+#define FSL_IFC_BANK_COUNT 8
 
 /*
  * CSPR - Chip Select Property Register
@@ -776,23 +776,23 @@ struct fsl_ifc_regs {
 		__be32 cspr;
 		u32 res2;
 	} cspr_cs[FSL_IFC_BANK_COUNT];
-	u32 res3[0x19];
+	u32 res3[0xd];
 	struct {
 		__be32 amask;
 		u32 res4[0x2];
 	} amask_cs[FSL_IFC_BANK_COUNT];
-	u32 res5[0x18];
+	u32 res5[0xc];
 	struct {
 		__be32 csor;
 		__be32 csor_ext;
 		u32 res6;
 	} csor_cs[FSL_IFC_BANK_COUNT];
-	u32 res7[0x18];
+	u32 res7[0xc];
 	struct {
 		__be32 ftim[4];
 		u32 res8[0x8];
 	} ftim_cs[FSL_IFC_BANK_COUNT];
-	u32 res9[0x60];
+	u32 res9[0x30];
 	__be32 rb_stat;
 	u32 res10[0x2];
 	__be32 ifc_gcr;
-- 
1.9.1
