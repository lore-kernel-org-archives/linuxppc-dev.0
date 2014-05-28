Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20E061A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 08:46:35 +1000 (EST)
Message-ID: <53866747.50703@suse.de>
Date: Thu, 29 May 2014 00:46:31 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>	
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>	
 <1401214527.3289.611.camel@ul30vt.home> <20140528005532.GA5528@shangw>	
 <5385CB6F.50300@suse.de> <20140528124947.GA19346@shangw>
 <1401314311.8262.26.camel@pasglop>
In-Reply-To: <1401314311.8262.26.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.05.14 23:58, Benjamin Herrenschmidt wrote:
> On Wed, 2014-05-28 at 22:49 +1000, Gavin Shan wrote:
>> I will remove those "address" related macros in next revision because it's
>> user-level bussiness, not related to host kernel any more.
>>
>> If the user is QEMU + guest, we need the address to identify the PE though PHB
>> BUID could be used as same purpose to get PHB, which is one-to-one mapping with
>> IOMMU group on sPAPR platform. However, once the PE address is built and returned
>> to guest, guest will use the PE address as input parameter in subsequent RTAS
>> calls.
>>
>> If the user is some kind of application who just uses the ioctl() without supporting
>> RTAS calls. We don't need care about PE address.
> I am a bit reluctant with that PE==PHB equation we seem to be introducing.
>
> This isn't the case in HW. It's possible that this is how we handle VFIO *today*
> in qemu but it doesn't have to be does it ?

Right, but that's pure QEMU internals. From the VFIO kernel interface's 
point of view, a VFIO group is a PE context, as that's what gets IOMMU 
controlled together too.

> It also paints us into a corner if we want to start implementing some kind of
> emulated EEH for selected emulated devices and/or virtio.

I don't think so :). In QEMU the PHB emulation would have to notify the 
"container" (IOMMU emulation layer -> PE) that a PE operation happened. 
It's that emulation code's responsibility to broadcast operations across 
its own emulated operations (recover config space access, reconfigure 
BARs, etc) and the VFIO PE operations.

So from a kernel interface point of view, I think leaving out any 
address information is the right way to go. Whether we managed to get 
all QEMU internal interfaces modeled correctly yet has to be seen on the 
next patch set revision :).


Alex
