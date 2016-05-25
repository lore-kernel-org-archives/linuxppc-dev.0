Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFCCD5DSVzDqVL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 23:03:52 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4PCx7Dw040106
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 09:03:47 -0400
Message-Id: <201605251303.u4PCx7Dw040106@mx0a-001b2d01.pphosted.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 234qj1rh4h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 09:03:47 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 25 May 2016 10:03:44 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 35DDC1DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 09:03:36 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4PD3gMn25624874
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 10:03:42 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4PD3fYo015327
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 10:03:42 -0300
Subject: Re: [v4] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <3qWdQC0MVDz9s9Y@ozlabs.org> <56F9255A.1040900@linux.vnet.ibm.com>
 <1464155117.8573.2.camel@ellerman.id.au>
Cc: mikey@neuling.org, linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 paulus@samba.org, imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 bhelgaas@google.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 25 May 2016 10:03:41 -0300
MIME-Version: 1.0
In-Reply-To: <1464155117.8573.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/25/2016 02:45 AM, Michael Ellerman wrote:
> Hi Guilherme,
>
> Sorry for the very late reply, this got lost in my email filters.

No problem Michael, thanks for replying!


> On Mon, 2016-03-28 at 09:36 -0300, Guilherme G. Piccoli wrote:
>> On 03/25/2016 06:33 AM, Michael Ellerman wrote:
>
>>>> +static int get_phb_number(struct device_node *dn)
>>>> +{
>>>> +	const __be64 *prop64;
>>>> +	const __be32 *regs;
>>>> +	int phb_id = 0;
>>>> +
>>>> +	/* try fixed PHB numbering first, by checking archs and reading
>>>> +	 * the respective device-tree property. */
>>>> +	if (machine_is(pseries)) {
>>>
>>> Firstly I don't see why this check needs to be conditional on pseries. Any
>>> machine where the PHB has a 'reg' property should be able to use 'reg' for
>>> numbering.
>>
>> This is something I'm not sure for all the powerpc sub-architectures,
>> like Cell - that's the reason of the check. If you are sure about this,
>> I'll gladly remove this check =)
>
> Please do.
>
> I'll test on Cell & other platforms. If there are bugs we can fix them. Maybe
> if we can't get it to work on eg. Cell then we need a machine_is() check, but
> that should be the last resort.
>
>>>> +		regs = of_get_property(dn, "reg", NULL);
>>>> +		if (regs)
>>>> +			return (int)(be32_to_cpu(regs[1]) & 0xFFFF);
>>>
>>> This should use of_property_read_u32().
>
> You missed this in v5 ^
>
>>> And finally in either case above, where you get a number from the device tree,
>>> you must check that it's not already allocated. Otherwise if you have a system
>>> where some PHBs have a property but others don't, you may give out the same
>>> number twice. Also you could have firmware give you the same number twice
>>> (which would be a firmware bug, but those happen).
>>>
>>> If the number is allocated you fall back to dynamic numbering.
>>>
>>> If it's not allocated you must mark it as allocated in the bitmap.
>>
>> Hmm..interesting. I thought in performing such check, but I wasn't able
>> to imagine a system in which we can have some PHBs indexed by
>> device-tree properties and others don't, seemed impossible to me. The
>> buggy fw case is an example, I can implement this modification if you
>> think it's valid.
>>
>> But, notice that for consistency in implementation, I'll might need to
>> increase the MAX_PHBS value to 65536, otherwise we won't cover all the
>> possible wrong cases, since I'm performing an AND with 0xFFFF mask
>> (imagine if we can have a buggy fw exposing same value for two different
>> PHBs, and this value is higher than 8192). What do you think about this?
>
> Yeah please increase the bitmap size to 65536. It will only take 8KB of memory,
> which is negligible.

Well, since I sent a v6 and you replied there too, I guess we can 
continue our iterations there - mostly suggestions (all except one) you 
gave here were implemented in v6.

Thanks,


Guilherme

>
> cheers
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
