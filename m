Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GQk82pMYzF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 22:48:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/2] powerpc/swiotlb: Dont free up allocated SWIOTLB slab on
 POWER
In-Reply-To: <20180404030301.25019-1-khandual@linux.vnet.ibm.com>
References: <20180404030301.25019-1-khandual@linux.vnet.ibm.com>
Date: Wed, 04 Apr 2018 22:48:31 +1000
Message-ID: <87fu4bcf34.fsf@concordia.ellerman.id.au>
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> Even though SWIOTLB slab gets allocated and initialized on powerpc with
> swiotlb_init() called during mem_init(), it gets released away again on
> POWER platform because 'ppc_swiotlb_enable' never gets set. The function
> swiotlb_detect_4g() checks for 4GB memory and then sets the variable
> 'ppc_swiotlb_enable' which prevents freeing up the SWIOTLB slab. Lets
> make POWER platform call swiotlb_detect_4g() during setup_arch() which
> will keep the SWIOTLB slab through out the runtime.
>
> A previous commit cf5621032f ("powerpc/64: Limit ZONE_DMA32 to 4GiB in
> swiotlb_detect_4g()") enforced 4GB limit on ZONE_DMA32 which is is not
> applicable on POWER (CONFIG_PPC_BOOK3S_64) platform. Lets remove this
> unnecessary restriction.

You're using "POWER" to mean Book3S 64-bit, but "POWER" is something
else (the ISA for POWER1/POWER2).

So please just say "Book3S 64-bit" or talk about a specific CPU, eg.
Power9.

> After the patch, SWIOTLB slab does not get released.
>
> [0.410992] software IO TLB [mem 0xfbff0000-0xffff0000] (64MB) mapped
> at [00000000767f6cb3-000000004a10114f]

But we don't want SWIOTLB on any existing Book3S 64-bit platforms, so
leaving it enabled is just wasting memory.

> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index d73ec518ef80..c4db844e0b0d 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -944,6 +944,7 @@ void __init setup_arch(char **cmdline_p)
>  	/* Initialize the MMU context management stuff. */
>  	mmu_context_init();
>  
> +	swiotlb_detect_4g();

You shouldn't be calling this, your use case has nothing to do with 4GB.

Instead when you detect that you're running under the ultravisor then
you should set ppc_swiotlb_enable = 1.

cheers
