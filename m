Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-pb-sasl-sd.pobox.com [64.74.157.62])
	by ozlabs.org (Postfix) with ESMTP id CA430B6F99
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 03:36:47 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
From: Nathan Lynch <ntl@pobox.com>
To: Steve Best <sfbest@us.ibm.com>
Date: Tue, 14 Jun 2011 12:30:57 -0500
In-Reply-To: <20110614165011.23034.66685.sendpatchset@squad5-lp1.lab.bos.redhat.com>
References: <20110614165011.23034.66685.sendpatchset@squad5-lp1.lab.bos.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308072658.2452.10.camel@orca.stoopid.dyndns.org>
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

Hi Steve,

On Tue, 2011-06-14 at 12:58 -0400, Steve Best wrote:
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index e72dcf6..e1aab6b 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -283,4 +283,15 @@ config PPC_EARLY_DEBUG_CPM_ADDR
>  	  platform probing is done, all platforms selected must
>  	  share the same address.
>  
> +config STRICT_DEVMEM
> +        def_bool y

Default new config items to n, please.


> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -520,3 +520,21 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  	hash_preload(vma->vm_mm, address, access, trap);
>  #endif /* CONFIG_PPC_STD_MMU */
>  }
> +
> +/*
> + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
> + * is valid. The argument is a physical page number.
> + *
> + * On PowerPC, access has to be given to data regions used by X. We have to
> + * disallow access to device-exclusive MMIO regions and system RAM. 
> + */
> +int devmem_is_allowed(unsigned long pfn)
> +{
> +        if ((pfn >= 57360 || pfn <= 57392))
> +                return 1;

That seems... fragile.  Where do these numbers come from, and are they
appropriate for all platforms and configurations?
