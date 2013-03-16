Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 25C6B2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 16:37:42 +1100 (EST)
Message-ID: <1363412256.1244.20.camel@pasglop>
Subject: Re: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 16 Mar 2013 06:37:36 +0100
In-Reply-To: <20130316013417.GA3873@shangw.(null)>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
 <1363375740.16793.12.camel@ul30vt.home>
 <20130316013417.GA3873@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-03-16 at 09:34 +0800, Gavin Shan wrote:
> >Could you explain further how this will be used?  How the device is
> >exposed to a guest is entirely a userspace construct, so why does vfio
> >need to know or care about this?  I had assumed for AER that QEMU would
> >do the translation from host to guest address space.
> >
> 
> The weak IOCTL function (vfio_pci_arch_ioctl) was introduced by previous
> patch. The PowerNV platform is going to override it to figure out the
> information for EEH core to use. On the other hand, QEMU will runs into
> the IOCTL command while opening (creating) one VFIO device.
> 
> Though I'm not familiar with AER very much. AER is quite different from
> EEH. The EEH functionality implemented in PHB instead of in PCI device
> core. So we don't care AER stuff in EEH directly :-)

To give Alex a bit more background...

EEH is our IBM specific error handling facility which is a superset of AER.

IE. In addition to AER's error detection and logging, it adds a layer of
error detection at the host bridge level (such as iommu violations etc...)
and a mechanism for handling and recovering from errors. This is tied to
our iommu domain stuff (our PE's) and our device "freezing" capability
among others.

With VFIO + KVM, we want to implement most of the EEH support for guests in
the host kernel. The reason is multipart and we can discuss this separately
as some of it might well be debatable (mostly it's more convenient that way
because we hook into the underlying HW/FW EEH which isn't directly userspace
accessible so we don't have to add a new layer of kernel -> user API in
addition to the VFIO stuff), but there's at least one aspect of it that drives
this requirement more strongly which is performance:

When EEH is enabled, whenever any MMIO returns all 1's, the kernel will do
a firmware call to query the EEH state of the device and check whether it
has been frozen. On some devices, that can be a performance issue, and
going all the way to qemu for that would be horribly expensive.

So we want at least a way to handle that call in the kernel and for that we
need at least some way of mapping things there.

Cheers,
Ben.
