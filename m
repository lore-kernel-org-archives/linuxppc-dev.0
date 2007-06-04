Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9B7ADDDE38
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 22:40:23 +1000 (EST)
Message-ID: <46640892.2030408@ru.mvista.com>
Date: Mon, 04 Jun 2007 16:41:54 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>	
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>	
	<4662EAA9.70104@ru.mvista.com>
	<1180905120.31677.22.camel@localhost.localdomain>
In-Reply-To: <1180905120.31677.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>    No, it doesn't -- since that info is almost *absolutely* useless
>>(the only 
>>exception is "cfi") in the context of Linux MTD subsys.
>>    Please, try to understand that knowing that chip is CFI compatible in 
>>itself doesn't yet guarantee that you can access the chip -- it all depends on 
>>its mapping to the real physical address range, therefore this group IMO 
>>cannot even constitute a valid "compatible" property.

> You make no sense to me. It's like saying that knowing that a 8250 chip
> on ISA cannot be accessed if you don't know it's IO ports so it
> shouldn't say "8250" in compatible property ?!?!?!?

    No, it's a completely different case.  Base address and even flash size 
are not the only things that matter.  There's bus width and interleave factors 
that influence the access (and possibly, byte-swapping too, although this is 
unlikely to happen in PPC world).

> Also, whatever shortcomings of the linux MTD drivers are totally
> irrelevant to what is correct to have in a device-tree. While we do
> tailor our device-tree specification around linux needs in most cases,
> there are cases like this one where common sense should be enough to
> understand that it's not because the linux MTD subsystem, as of today,
> cannot be told what programming interface to use, that we shouldn't
> provide that information in the tree.

    We did provide it, in the form of probing hints ("probe-type" prop).

> Regarding physical address ranges for the flash mapping, I suppose the
> best is to define a property for flash chips for it. 

    Flash chips in themselves have little to do with how they are mapped to 
the physical address space (considers the interleave factor), so that doesn't 
seem a practical idea.

WBR, Sergei
