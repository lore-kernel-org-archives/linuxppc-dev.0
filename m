Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BYlS30sBzF0wM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 16:51:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 12/14] powerpc: pass node id into create_section_mapping
In-Reply-To: <20180213150824.27689-13-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-13-npiggin@gmail.com>
Date: Thu, 29 Mar 2018 16:51:16 +1100
Message-ID: <87o9j71lbf.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 328ff9abc333..435b19e74508 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -862,9 +862,9 @@ static void remove_pagetable(unsigned long start, unsigned long end)
>  	radix__flush_tlb_kernel_range(start, end);
>  }
>  
> -int __ref radix__create_section_mapping(unsigned long start, unsigned long end)
> +int __ref radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
>  {
> -	return create_physical_mapping(start, end);
> +	return create_physical_mapping(start, end, nid);
>  }

This got a little muddled. We add the nid argument here, but
create_physical_mapping() doesn't take it until patch 14.

I managed to fix it by rearranging the last three patches and fiddling
things a bit. If you can check the result once I push that would be good.

cheers
