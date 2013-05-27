Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-qe0-f49.google.com (mail-qe0-f49.google.com
 [209.85.128.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 973D12C02E9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 20:23:33 +1000 (EST)
Received: by mail-qe0-f49.google.com with SMTP id a11so3642302qen.36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 03:23:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <51A33418.40909@redhat.com>
Date: Mon, 27 May 2013 12:23:20 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
References: <1369105607-20957-4-git-send-email-aik@ozlabs.ru>
 <1369256817.1374.29@scott-Lenovo-G560>
 <20130525024524.GA6112@boomeroo.fritz.box>
In-Reply-To: <20130525024524.GA6112@boomeroo.fritz.box>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 25/05/2013 04:45, David Gibson ha scritto:
>> >+	case KVM_CREATE_SPAPR_TCE_IOMMU: {
>> >+		struct kvm_create_spapr_tce_iommu create_tce_iommu;
>> >+		struct kvm *kvm = filp->private_data;
>> >+
>> >+		r = -EFAULT;
>> >+		if (copy_from_user(&create_tce_iommu, argp,
>> >+				sizeof(create_tce_iommu)))
>> >+			goto out;
>> >+		r = kvm_vm_ioctl_create_spapr_tce_iommu(kvm,
>> >&create_tce_iommu);
>> >+		goto out;
>> >+	}

Would it make sense to make this the only interface for creating TCEs?
That is, pass both a window_size and an IOMMU group id (or e.g. -1 for
no hardware IOMMU usage), and have a single ioctl for both cases?
There's some duplicated code between kvm_vm_ioctl_create_spapr_tce and
kvm_vm_ioctl_create_spapr_tce_iommu.

KVM_CREATE_SPAPR_TCE could stay for backwards-compatibility, or you
could just use a new capability and drop the old ioctl.  I'm not sure
whether you're already considering the ABI to be stable for kvmppc.

Paolo
