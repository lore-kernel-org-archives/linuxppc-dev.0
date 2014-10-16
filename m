Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 982211A028B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 08:39:55 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C64741400B8
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2014 08:39:53 +1100 (AEDT)
Message-ID: <1413495568.7417.7.camel@aoeu.buserror.net>
Subject: Re: [PATCH v2] powerpc: Only do dynamic DMA zone limits on
 platforms that need it
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 16 Oct 2014 23:39:28 +0200
In-Reply-To: <1413442068-5957-1-git-send-email-mpe@ellerman.id.au>
References: <1413442068-5957-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-16 at 17:47 +1100, Michael Ellerman wrote:
> Scott's patch 1c98025c6c95 "Dynamic DMA zone limits" changed
> dma_direct_alloc_coherent() to start using dev->coherent_dma_mask.
> 
> That seems fair enough, but it exposes the fact that some of the drivers
> we care about on IBM platforms aren't setting the coherent mask.
> 
> The proper fix is to have drivers set the coherent mask and also have
> the platform code honor it.
> 
> For now, just restrict the dynamic DMA zone limits to the platforms that
> need it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/dma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> v2: Use FSL_SOC.

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
