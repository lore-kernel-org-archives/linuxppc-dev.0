Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32B16DDF59
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 07:27:22 +1100 (EST)
Message-Id: <E1025115-6BE2-46B6-8416-A5ADD506E2ED@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20080111175039.GB7916@kroah.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: PCI Failed to allocate mem for PCI ROM
Date: Fri, 11 Jan 2008 14:27:16 -0600
References: <1B75C5A8-E512-40CB-A6F3-351640701D0D@kernel.crashing.org>
	<20080111175039.GB7916@kroah.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2008, at 11:50 AM, Greg KH wrote:

> On Fri, Jan 11, 2008 at 02:29:28AM -0600, Kumar Gala wrote:
>> Greg,
>>
>> I'm getting the following message from the kernel on an embedded  
>> ppc32
>> system:
>>
>> PCI: Failed to allocate mem resource #9:100000@e0000000 for  
>> 0000:00:00.0
>>
>> The HW setup is a PCIe host controller and an e1000 NIC card.  It  
>> appears
>> that pci_bus_assign_resources() is trying to call  
>> pci_assign_resource() for
>> the ROM and the resource for the ROM is [100000:1fffff] where the  
>> PHB is
>> [c0000000:dfffffff].
>>
>> It seems like the resno that pci_assign_resource is getting called  
>> with is
>> wrong and thus pci_update_resource() doesn't get called.
>>
>> any ideas?
>
> Nope, sorry, any help debugging this is appreciated, pci resource
> allocation is "tricky" :)

I'm happy to debug, is the fact that the resno == 9 ok or does that  
seem wrong?

- k
