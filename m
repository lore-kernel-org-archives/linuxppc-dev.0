Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 952F5140E6A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 14:26:28 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 6 May 2014 14:26:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0555B2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 14:26:24 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4645Fhe7602436
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 14:05:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s464QNZg014652
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 14:26:23 +1000
Date: Tue, 6 May 2014 14:26:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 00/22] EEH Support for VFIO PCI devices on PowerKVM
 guest
Message-ID: <20140506042622.GA24228@shangw>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53677C6C.8060508@suse.de> <1399298412.24318.521.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399298412.24318.521.camel@ul30vt.home>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 05, 2014 at 08:00:12AM -0600, Alex Williamson wrote:
>On Mon, 2014-05-05 at 13:56 +0200, Alexander Graf wrote:
>> On 05/05/2014 03:27 AM, Gavin Shan wrote:
>> > The series of patches intends to support EEH for PCI devices, which have been
>> > passed through to PowerKVM based guest via VFIO. The implementation is
>> > straightforward based on the issues or problems we have to resolve to support
>> > EEH for PowerKVM based guest.
>> >
>> > - Emulation for EEH RTAS requests. Thanksfully, we already have infrastructure
>> >    to emulate XICS. Without introducing new mechanism, we just extend that
>> >    existing infrastructure to support EEH RTAS emulation. EEH RTAS requests
>> >    initiated from guest are posted to host where the requests get handled or
>> >    delivered to underly firmware for further handling. For that, the host kerenl
>> >    has to maintain the PCI address (host domain/bus/slot/function to guest's
>> >    PHB BUID/bus/slot/function) mapping via KVM VFIO device. The address mapping
>> >    will be built when initializing VFIO device in QEMU and destroied when the
>> >    VFIO device in QEMU is going to offline, or VM is destroy.
>> 
>> Do you also expose all those interfaces to user space? VFIO is as much 
>> about user space device drivers as it is about device assignment.
>> 

Yep, all the interfaces are exported to user space. 

>> I would like to first see an implementation that doesn't touch KVM 
>> emulation code at all but instead routes everything through QEMU. As a 
>> second step we can then accelerate performance critical paths inside of KVM.
>> 

Ok. I'll change the implementation. However, the QEMU still has to
poll/push information from/to host kerenl. So the best place for that
would be tce_iommu_driver_ops::ioctl as EEH is Power specific feature.

For the error injection, I guess I have to put the logic token management
into QEMU and error injection request will be handled by QEMU and then
routed to host kernel via additional syscall as we did for pSeries.

>> That way we ensure that user space device drivers have all the power 
>> over a device they need to drive it.
>
>+1
>

Thanks,
Gavin
