Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69DB41A11B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 09:48:37 +1100 (AEDT)
Message-ID: <1450392501.5445.11.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 3/3] vfio-pci: Allow to mmap MSI-X table if EEH is
 supported
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>, yongji xie
 <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru, paulus@samba.org, mpe@ellerman.id.au,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com
Date: Fri, 18 Dec 2015 09:48:21 +1100
In-Reply-To: <1450388499.2674.153.camel@redhat.com>
References: <1449823994-3356-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1449823994-3356-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1450296869.2674.62.camel@redhat.com> <5672906C.5010708@linux.vnet.ibm.com>
 <1450388499.2674.153.camel@redhat.com>
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

On Thu, 2015-12-17 at 14:41 -0700, Alex Williamson wrote:
> > So I think it is safe to mmap/passthrough MSI-X table on PPC64
> > platform.
> > And I'm not sure whether other architectures can ensure these two 
> > points. 
> 
> There is another consideration, which is the API exposed to the user.
>  vfio currently enforces interrupt setup through ioctls by making the
> PCI mechanisms for interrupt programming inaccessible through the
> device regions.  Ignoring that you are only focused on PPC64 with QEMU,
> does it make sense for the vfio API to allow a user to manipulate
> interrupt programming in a way that not only will not work, but in a
> way that we expect to fail and require error isolation to recover from?
>  I can't say I'm fully convinced that a footnote in the documentation
> is sufficient for that.  Thanks,

Well, one could argue that the "isolation" provided by qemu here is
fairly weak anyway ;-)

I mean. .. how do you know the device doesn't have a backdoor path into
that table via some other MMIO registers anyway ?

In any case, the HW isolation on platforms like pseries means that the
worst the guest can do si shoot itself in the foot. Big deal. On the
other hand, not bothering with intercepting the table has benefits,
such as reducing the memory region clutter, but also removing all the
massive performacne problems we see because adapters have critical
registers in the same 64K page as the MSI-X table.

So I don't think there is any question here that we *need* that
functionality in power. The filtering of the table by Qemu doesn't
provide any practical benefit, it just gets in the way.

Cheers,
Ben.
