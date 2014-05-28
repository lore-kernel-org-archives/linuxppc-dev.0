Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 285F61A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 07:58:42 +1000 (EST)
Message-ID: <1401314311.8262.26.camel@pasglop>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Thu, 29 May 2014 07:58:31 +1000
In-Reply-To: <20140528124947.GA19346@shangw>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home> <20140528005532.GA5528@shangw>
 <5385CB6F.50300@suse.de> <20140528124947.GA19346@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-28 at 22:49 +1000, Gavin Shan wrote:
> 
> I will remove those "address" related macros in next revision because it's
> user-level bussiness, not related to host kernel any more.
> 
> If the user is QEMU + guest, we need the address to identify the PE though PHB
> BUID could be used as same purpose to get PHB, which is one-to-one mapping with
> IOMMU group on sPAPR platform. However, once the PE address is built and returned
> to guest, guest will use the PE address as input parameter in subsequent RTAS
> calls.
> 
> If the user is some kind of application who just uses the ioctl() without supporting
> RTAS calls. We don't need care about PE address. 

I am a bit reluctant with that PE==PHB equation we seem to be introducing.

This isn't the case in HW. It's possible that this is how we handle VFIO *today*
in qemu but it doesn't have to be does it ?

It also paints us into a corner if we want to start implementing some kind of
emulated EEH for selected emulated devices and/or virtio.

Cheers,
Ben.
