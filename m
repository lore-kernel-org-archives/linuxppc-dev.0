Return-Path: <CWernham@Airspan.com>
Received: from mail.airspan.com (mail.airspan.com [62.189.116.4])
	by ozlabs.org (Postfix) with ESMTP id 624662BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 01:14:40 +1100 (EST)
Message-ID: <41BDA25A.3090205@airspan.com>
Date: Mon, 13 Dec 2004 14:08:26 +0000
From: Colin Wernham <cwernham@airspan.com>
MIME-Version: 1.0
To: mporter@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: inuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH]PPC4XX DMA polarity init fix kernel 2.6.9
Reply-To: cwernham@airspan.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch applies to the kernel 2.6.9 and fixes the initialisation of 
the DMA channel polarity in the function ppc4xx_init_dma_channel() for 
the PPC 4XX processor.

Signed-off-by: Colin P Wernham <cwernham@airspan.com>

--- /home/cwernham/work/linux-2.6.9.old/arch/ppc/syslib/ppc4xx_dma.c 
2004-10-18 22:55:35.000000000 +0100
+++ arch/ppc/syslib/ppc4xx_dma.c	2004-12-10 09:19:19.000000000 +0000
@@ -466,7 +466,7 @@ ppc4xx_init_dma_channel(unsigned int dma

  	/* clear all polarity signals and then "or" in new signal levels */
  	polarity &= ~GET_DMA_POLARITY(dmanr);
-	polarity |= p_dma_ch->polarity;
+	polarity |= p_init->polarity;
  #if DCRN_POL > 0
  	mtdcr(DCRN_POL, polarity);
  #endif
