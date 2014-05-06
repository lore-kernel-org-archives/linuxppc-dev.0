Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D8221412DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 16:56:42 +1000 (EST)
Message-ID: <536887A3.30703@suse.de>
Date: Tue, 06 May 2014 08:56:35 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 00/22] EEH Support for VFIO PCI devices on PowerKVM
 guest
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53677C6C.8060508@suse.de> <1399298412.24318.521.camel@ul30vt.home>
 <20140506042622.GA24228@shangw>
In-Reply-To: <20140506042622.GA24228@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, kvm-ppc@vger.kernel.org,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06.05.14 06:26, Gavin Shan wrote:
> On Mon, May 05, 2014 at 08:00:12AM -0600, Alex Williamson wrote:
>> On Mon, 2014-05-05 at 13:56 +0200, Alexander Graf wrote:
>>> On 05/05/2014 03:27 AM, Gavin Shan wrote:
>>>> The series of patches intends to support EEH for PCI devices, which have been
>>>> passed through to PowerKVM based guest via VFIO. The implementation is
>>>> straightforward based on the issues or problems we have to resolve to support
>>>> EEH for PowerKVM based guest.
>>>>
>>>> - Emulation for EEH RTAS requests. Thanksfully, we already have infrastructure
>>>>     to emulate XICS. Without introducing new mechanism, we just extend that
>>>>     existing infrastructure to support EEH RTAS emulation. EEH RTAS requests
>>>>     initiated from guest are posted to host where the requests get handled or
>>>>     delivered to underly firmware for further handling. For that, the host kerenl
>>>>     has to maintain the PCI address (host domain/bus/slot/function to guest's
>>>>     PHB BUID/bus/slot/function) mapping via KVM VFIO device. The address mapping
>>>>     will be built when initializing VFIO device in QEMU and destroied when the
>>>>     VFIO device in QEMU is going to offline, or VM is destroy.
>>> Do you also expose all those interfaces to user space? VFIO is as much
>>> about user space device drivers as it is about device assignment.
>>>
> Yep, all the interfaces are exported to user space.
>
>>> I would like to first see an implementation that doesn't touch KVM
>>> emulation code at all but instead routes everything through QEMU. As a
>>> second step we can then accelerate performance critical paths inside of KVM.
>>>
> Ok. I'll change the implementation. However, the QEMU still has to
> poll/push information from/to host kerenl. So the best place for that
> would be tce_iommu_driver_ops::ioctl as EEH is Power specific feature.
>
> For the error injection, I guess I have to put the logic token management
> into QEMU and error injection request will be handled by QEMU and then
> routed to host kernel via additional syscall as we did for pSeries.

Yes, start off without in-kernel XICS so everything simply lives in 
QEMU. Then add callbacks into the in-kernel XICS to inject these 
interrupts if we don't have wide enough interfaces already.



Alex
