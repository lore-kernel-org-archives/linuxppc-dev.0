Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 077811A1AC1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 08:41:43 +1100 (AEDT)
Message-ID: <1450388499.2674.153.camel@redhat.com>
Subject: Re: [RFC PATCH 3/3] vfio-pci: Allow to mmap MSI-X table if EEH is
 supported
From: Alex Williamson <alex.williamson@redhat.com>
To: yongji xie <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Date: Thu, 17 Dec 2015 14:41:39 -0700
In-Reply-To: <5672906C.5010708@linux.vnet.ibm.com>
References: <1449823994-3356-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1449823994-3356-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1450296869.2674.62.camel@redhat.com> <5672906C.5010708@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-12-17 at 18:37 +0800, yongji xie wrote:
> 
> On 2015/12/17 4:14, Alex Williamson wrote:
> > On Fri, 2015-12-11 at 16:53 +0800, Yongji Xie wrote:
> > > Current vfio-pci implementation disallows to mmap MSI-X table in
> > > case that user get to touch this directly.
> > > 
> > > However, EEH mechanism could ensure that a given pci device
> > > can only shoot the MSIs assigned for its PE and guest kernel also
> > > would not write to MSI-X table in pci_enable_msix() because
> > > para-virtualization on PPC64 platform. So MSI-X table is safe to
> > > access directly from the guest with EEH mechanism enabled.
> > The MSI-X table is paravirtualized on vfio in general and interrupt
> > remapping theoretically protects against errant interrupts, so why
> > is
> > this PPC64 specific?  We have the same safeguards on x86 if we want
> > to
> > decide they're sufficient.  Offhand, the only way I can think that
> > a
> > device can touch the MSI-X table is via backdoors or p2p DMA with
> > another device.
> Maybe I didn't make my point clear. The reasons why we can mmap MSI-X
> table on PPC64 are：
> 
> 1. EEH mechanism could ensure that a given pci device can only shoot
> the MSIs assigned for its PE. So it would not do harm to other memory
> space when the guest write a garbage MSI-X address/data to the vector
> table
> if we passthough MSI-X tables to guest.

Interrupt remapping does the same on x86.

> 2. The guest kernel would not write to MSI-X table on PPC64 platform
> when device drivers call pci_enable_msix() to initialize MSI-X
> interrupts.

This is irrelevant to the vfio API.  vfio is a userspace driver
interface, QEMU is just one possible consumer of the interface.  Even
in the case of PPC64 & QEMU, the guest is still capable of writing to
the vector table, it just probably won't.

> So I think it is safe to mmap/passthrough MSI-X table on PPC64
> platform.
> And I'm not sure whether other architectures can ensure these two 
> points. 

There is another consideration, which is the API exposed to the user.
 vfio currently enforces interrupt setup through ioctls by making the
PCI mechanisms for interrupt programming inaccessible through the
device regions.  Ignoring that you are only focused on PPC64 with QEMU,
does it make sense for the vfio API to allow a user to manipulate
interrupt programming in a way that not only will not work, but in a
way that we expect to fail and require error isolation to recover from?
 I can't say I'm fully convinced that a footnote in the documentation
is sufficient for that.  Thanks,

Alex
