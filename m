Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 88FA1B71D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Aug 2011 00:39:47 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Aug 2011 08:39:37 -0600
In-Reply-To: <1312248479.8793.827.camel@pasglop>
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
	<1312248479.8793.827.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312295979.2653.408.camel@bling.home>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>, Avi Kivity <avi@redhat.com>,
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

On Tue, 2011-08-02 at 11:27 +1000, Benjamin Herrenschmidt wrote:
> It's a shared address space. With a basic configuration on p7ioc for
> example we have MMIO going from 3G to 4G (PCI side addresses). BARs
> contain the normal PCI address there. But that 1G is divided in 128
> segments of equal size which can separately be assigned to PE#'s.
> 
> So BARs are allocated by firmware or the kernel PCI code so that devices
> in different PEs don't share segments.
> 
> Of course there's always the risk that a device can be hacked via a
> sideband access to BARs to move out of it's allocated segment. That
> means that the guest owning that device won't be able to access it
> anymore and can potentially disturb a guest or host owning whatever is
> in that other segment.

Wait, what?  I thought the MMIO segments were specifically so that if
the device BARs moved out of the segment the guest only hurts itself and
not the new segments overlapped.

> The only way to enforce isolation here is to ensure that PE# are
> entirely behind P2P bridges, since those would then ensure that even if
> you put crap into your BARs you won't be able to walk over a neighbour.

Ok, so the MMIO segments are really just a configuration nuance of the
platform and being behind a P2P bridge is what allows you to hand off
BARs to a guest (which needs to know the bridge window to do anything
useful with them).  Is that right?

> I believe pHyp enforces that, for example, if you have a slot, all
> devices & functions behind that slot pertain to the same PE# under pHyp.
> 
> That means you cannot put individual functions of a device into
> different PE# with pHyp.
> 
> We plan to be a bit less restrictive here for KVM, assuming that if you
> use a device that allows such a back-channel to the BARs, then it's your
> problem to not trust such a device for virtualization. And most of the
> time, you -will- have a P2P to protect you anyways.
> 
> The problem doesn't exist (or is assumed as non-existing) for SR-IOV
> since in that case, the VFs are meant to be virtualized, so pHyp assumes
> there is no such back-channel and it can trust them to be in different
> PE#.

But you still need the P2P bridge to protect MMIO segments?  Or do
SR-IOV BARs need to be virtualized?  I'm having trouble with the mental
model of how you can do both.  Thanks,

Alex
