Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wswyN1cJpzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 17:17:16 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L7DgGf140983
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 03:17:14 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7jxgb8qs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 03:17:13 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 17:17:11 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5L7H00T2425308
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 17:17:08 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5L7GZYx017892
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 17:16:36 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com
Subject: Re: [RFC v2 05/12] powerpc: Implementation for sys_mprotect_pkey()
 system call.
In-Reply-To: <1497671564-20030-6-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-6-git-send-email-linuxram@us.ibm.com>
Date: Wed, 21 Jun 2017 12:46:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw39ak04.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

....

>
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +
>  /*
>   * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
>   * here.  How important is the optimization?
>   */
> -static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> -		unsigned long pkey)
> -{
> -	return (prot & PROT_SAO) ? VM_SAO : 0;
> -}
> -#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> +#define arch_calc_vm_prot_bits(prot, key) (             \
> +		((prot) & PROT_SAO ? VM_SAO : 0) |	\
> +			pkey_to_vmflag_bits(key))
> +#define arch_vm_get_page_prot(vm_flags) __pgprot(       \
> +		((vm_flags) & VM_SAO ? _PAGE_SAO : 0) |	\
> +		vmflag_to_page_pkey_bits(vm_flags))

Can we avoid converting static inline back to macors ? They loose type checking.
> +
> +#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
> +#define arch_calc_vm_prot_bits(prot, key) (	\
> +		((prot) & PROT_SAO ? VM_SAO : 0))
> +#define arch_vm_get_page_prot(vm_flags) __pgprot(	\
> +		((vm_flags) & VM_SAO ? _PAGE_SAO : 0))
> +
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>
> -static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
> -{
> -	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
> -}
> -#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
>
>  static inline bool arch_validate_prot(unsigned long prot)
>  {

-aneesh
