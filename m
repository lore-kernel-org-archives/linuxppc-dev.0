Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0B2BDDE31
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 10:02:37 +1100 (EST)
Received: from ng (84-73-191-27.dclient.hispeed.ch [84.73.191.27])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.11.20060308/8.12.11/taifun-1.0) with ESMTP id
	l0JN2WZv027964
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sat, 20 Jan 2007 00:02:32 +0100
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] # ppc: ppc4xx_set_src/dst_addr were only correct for DMA0
Date: Sat, 20 Jan 2007 00:02:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701200002.32078.niklaus.giger@member.fsf.org>
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[PATCH] # ppc: ppc4xx_set_src/dst_addr were only correct for DMA0

The DCR-register numbers for DMA1-DMA3 were wrongly corrected.

Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>
---
 arch/ppc/syslib/ppc4xx_dma.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/syslib/ppc4xx_dma.c b/arch/ppc/syslib/ppc4xx_dma.c
index 1cb68a6..26b2ddf 100644
--- a/arch/ppc/syslib/ppc4xx_dma.c
+++ b/arch/ppc/syslib/ppc4xx_dma.c
@@ -47,9 +47,9 @@ ppc4xx_set_src_addr(int dmanr, phys_addr_t src_addr)
 	}
 
 #ifdef PPC4xx_DMA_64BIT
-	mtdcr(DCRN_DMASAH0 + dmanr*2, (u32)(src_addr >> 32));
+	mtdcr(DCRN_DMASAH0 + dmanr * 0x8, (u32)(src_addr >> 32));
 #else
-	mtdcr(DCRN_DMASA0 + dmanr*2, (u32)src_addr);
+	mtdcr(DCRN_DMASA0 + dmanr * 0x8, (u32)src_addr);
 #endif
 }
 
@@ -62,9 +62,9 @@ ppc4xx_set_dst_addr(int dmanr, phys_addr_t dst_addr)
 	}
 
 #ifdef PPC4xx_DMA_64BIT
-	mtdcr(DCRN_DMADAH0 + dmanr*2, (u32)(dst_addr >> 32));
+	mtdcr(DCRN_DMADAH0 + dmanr * 0x8, (u32)(dst_addr >> 32));
 #else
-	mtdcr(DCRN_DMADA0 + dmanr*2, (u32)dst_addr);
+	mtdcr(DCRN_DMADA0 + dmanr * 0x8, (u32)dst_addr);
 #endif
 }
