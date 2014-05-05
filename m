Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 71A88140325
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 00:04:40 +1000 (EST)
Message-ID: <1399298412.24318.521.camel@ul30vt.home>
Subject: Re: [PATCH RFC 00/22] EEH Support for VFIO PCI devices on PowerKVM
 guest
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexander Graf <agraf@suse.de>
Date: Mon, 05 May 2014 08:00:12 -0600
In-Reply-To: <53677C6C.8060508@suse.de>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53677C6C.8060508@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-05 at 13:56 +0200, Alexander Graf wrote:
> On 05/05/2014 03:27 AM, Gavin Shan wrote:
> > The series of patches intends to support EEH for PCI devices, which have been
> > passed through to PowerKVM based guest via VFIO. The implementation is
> > straightforward based on the issues or problems we have to resolve to support
> > EEH for PowerKVM based guest.
> >
> > - Emulation for EEH RTAS requests. Thanksfully, we already have infrastructure
> >    to emulate XICS. Without introducing new mechanism, we just extend that
> >    existing infrastructure to support EEH RTAS emulation. EEH RTAS requests
> >    initiated from guest are posted to host where the requests get handled or
> >    delivered to underly firmware for further handling. For that, the host kerenl
> >    has to maintain the PCI address (host domain/bus/slot/function to guest's
> >    PHB BUID/bus/slot/function) mapping via KVM VFIO device. The address mapping
> >    will be built when initializing VFIO device in QEMU and destroied when the
> >    VFIO device in QEMU is going to offline, or VM is destroy.
> 
> Do you also expose all those interfaces to user space? VFIO is as much 
> about user space device drivers as it is about device assignment.
> 
> I would like to first see an implementation that doesn't touch KVM 
> emulation code at all but instead routes everything through QEMU. As a 
> second step we can then accelerate performance critical paths inside of KVM.
> 
> That way we ensure that user space device drivers have all the power 
> over a device they need to drive it.

+1
