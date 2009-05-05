Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75150DDD1C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 21:40:28 +1000 (EST)
Message-Id: <7CD322DD-A8FC-49DB-AA4C-E67C20793625@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <1241103047.7356.8.camel@concordia>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 0/9] powerpc/pci: clean up direct access to sysdata
Date: Tue, 5 May 2009 06:40:03 -0500
References: <1241096999-11164-1-git-send-email-galak@kernel.crashing.org>
	<1241099366.7356.4.camel@concordia>
	<EAC6B615-35F2-4CD9-A7E8-FAAD4B9D9DF3@kernel.crashing.org>
	<1241103047.7356.8.camel@concordia>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2009, at 9:50 AM, Michael Ellerman wrote:

> On Thu, 2009-04-30 at 09:18 -0500, Kumar Gala wrote:
>> On Apr 30, 2009, at 8:49 AM, Michael Ellerman wrote:
>>
>>> On Thu, 2009-04-30 at 08:09 -0500, Kumar Gala wrote:
>>>> We shouldn't be accessing sysdata directly.  In the future we might
>>>> have
>>>> sysdata be a device_node on ppc32 to match ppc64.  Direct access
>>>> would make that
>>>> a bit difficult.
>>>>
>>>> If someone can look at the iseries code I would appreciate that:
>>>>
>>>> arch/powerpc/platforms/iseries/pci.c:
>>>> iomm_table[current_iomm_table_entry] = dev->sysdata;
>>>> arch/powerpc/platforms/iseries/pci.c:
>>>> iseries_ds_addr(dev->sysdata) | (bar_num << 24);
>>>> arch/powerpc/platforms/iseries/pci.c:   pdev->sysdata = node;
>>>
>>> It looks like it's basically doing the same logic as
>>> pci_device_to_OF_node(), and fetch_dev_dn(), but there's probably  
>>> some
>>> reason why it's not using those.
>>>
>>> Given how much new iseries hardware there is, I think we'd probably
>>> rather leave the code as is. It's a device node anyway, so it  
>>> doesn't
>>> block your plans RE ppc32.
>>>
>>> cheers
>>
>> I was already thinking along those lines, but figured I see if anyone
>> is really "maintaining" iseries code :)
>
> Not that much, it would be sfr if anyone, but I think he's a bit  
> busy :)
>
> cheers

I was thinking about this a bit more and would like to clean up  
iseries as well.  Either iseries is maintained by someone or its not.

- k
