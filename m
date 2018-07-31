Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ftSV1N0jzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 20:47:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] powerpc: do not redefined NEED_DMA_MAP_STATE
In-Reply-To: <20180730073721.15991-1-hch@lst.de>
References: <20180730073721.15991-1-hch@lst.de>
Date: Tue, 31 Jul 2018 20:47:53 +1000
Message-ID: <87d0v3heau.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christoph Hellwig <hch@lst.de> writes:

> kernel/dma/Kconfig already defines NEED_DMA_MAP_STATE, just select it
> from PPC64 and NOT_COHERENT_CACHE instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/Kconfig                   | 3 ---
>  arch/powerpc/platforms/Kconfig.cputype | 2 ++
>  2 files changed, 2 insertions(+), 3 deletions(-)

Thanks.

I did this instead:

commit 870771ae76010c5e42ee8e0278f5823e46e96e3f (HEAD -> next-test)
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon Jul 30 09:37:21 2018 +0200
Commit:     Michael Ellerman <mpe@ellerman.id.au>
CommitDate: Tue Jul 31 20:43:57 2018 +1000

    powerpc: Do not redefine NEED_DMA_MAP_STATE
    
    kernel/dma/Kconfig already defines NEED_DMA_MAP_STATE, just select it
    from CONFIG_PPC using the same condition as an if guard.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    [mpe: Move it under PPC]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5eb4d969afbf..ee38fce075ee 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -226,6 +226,7 @@ config PPC
        select IRQ_DOMAIN
        select IRQ_FORCED_THREADING
        select MODULES_USE_ELF_RELA
+       select NEED_DMA_MAP_STATE               if PPC64 || NOT_COHERENT_CACHE
        select NEED_SG_DMA_LENGTH
        select NO_BOOTMEM
        select OF
@@ -885,9 +886,6 @@ config ZONE_DMA
        bool
        default y
 
-config NEED_DMA_MAP_STATE
-       def_bool (PPC64 || NOT_COHERENT_CACHE)
-
 config GENERIC_ISA_DMA
        bool
        depends on ISA_DMA_API


cheers
