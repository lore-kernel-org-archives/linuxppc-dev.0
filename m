Return-Path: <BATV+d9386a2b82e844863ec9+4376+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99F591A1E4C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 17:10:51 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: akpm@linux-foundation.org
Cc: arnd@arndb.de, linux@arm.linux.org.uk, catalin.marinas@arm.com,
 will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
 jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
 x86@kernel.org, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: provide more common DMA API functions V2
Date: Mon, 17 Aug 2015 09:06:51 +0200
Message-Id: <1439795216-32189-1-git-send-email-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since 2009 we have a nice asm-generic header implementing lots of DMA API
functions for architectures using struct dma_map_ops, but unfortunately
it's still missing a lot of APIs that all architectures still have to
duplicate.

This series consolidates the remaining functions, although we still
need arch opt outs for two of them as a few architectures have very
non-standard implementations.

Changes since V1:
 - keep a modified comment about dma_alloc_noncoherent vs
   dma_cache_sync in the ARM asm/dma-mapping.h
 - keep the ARM dma_set_mask instances to deal with dmabounce
