Date: Thu, 4 Apr 2002 16:52:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Message-ID: <20020404065258.GV21034@zax>
References: <200204041445.g34Ejjc14079@gt_tus_au.au.thalesgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200204041445.g34Ejjc14079@gt_tus_au.au.thalesgroup.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 04, 2002 at 04:40:00PM +1000, Rosen Jeremy wrote:
>
> >
> > This flag is used on architectures that have memory only accessible
> > from the processor, not from a DMA device, to ensure a DMA device
> > gets a memory bank that it can access.
>
> so it specifies that the kmalloc()ed region must be usable for DMA
> transfer.... which is exactly what we want.

Not really - IIRC it really is specific to ISA DMA.  PCI devices on
i386 won't generally need it and probably won't specify it.  Nor would
we want to, since that would put everything in the ludicrously small
ISA DMA region (only 1MB AFAIR) which could rapidly be exhausted.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
