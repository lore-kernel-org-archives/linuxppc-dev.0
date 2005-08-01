Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id 793CA67D88
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Aug 2005 10:48:19 +1000 (EST)
Message-ID: <33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
In-Reply-To: <20050730183217.3310585b.kim.phillips@freescale.com>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
Date: Sun, 31 Jul 2005 20:48:16 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: "Kim Phillips" <kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler "is" invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tried it as u said . No luck :(
But something more i noted now in CPSR(channel pointer status
register=0x2040)  that before ISR invoked it has 0x0:0x7.

After ISR invoked it has 0x7:0x2007 .  The 7 in low bits means
channel_error and 2 is at "reserved" bits as per documentation, don't know
what that means.

I also tried kmalloc with GFP_DMA, for the memory where i create the
Descriptor.
Please keep giving ideas for debugging this as this is what driving me
right now.
regards
-vikas


> On Fri, 29 Jul 2005 23:39:32 -0400 (EDT)
> "Vikas Aggarwal" <va824363@albany.edu> wrote:
>
>>
>> But i still think that may be virt_to_phys() is not doing what FR
>> expects.
>>
> try dma_map_single().  See drivers/net/gianfar.c
>
> Kim
>
