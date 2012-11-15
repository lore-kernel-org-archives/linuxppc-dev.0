Return-Path: <shuah.khan@hp.com>
Received: from g6t0184.atlanta.hp.com (g6t0184.atlanta.hp.com [15.193.32.61])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CCFB82C048A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2012 05:05:18 +1100 (EST)
Message-ID: <1353002712.2532.42.camel@lorien2>
Subject: Re: [PATCH RFT RESEND linux-next] powerpc: dma-mapping: support
 debug_dma_mapping_error
From: Shuah Khan <shuah.khan@hp.com>
To: benh@kernel.crashing.org, m.szyprowski@samsung.com
Date: Thu, 15 Nov 2012 11:05:12 -0700
In-Reply-To: <1351267705.4013.18.camel@lorien2>
References: <1351210584.6851.21.camel@lorien2>
 <1351267705.4013.18.camel@lorien2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: arnd@arndb.de, LKML <linux-kernel@vger.kernel.org>,
 kyungmin.park@samsung.com, paulus@samba.org, shuahkhan@gmail.com,
 andrzej.p@samsung.com, linuxppc-dev@lists.ozlabs.org,
 david@gibson.dropbear.id.au
Reply-To: shuah.khan@hp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-10-26 at 10:08 -0600, Shuah Khan wrote:
> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated.
> 
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> ---
>  arch/powerpc/include/asm/dma-mapping.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 7816087..e27e9ad 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -172,6 +172,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  {
>  	struct dma_map_ops *dma_ops = get_dma_ops(dev);
>  
> +	debug_dma_mapping_error(dev, dma_addr);
>  	if (dma_ops->mapping_error)
>  		return dma_ops->mapping_error(dev, dma_addr);
>  

Marek,

This one is for powerpc to go through your tree with the other arch
debug_dma_mapping_error() patches.

Thanks,
-- Shuah
