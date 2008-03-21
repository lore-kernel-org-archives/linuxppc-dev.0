Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA3CDDE01C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Mar 2008 03:18:42 +1100 (EST)
Date: Fri, 21 Mar 2008 11:18:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: James Black <jblack547@gmail.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
Message-ID: <20080321161833.GA4170@loki.buserror.net>
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
	<20080319174001.GF7962@ld0162-tx32.am.freescale.net>
	<b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>
	<b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>
	<47E2AADD.6090101@freescale.com>
	<b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>
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

On Thu, Mar 20, 2008 at 05:02:35PM -0600, James Black wrote:
> On Thu, Mar 20, 2008 at 12:20 PM, Scott Wood <scottwood@freescale.com> wrote:
> > James Black wrote:
> >  > Zone PFN ranges:
> >  >   DMA             0 ->    16384
> >  >   Normal      16384 ->    16384
> >  > Movable zone start PFN for each node
> >  > early_node_map[1] active PFN ranges
> >  >     0:        0 ->    16384
> >  > Unable to handle kernel paging request for data at address 0xe001a000
> >  > Faulting instruction address: 0xc00e1a6c
> >
> >  What function is 0xc00e1a6c in?
> Drilled down into the source and find that mm/bootmem.c:line 232
> 
>            : find_next_zero_bit()
> may be the culprit. When I put printks in, the line moves around a bit.

Is it node_bootmem_map, eidx, or i that is bad?  What is end_pfn?  What is
calling alloc_bootmem?

> >  You can't use all of 0x8000-0x8fff; there is device parameter RAM in
> >  there.  If you can figure out the portions that aren't in use, you can
> >  use those, but I wouldn't bother unless you really need the extra muram.
> 
> So, are you are saying that the muram node is giving the ram to the
> kernel and is no longer available for devices to use as buffer
> descriptors?

No.

> I imagined the opposite. I thought I was telling the
> kernel where the parameter ram and buffer descriptors live.

It's telling the kernel where available muram is, to be allocated by CPM
drivers for buffer descriptors.

> I am going to turn on the MCC2 device eventually and will need all of the
> dpram for buffer descriptors.
> 
> The memory map in my mind right now is
> 0x0000 - 0x3FFF --> buffer descriptors for SCCx and MCC2.
> 0x8000 - 0x8FFF --> paramter ram for SCCx and MCC2, et al. (reserved)
> 0xB000 - 0xB8FF --> FCCx specific (reserved)
> 
> In my case, I shouldn't define any of the dual port ram for the kernel?

You shouldn't define any of the reserved areas as general purpose muram.

-Scott
