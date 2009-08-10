Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 40758B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 16:46:40 +1000 (EST)
Subject: Re: [PATCH] Stop pci_set_dma_mask() from failing when RAM doesn't
	exceed the mask anyway
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1249069310.20192.220.camel@macbook.infradead.org>
References: <1249069310.20192.220.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 16:46:19 +1000
Message-Id: <1249886779.9841.19.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-07-31 at 20:41 +0100, David Woodhouse wrote:
> On an iMac G5, the b43 driver is failing to initialise because trying to
> set the dma mask to 30-bit fails. Even though there's only 512MiB of RAM
> in the machine anyway:
> 	https://bugzilla.redhat.com/show_bug.cgi?id=514787
> 
> We should probably let it succeed if the available RAM in the system
> doesn't exceed the requested limit.

I've slightly modified the patch to use lmb_end_of_DRAM() instead
of highest_memmap_pfn because the later is an mm internal.h thing,
it looked too fishy to rely on it form arch code with a local
"extern" in the C code :-) It's not going to cause much more overhead
and it's not a hot path anyway afaik.

Below is a copy of what I've commited to my merge branch and will
ask Linus to pull in a few minutes.

>From 10ba96df690618632a8786494b2359f5ee350048 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 31 Jul 2009 09:41:50 +0000
Subject: [PATCH] powerpc/dma: pci_set_dma_mask() shouldn't fail if mask fits in RAM

On an iMac G5, the b43 driver is failing to initialise because trying to
set the dma mask to 30-bit fails. Even though there's only 512MiB of RAM
in the machine anyway:
	https://bugzilla.redhat.com/show_bug.cgi?id=514787

We should probably let it succeed if the available RAM in the system
doesn't exceed the requested limit.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/dma.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 20a60d6..ccf129d 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/lmb.h>
 #include <asm/bug.h>
 #include <asm/abs_addr.h>
 
@@ -90,11 +91,10 @@ static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
 static int dma_direct_dma_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_PPC64
-	/* Could be improved to check for memory though it better be
-	 * done via some global so platforms can set the limit in case
+	/* Could be improved so platforms can set the limit in case
 	 * they have limited DMA windows
 	 */
-	return mask >= DMA_BIT_MASK(32);
+	return mask >= (lmb_end_of_DRAM() - 1);
 #else
 	return 1;
 #endif
-- 
1.6.1.2.14.gf26b5
