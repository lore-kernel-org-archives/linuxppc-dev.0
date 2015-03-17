Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5EC81A0299
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:23:58 +1100 (AEDT)
In-Reply-To: <1424210434-28070-9-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [8/9] powerpc/hv-24x7: Break up single_24x7_request
Message-Id: <20150317022358.8DE1D14011D@ozlabs.org>
Date: Tue, 17 Mar 2015 13:23:58 +1100 (AEDT)
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

On Tue, 2015-17-02 at 22:00:33 UTC, Sukadev Bhattiprolu wrote:
> Break up the function single_24x7_request() into smaller functions.
> This would later enable us to "prepare" a multi-event request
> buffer and then submit a single hcall for several events.

This looks fine, though the names are a bit laboured.
> 
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 3c36694..fde6211 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1001,6 +1001,44 @@ static void log_24x7_hcall(struct hv_24x7_request_buffer *request_buffer,
>  }
>  
>  /*
> + * Start the process for a new H_GET_24x7_DATA hcall.
> + */
> +static void start_24x7_get_data(struct hv_24x7_request_buffer *request_buffer,
> +			struct hv_24x7_data_result_buffer *result_buffer)
> +{

Just init_24x7_request() ?

> +
> +	memset(request_buffer, 0, 4096);
> +	memset(result_buffer, 0, 4096);
> +
> +	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
> +	/* memset above set request_buffer->num_requests to 0 */
> +}
> +
> +/*
> + * Commit (i.e perform) the H_GET_24x7_DATA hcall using the data collected
> + * by 'start_24x7_get_data()' and 'add_event_to_24x7_request()'.
> + */
> +static int commit_24x7_get_data(struct hv_24x7_request_buffer *request_buffer,
> +			struct hv_24x7_data_result_buffer *result_buffer)
> +{

It don't like "commit" that is a loaded term.

Just make_24x7_request() perhaps?


cheers
