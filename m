Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id C007767E1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 04:33:29 +1000 (EST)
Message-ID: <30177.198.22.236.230.1123094006.squirrel@198.22.236.230>
In-Reply-To: <20050803114749.739ae51e.kim.phillips@freescale.com>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
	<33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
	<20050801123728.62764c7e.kim.phillips@freescale.com>
	<53547.198.22.236.230.1122997515.squirrel@198.22.236.230>
	<20050803114749.739ae51e.kim.phillips@freescale.com>
Date: Wed, 3 Aug 2005 14:33:26 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: "Kim Phillips" <kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler 'is' invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I will try the new BSP but meanwhile like to debug my ported driver.

Is there a way , like kernel level single-stepping to know why the
"interrupt status register"  gets a value of "0x0000000000000040" which
means TEA , transfer error acknowledge.

I changed and tested ur latest advice but same error in "interrupt status
register"

-vikas


> On Tue, 2 Aug 2005 11:45:15 -0400 (EDT)
> "Vikas Aggarwal" <va824363@albany.edu> wrote:
>
>>
>> This is how i write the address of RNG buffer(sec1_dpd.c.
>> DPDPTR->fld[i].ptr = virt_to_phys(*(unsigned int *) ((unsigned int)pReq
>> +
>> pDesc->fld[i].ptrOffset1st));
>>
>
> everything looks good except I'd try changing the above to something like:
>
> DPDPTR->fld[i].ptr = dma_map_single(NULL, ...ptrOffset1st,
> 		...lenOffset1st, DMA_TO_DEVICE);
>
> and change the DMA_BIDIRECTIONAL to DMA_TO_DEVICE in the DPD's address
> assignment.
>
> btw, a BSP upgrade (based on 2.6.11) for your platform should be available
> in a couple of weeks.  I'll let you know the status of the SEC driver for
> it.
>
> Kim
>
