Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8E081A02D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 20:45:18 +1100 (AEDT)
In-Reply-To: <20160209030830.GA4815@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/perf/hv-gpci: Increase request buffer size
Message-Id: <20160209094518.B91C7140B9A@ozlabs.org>
Date: Tue,  9 Feb 2016 20:45:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 03:08:30 UTC, Sukadev Bhattiprolu wrote:
> >From 31edd352fb7c2a72913f1977fa1bf168109089ad Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 9 Feb 2016 02:47:45 -0500
> Subject: [PATCH] powerpc/perf/hv-gpci: Increase request buffer size
> 
> The GPCI hcall allows for a 4K buffer but we limit the buffer
> to 1K. The problem with a 1K buffer is if a request results in
> returning more values than can be accomodated in the 1K buffer
> the request will fail.
> 
> The buffer we are using is currently allocated on the stack and
> hence limited in size. Instead use a per-CPU 4K buffer like we do
> with 24x7 counters (hv-24x7.c).
> 
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 856fe6e..e6fad73 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -127,8 +127,16 @@ static const struct attribute_group *attr_groups[] = {
>  	NULL,
>  };
>  
> +#define HGPCI_REQ_BUFFER_SIZE	4096
>  #define GPCI_MAX_DATA_BYTES \
> -	(1024 - sizeof(struct hv_get_perf_counter_info_params))
> +	(HGPCI_REQ_BUFFER_SIZE - sizeof(struct hv_get_perf_counter_info_params))
> +
> +DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
> +
> +struct hv_gpci_request_buffer {
> +	struct hv_get_perf_counter_info_params params;
> +	uint8_t bytes[1];

bytes is 1 byte long, but ..

> @@ -163,9 +168,11 @@ static unsigned long single_gpci_request(u32 req, u32 starting_index,
>  	 */
>  	count = 0;
>  	for (i = offset; i < offset + length; i++)
> -		count |= arg.bytes[i] << (i - offset);
> +		count |= arg->bytes[i] << (i - offset);


Here you read from bytes[i] where i can be > 1 (AFAICS).

That's fishy at best, and newer GCCs just don't allow it.

I think you could do this and it would work, but untested:

   struct hv_gpci_request_buffer {
   	struct hv_get_perf_counter_info_params params;
   	uint8_t bytes[4096 - sizeof(struct hv_get_perf_counter_info_parms)];
   };

cheers
