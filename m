Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id C87402BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 05:59:55 +1100 (EST)
Date: Wed, 15 Dec 2004 11:59:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org, torvalds@osdl.org
Message-ID: <20041215115944.B3696@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, cwernham@airspan.com,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] PPC4XX DMA polarity init fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[Clear bug fix, hopefully it can go in before 2.6.10]

This patch applies to the kernel 2.6.9 and fixes the initialisation of 
the DMA channel polarity in the function ppc4xx_init_dma_channel() for 
the PPC 4XX processor.

Signed-off-by: Colin P Wernham <cwernham@airspan.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/syslib/ppc4xx_dma.c 1.8 vs edited =====
--- 1.8/arch/ppc/syslib/ppc4xx_dma.c	2004-08-07 11:05:39 -07:00
+++ edited/arch/ppc/syslib/ppc4xx_dma.c	2004-12-15 11:58:16 -07:00
@@ -466,7 +466,7 @@
 
 	/* clear all polarity signals and then "or" in new signal levels */
 	polarity &= ~GET_DMA_POLARITY(dmanr);
-	polarity |= p_dma_ch->polarity;
+	polarity |= p_init->polarity;
 #if DCRN_POL > 0
 	mtdcr(DCRN_POL, polarity);
 #endif
