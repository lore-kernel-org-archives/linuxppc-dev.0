Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXb8V54rkzDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:56:10 +1000 (AEST)
Date: Wed, 16 Aug 2017 10:56:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Robin Murphy  <robin.murphy@arm.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger
 <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Jike Song
 <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel
 <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, David
 Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Neo Jia
 <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>, Vlad Tsyrklevich
 <vlad@tsyrklevich.net>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
Message-ID: <20170816105602.57fd1dcc@w520.home>
In-Reply-To: <1502843749.4493.67.camel@kernel.crashing.org>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
 <20170815103717.3b64e10c@w520.home>
 <1502843749.4493.67.camel@kernel.crashing.org>
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

On Wed, 16 Aug 2017 10:35:49 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2017-08-15 at 10:37 -0600, Alex Williamson wrote:
> > Of course I don't think either of those are worth imposing a
> > performance penalty where we don't otherwise need one.  However, if we
> > look at a VM scenario where the guest is following the PCI standard for
> > programming MSI-X interrupts (ie. not POWER), we need some mechanism to
> > intercept those MMIO writes to the vector table and configure the host
> > interrupt domain of the device rather than allowing the guest direct
> > access.  This is simply part of virtualizing the device to the guest.
> > So even if the kernel allows mmap'ing the vector table, the hypervisor
> > needs to trap it, so the mmap isn't required or used anyway.  It's only
> > when you define a non-PCI standard for your guest to program
> > interrupts, as POWER has done, and can therefore trust that the
> > hypervisor does not need to trap on the vector table that having that
> > mmap'able vector table becomes fully useful.  AIUI, ARM supports 64k
> > pages too... does ARM have any strategy that would actually make it
> > possible to make use of an mmap covering the vector table?  Thanks,  
> 
> WTF ???? Alex, can you stop once and for all with all that "POWER is
> not standard" bullshit please ? It's completely wrong.

As you've stated, the MSI-X vector table on POWER is currently updated
via a hypercall.  POWER is overall PCI compliant (I assume), but the
guest does not directly modify the vector table in MMIO space of the
device.  This is important...

> This has nothing to do with PCIe standard !

Yes, it actually does, because if the guest relies on the vector table
to be virtualized then it doesn't particularly matter whether the
vfio-pci kernel driver allows that portion of device MMIO space to be
directly accessed or mapped because QEMU needs for it to be trapped in
order to provide that virtualization.

I'm not knocking POWER, it's a smart thing for virtualization to have
defined this hypercall which negates the need for vector table
virtualization and allows efficient mapping of the device.  On other
platform, it's not necessarily practical given the broad base of legacy
guests supported where we'd never get agreement to implement this as
part of the platform spec... if there even was such a thing.  Maybe we
could provide the hypercall and dynamically enable direct vector table
mapping (disabling vector table virtualization) only if the hypercall
is used.

> The PCIe standard says strictly *nothing* whatsoever about how an OS
> obtains the magic address/values to put in the device and how the PCIe
> host bridge may do appropriate fitering.

And now we've jumped the tracks...  The only way the platform specific
address/data values become important is if we allow direct access to
the vector table AND now we're formulating how the user/guest might
write to it directly.  Otherwise the virtualization of the vector
table, or paravirtualization via hypercall provides the translation
where the host and guest address/data pairs can operate in completely
different address spaces.

> There is nothing on POWER that prevents the guest from writing the MSI-
> X address/data by hand. The problem isn't who writes the values or even
> how. The problem breaks down into these two things that are NOT covered
> by any aspect of the PCIe standard:

You've moved on to a different problem, I think everyone aside from
POWER is still back at the problem where who writes the vector table
values is a forefront problem.
 
>   1- The OS needs to obtain address/data values for an MSI that will
> "work" for the device.
> 
>   2- The HW+HV needs to prevent collateral damage caused by a device
> issuing stores to incorrect address or with incorrect data. Now *this*
> is necessary for *ANY* kind of DMA whether it's an MSI or something
> else anyway.
> 
> Now, the filtering done by qemu is NOT a reasonable way to handle 2)
> and whatever excluse about "making it harder" doesn't fly a meter when
> it comes to security. Making it "harder to break accidentally" I also
> don't buy, people don't just randomly put things in their MSI-X tables
> "accidentally", that stuff works or doesn't.

As I said before, I'm not willing to preserve the weak attributes that
blocking direct vector table access provides over pursuing a more
performant interface, but I also don't think their value is absolute
zero either.

> That leaves us with 1). Now this is purely a platform specific matters,
> not a spec matter. Once the HW has a way to enforce you can only
> generate "allowed" MSIs it becomes a matter of having some FW mechanism
> that can be used to informed the OS what address/values to use for a
> given interrupts.
> 
> This is provided on POWER by a combination of device-tree and RTAS. It
> could be that x86/ARM64 doesn't provide good enough mechanisms via ACPI
> but this is no way a problem of standard compliance, just inferior
> firmware interfaces.

Firmware pissing match...  Processors running with 8k or less page size
fall within the recommendations of the PCI spec for register alignment
of MMIO regions of the device and this whole problem becomes less of an
issue.

> So again, for the 234789246th time in years, can we get that 1-bit-of-
> information sorted one way or another so we can fix our massive
> performance issue instead of adding yet another dozen layers of paint
> on that shed ?

TBH, I'm not even sure which bikeshed we're looking at with this latest
distraction of interfaces through which the user/guest could discover
viable address/data values to write the vector table directly.  Thanks,

Alex
