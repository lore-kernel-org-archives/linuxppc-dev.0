Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8555B1A09AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:16:02 +1100 (AEDT)
In-Reply-To: <1424210434-28070-4-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/9] powerpc/hv-24x7: Drop event_24x7_request()
Message-Id: <20150317021602.6BCFE14010F@ozlabs.org>
Date: Tue, 17 Mar 2015 13:16:02 +1100 (AEDT)
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-17-02 at 22:00:28 UTC, Sukadev Bhattiprolu wrote:
> The function event_24x7_request() is essentially a wrapper to the
> function single_24x7_request() and can be dropped to simplify code.
> 
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 7856e38..c189e75 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1004,17 +1004,22 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
>  	memset(request_buffer, 0, 4096);
>  	memset(result_buffer, 0, 4096);
>  
> +	if (is_physical_domain(event_get_domain(event)))
> +		idx = event_get_core(event);
> +	else
> +		idx = event_get_vcpu(event);
> +
>  	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
>  	request_buffer->num_requests = 1;
>  
>  	req = &request_buffer->requests[0];
>  
> -	req->performance_domain = domain;
> +	req->performance_domain = event_get_domain(event);
>  	req->data_size = cpu_to_be16(8);
> -	req->data_offset = cpu_to_be32(offset);
> -	req->starting_lpar_ix = cpu_to_be16(lpar),
> +	req->data_offset = cpu_to_be32(event_get_offset(event));
> +	req->starting_lpar_ix = cpu_to_be16(event_get_lpar(event)),
>  	req->max_num_lpars = cpu_to_be16(1);
> -	req->starting_ix = cpu_to_be16(ix);
> +	req->starting_ix = cpu_to_be16(idx);
>  	req->max_ix = cpu_to_be16(1);
>  
>  	/*
> @@ -1029,7 +1034,9 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
>  	if (ret) {
>  		pr_notice_ratelimited("hcall failed: %d %#x %#x %d => "
>  				"0x%lx (%ld) detail=0x%x failing ix=%x\n",
> -				domain, offset, ix, lpar, ret, ret,
> +				(int)event_get_domain(event),
> +				(unsigned int)event_get_offset(event),
> +				idx, (int)event_get_lpar(event), ret, ret,

It seems more natural here to print the req->performance_domain etc. rather
then re-extracting them from the event?

cheers
