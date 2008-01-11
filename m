Return-Path: <jirislaby@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id DABF5DE0AA
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 20:13:27 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so1000150fkz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 01:13:25 -0800 (PST)
Message-ID: <47873333.5020202@gmail.com>
Date: Fri, 11 Jan 2008 10:13:23 +0100
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI Failed to allocate mem for PCI ROM
References: <1B75C5A8-E512-40CB-A6F3-351640701D0D@kernel.crashing.org>
	<47872BC8.2040204@gmail.com>
	<0119CD93-D9F1-42E0-9F6A-A50B2C63B19D@kernel.crashing.org>
In-Reply-To: <0119CD93-D9F1-42E0-9F6A-A50B2C63B19D@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 01/11/2008 10:07 AM, Kumar Gala wrote:
> 
> On Jan 11, 2008, at 2:41 AM, Jiri Slaby wrote:
> 
>> On 01/11/2008 09:29 AM, Kumar Gala wrote:
>>> Greg,
>>> I'm getting the following message from the kernel on an embedded 
>>> ppc32 system:
>>> PCI: Failed to allocate mem resource #9:100000@e0000000 for 0000:00:00.0
>>> The HW setup is a PCIe host controller and an e1000 NIC card.  It 
>>> appears that pci_bus_assign_resources() is trying to call 
>>> pci_assign_resource() for the ROM and the resource for the ROM is 
>>> [100000:1fffff] where the PHB is [c0000000:dfffffff].
>>> It seems like the resno that pci_assign_resource is getting called 
>>> with is wrong and thus pci_update_resource() doesn't get called.
>>> any ideas?
>>
>> Kernel version, please.
> 
> Sorry, its 2.6.24-rc7 + some ppc patches queued for 2.6.25

Could you try this patch?
http://git.kernel.org/?p=linux/kernel/git/gregkh/patches.git;a=blob_plain;f=pci/pci-remove-default-pci-expansion-rom-memory-allocation.patch

Greg: is this 2.6.25 material, please? We need this for SP2.

thanks,
-- 
Jiri Slaby
Faculty of Informatics, Masaryk University
Suse Labs
