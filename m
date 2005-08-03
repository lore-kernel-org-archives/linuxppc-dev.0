Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F18DF67E3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 02:48:01 +1000 (EST)
Date: Wed, 3 Aug 2005 11:47:49 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Vikas Aggarwal" <va824363@albany.edu>
Message-Id: <20050803114749.739ae51e.kim.phillips@freescale.com>
In-Reply-To: <53547.198.22.236.230.1122997515.squirrel@198.22.236.230>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
	<33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
	<20050801123728.62764c7e.kim.phillips@freescale.com>
	<53547.198.22.236.230.1122997515.squirrel@198.22.236.230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 2 Aug 2005 11:45:15 -0400 (EDT)
"Vikas Aggarwal" <va824363@albany.edu> wrote:

> 
> This is how i write the address of RNG buffer(sec1_dpd.c.
> DPDPTR->fld[i].ptr = virt_to_phys(*(unsigned int *) ((unsigned int)pReq +
> pDesc->fld[i].ptrOffset1st));
> 

everything looks good except I'd try changing the above to something like:

DPDPTR->fld[i].ptr = dma_map_single(NULL, ...ptrOffset1st,
		...lenOffset1st, DMA_TO_DEVICE);

and change the DMA_BIDIRECTIONAL to DMA_TO_DEVICE in the DPD's address assignment.

btw, a BSP upgrade (based on 2.6.11) for your platform should be available in a couple of weeks.  I'll let you know the status of the SEC driver for it.

Kim
