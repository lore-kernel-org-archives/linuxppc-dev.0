Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xX9Qk2Rp5zDqfx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 10:37:02 +1000 (AEST)
Message-ID: <1502843749.4493.67.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>, Robin Murphy
 <robin.murphy@arm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger
 <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Jike Song
 <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel
 <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, David
 Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Neo Jia
 <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>, Vlad Tsyrklevich
 <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Aug 2017 10:35:49 +1000
In-Reply-To: <20170815103717.3b64e10c@w520.home>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
 <20170815103717.3b64e10c@w520.home>
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

On Tue, 2017-08-15 at 10:37 -0600, Alex Williamson wrote:
> Of course I don't think either of those are worth imposing a
> performance penalty where we don't otherwise need one.  However, if we
> look at a VM scenario where the guest is following the PCI standard for
> programming MSI-X interrupts (ie. not POWER), we need some mechanism to
> intercept those MMIO writes to the vector table and configure the host
> interrupt domain of the device rather than allowing the guest direct
> access.  This is simply part of virtualizing the device to the guest.
> So even if the kernel allows mmap'ing the vector table, the hypervisor
> needs to trap it, so the mmap isn't required or used anyway.  It's only
> when you define a non-PCI standard for your guest to program
> interrupts, as POWER has done, and can therefore trust that the
> hypervisor does not need to trap on the vector table that having that
> mmap'able vector table becomes fully useful.  AIUI, ARM supports 64k
> pages too... does ARM have any strategy that would actually make it
> possible to make use of an mmap covering the vector table?  Thanks,

WTF ???? Alex, can you stop once and for all with all that "POWER is
not standard" bullshit please ? It's completely wrong.

This has nothing to do with PCIe standard !

The PCIe standard says strictly *nothing* whatsoever about how an OS
obtains the magic address/values to put in the device and how the PCIe
host bridge may do appropriate fitering.

There is nothing on POWER that prevents the guest from writing the MSI-
X address/data by hand. The problem isn't who writes the values or even
how. The problem breaks down into these two things that are NOT covered
by any aspect of the PCIe standard:

  1- The OS needs to obtain address/data values for an MSI that will
"work" for the device.

  2- The HW+HV needs to prevent collateral damage caused by a device
issuing stores to incorrect address or with incorrect data. Now *this*
is necessary for *ANY* kind of DMA whether it's an MSI or something
else anyway.

Now, the filtering done by qemu is NOT a reasonable way to handle 2)
and whatever excluse about "making it harder" doesn't fly a meter when
it comes to security. Making it "harder to break accidentally" I also
don't buy, people don't just randomly put things in their MSI-X tables
"accidentally", that stuff works or doesn't.

That leaves us with 1). Now this is purely a platform specific matters,
not a spec matter. Once the HW has a way to enforce you can only
generate "allowed" MSIs it becomes a matter of having some FW mechanism
that can be used to informed the OS what address/values to use for a
given interrupts.

This is provided on POWER by a combination of device-tree and RTAS. It
could be that x86/ARM64 doesn't provide good enough mechanisms via ACPI
but this is no way a problem of standard compliance, just inferior
firmware interfaces.

So again, for the 234789246th time in years, can we get that 1-bit-of-
information sorted one way or another so we can fix our massive
performance issue instead of adding yet another dozen layers of paint
on that shed ?

Ben.
