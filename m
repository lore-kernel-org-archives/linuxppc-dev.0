Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F099414029B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 20:03:17 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 10 Apr 2014 20:03:15 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 369682CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 20:03:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3AA2wej11076062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 20:02:58 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3AA3Bpf030669
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 20:03:11 +1000
Received: from localhost.localdomain (dhcp-9-111-29-75.cn.ibm.com
 [9.111.29.75])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s3AA39GK030602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 20:03:10 +1000
Message-ID: <53466C5D.3070907@linux.vnet.ibm.com>
Date: Thu, 10 Apr 2014 18:03:09 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix 3bc95598 'powerpc/PCI: Use list_for_each_entry()
 for bus traversal'
References: <1397112695-3945-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1397116463.3671.181.camel@pasglop>
In-Reply-To: <1397116463.3671.181.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/2014 03:54 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-04-10 at 02:51 -0400, Mike Qiu wrote:
>> Unable to handle kernel paging request for data at address 0x00000000
>> Faulting instruction address: 0xc000000000041d78
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> ...
>> NIP [c000000000041d78] .sys_pciconfig_iobase+0x68/0x1f0
>> LR [c000000000041e0c] .sys_pciconfig_iobase+0xfc/0x1f0
>> Call Trace:
>> [c0000003b4787db0] [c000000000041e0c] .sys_pciconfig_iobase+0xfc/0x1f0 (unreliable)
>> [c0000003b4787e30] [c000000000009ed8] syscall_exit+0x0/0x98
>>
>> This bug was introduced by commit 3bc955987fb377f3c95bc29deb498e96819b8451
>> The root cause was the 'bus' has been set to null while try to access
>> bus->next.
> Good catch. Out of curiosity, what is using that syscall nowadays ? It's
> been long buggy in all sort of ways and is pretty much deprecated...
>

I just boot my Power7 machine with newest mainline kernel, it happens 
and block the system.

I really do not know which software use this syscall, need to do some 
research on it.

Thanks
Mike
> Cheers,
> Ben.
>
>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/kernel/pci_64.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
>> index 2a47790..7b6c1ae 100644
>> --- a/arch/powerpc/kernel/pci_64.c
>> +++ b/arch/powerpc/kernel/pci_64.c
>> @@ -209,6 +209,7 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>>   {
>>   	struct pci_controller* hose;
>>   	struct pci_bus *bus = NULL;
>> +	struct pci_bus *tmp_bus = NULL;
>>   	struct device_node *hose_node;
>>   
>>   	/* Argh ! Please forgive me for that hack, but that's the
>> @@ -229,10 +230,12 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>>   	 * used on pre-domains setup. We return the first match
>>   	 */
>>   
>> -	list_for_each_entry(bus, &pci_root_buses, node) {
>> -		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
>> +	list_for_each_entry(tmp_bus, &pci_root_buses, node) {
>> +		if (in_bus >= tmp_bus->number &&
>> +		    in_bus <= tmp_bus->busn_res.end) {
>> +			bus = tmp_bus;
>>   			break;
>> -		bus = NULL;
>> +		}
>>   	}
>>   	if (bus == NULL || bus->dev.of_node == NULL)
>>   		return -ENODEV;
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
