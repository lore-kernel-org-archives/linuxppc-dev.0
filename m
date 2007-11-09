Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABF47DDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 08:12:07 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Fix oops related to 4xx flush_tlb_page
	modification
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0711090358300.28266@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0711090358300.28266@blarg.am.freescale.net>
Content-Type: text/plain
Date: Sat, 10 Nov 2007 08:11:58 +1100
Message-Id: <1194642718.21340.20.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-09 at 03:58 -0600, Kumar Gala wrote:
> kmap_atomic calls flush_tlb_page with a NULL VMA and thus we end
> up dereferencing a NULL pointer to try and get the context.id.
> 
> If the VMA is null use the global pid value of 0.

Ack.

> ---
>  include/asm-powerpc/tlbflush.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-powerpc/tlbflush.h b/include/asm-powerpc/tlbflush.h
> index e7b4c0d..5c91081 100644
> --- a/include/asm-powerpc/tlbflush.h
> +++ b/include/asm-powerpc/tlbflush.h
> @@ -44,13 +44,13 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>  static inline void flush_tlb_page(struct vm_area_struct *vma,
>  				  unsigned long vmaddr)
>  {
> -	_tlbie(vmaddr, vma->vm_mm->context.id);
> +	_tlbie(vmaddr, vma ? vma->vm_mm->context.id : 0);
>  }
> 
>  static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
>  					 unsigned long vmaddr)
>  {
> -	_tlbie(vmaddr, vma->vm_mm->context.id);
> +	_tlbie(vmaddr, vma ? vma->vm_mm->context.id : 0);
>  }
> 
>  static inline void flush_tlb_range(struct vm_area_struct *vma,
