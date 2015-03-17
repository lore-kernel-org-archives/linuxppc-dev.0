Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA2501A09AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:18:07 +1100 (AEDT)
In-Reply-To: <1424210434-28070-7-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [6/9] powerpc/hv-24x7: Define add_event_to_24x7_request()
Message-Id: <20150317021807.A73A314011D@ozlabs.org>
Date: Tue, 17 Mar 2015 13:18:07 +1100 (AEDT)
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

On Tue, 2015-17-02 at 22:00:31 UTC, Sukadev Bhattiprolu wrote:
> Move code that maps a perf_event to a 24x7 request buffer into a
> separate function, add_event_to_24x7_request().
> 
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index e78b127..76c649a 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1052,7 +1077,6 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
>  	}
>  
>  	resb = &result_buffer->results[0];
> -
>  	*count = be64_to_cpu(resb->elements[0].element_data[0]);
>  out:
>  	return ret;
> @@ -1150,6 +1174,7 @@ static void h_24x7_event_read(struct perf_event *event)
>  {
>  	s64 prev;
>  	u64 now;
> +
>  	now = h_24x7_get_value(event);
>  	prev = local64_xchg(&event->hw.prev_count, now);
>  	local64_add(now - prev, &event->count);

I'm a fan of whitespace for readability in cases like this, but do it as a
separate patch.

cheers
