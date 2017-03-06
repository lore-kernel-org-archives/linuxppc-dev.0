Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc2sL3klGzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 12:54:30 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b5so1386260pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 17:54:30 -0800 (PST)
Subject: Re: [PATCH] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170303044718.19253-1-ruscur@russell.cc>
 <2ac7b7d0-c04f-1c33-4661-d2e4f9a0e054@ozlabs.ru>
 <20170305232246.GA14744@gwshan>
Cc: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <12caa751-ed78-d3b9-b5d7-6d18f63f691a@ozlabs.ru>
Date: Mon, 6 Mar 2017 12:54:23 +1100
MIME-Version: 1.0
In-Reply-To: <20170305232246.GA14744@gwshan>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/17 10:22, Gavin Shan wrote:
> On Fri, Mar 03, 2017 at 04:59:11PM +1100, Alexey Kardashevskiy wrote:
>> On 03/03/17 15:47, Russell Currey wrote:
>>> eeh_handle_special_event() is called when an EEH event is detected but
>>> can't be narrowed down to a specific PE.  This function looks through
>>> every PE to find one in an erroneous state, then calls the regular event
>>> handler eeh_handle_normal_event() once it knows which PE has an error.
>>>
>>> However, if eeh_handle_normal_event() found that the PE cannot possibly
>>> be recovered, it will remove the PE and associated devices.  This leads
>>> to a use after free in eeh_handle_special_event() as it attempts to clear
>>> the "recovering" state on the PE after eeh_handle_normal_event() returns.
>>>
>>> Thus, make sure the PE is valid when attempting to clear state in
>>> eeh_handle_special_event().
>>>
>>> Cc: <stable@vger.kernel.org> #3.10+
>>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>>> ---
>>>  arch/powerpc/kernel/eeh_driver.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>>> index b94887165a10..492397298a2a 100644
>>> --- a/arch/powerpc/kernel/eeh_driver.c
>>> +++ b/arch/powerpc/kernel/eeh_driver.c
>>> @@ -983,6 +983,19 @@ static void eeh_handle_special_event(void)
>>>  		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
>>>  		    rc == EEH_NEXT_ERR_FENCED_PHB) {
>>>  			eeh_handle_normal_event(pe);
>>> +
>>> +			/*
>>> +			 * eeh_handle_normal_event() can free the PE if it
>>> +			 * determines that the PE cannot possibly be recovered.
>>> +			 * Make sure the PE still exists before changing its
>>> +			 * state.
>>> +			 */
>>> +			if (!pe || (pe->type & EEH_PE_INVALID)
>>> +			    || (pe->state & EEH_PE_REMOVED)) {
>>
>>
>> The bug is that pe becomes stale after eeh_handle_normal_event() returned
>> and dereferencing it afterwards is broken.
>>
> 
> Correct, it won't cause a kernel crash as @pe is deferencing linear mapped
> area whose address is always valid.

Dereferencing pe would not crash but dereferencing any pointer from the
pnv_ioda_pe struct would (as it would random stuff or a poison).


> I think the proper fix would be to use
> eeh_handle_normal_event() to indicate the @pe has been released and don't
> access it any more.

Correct. The problem is that the callstack from my other reply is a bit too
long to make an trivial patch :)



>>
>>
>>> +				pr_warn("EEH: not clearing state on bad PE\n");
> 
> The message like this isn't meaningful, no need to have it. The messages that
> have prefix "EEH:" is informative messages. We definitely needn't this here.
> However, the message might be not needed in next revision.
> 
>>> +				continue;
>>> +			}
>>> +
>>>  			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>>>  		} else {
>>>  			pci_lock_rescan_remove();
>>>
> 
> Thanks,
> Gavin
> 


-- 
Alexey
