Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A003D2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 15:45:17 +1100 (EST)
Message-ID: <1363668309.18880.10.camel@pasglop>
Subject: Re: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 19 Mar 2013 05:45:09 +0100
In-Reply-To: <1363666721.24132.472.camel@bling.home>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
 <1363375740.16793.12.camel@ul30vt.home>
 <20130316013417.GA3873@shangw.(null)> <1363412256.1244.20.camel@pasglop>
 <1363640474.24132.433.camel@bling.home>
 <20130319032410.GA22591@shangw.(null)>
 <1363666721.24132.472.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-03-18 at 22:18 -0600, Alex Williamson wrote:
> > Yes, EEH firmware call needn't going through VFIO. However, EEH has
> > very close relationship with PCI and so VFIO-PCI does. Eventually, EEH
> > has close relationship with VFIO-PCI :-)
> 
> Is there some plan to do more with EEH through VFIO in the future or are
> we just talking about some kind of weird associative property to sell
> this ioctl?  Thanks,

Well, I'm not sure how 'weird' that is but it makes sense to me... VFIO
is the mechanism that virtualizes access to a PCI device and provides
interfaces to qemu & kvm to access it &| map it.

Or rather VFIO-PCI is.

At a basic level it provides ... the basic PCI interfaces, ie, config
space access (with or without filtering), interrupts, etc...

In our environment, EEH is just another functionality of PCI really.
The firmware calls used by the guest to do that fall into more or less
the same category as the ones used for PCI config space accesses,
manipulation of DMA windows, etc... Similar to host (though guest
and host use a different FW interface for various reasons).

So it's very natural to "transport" these via VFIO-PCI like everything
else, I don't see a more natural place to put the ioctl's we need for
qemu to be able to access the EEH state, trigger EEH (un)isolation,
resets, etc...

Fundamentally, the design should be for VFIO-PCI to provide some specific
ioctls for EEH that userspace programs such as qemu can use, and then
re-expose those APIs to the guest.

In addition, to do some of it in the kernel for performance reason, we
want to establish that mapping, but I see that as a VFIO "accelerator".

IE. Whatever is going to respond to the EEH calls from the guest in-kernel
will have to share state with the rest of the EEH stuff provided to qemu
by vfio-pci.

Ben.
