Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5A161A06C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 13:44:12 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id p10so469586pdj.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 20:44:09 -0700 (PDT)
Message-ID: <5387FE84.5060502@ozlabs.ru>
Date: Fri, 30 May 2014 13:44:04 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
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
Content-Type: text/plain; charset=KOI8-R
Cc: qiudayu@linux.vnet.ibm.com, Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2014 07:58 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2014-05-28 at 22:49 +1000, Gavin Shan wrote:
>>
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
> 
> I am a bit reluctant with that PE==PHB equation we seem to be introducing.
>
> This isn't the case in HW.

It is pseries, not real HW. Does phyp allow multiple real host PEs on the
same virtual PHB?


> It's possible that this is how we handle VFIO *today*
> in qemu but it doesn't have to be does it ?
> 
> It also paints us into a corner if we want to start implementing some kind of
> emulated EEH for selected emulated devices and/or virtio.




-- 
Alexey
