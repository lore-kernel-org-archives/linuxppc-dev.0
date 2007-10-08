Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7166DDF15
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 23:32:18 +1000 (EST)
In-Reply-To: <20071008120849.GA32540@localhost.localdomain>
References: <20071005174015.GA11016@localhost.localdomain>
	<20071005174642.GB32145@localhost.localdomain>
	<47067ADE.9060306@ru.mvista.com>
	<20071005180553.GA32405@localhost.localdomain>
	<EB9BE8E7-6437-403F-A7F4-953B393FDF51@kernel.crashing.org>
	<20071008120849.GA32540@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8B3EB438-F672-4E13-A29A-3F21D0048CF0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/7] [POWERPC] mpc8568mds.dts: fix PCI/PCIe nodes
Date: Mon, 8 Oct 2007 08:32:33 -0500
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2007, at 7:08 AM, Anton Vorontsov wrote:

> On Fri, Oct 05, 2007 at 03:58:00PM -0500, Kumar Gala wrote:
>>
>> On Oct 5, 2007, at 1:05 PM, Anton Vorontsov wrote:
>>
>>> On Fri, Oct 05, 2007 at 09:56:46PM +0400, Sergei Shtylyov wrote:
>>>> Hello.
>>>>
>>>> Anton Vorontsov wrote:
>>>>
>>>>> Commit 5bece127f0666996ca90772229e00332a34e516c tried to fix
>>>>> PCI/PCIe nodes, but actually it broke them even harder. ;-)
>>>>
>>>>    Of course. But shouldn't those be the subnoses of the "soc"  
>>>> type node?
>>>
>>> Nope. PCI's ranges = <>; isn't in the SOC address space.
>>>
>>> Valentine Barshak posted a patch titled "[RFC] [PATCH] PowerPC:  
>>> Add 64-bit
>>> phys addr support to 32-bit pci" that started using  
>>> of_translate_address()
>>> for ranges, and of_translate_address() will not work if PCI  
>>> placed in the
>>> SOC node. Not sure if that patch applied or not, though.
>>
>> I'm confused, what's the actual issue with PCI that this patch  
>> addresses?
>
> Which patch? Valentine's or mine under the subject? Don't know  
> about the
> former, but mine patch is pretty obvious: your commit
> 5bece127f0666996ca90772229e00332a34e516c moved PCI nodes out of soc  
> node,
> but you forgot to change regs = <>, thus instead of e000a000/e0008000,
> kernel used a000/8000 for accessing PCI ccsr registers.

Yeah, I see that bug now.  It looks like I wasn't getting my new .dts  
on the board.  Will fixup that issue in my patch.

- k
