Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8862B1007D3
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 04:21:20 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] [v2] powerpc/fsl: add PAMUBYPENR register definition to
 fsl_guts.h
Date: Thu, 16 Feb 2012 11:21:10 -0600
Message-ID: <1329412870-16716-2-git-send-email-timur@freescale.com>
In-Reply-To: <1329412870-16716-1-git-send-email-timur@freescale.com>
References: <1329412870-16716-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a defintion of register PAMUBYPENR (offset 0x604) to the global
utilities structure.

PAMUBYPENR is the PAMU bypass enable register.  It contains control
bits for enabling bypass mode on each PAMU.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/fsl_guts.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index a880377..23e483d 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -69,7 +69,9 @@ struct ccsr_guts {
 	u8	res0c4[0x224 - 0xc4];
 	__be32  iodelay1;	/* 0x.0224 - IO delay control register 1 */
 	__be32  iodelay2;	/* 0x.0228 - IO delay control register 2 */
-	u8	res22c[0x800 - 0x22c];
+	u8	res22c[0x604 - 0x22c];
+	__be32	pamubypenr;	/* 0x.0604 - PAMU bypass enable register */
+	u8	res608[0x800 - 0x608];
 	__be32	clkdvdr;	/* 0x.0800 - Clock Divide Register */
 	u8	res804[0x900 - 0x804];
 	__be32	ircr;		/* 0x.0900 - Infrared Control Register */
-- 
1.7.3.4
