Return-Path: <akinobu.mita@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 46835DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 14:44:21 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so193120waf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Apr 2009 20:44:19 -0700 (PDT)
Date: Thu, 2 Apr 2009 12:44:14 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix highmem build failure
Message-ID: <20090402034414.GA22836@localhost.localdomain>
References: <1238621611-4844-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238621611-4844-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 01, 2009 at 04:33:31PM -0500, Kumar Gala wrote:
> The following commit breaks PPC builds with CONFIG_HIGHMEM=y
> 
> commit f4112de6b679d84bd9b9681c7504be7bdfb7c7d5
> Author: Akinobu Mita <akinobu.mita@gmail.com>
> Date:   Tue Mar 31 15:23:25 2009 -0700
> 
>     mm: introduce debug_kmap_atomic
> 

Thanks.
But the definition of debug_kmap_atomic() needs to be outside of
ifdef CONFIG_HIGHMEM. Because debug_kmap_atomic() is used without
CONFIG_HIGHMEM by kmap_atomic_prot_pfn() in arch/x86/mm/iomap_32.c

> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -20,6 +20,19 @@ static inline void flush_kernel_dcache_page(struct page *page)
>  #endif
>  
>  #ifdef CONFIG_HIGHMEM
> +#include <asm/kmap_types.h>
> +
> +#if defined(CONFIG_DEBUG_HIGHMEM) && defined(CONFIG_TRACE_IRQFLAGS_SUPPORT)
> +
> +void debug_kmap_atomic(enum km_type type);
> +
> +#else
> +
> +static inline void debug_kmap_atomic(enum km_type type)
> +{
> +}
> +
> +#endif
>  
>  #include <asm/highmem.h>
>  
