Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BE012C05EA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2012 00:59:58 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joerg.roedel@amd.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <timur@freescale.com>, <scottwood@freescale.com>
Subject: [PATCH 2/4] iommu/fsl: Add PAMU bypass enable register to ccsr_guts
 structure.
Date: Fri, 14 Dec 2012 19:23:52 +0530
Message-ID: <1355493232-21821-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAMU bypass enable register added to the ccsr_guts structure.

(This patch has already been applied by Kumar Gala in the linuxppc tree next branch)

Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/include/asm/fsl_guts.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index dd5ba2c..77ced0b 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -71,7 +71,9 @@ struct ccsr_guts {
 	u8	res0c4[0x224 - 0xc4];
 	__be32  iodelay1;	/* 0x.0224 - IO delay control register 1 */
 	__be32  iodelay2;	/* 0x.0228 - IO delay control register 2 */
-	u8	res22c[0x800 - 0x22c];
+	u8	res22c[0x604 - 0x22c];
+	__be32	pamubypenr; 	/* 0x.604 - PAMU bypass enable register */
+	u8	res608[0x800 - 0x608];
 	__be32	clkdvdr;	/* 0x.0800 - Clock Divide Register */
 	u8	res804[0x900 - 0x804];
 	__be32	ircr;		/* 0x.0900 - Infrared Control Register */
-- 
1.7.4.1
