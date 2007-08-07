Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9AA9EDDE18
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 01:20:29 +1000 (EST)
Message-ID: <46B88DAC.70005@freescale.com>
Date: Tue, 07 Aug 2007 10:20:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix>
In-Reply-To: <op.twol4cixnhx3hy@phoenix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandros Kostopoulos wrote:
> Except from some macros arch/powerpc/include/asm/io.h / mpc8260_pci9.h, 
> I  can seem to find anywhere the code regarding PCI Erratum 9. The 
> defined  macros(in io.h) for read/write are sufficient as a workaround 
> for PCI9?  Who does DMA and register initialization for this (it used to 
> be done in  arch/ppc/syslib/m8260_pci_erratum9.c in arc/ppc). Maybe 
> u-boot or the  bootwrapper?

I don't think the workaround exists yet in arch/powerpc, despite the 
config option.

> Another question regarding resource allocation: when  
> alloc_resource(pci_32.c), called from pcibios_allocate_resources(), 
> during  pcibios init, attempts to allocate resources using 
> request_resource(), the  request fails. This seems to happen because the 
> previously scanned PCI  devices request resources in the form, e.g. 
> 00000- 0000f (i.e. starting  from zero), and this should be mapped 
> somewhere else in cpu mem space. My  question (in order to find my bug) 
> is, who performs this mapping, from PCI  space to CPU space, the kernel 
> (and if yes, where?) or the host bridge (in  which case, I've probably 
> failed to configure it properly).

If the error message is the one I'm thinking of (it always helps to post 
the actual messages), that's normal for when the PCI bus hasn't been 
probed by the firmware.  Linux first tries to use the BARs as they're 
already set, which will obviously fail because they haven't been set, 
and then it will properly allocated them.  It's harmless verbosity, 
though it'd be nice to have a flag to tell the PCI layer to not bother 
trying to preserve any existing BARs.

-Scott
