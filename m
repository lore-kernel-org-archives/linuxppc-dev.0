Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A8E29140316
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 21:56:33 +1000 (EST)
Message-ID: <53677C6C.8060508@suse.de>
Date: Mon, 05 May 2014 13:56:28 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 00/22] EEH Support for VFIO PCI devices on PowerKVM
 guest
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, kvm-ppc@vger.kernel.org,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/2014 03:27 AM, Gavin Shan wrote:
> The series of patches intends to support EEH for PCI devices, which have been
> passed through to PowerKVM based guest via VFIO. The implementation is
> straightforward based on the issues or problems we have to resolve to support
> EEH for PowerKVM based guest.
>
> - Emulation for EEH RTAS requests. Thanksfully, we already have infrastructure
>    to emulate XICS. Without introducing new mechanism, we just extend that
>    existing infrastructure to support EEH RTAS emulation. EEH RTAS requests
>    initiated from guest are posted to host where the requests get handled or
>    delivered to underly firmware for further handling. For that, the host kerenl
>    has to maintain the PCI address (host domain/bus/slot/function to guest's
>    PHB BUID/bus/slot/function) mapping via KVM VFIO device. The address mapping
>    will be built when initializing VFIO device in QEMU and destroied when the
>    VFIO device in QEMU is going to offline, or VM is destroy.

Do you also expose all those interfaces to user space? VFIO is as much 
about user space device drivers as it is about device assignment.

I would like to first see an implementation that doesn't touch KVM 
emulation code at all but instead routes everything through QEMU. As a 
second step we can then accelerate performance critical paths inside of KVM.

That way we ensure that user space device drivers have all the power 
over a device they need to drive it.


Alex
