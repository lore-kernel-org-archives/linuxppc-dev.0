Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF9301A0B10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 19:58:49 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 29 Oct 2015 18:58:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ABC8B2CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 19:58:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9T8wbHL40108092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 19:58:46 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9T8wCJ3008375
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 19:58:13 +1100
Date: Thu, 29 Oct 2015 16:57:47 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 05/12] powerpc/eeh: Cache only BARs, not windows or
 IOV BARs
Message-ID: <20151029085747.GA1400@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-6-git-send-email-weiyang@linux.vnet.ibm.com>
 <87h9lapd2o.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h9lapd2o.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 29, 2015 at 02:29:19PM +1100, Daniel Axtens wrote:
>Wei Yang <weiyang@linux.vnet.ibm.com> writes:
>
>> EEH address cache, which helps to locate the PCI device according to
>> the given (physical) MMIO address, didn't cover PCI bridges. Also, it
>> shouldn't return PF with address in PF's IOV BARs. Instead, the VFs
>> should be returned.
>>
>> Also, by doing so, it removes the type check in
>> eeh_addr_cache_insert_dev(), since bridge's window would not be cached.
>>
>> The patch restricts the address cache to cover first 7 BARs for the
>> above purposes.
>If I've understoond the patch correctly, I think you want to swap the
>last two paragraphs in the commit message:
>
>"Restrict the address cache to cover the first 7 BARs...
>
>Since the window of a bridge will now not be cached, remove the type
>check..."
>

Hmm... my purpose in the last paragraphs is to state what the patch does and
the 2nd one is to mention another change in the log.

The order is both fine to me.

>With regards to the actual patch, I have now got access to the PCI and
>SR-IOV specs, but I'm still getting to grips with it all so let me know
>if something I say doesn't make sense.
>
>Here, you restrict the enumeration of resources to the standard and
>extension ROM resources (the first 7), which excludes enumeration of
>VF resources. That much I understand.
>
>I'm having more trouble convincing myself that it's safe or desirable to
>drop the test for bridges. I think I understand that the change to the
>for loop means it _should_ be safe, but is there any motivation for the
>change other than making the code more straightforward?
>

The motivation is just make the code more straightforward.

For a bridge device, the first 7 resources are not used and the last several
are not cached, This is the reason why I remove it in the patch.

>>  	/* Walk resources on this device, poke them into the tree *
>This comment probably needs to be made more descriptive given the change.

Right, will change it.

>> -	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>>  		resource_size_t start = pci_resource_start(dev,i);
>>  		resource_size_t end = pci_resource_end(dev,i);
>>  		unsigned long flags = pci_resource_flags(dev,i);
>> @@ -222,10 +222,6 @@ void eeh_addr_cache_insert_dev(struct pci_dev *dev)
>>  {
>
>Regards,
>Daniel
>
>>  	unsigned long flags;
>>  
>> -	/* Ignore PCI bridges */
>> -	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
>> -		return;
>> -
>>  	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
>>  	__eeh_addr_cache_insert_dev(dev);
>>  	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
>> -- 
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Richard Yang
Help you, Help me
