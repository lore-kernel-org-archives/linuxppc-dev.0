Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2LCW4msGzDq7q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 09:42:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] powerpc: do not call ppc_md.panic in panic notifier
 if fadump not used
In-Reply-To: <20170704100909.8738-2-npiggin@gmail.com>
References: <20170704100909.8738-1-npiggin@gmail.com>
 <20170704100909.8738-2-npiggin@gmail.com>
Date: Wed, 05 Jul 2017 09:42:46 +1000
Message-ID: <87o9szydjd.fsf@concordia.ellerman.id.au>
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
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 94a948207cd2..39ba09965b04 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -707,12 +707,15 @@ EXPORT_SYMBOL(check_legacy_ioport);
>  static int ppc_panic_event(struct notifier_block *this,
>                               unsigned long event, void *ptr)
>  {
> -	/*
> -	 * If firmware-assisted dump has been registered then trigger
> -	 * firmware-assisted dump and let firmware handle everything else.
> -	 */
> -	crash_fadump(NULL, ptr);
> -	ppc_md.panic(ptr);  /* May not return */
> +	if (is_fadump_active()) {
> +		/*
> +		 * If firmware-assisted dump has been registered then trigger
> +		 * firmware-assisted dump and let firmware handle everything
> +		 * else.
> +		 */
> +		crash_fadump(NULL, ptr);

As Mahesh pointed out the check for fadump active is not correct.

> +		ppc_md.panic(ptr);  /* May not return */

But I wonder if this is the real problem?

AFAICS we only have two users of ppc_md.panic(), ps3 and pseries.

At least on ps3 it has nothing to do with fadump, so skipping it like
you've done is not right.

On pseries it uses rtas_os_term() which tells the HV that we "terminated
normal operation", unless you're doing fadump it's supposed to return
and shouldn't stop the regular panic path. Though maybe that's not true
in practice.

It sounds like what we need to do is have a look at the panic flow and
decide whether ppc_md.panic is useful at all, and if so is it called in
the right place.

cheers
