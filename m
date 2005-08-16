Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id A92FB67F5A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 15:21:47 +1000 (EST)
Date: Mon, 15 Aug 2005 22:21:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050815222144.B28706@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix ppc4xx stb03xxx dma build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fixes build on 4xx stb03xxx when general purpose dma engine support
is enabled.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/syslib/ppc4xx_dma.c b/arch/ppc/syslib/ppc4xx_dma.c
--- a/arch/ppc/syslib/ppc4xx_dma.c
+++ b/arch/ppc/syslib/ppc4xx_dma.c
@@ -620,6 +620,7 @@ ppc4xx_clr_dma_status(unsigned int dmanr
 	return DMA_STATUS_GOOD;
 }
 
+#ifdef CONFIG_PPC4xx_EDMA
 /*
  * Enables the burst on the channel (BTEN bit in the control/count register)
  * Note:
@@ -685,6 +686,11 @@ ppc4xx_set_burst_size(unsigned int dmanr
 	return DMA_STATUS_GOOD;
 }
 
+EXPORT_SYMBOL(ppc4xx_enable_burst);
+EXPORT_SYMBOL(ppc4xx_disable_burst);
+EXPORT_SYMBOL(ppc4xx_set_burst_size);
+#endif /* CONFIG_PPC4xx_EDMA */
+
 EXPORT_SYMBOL(ppc4xx_init_dma_channel);
 EXPORT_SYMBOL(ppc4xx_get_channel_config);
 EXPORT_SYMBOL(ppc4xx_set_channel_priority);
@@ -703,6 +709,4 @@ EXPORT_SYMBOL(ppc4xx_enable_dma_interrup
 EXPORT_SYMBOL(ppc4xx_disable_dma_interrupt);
 EXPORT_SYMBOL(ppc4xx_get_dma_status);
 EXPORT_SYMBOL(ppc4xx_clr_dma_status);
-EXPORT_SYMBOL(ppc4xx_enable_burst);
-EXPORT_SYMBOL(ppc4xx_disable_burst);
-EXPORT_SYMBOL(ppc4xx_set_burst_size);
+
diff --git a/include/asm-ppc/ppc4xx_dma.h b/include/asm-ppc/ppc4xx_dma.h
--- a/include/asm-ppc/ppc4xx_dma.h
+++ b/include/asm-ppc/ppc4xx_dma.h
@@ -285,7 +285,7 @@ typedef uint32_t sgl_handle_t;
 
 #define GET_DMA_POLARITY(chan) (DMAReq_ActiveLow(chan) | DMAAck_ActiveLow(chan) | EOT_ActiveLow(chan))
 
-#elif defined(CONFIG_STBXXX_DMA)		/* stb03xxx */
+#elif defined(CONFIG_STB03xxx)		/* stb03xxx */
 
 #define DMA_PPC4xx_SIZE	4096
 
