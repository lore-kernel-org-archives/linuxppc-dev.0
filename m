Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B87DDDEB6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 05:56:14 +1000 (EST)
Message-ID: <46BA1FD2.4000705@freescale.com>
Date: Wed, 08 Aug 2007 14:56:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqvg3i0nhx3hy@phoenix>,
	<op.twqvg3i0nhx3hy@phoenix> <twig.1186602365.9125@inaccessnetworks.com>
In-Reply-To: <twig.1186602365.9125@inaccessnetworks.com>
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
> I was referring to the allocation of primary bus' IO space based on the 
> device tree. I understand that IO-space resources are relative to the start 
> of the primary bus' IO space. But I think the primary bus IO space allocation 
> itself is broken. Let me explain with an example:
> 
> In mpc8272ads.dts, the ranges property for pci is:
> 
> ranges = <42000000 0 80000000 80000000 0 20000000
>           02000000 0 a0000000 a0000000 0 20000000
>           01000000 0 00000000 f6000000 0 02000000>;
> 
> The third obviously corresponds to IO space. So, shouldn't the res->start for 
> the host bridge be set to f6000000 ?

No, because as I said, res->start is relative to the start of IO-space. 
  The in/out functions add isa_io_base to the address.

> Because, currently, based on what I've 
> described in my previous mail, it gets set to 0. It seems to me like a matter 
> of incorrect parsing of the device tree from pci_process_bridge_OF_ranges() 
> for IO space.

It is not, at least not in this case.  It does appear to be ignoring the 
possibility that it needs to do further translation of the address 
through parent buses, though.

-Scott
