Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2B7E1A0150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jul 2014 23:35:27 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Mon, 14 Jul 2014 23:35:23 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9B5F02CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jul 2014 23:35:21 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6EDCd2P51839172
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jul 2014 23:12:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6EDZKQQ018063
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jul 2014 23:35:20 +1000
Message-ID: <53C3DC96.70505@linux.vnet.ibm.com>
Date: Mon, 14 Jul 2014 21:35:18 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] Bugfix: powerpc/eeh: Wrong place to call pci_get_slot()
References: <1405325963-1664-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20140714130149.GA4752@shangw>
In-Reply-To: <20140714130149.GA4752@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/14/2014 09:01 PM, Gavin Shan wrote:
> On Mon, Jul 14, 2014 at 04:19:23AM -0400, Mike Qiu wrote:
>> [  121.133381] WARNING: at drivers/pci/search.c:223
>> [  121.133422] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.16.0-rc3+ #72
>> [  121.133424] task: c000000001367af0 ti: c000000001444000 task.ti: c000000001444000
>> [  121.133425] NIP: c000000000497b70 LR: c000000000037530 CTR: 000000003003d114
>> [  121.133427] REGS: c000000001446fa0 TRAP: 0700   Not tainted  (3.16.0-rc3+)
>> [  121.133428] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 48002422  XER: 20000000
>> [  121.133433] CFAR: c00000000003752c SOFTE: 0
>> GPR00: c000000000037530 c000000001447220 c000000001448c30 c0000003bca1dc00
>> GPR04: 0000000000000000 c000000000066064 9000000000009032 0000000000000008
>> GPR08: 0000000000000007 0000000000000001 0000000000000100 000000003003d200
>> GPR12: 0000000044002482 c00000000fee0000 0000000000000000 c0000000015e8830
>> GPR16: c0000000015e8c30 0000000000000000 c0000000015e8430 c0000000015e8030
>> GPR20: c000000001348c30 c000000001482180 0000000000000000 0000000000000000
>> GPR24: 0000000000200200 c0000003bc243500 c0000003feff4070 c0000003bcec3000
>> GPR28: c0000000014cac00 c0000003bca1dc00 0000000000000000 0000000000000000
>> [  121.133454] NIP [c000000000497b70] .pci_get_slot+0x40/0x110
>> [  121.133457] LR [c000000000037530] .eeh_pe_loc_get+0x150/0x190
>> [  121.133458] Call Trace:
>> [  121.133461] [c000000001447220] [c000000000721730] .of_get_property+0x30/0x60 (unreliable)
>> [  121.133464] [c0000000014472b0] [c000000000037530] .eeh_pe_loc_get+0x150/0x190
>> [  121.133466] [c000000001447340] [c000000000034684] .eeh_dev_check_failure+0x1b4/0x550
>> [  121.133468] [c0000000014473f0] [c000000000034ab0] .eeh_check_failure+0x90/0xf0
>> [  121.133493] [c000000001447490] [d000000002c03e84] .lpfc_sli_check_eratt+0x504/0x7c0 [lpfc]
>> [  121.133501] [c000000001447520] [d000000002c041a4] .lpfc_poll_eratt+0x64/0x100 [lpfc]
>> [  121.133504] [c0000000014475a0] [c0000000000b45b4] .call_timer_fn+0x64/0x190
>> [  121.133506] [c000000001447650] [c0000000000b4d1c] .run_timer_softirq+0x2cc/0x3e0
>> [  121.133508] [c000000001447760] [c0000000000a90c8] .__do_softirq+0x198/0x3c0
>> [  121.133510] [c000000001447880] [c0000000000a9658] .irq_exit+0xc8/0x110
>> [  121.133513] [c000000001447900] [c00000000001e010] .timer_interrupt+0xa0/0xe0
>> [  121.133515] [c000000001447980] [c0000000000026d8] decrementer_common+0x158/0x180
>> [  121.133518] --- Exception: 901 at .arch_local_irq_restore+0x74/0x90
>>
>> pci_get_slot() should not be used in interrupt. But eeh subsystem do
>> the error checking in interrupt in this situation.
>>
>> This patch is to solve this issue.
>>
> The commit log has been clear enough, but the following message might
> be better. I'm not good at writing good commit log as well:
>
> ---
>
> pci_get_slot() is called with hold of PCI bus semaphore and it's not
> safe to be called in interrupt context. However, we possibly checks
> EEH error and calls the function in interrupt context. To avoid using
> pci_get_slot(), we turn into device tree for fetching location code.
> Otherwise, we might run into WARN_ON() as following messages indicate:
>
>   WARNING: at drivers/pci/search.c:223
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.16.0-rc3+ #72
>   task: c000000001367af0 ti: c000000001444000 task.ti: c000000001444000
>   NIP: c000000000497b70 LR: c000000000037530 CTR: 000000003003d114
>   REGS: c000000001446fa0 TRAP: 0700   Not tainted  (3.16.0-rc3+)
>   MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 48002422  XER: 20000000
>   CFAR: c00000000003752c SOFTE: 0
>     :
>   NIP [c000000000497b70] .pci_get_slot+0x40/0x110
>   LR [c000000000037530] .eeh_pe_loc_get+0x150/0x190
>   Call Trace:
>     .of_get_property+0x30/0x60 (unreliable)
>     .eeh_pe_loc_get+0x150/0x190
>     .eeh_dev_check_failure+0x1b4/0x550
>     .eeh_check_failure+0x90/0xf0
>     .lpfc_sli_check_eratt+0x504/0x7c0 [lpfc]
>     .lpfc_poll_eratt+0x64/0x100 [lpfc]
>     .call_timer_fn+0x64/0x190
>     .run_timer_softirq+0x2cc/0x3e0
>

