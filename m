Return-Path: <michael@ozlabs.org>
In-Reply-To: <1392415338-16288-2-git-send-email-cody@linux.vnet.ibm.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 01/11] perf: add PMU_RANGE_ATTR() helper for use by
 sw-like pmus
Message-Id: <20140225033326.135BB2C0227@ozlabs.org>
Date: Tue, 25 Feb 2014 14:33:26 +1100 (EST)
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-14-02 at 22:02:05 UTC, Cody P Schafer wrote:
> Add PMU_RANGE_ATTR() and PMU_RANGE_RESV() (for reserved areas) which
> generate functions to extract the relevent bits from
> event->attr.config{,1,2} for use by sw-like pmus where the
> 'config{,1,2}' values don't map directly to hardware registers.
> 
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  include/linux/perf_event.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e56b07f..2702e91 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -871,4 +871,21 @@ _name##_show(struct device *dev,					\
>  									\
>  static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
>  
> +#define PMU_RANGE_ATTR(name, attr_var, bit_start, bit_end)		\
> +PMU_FORMAT_ATTR(name, #attr_var ":" #bit_start "-" #bit_end);		\
> +PMU_RANGE_RESV(name, attr_var, bit_start, bit_end)
> +
> +#define PMU_RANGE_RESV(name, attr_var, bit_start, bit_end)		\
> +static u64 event_get_##name##_max(void)					\
> +{									\
> +	int bits = (bit_end) - (bit_start) + 1;				\
> +	return ((0x1ULL << (bits - 1ULL)) - 1ULL) |			\
> +		(0xFULL << (bits - 4ULL));				\
> +}									\
> +static u64 event_get_##name(struct perf_event *event)			\
> +{									\
> +	return (event->attr.attr_var >> (bit_start)) &			\
> +		event_get_##name##_max();				\
> +}

I still don't like the names.

EVENT_GETTER_AND_FORMAT()
EVENT_RESERVED()

?

It's not clear to me the max routine is useful in general. Can't we just do:

> +#define EVENT_RESERVED(name, attr_var, bit_start, bit_end)		\
> +static u64 event_get_##name(struct perf_event *event)		\
> +{									\
> +	return (event->attr.attr_var >> (bit_start)) &			\
> +		((0x1ULL << ((bit_end) - (bit_start) + 1)) - 1ULL);	\
> +}


cheers
