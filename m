Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2lXV1jRfzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:43:38 +1000 (AEST)
Date: Wed, 12 Apr 2017 10:43:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com,
 linux-nvdimm@lists.01.org
Subject: Re: [PATCH 6/9] powerpc, mm: Enable ZONE_DEVICE on powerpc
Message-ID: <20170412104337.535c5abb@canb.auug.org.au>
In-Reply-To: <20170411174233.21902-7-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-7-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Oliver,

On Wed, 12 Apr 2017 03:42:30 +1000 Oliver O'Halloran <oohall@gmail.com> wrote:
>
> Flip the switch. Running around and screaming "IT'S ALIVE" is optional,
> but recommended.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 43d000e44424..d696af58f97f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -724,7 +724,7 @@ config ZONE_DEVICE
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
>  	depends on SPARSEMEM_VMEMMAP
> -	depends on X86_64 #arch_add_memory() comprehends device memory
> +	depends on (X86_64 || PPC_BOOK3S_64)  #arch_add_memory() comprehends device memory
>  

That's fine, but at what point do we create
CONFIG_ARCH_HAVE_ZONE_DEVICE, replace the "depends on
<archs/platforms>" above with "depends on ARCH_HAVE_ZONE_DEVICE" and
select that from the appropriate places?

-- 
Cheers,
Stephen Rothwell