Yes, it's better enough.
>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>> ---
>> arch/powerpc/kernel/eeh_pe.c | 29 ++++++++++++++++++++++++++---
>> 1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>> index fbd01eb..6f4bfee 100644
>> --- a/arch/powerpc/kernel/eeh_pe.c
>> +++ b/arch/powerpc/kernel/eeh_pe.c
>> @@ -792,6 +792,28 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
>> }
>>
>> /**
>> + * __dn_get_pdev - Retrieve the pci_dev from device_node by bus/devfn
>> + * @dn: device_node of the pci_dev
>> + * @data: the pci device's bus/devfn
>> + *
>> + * Retrieve the pci_dev using the given device_node and bus/devfn.
>> + */
>> +void *__dn_get_pdev(struct device_node *dn, void *data)
>> +{
> The function isn't necessarily public. "static" is enough, I think.
> I don't think we need this actually. Please refer to more comments
> below.
>
>> +	struct pci_dn *pdn = PCI_DN(dn);
>> +	int busno = *((int *)data) >> 8;
>> +	int devfn = *((int *)data) & 0xff;
>> +
>> +	if (!pdn)
>> +		return NULL;
>> +
>> +	if (pdn->busno == busno && pdn->devfn == devfn)
>> +		return pdn->pcidev;
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>>   * eeh_pe_loc_get - Retrieve location code binding to the given PE
>>   * @pe: EEH PE
>>   *
>> @@ -807,6 +829,7 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
>> 	struct pci_dev *pdev;
>> 	struct device_node *dn;
>> 	const char *loc;
>> +	int bdevfn;
>>
>> 	if (!bus)
>> 		return "N/A";
>> @@ -823,7 +846,9 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
>> 		if (loc)
>> 			return loc;
>>
>> -		pdev = pci_get_slot(bus, 0x0);
>> +		/* Get the root port */
>> +		bdevfn = (bus->number) << 8 || 0x0;
>> +		pdev = traverse_pci_devices(hose->dn, __dn_get_pdev, &bdevfn);
> We needn't search pdev from device-tree and then translate it to
> device-node. Root port is the only child hooked to root bus's
> device node (it's also PHB's device-node). So I guess you can

So here you mean, child hooked device node(root port) can be 
hose->dn->child?

> just have something:
>
> 		/* Check PHB's device node */
> 		dn = pci_bus_to_OF_node(bus);
> 		if (unlikely(!dn)) {
> 			loc = "N/A";
> 			goto out;
> 		}
> 		loc = of_get_property(hose->dn,
>   				      "ibm,loc-code", NULL);
> 		if (loc)
> 			return loc;
> 		loc = of_get_property(hose->dn,
> 				      "ibm,io-base-loc-code", NULL);
> 		if (loc)
> 			return loc;
>
> 		/* Check root port */
> 		dn = dn->child;
>> 	} else {
>> 		pdev = bus->self;
> Here, we needn't grab the bridge as well:
>
> 		dn = pci_bus_to_OF_node(bus);
>> 	}
> Then check the device-node of bridge (or root port):
>
> 	if (unlikely(!dn)) {
> 		loc = "N/A";
> 		goto out;
> 	}
>
>          loc = of_get_property(dn, "ibm,loc-code", NULL);
>          if (!loc)
>                  loc = of_get_property(dn, "ibm,slot-location-code", NULL);
>          if (!loc)
>                  loc = "N/A";
>
>> @@ -846,8 +871,6 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
>> 		loc = "N/A";
>>
>> out:
>> -	if (pci_is_root_bus(bus) && pdev)
>> -		pci_dev_put(pdev);
>> 	return loc;
>> }

I will make a new patch, after tested, I will resend it out

Thanks
Mike
> Thanks,
> Gavin
>
