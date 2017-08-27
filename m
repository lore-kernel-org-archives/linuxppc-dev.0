Return-Path: <BATV+0d43c28c1e7909f7e68d+5117+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgKdB10KyzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 02:10:51 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>,
 David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] floppy: consolidate the dummy fd_cacheflush definition
Date: Sun, 27 Aug 2017 18:10:21 +0200
Message-Id: <20170827161032.22772-2-hch@lst.de>
In-Reply-To: <20170827161032.22772-1-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only mips defines this helper, so remove all the other arch definitions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/floppy.h    | 2 --
 arch/powerpc/include/asm/floppy.h  | 2 --
 arch/sparc/include/asm/floppy_32.h | 1 -
 arch/sparc/include/asm/floppy_64.h | 1 -
 drivers/block/floppy.c             | 4 ++++
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/include/asm/floppy.h b/arch/alpha/include/asm/floppy.h
index bae97eb19d26..942924756cf2 100644
--- a/arch/alpha/include/asm/floppy.h
+++ b/arch/alpha/include/asm/floppy.h
@@ -24,7 +24,6 @@
 #define fd_set_dma_count(count) set_dma_count(FLOPPY_DMA,count)
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
-#define fd_cacheflush(addr,size) /* nothing */
 #define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt,\
 					    0, "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL)
@@ -62,7 +61,6 @@ alpha_fd_dma_setup(char *addr, unsigned long size, int mode, int io)
 	prev_dir = dir;
 
 	fd_clear_dma_ff();
-	fd_cacheflush(addr, size);
 	fd_set_dma_mode(mode);
 	set_dma_addr(FLOPPY_DMA, bus_addr);
 	fd_set_dma_count(size);
diff --git a/arch/powerpc/include/asm/floppy.h b/arch/powerpc/include/asm/floppy.h
index 936a904ae78c..167c44b58848 100644
--- a/arch/powerpc/include/asm/floppy.h
+++ b/arch/powerpc/include/asm/floppy.h
@@ -25,7 +25,6 @@
 #define fd_get_dma_residue()    fd_ops->_get_dma_residue(FLOPPY_DMA)
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
-#define fd_cacheflush(addr,size) /* nothing */
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
 #include <linux/pci.h>
@@ -152,7 +151,6 @@ static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
 	prev_dir = dir;
 
 	fd_clear_dma_ff();
-	fd_cacheflush(addr, size);
 	fd_set_dma_mode(mode);
 	set_dma_addr(FLOPPY_DMA, bus_addr);
 	fd_set_dma_count(size);
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index 071b83e52f15..dab58525229e 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -70,7 +70,6 @@ static struct sun_floppy_ops sun_fdops;
 #define fd_set_dma_count(count)   sun_fd_set_dma_count(count)
 #define fd_enable_irq()           /* nothing... */
 #define fd_disable_irq()          /* nothing... */
-#define fd_cacheflush(addr, size) /* nothing... */
 #define fd_request_irq()          sun_fd_request_irq()
 #define fd_free_irq()             /* nothing... */
 #if 0  /* P3: added by Alain, these cause a MMU corruption. 19960524 XXX */
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 625756406a7e..a1db35a22c99 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -72,7 +72,6 @@ static struct sun_floppy_ops sun_fdops;
 #define fd_set_dma_addr(addr)     sun_fdops.fd_set_dma_addr(addr)
 #define fd_set_dma_count(count)   sun_fdops.fd_set_dma_count(count)
 #define get_dma_residue(x)        sun_fdops.get_dma_residue()
-#define fd_cacheflush(addr, size) /* nothing... */
 #define fd_request_irq()          sun_fdops.fd_request_irq()
 #define fd_free_irq()             sun_fdops.fd_free_irq()
 #define fd_eject(drive)           sun_fdops.fd_eject(drive)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 9c00f29e40c1..b1d896f9a227 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -275,6 +275,10 @@ static int set_next_request(void);
 #define fd_dma_mem_alloc(size) __get_dma_pages(GFP_KERNEL, get_order(size))
 #endif
 
+#ifndef fd_cacheflush
+#define fd_cacheflush(addr, size) /* nothing... */
+#endif
+
 static inline void fallback_on_nodma_alloc(char **addr, size_t l)
 {
 #ifdef FLOPPY_CAN_FALLBACK_ON_NODMA
-- 
2.11.0
