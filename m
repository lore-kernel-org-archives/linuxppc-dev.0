Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 4490FDE2A0
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 04:36:19 +1100 (EST)
Message-ID: <47E93866.1060606@ru.mvista.com>
Date: Tue, 25 Mar 2008 20:37:42 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: OF compatible MTD platform RAM driver ?
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251744.46001.laurentp@cse-semaphore.com>
	<47E93010.5090904@ru.mvista.com>
	<200803251823.32039.laurentp@cse-semaphore.com>
In-Reply-To: <200803251823.32039.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:

>>>>Heh, there was a whole company against mentioning "mtd" when we started 
>>>>working on this (of course, the first idea was to call the flash device
>>>>type "mtd"). I don't think "mtd" looks good here -- I'd suggest
>>>>"flash-ram" (if this is just a linearly mapped NVRAM).

>>>I'm fine with "flash-ram" (even thought it looks a bit weird). I'll
>>>prepare a patch.

>>Yeah. I forgeot that "flash" means EEPROM. Actually, the main facts about 
>>the NVRAM that I'd want to be stated in the "compatible" property is that
>>it's  non-volatile and directly/lineraly mapped... Just "nvram" doesn't seem 
>>enopugh, maybe "linear-nvram" is.

> Direct mapping is a hard requirement for the nvram if we want to use it with 
> the MTD subsystem.

    I thought we're currently talking about a driver controlling the directly 
mapped NVRAM.  The "compatible" property wouldn't allow us to specify the 
compatibility to *any* NVRAM since there could be no "least common 
denominator" driver anyway.

> Regarding non-volatility nothing prevents a user from 
> using a volatile RAM as an MTD device, but there's little point in doing so.

    Indeed, if just for testing... we could specify non-volatility as the 
device's prop, though...

> Would it be acceptable for the "linear-nvram" specification not to include 
> volatile RAM ? ROM chips would be excluded too. Is that an issue ?

    Well, I think we need a separate "compatible" prop for ROMs. Or we'll end 
up with the "compatible" being just "memory" with the memory "attributes" 
(R/O, N/V) being described by other "properties"... :-)

>>And we can specify "device_type" of "nvram" indeed (and #size). 

> I suppose you meant #bytes.

    Of course. :-)

> What about sub-partitions support ? Nothing prevents RAM-based MTD devices 

    Hm... I remember that the knowledge of MTD partitions turned me away from 
"nvram" device type when I started spec'ing the flash binding -- it's not 
uncommon to have a flash partition devoted to and labelled as "nvram". 
Therefore, that sole partition would have been a "nvram" device for OF...

> from being partioned. Would it be acceptable to reference the CFI/JEDEC flash 
> section in Documentation/powerpc/booting-without-of.txt in the description of 
> the nvram node ?

    I don't see why not.

> Best regards,

WBR, Sergei
