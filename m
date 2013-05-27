Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 314682C02FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 00:42:07 +1000 (EST)
Message-ID: <51A370AF.4090208@redhat.com>
Date: Mon, 27 May 2013 16:41:51 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
References: <1369105607-20957-4-git-send-email-aik@ozlabs.ru>
 <1369256817.1374.29@scott-Lenovo-G560>
 <20130525024524.GA6112@boomeroo.fritz.box> <51A33418.40909@redhat.com>
 <51A36D28.7090202@ozlabs.ru>
In-Reply-To: <51A36D28.7090202@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 27/05/2013 16:26, Alexey Kardashevskiy ha scritto:
> On 05/27/2013 08:23 PM, Paolo Bonzini wrote:
>> Il 25/05/2013 04:45, David Gibson ha scritto:
>>>>> +	case KVM_CREATE_SPAPR_TCE_IOMMU: {
>>>>> +		struct kvm_create_spapr_tce_iommu create_tce_iommu;
>>>>> +		struct kvm *kvm = filp->private_data;
>>>>> +
>>>>> +		r = -EFAULT;
>>>>> +		if (copy_from_user(&create_tce_iommu, argp,
>>>>> +				sizeof(create_tce_iommu)))
>>>>> +			goto out;
>>>>> +		r = kvm_vm_ioctl_create_spapr_tce_iommu(kvm,
>>>>> &create_tce_iommu);
>>>>> +		goto out;
>>>>> +	}
>>
>> Would it make sense to make this the only interface for creating TCEs?
>> That is, pass both a window_size and an IOMMU group id (or e.g. -1 for
>> no hardware IOMMU usage), and have a single ioctl for both cases?
>> There's some duplicated code between kvm_vm_ioctl_create_spapr_tce and
>> kvm_vm_ioctl_create_spapr_tce_iommu.
> 
> Just few bits. Is there really much sense in making one function from those
> two? I tried, looked a bit messy.

Cannot really tell without the userspace bits.  But ioctl proliferation
is what the device and one_reg APIs were supposed to avoid...

>> KVM_CREATE_SPAPR_TCE could stay for backwards-compatibility, or you
>> could just use a new capability and drop the old ioctl.
> 
> The old capability+ioctl already exist for quite a while and few QEMU
> versions supporting it were released so we do not want just drop it. So
> then what is the benefit of having a new interface with support of both types?
> 
>>  I'm not sure
>> whether you're already considering the ABI to be stable for kvmppc.
> 
> Is any bit of KVM using it? Cannot see from Documentation/ABI.

I mean the userspace ABI (ioctls).

Paolo
