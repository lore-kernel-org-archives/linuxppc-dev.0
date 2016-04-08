Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhDJq4rtjzDqZ0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 19:13:15 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id zy2so8696874pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Apr 2016 02:13:15 -0700 (PDT)
Subject: Re: [PATCH kernel 9/9] KVM: PPC: VFIO device: support SPAPR TCE
To: David Gibson <david@gibson.dropbear.id.au>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-10-git-send-email-aik@ozlabs.ru>
 <20160309054544.GM22546@voom.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <57077622.4000002@ozlabs.ru>
Date: Fri, 8 Apr 2016 19:13:06 +1000
MIME-Version: 1.0
In-Reply-To: <20160309054544.GM22546@voom.fritz.box>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2016 04:45 PM, David Gibson wrote:

>> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
>> index 7f7b6d8..71f577c 100644
>> --- a/arch/powerpc/kvm/Makefile
>> +++ b/arch/powerpc/kvm/Makefile
>> @@ -8,7 +8,7 @@ ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
>>   KVM := ../../../virt/kvm
>>
>>   common-objs-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
>> -		$(KVM)/eventfd.o $(KVM)/vfio.o
>> +		$(KVM)/eventfd.o
>
> Please don't disable the VFIO device for the non-book3s case.  I added
> it (even though it didn't do anything until now) so that libvirt
> wouldn't choke when it finds it's not available.  Obviously the new
> ioctl needs to be only for the right IOMMU setup, but the device
> itself should be available always.


After having a closer look, the statement above does not enable VFIO KVM 
device on book3s but does for everything else:


common-objs-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
[...]
kvm-e500-objs := \
         $(common-objs-y) \
[...]
kvm-objs-$(CONFIG_KVM_E500V2) := $(kvm-e500-objs)
[...]
kvm-e500mc-objs := \
         $(common-objs-y) \
[...]
kvm-objs-$(CONFIG_KVM_E500MC) := $(kvm-e500mc-objs)
[...]
kvm-book3s_32-objs := \
         $(common-objs-y) \
[...]
kvm-objs-$(CONFIG_KVM_BOOK3S_32) := $(kvm-book3s_32-objs)


This is becaise CONFIG_KVM_BOOK3S_64 does not use "common-objs-y":

kvm-objs-$(CONFIG_KVM_BOOK3S_64) := $(kvm-book3s_64-module-objs)


So I will keep vfio.o in the "common-objs-y" list and add:

+kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) += \
+	$(KVM)/vfio.o


-- 
Alexey
