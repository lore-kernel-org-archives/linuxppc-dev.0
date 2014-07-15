Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B07D91A0150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 15:16:06 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 15 Jul 2014 10:46:04 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 65E16125804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 10:45:47 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F5GKVO11076060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 10:46:20 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F5Fxwo025218
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 10:46:00 +0530
Message-ID: <53C4B90E.7060807@linux.vnet.ibm.com>
Date: Tue, 15 Jul 2014 13:15:58 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] Bugfix: powerpc/eeh: Wrong place to call pci_get_slot()
References: <1405391628-1680-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20140715050707.GA17089@shangw>
In-Reply-To: <20140715050707.GA17089@shangw>
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

On 07/15/2014 01:07 PM, Gavin Shan wrote:
> On Mon, Jul 14, 2014 at 10:33:48PM -0400, Mike Qiu wrote:
>> pci_get_slot() is called with hold of PCI bus semaphore and it's not
>> safe to be called in interrupt context. However, we possibly checks
>> EEH error and calls the function in interrupt context. To avoid using
>> pci_get_slot(), we turn into device tree for fetching location code.
>> Otherwise, we might run into WARN_ON() as following messages indicate:
>>
>> WARNING: at drivers/pci/search.c:223
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.16.0-rc3+ #72
>> task: c000000001367af0 ti: c000000001444000 task.ti: c000000001444000
>> NIP: c000000000497b70 LR: c000000000037530 CTR: 000000003003d114
>> REGS: c000000001446fa0 TRAP: 0700   Not tainted  (3.16.0-rc3+)
>> MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 48002422  XER: 20000000
>> CFAR: c00000000003752c SOFTE: 0
>>    :
>> NIP [c000000000497b70] .pci_get_slot+0x40/0x110
>> LR [c000000000037530] .eeh_pe_loc_get+0x150/0x190
>> Call Trace:
>>    .of_get_property+0x30/0x60 (unreliable)
>>    .eeh_pe_loc_get+0x150/0x190
>>    .eeh_dev_check_failure+0x1b4/0x550
>>    .eeh_check_failure+0x90/0xf0
>>    .lpfc_sli_check_eratt+0x504/0x7c0 [lpfc]
>>    .lpfc_poll_eratt+0x64/0x100 [lpfc]
>>    .call_timer_fn+0x64/0x190
>>    .run_timer_softirq+0x2cc/0x3e0
>>
>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>> ---
>> Changelog[v2]:
>> 	Check the child device_node of root bus for root port
>> 	directly instead of search pdev from device-tree and
>> 	then translate it to device-node
>>
> I run into following warning with your patch. Please test the attached
> one. If no problem found, send that one please.
>
> arch/powerpc/kernel/eeh_pe.c: In function 'eeh_pe_loc_get':
> arch/powerpc/kernel/eeh_pe.c:806:18: warning: unused variable 'pdev'

OK, I will remove unused variable.

Thanks,
Mike
> Thanks,
> Gavin
>
>> arch/powerpc/kernel/eeh_pe.c | 24 ++++++------------------
>> 1 file changed, 6 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>> index fbd01eb..f96c10f 100644
>> --- a/arch/powerpc/kernel/eeh_pe.c
>> +++ b/arch/powerpc/kernel/eeh_pe.c
>> @@ -802,7 +802,6 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
>>   */
>> const char *eeh_pe_loc_get(struct eeh_pe *pe)
>> {
>> -	struct pci_controller *hose;
>> 	struct pci_bus *bus = eeh_pe_bus_get(pe);
>> 	struct pci_dev *pdev;
>> 	struct device_node *dn;
>> @@ -811,29 +810,20 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
>> 	if (!bus)
>> 		return "N/A";
>>
>> +	dn = pci_bus_to_OF_node(bus);
>> 	/* PHB PE or root PE ? */
>> -	if (pci_is_root_bus(bus)) {
>> -		hose = pci_bus_to_host(bus);
>> -		loc = of_get_property(hose->dn,
>> -				"ibm,loc-code", NULL);
>> +	if (dn && pci_is_root_bus(bus)) {
>> +		loc = of_get_property(dn, "ibm,loc-code", NULL);
>> 		if (loc)
>> 			return loc;
>> -		loc = of_get_property(hose->dn,
>> -				"ibm,io-base-loc-code", NULL);
>> +		loc = of_get_property(dn, "ibm,io-base-loc-code", NULL);
>> 		if (loc)
>> 			return loc;
>>
>> -		pdev = pci_get_slot(bus, 0x0);
>> -	} else {
>> -		pdev = bus->self;
>> -	}
>> -
>> -	if (!pdev) {
>> -		loc = "N/A";
>> -		goto out;
>> +		/* Check the root port */
>> +		dn = dn->child;
>> 	}
>>
>> -	dn = pci_device_to_OF_node(pdev);
>> 	if (!dn) {
>> 		loc = "N/A";
>> 		goto out;
>> @@ -846,8 +836,6 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
>> 		loc = "N/A";
>>
>> out:
>> -	if (pci_is_root_bus(bus) && pdev)
>> -		pci_dev_put(pdev);
>> 	return loc;
>> }
>>
>> -- 
>> 1.8.1.4
>>
