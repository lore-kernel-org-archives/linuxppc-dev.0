Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6167D2C02F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 00:26:58 +1000 (EST)
Received: by mail-pd0-f178.google.com with SMTP id w11so3623714pde.37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 07:26:56 -0700 (PDT)
Message-ID: <51A36D28.7090202@ozlabs.ru>
Date: Tue, 28 May 2013 00:26:48 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
References: <1369105607-20957-4-git-send-email-aik@ozlabs.ru>
 <1369256817.1374.29@scott-Lenovo-G560>
 <20130525024524.GA6112@boomeroo.fritz.box> <51A33418.40909@redhat.com>
In-Reply-To: <51A33418.40909@redhat.com>
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

On 05/27/2013 08:23 PM, Paolo Bonzini wrote:
> Il 25/05/2013 04:45, David Gibson ha scritto:
>>>> +	case KVM_CREATE_SPAPR_TCE_IOMMU: {
>>>> +		struct kvm_create_spapr_tce_iommu create_tce_iommu;
>>>> +		struct kvm *kvm = filp->private_data;
>>>> +
>>>> +		r = -EFAULT;
>>>> +		if (copy_from_user(&create_tce_iommu, argp,
>>>> +				sizeof(create_tce_iommu)))
>>>> +			goto out;
>>>> +		r = kvm_vm_ioctl_create_spapr_tce_iommu(kvm,
>>>> &create_tce_iommu);
>>>> +		goto out;
>>>> +	}
> 
> Would it make sense to make this the only interface for creating TCEs?
> That is, pass both a window_size and an IOMMU group id (or e.g. -1 for
> no hardware IOMMU usage), and have a single ioctl for both cases?
> There's some duplicated code between kvm_vm_ioctl_create_spapr_tce and
> kvm_vm_ioctl_create_spapr_tce_iommu.

Just few bits. Is there really much sense in making one function from those
two? I tried, looked a bit messy.

> KVM_CREATE_SPAPR_TCE could stay for backwards-compatibility, or you
> could just use a new capability and drop the old ioctl.

The old capability+ioctl already exist for quite a while and few QEMU
versions supporting it were released so we do not want just drop it. So
then what is the benefit of having a new interface with support of both types?

>  I'm not sure
> whether you're already considering the ABI to be stable for kvmppc.

Is any bit of KVM using it? Cannot see from Documentation/ABI.


-- 
Alexey
