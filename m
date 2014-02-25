Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6FF5A2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 07:34:11 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 13:34:09 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7552B19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 13:34:05 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PKY7OI786768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 21:34:07 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1PKbX54014547
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 13:37:34 -0700
Message-ID: <530CFE30.70803@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 12:33:52 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2 01/11] perf: add PMU_RANGE_ATTR() helper for use by
 sw-like pmus
References: <20140225033326.135BB2C0227@ozlabs.org>
In-Reply-To: <20140225033326.135BB2C0227@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2014 07:33 PM, Michael Ellerman wrote:
> On Fri, 2014-14-02 at 22:02:05 UTC, Cody P Schafer wrote:
>> Add PMU_RANGE_ATTR() and PMU_RANGE_RESV() (for reserved areas) which
>> generate functions to extract the relevent bits from
>> event->attr.config{,1,2} for use by sw-like pmus where the
>> 'config{,1,2}' values don't map directly to hardware registers.
>>
>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>> ---
>>   include/linux/perf_event.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index e56b07f..2702e91 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -871,4 +871,21 @@ _name##_show(struct device *dev,					\
>>   									\
>>   static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
>>
>> +#define PMU_RANGE_ATTR(name, attr_var, bit_start, bit_end)		\
>> +PMU_FORMAT_ATTR(name, #attr_var ":" #bit_start "-" #bit_end);		\
>> +PMU_RANGE_RESV(name, attr_var, bit_start, bit_end)
>> +
>> +#define PMU_RANGE_RESV(name, attr_var, bit_start, bit_end)		\
>> +static u64 event_get_##name##_max(void)					\
>> +{									\
>> +	int bits = (bit_end) - (bit_start) + 1;				\
>> +	return ((0x1ULL << (bits - 1ULL)) - 1ULL) |			\
>> +		(0xFULL << (bits - 4ULL));				\
>> +}									\
>> +static u64 event_get_##name(struct perf_event *event)			\
>> +{									\
>> +	return (event->attr.attr_var >> (bit_start)) &			\
>> +		event_get_##name##_max();				\
>> +}
>
> I still don't like the names.
>
> EVENT_GETTER_AND_FORMAT()

EVENT_RANGE()

I'd prefer to describe the intended usage rather than what is generated 
both in case we change some of the specifics later, and to provide 
additional information to the developers beyond what a simple code 
reading gives.

> EVENT_RESERVED()

Sure. The PMU_* naming was just based on the PMU_FORMAT_ATTR() naming, 
so I kept it for continuity with the existing API. Maybe 
EVENT_RANGE_RESERVED() would be more appropriate?

> ?
>
> It's not clear to me the max routine is useful in general. Can't we just do:
>
>> +#define EVENT_RESERVED(name, attr_var, bit_start, bit_end)		\
>> +static u64 event_get_##name(struct perf_event *event)		\
>> +{									\
>> +	return (event->attr.attr_var >> (bit_start)) &			\
>> +		((0x1ULL << ((bit_end) - (bit_start) + 1)) - 1ULL);	\
>> +}

I use event_get_*_max() for some checking of parameters in event_init(). 
Having it lets me avoid specifying the maximum explicitly (0x7ffff = 
0-19, for example). Specifying it explicitly would mean we'd have the 
bit width of the field in question encoded in two places instead of one, 
and I'd prefer to avoid unneeded duplication.
