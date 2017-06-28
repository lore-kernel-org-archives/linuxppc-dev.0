Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyDfy20JPzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 17:18:50 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u36so7182383pgn.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 00:18:50 -0700 (PDT)
Subject: Re: [PATCH] powerpc: Build fix for non SPARSEMEM_VMEMAP config
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <1498630168-26376-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <bb344453-f49d-aff1-8f9c-732b8a40cbfa@ozlabs.ru>
Date: Wed, 28 Jun 2017 17:18:42 +1000
MIME-Version: 1.0
In-Reply-To: <1498630168-26376-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/06/17 16:09, Aneesh Kumar K.V wrote:
> We can use pfn_to_page in realmode for other configs. Hence remove the
> CONFIG_FLATMEM ifdef


For CONFIG_SPARSEMEM and CONFIG_DISCONTIGMEM and others (I am struggling to
find the full list :) )? Are you sure about that? If I recall correctly, at
the time realmode_pfn_to_page() could not work for all of them, what changed?

> 
> Fixes: 8e0861fa3c4ed (powerpc: Prepare to support kernel handling of IOMMU map/unmap)
> 
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/init_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index ec84b31c6c86..3dd507b4f8cd 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -322,7 +322,7 @@ struct page *realmode_pfn_to_page(unsigned long pfn)
>  }
>  EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
>  
> -#elif defined(CONFIG_FLATMEM)
> +#else

There is also a comment at the #endif with "FLATMEM", needs to be updated.


>  
>  struct page *realmode_pfn_to_page(unsigned long pfn)
>  {
> 


-- 
Alexey
