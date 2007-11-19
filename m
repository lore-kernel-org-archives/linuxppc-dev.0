Return-Path: <jwboyer@gmail.com>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.247])
	by ozlabs.org (Postfix) with ESMTP id A4EBCDDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 23:06:30 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so1083511aga
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 04:06:29 -0800 (PST)
Date: Mon, 19 Nov 2007 06:06:23 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Fix 8xx build breakage due to _tlbie changes
Message-ID: <20071119060623.67387f2c@vader.jdub.homelinux.org>
In-Reply-To: <20071119064209.03A53DDE21@ozlabs.org>
References: <1195454481.61987.176042550045.qpush@grosgo>
	<20071119064209.03A53DDE21@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 Nov 2007 17:41:21 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> My changes to _tlbie to fix 4xx unfortunately broke 8xx build in a
> couple of places. This fixes it.
> 
> Spotted by Olof Johansson
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
>  arch/powerpc/mm/mem.c      |    2 +-
>  arch/powerpc/mm/mmu_decl.h |    2 +-
>  arch/ppc/mm/init.c         |    2 +-
>  arch/ppc/mm/mmu_decl.h     |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-work/arch/powerpc/mm/mem.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/mm/mem.c	2007-11-15 13:59:27.000000000 +1100
> +++ linux-work/arch/powerpc/mm/mem.c	2007-11-15 13:59:44.000000000 +1100
> @@ -464,7 +464,7 @@ void update_mmu_cache(struct vm_area_str
>  		 * we invalidate the TLB here, thus avoiding dcbst
>  		 * misbehaviour.
>  		 */
> -		_tlbie(address);
> +		_tlbie(address, 0 /* 8xx doesn't care about PID */);
>  #endif
>  		if (!PageReserved(page)
>  		    && !test_bit(PG_arch_1, &page->flags)) {
> Index: linux-work/arch/ppc/mm/init.c
> ===================================================================
> --- linux-work.orig/arch/ppc/mm/init.c	2007-11-15 14:00:20.000000000 +1100
> +++ linux-work/arch/ppc/mm/init.c	2007-11-15 14:00:35.000000000 +1100
> @@ -561,7 +561,7 @@ void update_mmu_cache(struct vm_area_str
>  		 * That means the zeroed TLB has to be invalidated
>  		 * whenever a page miss occurs.
>  		 */
> -		_tlbie(address);
> +		_tlbie(address, 0 /* 8xx doesn't care about PID */);
>  #endif
>  		if (!PageReserved(page)
>  		    && !test_bit(PG_arch_1, &page->flags)) {
> Index: linux-work/arch/powerpc/mm/mmu_decl.h
> ===================================================================
> --- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2007-11-15 14:09:16.000000000 +1100
> +++ linux-work/arch/powerpc/mm/mmu_decl.h	2007-11-15 14:14:29.000000000 +1100
> @@ -56,7 +56,7 @@ extern unsigned long total_lowmem;
>   * architectures.  -- Dan
>   */
>  #if defined(CONFIG_8xx)
> -#define flush_HPTE(X, va, pg)	_tlbie(va)
> +#define flush_HPTE(X, va, pg)	_tlbie(va, 0, /* 8xx doesn't care about PID */)

Spurious ','?

josh
