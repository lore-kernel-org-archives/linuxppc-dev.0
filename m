Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYYLz3rQyzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 23:36:59 +1100 (AEDT)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 28 Mar 2016 09:36:54 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id DA52C1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 08:36:38 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2SBan8o24510724
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 08:36:50 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2SCagKh023863
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 09:36:43 -0300
Subject: Re: [v4] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <3qWdQC0MVDz9s9Y@ozlabs.org>
Cc: mikey@neuling.org, linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 paulus@samba.org, imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 bhelgaas@google.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56F9255A.1040900@linux.vnet.ibm.com>
Date: Mon, 28 Mar 2016 09:36:42 -0300
MIME-Version: 1.0
In-Reply-To: <3qWdQC0MVDz9s9Y@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2016 06:33 AM, Michael Ellerman wrote:
> Hi Guilherme,
>
> Some comments below ...

Hi Michael, thanks for the comments.


>> +/* For dynamic PHB numbering on get_phb_number(): max number of PHBs. */
>> +#define	MAX_PHBS	8192
>
> Did we just make that up? It seems like a lot, but then we have some big
> systems?

Well, this is not documented AFAICT. I asked Benjamin on IRC and he 
pointed me the PCI stack (in special user space tools, like lspci) would 
be able to deal with at most 16 bit domain number (meaning 65536 bits in 
a bitmap). I thought it was too much, and chatting with Gavin, we ended 
up with 8192 ( == 1kB of memory, not too much I believe). What do you 
think about this number Michael? Should we decrease? Or even increase?
Below, following the last comment of yours, I'll discuss more about this 
value.


>> +/* For dynamic PHB numbering: used/free PHBs tracking bitmap. */
>
> Locking? It looks like it's protected by the hose_spinlock, but you should say
> that here, and also in the comment for hose_spinlock.
>
>> +static DECLARE_BITMAP(phb_bitmap, MAX_PHBS);
>>
>>   /* ISA Memory physical address */
>>   resource_size_t isa_mem_base;
>> @@ -64,6 +67,32 @@ struct dma_map_ops *get_pci_dma_ops(void)
>>   }
>>   EXPORT_SYMBOL(get_pci_dma_ops);
>>
>
> There should be a comment here saying what the locking requirements are for
> this function.

Well pointed Michael, I'll add the comments.


>> +static int get_phb_number(struct device_node *dn)
>> +{
>> +	const __be64 *prop64;
>> +	const __be32 *regs;
>> +	int phb_id = 0;
>> +
>> +	/* try fixed PHB numbering first, by checking archs and reading
>> +	 * the respective device-tree property. */
>> +	if (machine_is(pseries)) {
>
> Firstly I don't see why this check needs to be conditional on pseries. Any
> machine where the PHB has a 'reg' property should be able to use 'reg' for
> numbering.

This is something I'm not sure for all the powerpc sub-architectures, 
like Cell - that's the reason of the check. If you are sure about this, 
I'll gladly remove this check =)


>
>> +		regs = of_get_property(dn, "reg", NULL);
>> +		if (regs)
>> +			return (int)(be32_to_cpu(regs[1]) & 0xFFFF);
>
> This should use of_property_read_u32().
>
>> +	} else if (machine_is(powernv)) {
>
> This shouldn't be a machine check, it should just look for 'ibm,opal-phbid'
> first, before 'reg'.
>
>> +		prop64 = of_get_property(dn, "ibm,opal-phbid", NULL);
>> +		if (prop64)
>> +			return (int)(be64_to_cpup(prop64) & 0xFFFF);
>
> of_property_read_u64().
>
>> +	}

OK, I'll implement these changes.


> And finally in either case above, where you get a number from the device tree,
> you must check that it's not already allocated. Otherwise if you have a system
> where some PHBs have a property but others don't, you may give out the same
> number twice. Also you could have firmware give you the same number twice
> (which would be a firmware bug, but those happen).
>
> If the number is allocated you fall back to dynamic numbering.
>
> If it's not allocated you must mark it as allocated in the bitmap.

Hmm..interesting. I thought in performing such check, but I wasn't able 
to imagine a system in which we can have some PHBs indexed by 
device-tree properties and others don't, seemed impossible to me. The 
buggy fw case is an example, I can implement this modification if you 
think it's valid.

But, notice that for consistency in implementation, I'll might need to 
increase the MAX_PHBS value to 65536, otherwise we won't cover all the 
possible wrong cases, since I'm performing an AND with 0xFFFF mask 
(imagine if we can have a buggy fw exposing same value for two different 
PHBs, and this value is higher than 8192). What do you think about this?

Cheers,


Guilherme
