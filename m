Return-Path: <cody@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96BA72C0385
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 11:06:03 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 17:06:01 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AD7941FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 17:05:57 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2605TZK3015062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 01:05:29 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s2609Rs5010161
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 17:09:28 -0700
Message-ID: <5317BBE1.4050001@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 16:05:53 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 02/11] perf: add PMU_FORMAT_RANGE() helper for use
 by sw-like pmus
References: <20140304051936.33A712C01AB@ozlabs.org>
 <53158A2F.8050605@linux.vnet.ibm.com>
In-Reply-To: <53158A2F.8050605@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <peterz@infradead.org>, scottwood@freescale.com,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/04/2014 12:09 AM, Cody P Schafer wrote:
> On 03/03/2014 09:19 PM, Michael Ellerman wrote:
>> On Thu, 2014-27-02 at 21:04:55 UTC, Cody P Schafer wrote:
>>> Add PMU_FORMAT_RANGE() and PMU_FORMAT_RANGE_RESERVED() (for reserved
>>> areas) which generate functions to extract the relevent bits from
>>> event->attr.config{,1,2} for use by sw-like pmus where the
>>> 'config{,1,2}' values don't map directly to hardware registers.
>>>
>>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>>> ---
>>>   include/linux/perf_event.h | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index e56b07f..3da5081 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -871,4 +871,21 @@ _name##_show(struct device
>>> *dev,                    \
>>>                                       \
>>>   static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
>>>
>>> +#define PMU_FORMAT_RANGE(name, attr_var, bit_start, bit_end)        \
>>> +PMU_FORMAT_ATTR(name, #attr_var ":" #bit_start "-" #bit_end);        \
>>> +PMU_FORMAT_RANGE_RESERVED(name, attr_var, bit_start, bit_end)
>>
>> I really think these should have event in the name.
>>
>> Someone looking at the code is going to see event_get_foo() and wonder
>> where
>> that is defined. Grep won't find a definition, tags won't find a
>> definition,
>> the least you can do is have the macro name give some hint.
>>
>
> That is a good point (grep-ability). Let me think about this. There is
> also the possibility that I could adjust the event_get_*() naming to
> something else. format_get_*()? event_get_format_*()? (these names keep
> growing...)
>

I've gone with a format_get(name, event) style macro (making it more 
grep-able), in v4.
Feel free to direct further discussion to the v4 posting.
