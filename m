Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BB7DDDF05
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 16:11:35 +1100 (EST)
Message-Id: <C2765CC8-2113-4323-9983-FD6E9A357453@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0812111957470.28806@t2.domain.actdsltmp>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: How to support 3GB pci address?
Date: Thu, 11 Dec 2008 23:08:50 -0600
References: <200812112004118902765@gmail.com>
	<41706FC0-B740-42C0-BA2B-B9E4B5839477@kernel.crashing.org>
	<Pine.LNX.4.64.0812111957470.28806@t2.domain.actdsltmp>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"maillist.kernel" <maillist.kernel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 11, 2008, at 10:07 PM, Trent Piepho wrote:

> On Thu, 11 Dec 2008, Kumar Gala wrote:
>> On Dec 11, 2008, at 6:04 AM, maillist.kernel wrote:
>>> In the system, the total PCI address needed is about 3GB, so I  
>>> want to know
>>> how to support it in linux. mpc8548 has 36-bit real address, and can
>>> support 32GB PCIE address space, but in linux, there is only 1GB  
>>> kernel
>>> space, how to map the 3GB pci address to kernel? Is the  36-bit real
>>> address only used to support large memory(>4GB) for muti-threads?
>>
>> The 36-bit support is current (in tree) in complete.  Work is in  
>> progress to
>> add swiotlb support to PPC which will generically enable what you  
>> want to
>> accomplish.
>
> Don't the ATMU windows in the pcie controller serve as a IOMMU,  
> making swiotlb
> unnecessary and wasteful?

Nope.  You have no way to tell when to switch a window as you have no  
idea when a device might DMA data.

- k
