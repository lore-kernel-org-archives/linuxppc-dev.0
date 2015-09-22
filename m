Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 395E51A0419
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 15:29:04 +1000 (AEST)
Message-ID: <1442899743.18408.5.camel@ellerman.id.au>
Subject: Re: [PATCH V2  2/2] powerpc:numa Do not allocate bootmem memory for
 non existing nodes
From: Michael Ellerman <mpe@ellerman.id.au>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 akpm@linux-foundation.org, nacc@linux.vnet.ibm.com,
 gkurz@linux.vnet.ibm.com,  grant.likely@linaro.org,
 nikunj@linux.vnet.ibm.com, vdavydov@parallels.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Date: Tue, 22 Sep 2015 15:29:03 +1000
In-Reply-To: <1442282917-16893-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1442282917-16893-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1442282917-16893-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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

On Tue, 2015-09-15 at 07:38 +0530, Raghavendra K T wrote:
>
> ... nothing

Sure this patch looks obvious, but please give me a changelog that proves
you've thought about it thoroughly.

For example is it OK to use for_each_node() at this point in boot? Is there any
historical reason why we did it with a hard coded loop? If so what has changed.
What systems have you tested on? etc. etc.

cheers

> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 8b9502a..8d8a541 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -80,7 +80,7 @@ static void __init setup_node_to_cpumask_map(void)
>  		setup_nr_node_ids();
>  
>  	/* allocate the map */
> -	for (node = 0; node < nr_node_ids; node++)
> +	for_each_node(node)
>  		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
>  
>  	/* cpumask_of_node() will now work */
