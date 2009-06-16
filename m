Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B6C38B716D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 02:46:43 +1000 (EST)
Message-ID: <4A37CC72.3060709@freescale.com>
Date: Tue, 16 Jun 2009 11:46:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Chris Pringle <chris.pringle@oxtel.com>
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
References: <4A37A503.3030209@oxtel.com>
	<20090616162114.GA5051@loki.buserror.net>
	<4A37C97A.5050508@oxtel.com>
In-Reply-To: <4A37C97A.5050508@oxtel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chris Pringle wrote:
> The kernel version is 2.6.26. Firmware is custom on a custom board.
>> Cache coherency on PCI DMA requires that the memory be mapped with the M
>> attribute on this chip, but that should be happening based on 
>> detection of
>> the core.
>>   
> I'm not sure where to look to verify this?

Check asm/cputable.h for CPU_FTR_NEED_COHERENT.  Make sure that 
CONFIG_8260 is one of the #ifdefs that turns that on.  It looks like 
that was in place by 2.6.26 in arch/powerpc.  I'm not sure what to look 
for in arch/ppc.

>> Also make sure that you park the bus on PCI and raise its arbitration
>> priority, as done at the end of fixup_pci in 
>> arch/powerpc/boot/cuboot-pq2.c.
>>   
> Since this is a reasonably recent kernel,

Not really, there was a fair amount of 82xx work in the mid-2.6.20s. 
The addition of CPU_FTR_NEED_COHERENT to 82xx was somewhere in that time.

Can you try 2.6.30?

> I'd guess that both of these 
> things are correct. I've had a quick look in that file and there is code 
> in there raising arbitartion priority and parking the bus.

Just because the code is there doesn't mean you're using it -- are you 
using cuImage?  Are you using arch/ppc or arch/powerpc?

Typically this would be done by firmware; it's only in cuboot because 
u-boot wasn't doing it.

>> BTW, you may want to post to linuxppc-dev@lists.ozlabs.org for
>> powerpc-specific issues, especially this kind of hardware issue.
>>
>>   
> I've just posted there :-)

Doh, sorry. :-)

> Interestingly, I've just turned off cache snooping and the problem has 
> got much worse. This has surprised me as I thought that part of the job 
> done by pci_map_sg was to flush the CPU cache

It only flushes the cache on hardware that doesn't do coherent DMA.

-Scott
