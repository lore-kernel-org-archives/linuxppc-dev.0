Return-Path: <B32579@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 637DD2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 13:58:48 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mpc85xx:Add new ext fields to Integrated FLash
 Controller
Date: Thu, 16 Aug 2012 09:28:22 +0530
Message-ID: <1345089502-23979-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Prabhakar Kushwaha <prabhakar@freescale.com>,
 York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale's Integrated Flash controller(IFC) v1.1.0 supports 40 bit
address bus width. 
In case more than 32 bit address is used, the EXT registers should be set.

Add support of ext registers.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
Base upon git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
Branch next

 arch/powerpc/include/asm/fsl_ifc.h |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_ifc.h b/arch/powerpc/include/asm/fsl_ifc.h
index b955012..b8a4b9b 100644
--- a/arch/powerpc/include/asm/fsl_ifc.h
+++ b/arch/powerpc/include/asm/fsl_ifc.h
@@ -768,22 +768,24 @@ struct fsl_ifc_gpcm {
  */
 struct fsl_ifc_regs {
 	__be32 ifc_rev;
-	u32 res1[0x3];
+	u32 res1[0x2];
 	struct {
+		__be32 cspr_ext;
 		__be32 cspr;
-		u32 res2[0x2];
+		u32 res2;
 	} cspr_cs[FSL_IFC_BANK_COUNT];
-	u32 res3[0x18];
+	u32 res3[0x19];
 	struct {
 		__be32 amask;
 		u32 res4[0x2];
 	} amask_cs[FSL_IFC_BANK_COUNT];
-	u32 res5[0x18];
+	u32 res5[0x17];
 	struct {
+		__be32 csor_ext;
 		__be32 csor;
-		u32 res6[0x2];
+		u32 res6;
 	} csor_cs[FSL_IFC_BANK_COUNT];
-	u32 res7[0x18];
+	u32 res7[0x19];
 	struct {
 		__be32 ftim[4];
 		u32 res8[0x8];
-- 
1.7.9.5
