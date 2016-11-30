Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTDJ71vq3zDvNL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:35:19 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tTDJ64b7Pz9vG1
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 19:35:17 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAU8Xw5A071683
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 03:35:15 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 271pck5r00-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 03:35:15 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 01:35:14 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Radim <rkrcmar@redhat.com>
Subject: Re: [PATCH v2] KVM/PPC Patch for KVM issue in real mode
In-Reply-To: <20a3e138-8a6e-6ad8-b9ba-ec8332f011a5@gmail.com>
References: <20a3e138-8a6e-6ad8-b9ba-ec8332f011a5@gmail.com>
Date: Wed, 30 Nov 2016 14:05:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760n5icw5.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> Some KVM functions for book3s_hv are called in real mode.
> In real mode the top 4 bits of the address space are ignored,
> hence an address beginning with 0xc0000000+offset is the
> same as 0xd0000000+offset. The issue was observed when
> a kvm memslot resolution lead to random values when
> access from kvmppc_h_enter(). The issue is hit if the
> KVM host is running with a page size of 4K, since
> kvzalloc() looks at size < PAGE_SIZE. On systems with
> 64K the issue is not observed easily, it largely depends
> on the size of the structure being allocated.
>
> The proposed fix moves all KVM allocations for book3s_hv
> to kzalloc() until all structures used in real mode are
> audited. For safety allocations are moved to kmalloc
> space. The impact is a large allocation on systems with
> 4K page size.

We did such access using *real_vmalloc_addr(void *x). So you are
suggesting here is we don't do that for all code path ?

Do you have a stack dump for which you identified the issue ?

>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  Changelog v2:
>    Fix build failures reported by the kbuild test robot
>    http://www.spinics.net/lists/kvm/msg141727.html
>
>  arch/powerpc/include/asm/kvm_host.h | 19 +++++++++++++++++++
>  include/linux/kvm_host.h            | 11 +++++++++++
>  virt/kvm/kvm_main.c                 |  2 +-
>  3 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index f15713a..53f5172 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -734,6 +734,25 @@ struct kvm_vcpu_arch {
>  #define __KVM_HAVE_ARCH_WQP
>  #define __KVM_HAVE_CREATE_DEVICE
>  
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +#define __KVM_HAVE_ARCH_VZALLOC_OVERRIDE

do we need that OVERRIDE ? We usually have HAVE_ARCH_KVM_VZALLOC
or just say #ifndef kvm_arch_vzalloc ?


> +
> +/*
> + * KVM uses some of these data structures -- the ones
> + * from kvzalloc() in real mode. If the data structure
> + * happens to come from a vmalloc'd range then its access
> + * in real mode will lead to problems due to the aliasing
> + * issue - (top 4 bits are ignore).
> + * A 0xd000+offset will point to a 0xc000+offset in realmode
> + * Hence we want our data structures from come from kmalloc'd
> + * regions, so that we don't have these aliasing issues
> + */
> +static inline void *kvm_arch_vzalloc(unsigned long size)
> +{
> +	return kzalloc(size, GFP_KERNEL);
> +}
> +#endif


....
-aneesh
