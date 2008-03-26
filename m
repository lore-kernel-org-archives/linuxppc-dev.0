Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 43678DE074
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 23:51:59 +1100 (EST)
Message-ID: <47EA4741.2050402@ru.mvista.com>
Date: Wed, 26 Mar 2008 15:53:21 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: OF compatible MTD platform RAM driver ?
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251823.32039.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0427706A@ismail.innsys.innovsys.com>
	<200803251914.24021.laurentp@cse-semaphore.com>
In-Reply-To: <200803251914.24021.laurentp@cse-semaphore.com>
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

>>>Regarding non-volatility nothing prevents a user from using a 
>>>volatile RAM as an MTD device, but there's little point in doing so.
>>>Would it be acceptable for the "linear-nvram" specification
>>>not to include > volatile RAM ? ROM chips would be excluded too. Is

>>that an issue ?

>>We actually use a volatile ram (SRAM) as an MTD device. We use it to
>>store info from bootloader and system specific values between resets.

> So we're left with two main options.

> - Reusing the nvram device type from the Device Support Extensions. Volatile 
> devices wouldn't be supported, and we'd need a separate device specification 
> for linear-mapped volatile RAMs. I'm not very happy with that.

> - Using another device node with a compatible value set to "linear-ram" (or 
> something similar). This would support both volatile and non-volatile 
> devices, and a property could be added to specify if the device is volatile 
> or not.

> I'd go for the second option, and I'd specify a "linear-rom" compatible value 
> as well while we're at it.

> Both volatile and non-volatile RAMs can be handled by the physmap_of MTD 
> driver. They both use the same map probe type ("map_ram"). Volatility isn't 
> handled there.

> ROMs should be handled by the same driver and should use the "mtd_rom" map 
> probe type.

    OK, let's go with it.

> As all those devices use the physmap_of MTD driver, what about 
> using "physmap-ram" and "physmap-rom" as compatibility names ?

    Heh, we've gone thru "physmap" before -- it was labelled Linux-specific 
name (well, I'd agree with that).

> Best regards,

WBR, Sergei
