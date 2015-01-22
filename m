Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 761741A0C45
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:21:23 +1100 (AEDT)
Message-ID: <1421907682.4598.6.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/kernel: Avoid memory corruption at early stage
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Thu, 22 Jan 2015 17:21:22 +1100
In-Reply-To: <1420695651-574-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1420695651-574-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-08 at 16:40 +1100, Gavin Shan wrote:
> When calling to early_setup(), we picks "boot_paca" up for the
> master CPU and initialize that with initialise_paca(). At the
> point, SLB shadow buffer isn't populated yet. Updating the SLB
> shadow buffer should corrupt what we had in physical address 0
> where the trap instruction is usually stored.

Ouch.

Introduced in 6f4441ef7009 ("powerpc: Dynamically allocate slb_shadow from
memblock") - December 2013.

So it seems it doesn't cause us any harm in general.

Did you actually hit a bug with it?

> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index d6e195e..048a6ee 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -115,6 +115,9 @@ static struct slb_shadow * __init init_slb_shadow(int cpu)
>  {
>  	struct slb_shadow *s = &slb_shadow[cpu];
>  
> +	if (!slb_shadow)
> +		return NULL;
> +
>  	s->persistent = cpu_to_be32(SLB_NUM_BOLTED);
>  	s->buffer_length = cpu_to_be32(sizeof(*s));


Yeah I guess that's an OK fix.

We must have a valid SLB shadow before we ever call _switch(), which is much
later. The only way we could hit this case for the real paca is if
allocate_slb_shadows() failed to allocate, but it would have panicked if it
did.

cheers
