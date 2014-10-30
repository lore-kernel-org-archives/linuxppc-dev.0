Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C88091A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 20:27:11 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Added rcw registers to global utility registers
Date: Thu, 30 Oct 2014 11:15:47 +0200
Message-ID: <1414660547-1488-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>,
 Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

The RCW registers are required for the future clock binding implementation.

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
Change-Id: Ic36dd8bc2959aa7f97fb6fd7bbb8420822fef0a9
---
 arch/powerpc/include/asm/fsl_guts.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index 193d1f1..38d0b57 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -68,7 +68,10 @@ struct ccsr_guts {
 	u8	res0b4[0xc0 - 0xb4];
 	__be32  iovselsr;	/* 0x.00c0 - I/O voltage select status register
 					     Called 'elbcvselcr' on 86xx SOCs */
-	u8	res0c4[0x224 - 0xc4];
+	u8	res0c4[0x100 - 0xc4];
+	__be32	rcwsr[16];	/* 0x.0100 - Reset Control Word Status registers
+					     There are 16 registers */
+	u8	res140[0x224 - 0x140];
 	__be32  iodelay1;	/* 0x.0224 - IO delay control register 1 */
 	__be32  iodelay2;	/* 0x.0228 - IO delay control register 2 */
 	u8	res22c[0x604 - 0x22c];
-- 
1.7.9.5
