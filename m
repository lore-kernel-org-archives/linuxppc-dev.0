Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B73C3B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 13:01:15 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p712snHq002056
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2011 12:54:49 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7130EEI942106
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2011 13:00:14 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p71311V1026089
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2011 13:01:02 +1000
Date: Mon, 1 Aug 2011 12:48:46 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110801024846.GA28437@yookeroo.fritz.box>
References: <1311983933.8793.42.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311983933.8793.42.camel@pasglop>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 30, 2011 at 09:58:53AM +1000, Benjamin Herrenschmidt wrote:
[snip]
> That current hack won't work well if two devices share an iommu. Note
> that we have an additional constraint here due to our paravirt
> interfaces (specificed in PAPR) which is that PE domains must have a
> common parent. Basically, pHyp makes them look like a PCIe host bridge
> per domain in the guest. I think that's a pretty good idea and qemu
> might want to do the same.
> 
> - We hack out the currently unconditional mapping of the entire guest
> space in the iommu. Something will have to be done to "decide" whether
> to do that or not ... qemu argument -> ioctl ?

Not quite.  We already require the not-yet-upstream patches which add
guest-side (emulated) IOMMU support to qemu.  The approach we're using
for the passthrough (or at least will when I fix up my patches again)
is that we only map all guest ram into the vfio iommu if and only if
there is no guest visible iommu advertised in the qdev.

This kind of makes sense - if there is no iommu from the guest
perspective, the guest will expect to see all its physical memory 1:1
in DMA.

The hacky bit is that when there *is* a guest visible iommu, it's
assumed that whatever interface the guest iommu uses is somehow wired
up to vfio map/unmap calls.  For us at the moment, this means
passthrough devices for us must be assigned to a special (guest) pci
domain which sets up a suitable wires up the paravirt iommu to the vfio iommu.

In theory under some circumstances, with full emu, you could wire up
an emulated guest iommu interface to a different host iommu
implementation via this mechanism.  However that wouldn't work if the
guest and host iommus capabilities are too different, and in any case
would require considerable extra abstraction work on the qemu guest
iommu code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
