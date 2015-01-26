Return-Path: <brking@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 328AA1A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 10:36:25 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 26 Jan 2015 16:36:23 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 531C63E40041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 16:36:22 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0QNaT0p21430450
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 16:36:29 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0QNaLqd027089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 16:36:22 -0700
Message-ID: <54C6CF73.7000403@linux.vnet.ibm.com>
Date: Mon, 26 Jan 2015 17:36:19 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if
 required
References: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1421746096.4949.40.camel@kernel.crashing.org>
 <20150120225607.GA12174@shangw> <20150120235338.GA5280@shangw>
 <20150123035029.GA19657@shangw>
 <1422093450.4949.89.camel@kernel.crashing.org>
In-Reply-To: <1422093450.4949.89.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: wenxiong@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/24/2015 03:57 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2015-01-23 at 14:50 +1100, Gavin Shan wrote:
> 
>> Messages from Brian for reference:
>>
>> | The API has changed. I wrote the pci_set_pcie_reset_state API originally.
>> | When this API was put in place initially, it was perfectly legal to call it
>> | from an atomic context. Can you clarify why we have to have the delay in the
>> | pci_set_pcie_reset_state function? Shouldn't it be the responsibility of the
>> | callers to ensure a proper delay is used? This was always the case until
>> | recently.
>>
>> So please ignore this patch and I'll send another one, which is implemented in
>> above approach.
> 
> I still think it's not a great idea to allow that API to be called in
> atomic context.

That was the entire purpose of the API though. If a driver doesn't need to
do the reset in atomic context, why bother having separate assert / deassert
APIs and just have an API that does the reset, delay, and deassert?


> Brian, the reset API for PCIe involves FW calls which might have to do
> a bunch of stuff under the hood, including potentially significant
> delays.
> 
> For example, under OPAL (and I suppose PowerVM), if doing a PERST, the
> API calls will loop until the link is back up, at least when "releasing"
> the reset line.

Under PowerVM, this maps to the ibm,set-slot-reset. According to PAPR+ V2.7,
R1-7.2.4-5:

For RTAS calls which do not allow the Status of -2 (Busy), there may be “rare” instances where an
anomaly may occur and the call may take longer than a “very short period of time.” In these cases, the call
must complete within 250 microseconds. Otherwise, a hardware error response must be given.


> I wouldn't be surprised if on x86, similar kinds of ACPI calls are
> needed which may not be the best thing to do in atomic context.

x86 hasn't wired up the function yet, so we don't have any code
to look at here. In fact, Power is the only architecture that has
wired up this API at all, all other architectures will return -EINVAL
if it is called.


> I don't see any specific performance issues with issuing resets, so I
> would strongly advocate for changing the API requirements instead so
> that it's called from a task context.

To set some context, this function is only used by ipr for some old
broken adapters. These are adapters that are not supported on p8,
so will never show up under OPAL, only PowerVM. I'm fine with looking
at alternatives for the future, but I can't say I'm too excited about
changing the calling requirements for an API that has been around
for many years. Particularly given that this code is only needed for
these old adapters. If its difficult to implement this for OPAL without
noticeable delays, could we just return -EINVAL for this function on OPAL?,
since its not needed there today anyway.

Thanks,

Brian

> 
> Cheers,
> Ben.
> 
> 
> 
>> Thanks,
>> Gavin
>>
>>>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>>> Tested-by: Wen Xiong<wenxiong@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 12 ++++++++----
>>>>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>>>> index a6c7e19..67623a3 100644
>>>>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>>>> @@ -503,8 +503,7 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
>>>>>>   */
>>>>>>  static int pseries_eeh_reset(struct eeh_pe *pe, int option)
>>>>>>  {
>>>>>> -	int config_addr;
>>>>>> -	int ret;
>>>>>> +	int config_addr, delay, ret;
>>>>>>  
>>>>>>  	/* Figure out PE address */
>>>>>>  	config_addr = pe->config_addr;
>>>>>> @@ -528,9 +527,14 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
>>>>>>  	/* We need reset hold or settlement delay */
>>>>>>  	if (option == EEH_RESET_FUNDAMENTAL ||
>>>>>>  	    option == EEH_RESET_HOT)
>>>>>> -		msleep(EEH_PE_RST_HOLD_TIME);
>>>>>> +		delay = EEH_PE_RST_HOLD_TIME;
>>>>>> +	else
>>>>>> +		delay = EEH_PE_RST_SETTLE_TIME;
>>>>>> +
>>>>>> +	if (in_atomic())
>>>>>> +		udelay(delay * 1000);
>>>>>>  	else
>>>>>> -		msleep(EEH_PE_RST_SETTLE_TIME);
>>>>>> +		msleep(delay);
>>>>>>  
>>>>>>  	return ret;
>>>>>>  }
>>>>>
>>>>>
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
