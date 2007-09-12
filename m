Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 874DBDDF59
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 12:10:00 +1000 (EST)
In-Reply-To: <200709121013.51500.arnd@arndb.de>
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
	<200709120057.18873.arnd@arndb.de>
	<20070912035602.0be0d47e@localhost.localdomain>
	<200709121013.51500.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4cd6407b936b2ce65c11092883e7b8d5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Date: Wed, 12 Sep 2007 16:51:25 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> +struct ranges_pci {
>>>> +	unsigned int pci_space;
>>>> +	u64 pci_addr;
>>>> +	phys_addr_t phys_addr;
>>>> +	u64 size;
>>>> +} __attribute__((packed));
>>>> +
>>>
>>> This structure definition uses unaligned members because of the
>>> 'packed' attribute. Is that really what you intended?
>>>
>> yes, exactly, because I'm mapping this struct on ranges extracted from
>> the dts instead of juggling with ranges[foo] offsets.
>
> I see. It does however look wrong to me, because you are using a 
> hardcoded
> phys_addr_t type. This breaks when phys_addr has a different size from 
> what
> you expect, e.g. when booting a pure 32 bit kernel on a machine that 
> has
> a 64 bit physical address space.

More generally, you can even have a different size for the "phys_addr"
for different nodes in the same device tree.

You really should look at the #address-cells in this node's parent,
and translate that all the way up to the root node to get a CPU
address.


Segher
