Return-Path: <cody@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC1DE2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 08:25:54 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 14:25:52 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8E2A41FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 14:25:50 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PJN9Kv11076036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 20:23:09 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1PLTGEN005044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 14:29:17 -0700
Message-ID: <530D0A4E.8030706@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 13:25:34 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 08/11] powerpc/perf: add support for the hv gpci (get
 performance counter info) interface
References: <20140225033329.400E22C0331@ozlabs.org>
In-Reply-To: <20140225033329.400E22C0331@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2014 07:33 PM, Michael Ellerman wrote:
> On Fri, 2014-14-02 at 22:02:12 UTC, Cody P Schafer wrote:
>> This provides a basic link between perf and hv_gpci. Notably, it does
>> not yet support transactions and does not list any events (they can
>> still be manually composed).
>
> Can you explain how the HV_CAPS stuff ends up looking.
>
> I'm not against adding it, but I'd like to understand how we expect it to be
> used a bit better.

It's just a quick mechanism for me to expose some relevant information 
to userspace via sysfs using the hv_perf_caps_get() function's returned 
data. Documentation for this sysfs interface (and the rest) is in a 
later patch.
I don't expect any more uses to show up unless the firmware decides to 
add another capability bit (in which case I'll want to expose it as well).

>> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
>> new file mode 100644
>> index 0000000..1f5d96d
>> --- /dev/null
>> +++ b/arch/powerpc/perf/hv-gpci.c
>> +
>> +static struct pmu h_gpci_pmu = {
>> +	.task_ctx_nr = perf_invalid_context,
>> +
>> +	.name = "hv_gpci",
>> +	.attr_groups = attr_groups,
>> +	.event_init  = h_gpci_event_init,
>> +	.add         = h_gpci_event_add,
>> +	.del         = h_gpci_event_del,
> 		     = h_gpci_event_stop,
>
>> +	.start       = h_gpci_event_start,
>> +	.stop        = h_gpci_event_stop,
>> +	.read        = h_gpci_event_read,
> 		     = h_gpci_event_update
>
>> +	.event_idx = perf_swevent_event_idx,
>> +};

whoops, thought I had fixed those 2 already.
