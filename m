Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVpvb5yYmzDrKc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:39:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: powerpc/perf: Fix a sizeof() typo so we allocate less memory
In-Reply-To: <20171104075136.nujqcprikcevsfwv@mwanda>
References: <20171104075136.nujqcprikcevsfwv@mwanda>
Date: Mon, 06 Nov 2017 21:39:07 +1100
Message-ID: <87a7zzbsj8.fsf@concordia.ellerman.id.au>
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

Dan Carpenter <dan.carpenter@oracle.com> writes:

> We're allocating the size of the struct which is 32 bytes when we should
> be allocating sizeof(void *) which is 4 or 8 bytes depending on the
> architecture.
>
> Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks.

I think your patch is right, but the code would be much simpler if we
actually did just allocate an array of struct imc_events, rather than an
array of pointers to structs.

Some of the cleanup code is written as if that is already the case, ie.
it frees the pmu->events array, but not the things the array points to.
So there's a memory leak there too.

Anju, Maddy, can one of you rework the code to just use an array of
structs? Basically imc_parse_event() wouldn't allocate a struct, we
would pass it a pointer to a slot in the array.

cheers

> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 88126245881b..91c90ddab807 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -210,7 +210,7 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
>  	of_property_read_u32(node, "reg", &base_reg);
>  
>  	/* Allocate memory for the events */
> -	pmu->events = kcalloc(ct, sizeof(struct imc_events), GFP_KERNEL);
> +	pmu->events = kcalloc(ct, sizeof(*pmu->events), GFP_KERNEL);
>  	if (!pmu->events)
>  		return -ENOMEM;
>  
