Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 299CD1A116C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 21:00:30 +1100 (AEDT)
Message-ID: <1449741623.7156.3.camel@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] powerpc: Copy only required pieces of the
 mm_context_t to the paca
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, Cyril Bur <cyrilbur@gmail.com>
Date: Thu, 10 Dec 2015 21:00:23 +1100
In-Reply-To: <1449719211.29188.5.camel@neuling.org>
References: <1446008047-2393-1-git-send-email-mikey@neuling.org>
 <1446008047-2393-2-git-send-email-mikey@neuling.org>
 <1449719211.29188.5.camel@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-12-10 at 14:46 +1100, Michael Neuling wrote:

> Currently we copy the whole mm_context_t to the paca but only access a
> few bits of it.  This is wasteful of space paca and also takes quite
> some time in the hot path of context switching.
> 
> diff --git a/arch/powerpc/include/asm/paca.h
> b/arch/powerpc/include/asm/paca.h
> index 1cc6e08..06cdaee 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -199,7 +206,14 @@ struct paca_struct {
>  #ifdef CONFIG_PPC_BOOK3S
>  static inline void copy_mm_to_paca(mm_context_t *context)
>  {
> -	get_paca()->context = *context;
> +	get_paca()->context_id = context->id;
> +#ifdef CONFIG_PPC_MM_SLICES
> +	get_paca()->context_low_slices_psize = context
> ->low_slices_psize;

Patch is wrapped ^

And so on.

cheers
