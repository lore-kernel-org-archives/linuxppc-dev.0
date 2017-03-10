Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfkR95NRqzDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 21:44:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/2] powerpc/fadump: reserve memory at halfway mark
In-Reply-To: <148907087368.3574.8071537539290192784.stgit@hbathini.in.ibm.com>
References: <148907087368.3574.8071537539290192784.stgit@hbathini.in.ibm.com>
Date: Fri, 10 Mar 2017 21:44:33 +1100
Message-ID: <87zigtjtri.fsf@concordia.ellerman.id.au>
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

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> Currently, the area to preserve boot memory is reserved at the top of
> RAM. This leaves fadump vulnerable to DLPAR memory remove operations.
> As memory for fadump needs to be reserved early in the boot process,
> fadump can't be registered after a DLPAR memory remove operation.
> While this problem can't be eleminated completely, the impact can be
> minimized by reserving memory at the halfway mark instead. With this
> change, fadump can register successfully after a DLPAR memory remove
> operation as long as the sum of the sizes of boot memory and memory
> removed is less than half of the total available memory.
>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/fadump.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 8ff0dd4..9c85c5a 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -319,9 +319,13 @@ int __init fadump_reserve_mem(void)
>  		pr_debug("fadumphdr_addr = %p\n",
>  				(void *) fw_dump.fadumphdr_addr);
>  	} else {
> -		/* Reserve the memory at the top of memory. */
> +		/*
> +		 * Reserve memory at the halfway mark to minimize
> +		 * the impact of DLPAR memory remove operation.
> +		 */
> +		base = PAGE_ALIGN(memory_boundary/2);

This doesn't account for holes, do we never have holes in the memory
layout on phyp?

cheers
