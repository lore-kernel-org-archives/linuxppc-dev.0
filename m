Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx85S694tzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 22:49:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Santosh Sivaraj <santosh@fossix.org>, linuxppc-dev@lists.ozlabs.org
Cc: arnd@arndb.de, benh@kernel.crashing.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/smp: Do not BUG_ON if invalid CPU during kick
In-Reply-To: <20170624091640.20935-1-santosh@fossix.org>
References: <20170624091640.20935-1-santosh@fossix.org>
Date: Mon, 26 Jun 2017 22:49:31 +1000
Message-ID: <8760fiewx0.fsf@concordia.ellerman.id.au>
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

Santosh Sivaraj <santosh@fossix.org> writes:

> During secondary start, we do not need to BUG_ON if an invalid CPU number
> is passed. We alreay print an error if secondary cannot be started, so
                    ^
                    d
> just return an error instead.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  arch/powerpc/kernel/smp.c            | 3 ++-
>  arch/powerpc/platforms/cell/smp.c    | 3 ++-
>  arch/powerpc/platforms/powernv/smp.c | 3 ++-
>  arch/powerpc/platforms/pseries/smp.c | 3 ++-

This looks good to me ...

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index df2a416..05bf583 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -112,7 +112,8 @@ int smp_generic_cpu_bootable(unsigned int nr)
>  #ifdef CONFIG_PPC64
>  int smp_generic_kick_cpu(int nr)
>  {
> -	BUG_ON(nr < 0 || nr >= NR_CPUS);
> +	if (nr < 0 || nr >= NR_CPUS)
> +		return -EINVAL;

Except that these checks should all use nr_cpu_ids AFAICS.

I think they were just written before nr_cpu_ids existed.

Can you send me an incremental patch to switch them to nr_cpu_ids?

cheers
