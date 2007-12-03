Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C7367DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 04:48:55 +1100 (EST)
Message-ID: <475441DD.9030601@ovro.caltech.edu>
Date: Mon, 03 Dec 2007 09:50:21 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: Maximum ioremap size for ppc arch?
References: <36D7B34A3A79F84F82FA0C154F299F2505FE26D2@E03MVX1-UKDY.domain1.systemhost.net>
	<20071203153009.GA30746@gate.crashing.org>
In-Reply-To: <20071203153009.GA30746@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matt,

> On Mon, Dec 03, 2007 at 09:22:06AM -0000, michael.firth@bt.com wrote:
>> I'm trying to get am MPC834x system running that has 256MBytes of NOR
>> flash connected.
>>
>> The physmap flash driver is failing to ioremap() that amount of space,
>> while on a similar system with 128Mbytes of flash, there are no
>> problems.
>>
>> Is this a known limitation of ioremap() on the ppc architecture, or
>> specifically the MPC834x family, and is there any (hopefully easy) way
>> to increase this limit?
> 
> The answer is "it depends". It depends on the amount of system memory
> you have. By default, your system memory is mapped at 0xc0000000, leaving
> not enough space for vmalloc allocations to grab 256MB for the
> ioremap (and avoid the fixed virtual mapping in the high virtual
> address area).
> 
> See the "Advanced setup" menu. Normally, you can set "Set custom kernel
> base address" to 0xa0000000 safely. That will give you an additional
> 256MB of vmalloc space. On arch/powerpc, you'll also have to set
> "Size of user task space" to 0x80000000 or 0xa0000000.

Could you comment on a similar problem I had/have.

I have a CPU with 1GB memory, and I use about 20 cPCI boards that
I give 8MB windows in PCI space. When I was trying to load my
custom driver with these boards, it would give me ioremap failures.
On a CPU that had 512MB of memory it worked fine. My 'temporary hack'
(which is still in place) for the 1GB CPUs was to add mem=512M (or 
whatever it is) to the kernel command line. That was a good
enough fix at the time :)

I have figured I was running out of page table entries or something
like that and was going to investigate one of these days ...

However, perhaps it was that I was running out of address space.
But 0xC0000000 is at 3GB, I can't see that I would be triggering
an address space issue:

1GB = 0x40000000
20 x 8MB = 160MB

But, I figured I'd ask anyway :)

Thanks,
Dave

PS. The CPUs in this case are x86 based, while the PCI boards use
PLX-9054 bridges. I'm building new peripheral boards with MPC8349EAs
so this problem is going to rear its ugly head again soon, when
I work on the drivers for the new peripheral boards.
