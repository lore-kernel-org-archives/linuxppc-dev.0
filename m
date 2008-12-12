Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3300CDE0CC
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 04:14:35 +1100 (EST)
Message-ID: <49429BC9.7070508@freescale.com>
Date: Fri, 12 Dec 2008 11:13:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to support 3GB pci address?
References: <200812112004118902765@gmail.com>	<41706FC0-B740-42C0-BA2B-B9E4B5839477@kernel.crashing.org>	<Pine.LNX.4.64.0812111957470.28806@t2.domain.actdsltmp>	<C2765CC8-2113-4323-9983-FD6E9A357453@kernel.crashing.org>	<Pine.LNX.4.64.0812120015050.28806@t2.domain.actdsltmp>
	<A15C72A2-1CEE-4D22-ACA8-F0DA1F04699E@kernel.crashing.org>
In-Reply-To: <A15C72A2-1CEE-4D22-ACA8-F0DA1F04699E@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"maillist.kernel" <maillist.kernel@gmail.com>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Dec 12, 2008, at 3:04 AM, Trent Piepho wrote:
> 
>> On Thu, 11 Dec 2008, Kumar Gala wrote:
>>> On Dec 11, 2008, at 10:07 PM, Trent Piepho wrote:
>>>> Don't the ATMU windows in the pcie controller serve as a IOMMU, making
>>>> swiotlb
>>>> unnecessary and wasteful?
>>>
>>> Nope.  You have no way to tell when to switch a window as you have no 
>>> idea
>>> when a device might DMA data.
>>
>> Isn't that what dma_alloc_coherent() and dma_map_single() are for?
> 
> Nope.  How would manipulate the PCI ATMU?

It could dynamically set up 1GB or so windows to cover 
currently-established mappings as they happen, and fall back on bounce 
buffering if no windows are available.  This avoids penalizing a 
DMA-heavy application that is the only DMA user (so no window 
thrashing), but happens to live in high memory.

That said, let's get things working first, and optimize later.

-Scott
