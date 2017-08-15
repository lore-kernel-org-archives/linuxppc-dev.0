Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWypR62X6zDr3L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 02:37:29 +1000 (AEST)
Date: Tue, 15 Aug 2017 10:37:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger
 <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Jike Song
 <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel
 <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse
 <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>, Mauricio
 Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Neo Jia <cjia@nvidia.com>,
 Paul Mackerras <paulus@samba.org>, Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
Message-ID: <20170815103717.3b64e10c@w520.home>
In-Reply-To: <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 14 Aug 2017 14:12:33 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 14/08/17 10:45, Alexey Kardashevskiy wrote:
> > Folks,
> > 
> > Is there anything to change besides those compiler errors and David's
> > comment in 5/5? Or the while patchset is too bad? Thanks.  
> 
> While I now understand it's not the low-level thing I first thought it
> was, so my reasoning has changed, personally I don't like this approach
> any more than the previous one - it still smells of abusing external
> APIs to pass information from one part of VFIO to another (and it has
> the same conceptual problem of attributing something to interrupt
> sources that is actually a property of the interrupt target).
> 
> Taking a step back, though, why does vfio-pci perform this check in the
> first place? If a malicious guest already has control of a device, any
> kind of interrupt spoofing it could do by fiddling with the MSI-X
> message address/data it could simply do with a DMA write anyway, so the
> security argument doesn't stand up in general (sure, not all PCIe
> devices may be capable of arbitrary DMA, but that seems like more of a
> tenuous security-by-obscurity angle to me). Besides, with Type1 IOMMU
> the fact that we've let a device be assigned at all means that this is
> already a non-issue (because either the hardware provides isolation or
> the user has explicitly accepted the consequences of an unsafe
> configuration) - from patch #4 that's apparently the same for SPAPR TCE,
> in which case it seems this flag doesn't even need to be propagated and
> could simply be assumed always.
> 
> On the other hand, if the check is not so much to mitigate malicious
> guests attacking the system as to prevent dumb guests breaking
> themselves (e.g. if some or all of the MSI-X capability is actually
> emulated), then allowing things to sometimes go wrong on the grounds of
> an irrelevant hardware feature doesn't seem correct :/

While the theoretical security provided by preventing direct access to
the MSI-X vector table may be mostly a matter of obfuscation, in
practice, I think it changes the problem of creating arbitrary DMA
writes from a generic, trivial, PCI spec based exercise to a more device
specific challenge.  I do however have evidence that there are
consumers of the vfio API who would have attempted to program device
interrupts by directly manipulating the vector table had they not been
prevented from doing so and contacting me to learn about the SET_IRQ
ioctl.  Therefore I think the behavior also contributes to making the
overall API more difficult to use incorrectly.

Of course I don't think either of those are worth imposing a
performance penalty where we don't otherwise need one.  However, if we
look at a VM scenario where the guest is following the PCI standard for
programming MSI-X interrupts (ie. not POWER), we need some mechanism to
intercept those MMIO writes to the vector table and configure the host
interrupt domain of the device rather than allowing the guest direct
access.  This is simply part of virtualizing the device to the guest.
So even if the kernel allows mmap'ing the vector table, the hypervisor
needs to trap it, so the mmap isn't required or used anyway.  It's only
when you define a non-PCI standard for your guest to program
interrupts, as POWER has done, and can therefore trust that the
hypervisor does not need to trap on the vector table that having that
mmap'able vector table becomes fully useful.  AIUI, ARM supports 64k
pages too... does ARM have any strategy that would actually make it
possible to make use of an mmap covering the vector table?  Thanks,

Alex
