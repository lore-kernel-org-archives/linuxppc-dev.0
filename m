Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D0D31A003C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Aug 2014 07:46:50 +1000 (EST)
Date: Fri, 15 Aug 2014 16:07:48 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <1346443438.56997.1408136868975.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <420065698.56284.1408136539532.JavaMail.zimbra@xes-inc.com>
Subject: [PATCH 1/2] fsl_ifc: Fix csor_ext position in fsl_ifc_regs
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

According to Freescale manuals, the IFC_CSORn_EXT register is located
immediately _after_ the bank's IFC_CSORn register.

This patch adjusts the csor_ext member of and reserved register arrays
immediately surrounding the csor_cs structure to provide proper access
to this register.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 include/linux/fsl_ifc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
index f49ddb1..84d60cb 100644
--- a/include/linux/fsl_ifc.h
+++ b/include/linux/fsl_ifc.h
@@ -781,13 +781,13 @@ struct fsl_ifc_regs {
 		__be32 amask;
 		u32 res4[0x2];
 	} amask_cs[FSL_IFC_BANK_COUNT];
-	u32 res5[0x17];
+	u32 res5[0x18];
 	struct {
-		__be32 csor_ext;
 		__be32 csor;
+		__be32 csor_ext;
 		u32 res6;
 	} csor_cs[FSL_IFC_BANK_COUNT];
-	u32 res7[0x19];
+	u32 res7[0x18];
 	struct {
 		__be32 ftim[4];
 		u32 res8[0x8];
-- 
1.9.1
