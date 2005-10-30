Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EAB5F6862F
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Oct 2005 15:04:54 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: bcm43xx-dev@lists.berlios.de
Content-Type: text/plain
Date: Sun, 30 Oct 2005 15:03:55 +1100
Message-Id: <1130645036.29054.229.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: 30 bits DMA and ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

I was thinking about the best ways to deal with the 30 bits limitation
of the Broadcom chips for DMA on PowerMacs. No emergency there, we still
need to have a working bcm43xx driver and the developpement can be done
with <= 1Gb of RAM, but it will have to be addressed at one point as we
are getting closer to something that is useable :)

I will not implement something like GFP_DMA, I think. It just sucks too
much...

However, what I can do is have the architecture code reserve a pool of
memory at boot if the machine main RAM is bigger than 1Gb, to use for
bounce-buffering. On the G5 with more than 2Gb, this is even easier
since I already have to blow away a 16Mb page for use by the IOMMU, but
the IOMMU only uses 2Mb in there, so I have about 14Mb that I could
re-use for that. On 32 bits machine, I can just reserve something early
during boot.

Now, how to actually make use of that pool. One way is to hack something
specific inside the bcm43xx driver. The pool can then be easily cut in
regions: the descriptor rings buffers, and 2 pools, one for Rx and one
for Tx. The allocation inside of those pools can be done as simple ring
buffer too due to the inherently ordered processing of packets.

However, the above would require arch specific hacks, and would only
work for one card in the system (too bad if you plug a cardbus one).

Another possibility that might be more interesting is to use swiotlb.
This is a somewhat generic bounce-buffering implementation of the DMA
mapping routines that is used by ia64 and x86_64 when no IOMMU is
available. It will automatically do nothing if the address fits the DMA
mask so it shouldn't add much overhead to other drivers and would "make
things work" transparently. In addition, for G5s with more than 2Gb of
RAM (which have an iommu), I could modify the iommu code to take into
account the DMA mask when allocating DMA virtual space. (The later would
have a slight risk of failure, but I doubt it will happen in practice,
as it would mean one has more than 1Gb of pending DMA at a given point
in time).

I tend to prefer the later solution ...

Anybody with strong disagreement with using swiotlb on PPC ? The choice
of wether to allocate RAM for it at boot and how much can be done per
platform and based on the amount of real RAM (for example, on pmac, I
suppose I would only allocate some if the physical RAM is more than 1Gb
since that's the limitation of those Broadcom chips and I don't see any
other potential user for it).

Besides, it may end up being useful for some crappy embedded stuffs (no
name here :)

Ben.
 
