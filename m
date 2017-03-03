Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZJZF3RBBzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 17:05:25 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 25so11649859pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 22:05:25 -0800 (PST)
Subject: Re: [PATCH] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
References: <20170303044718.19253-1-ruscur@russell.cc>
 <20170303055557.GA32465@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b522ad3a-c88e-4bfd-7602-486beea24721@ozlabs.ru>
Date: Fri, 3 Mar 2017 17:05:19 +1100
MIME-Version: 1.0
In-Reply-To: <20170303055557.GA32465@gwshan>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/17 16:55, Gavin Shan wrote:
> On Fri, Mar 03, 2017 at 03:47:18PM +1100, Russell Currey wrote:
>> eeh_handle_special_event() is called when an EEH event is detected but
>> can't be narrowed down to a specific PE.  This function looks through
>> every PE to find one in an erroneous state, then calls the regular event
>> handler eeh_handle_normal_event() once it knows which PE has an error.
>>
>> However, if eeh_handle_normal_event() found that the PE cannot possibly
>> be recovered, it will remove the PE and associated devices.  This leads
>> to a use after free in eeh_handle_special_event() as it attempts to clear
>> the "recovering" state on the PE after eeh_handle_normal_event() returns.
>>
>> Thus, make sure the PE is valid when attempting to clear state in
>> eeh_handle_special_event().
>>
> 
> From the changelog, I don't see how the PE is free'd. Could you explain
> a bit about it?


This is a backtrace when kfree(pe) is done:

dump_stack+0xb0/0xf0 (unreliable)
eeh_rmv_from_parent_pe+0x2f8/0x330
eeh_remove_device+0x128/0x170
pcibios_release_device+0x2c/0x70
pci_release_dev+0x5c/0xb0
device_release+0x58/0xf0
kobject_put+0x144/0x2e0
put_device+0x24/0x40
pci_remove_bus_device+0x14c/0x190
pci_hp_remove_devices+0xac/0x170
eeh_handle_normal_event+0x120/0x560
eeh_handle_special_event+0x328/0x3b0
eeh_handle_event+0x74/0xa0
eeh_event_handler+0x260/0x280
kthread+0x14c/0x190
ret_from_kernel_thread+0x5c/0x74


> 
>> Cc: <stable@vger.kernel.org> #3.10+
>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> ---
>> arch/powerpc/kernel/eeh_driver.c | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> index b94887165a10..492397298a2a 100644
>> --- a/arch/powerpc/kernel/eeh_driver.c
>> +++ b/arch/powerpc/kernel/eeh_driver.c
>> @@ -983,6 +983,19 @@ static void eeh_handle_special_event(void)
>> 		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
>> 		    rc == EEH_NEXT_ERR_FENCED_PHB) {
>> 			eeh_handle_normal_event(pe);
>> +
>> +			/*
>> +			 * eeh_handle_normal_event() can free the PE if it
>> +			 * determines that the PE cannot possibly be recovered.
>> +			 * Make sure the PE still exists before changing its
>> +			 * state.
>> +			 */
>> +			if (!pe || (pe->type & EEH_PE_INVALID)
>> +			    || (pe->state & EEH_PE_REMOVED)) {
>> +				pr_warn("EEH: not clearing state on bad PE\n");
>> +				continue;
>> +			}
>> +
> 
> It seems not correct. @pe has set to the valid PE in advance, the !pe is
> always false? If the PE has been free'd, how can we access @pe->type here
> and how can we make sure PE_INVALID and PE_REMOVED flag wasn't overwritten
> by somebody else?
> 
>> 			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>> 		} else {
>> 			pci_lock_rescan_remove();
> 
> Cheers,
> Gavin
> 


-- 
Alexey
