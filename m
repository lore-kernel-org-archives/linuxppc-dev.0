Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A7FADDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 20:07:50 +1100 (EST)
Message-Id: <0119CD93-D9F1-42E0-9F6A-A50B2C63B19D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jiri Slaby <jirislaby@gmail.com>
In-Reply-To: <47872BC8.2040204@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: PCI Failed to allocate mem for PCI ROM
Date: Fri, 11 Jan 2008 03:07:29 -0600
References: <1B75C5A8-E512-40CB-A6F3-351640701D0D@kernel.crashing.org>
	<47872BC8.2040204@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2008, at 2:41 AM, Jiri Slaby wrote:

> On 01/11/2008 09:29 AM, Kumar Gala wrote:
>> Greg,
>> I'm getting the following message from the kernel on an embedded  
>> ppc32 system:
>> PCI: Failed to allocate mem resource #9:100000@e0000000 for  
>> 0000:00:00.0
>> The HW setup is a PCIe host controller and an e1000 NIC card.  It  
>> appears that pci_bus_assign_resources() is trying to call  
>> pci_assign_resource() for the ROM and the resource for the ROM is  
>> [100000:1fffff] where the PHB is [c0000000:dfffffff].
>> It seems like the resno that pci_assign_resource is getting called  
>> with is wrong and thus pci_update_resource() doesn't get called.
>> any ideas?
>
> Kernel version, please.

Sorry, its 2.6.24-rc7 + some ppc patches queued for 2.6.25

- k
