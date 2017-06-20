Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsLRS5y05zDqhl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:21:56 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K8IkQY074575
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 04:21:54 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b6qenb8gq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 04:21:53 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 18:21:50 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K8LmMl9044290
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:21:48 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K8Ll3Y000382
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:21:47 +1000
Subject: Re: [RFC v2 06/12] powerpc: Program HPTE key protection bits.
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-7-git-send-email-linuxram@us.ibm.com>
Cc: dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 13:51:45 +0530
MIME-Version: 1.0
In-Reply-To: <1497671564-20030-7-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <645f057e-1599-3206-d8d7-b4118a89d3a0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2017 09:22 AM, Ram Pai wrote:
> Map the PTE protection key bits to the HPTE key protection bits,
> while creatiing HPTE  entries.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 5 +++++
>  arch/powerpc/include/asm/pkeys.h              | 7 +++++++
>  arch/powerpc/mm/hash_utils_64.c               | 5 +++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index cfb8169..3d7872c 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -90,6 +90,8 @@
>  #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
>  #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
>  #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
> +#define HPTE_R_KEY_BIT0		ASM_CONST(0x2000000000000000)
> +#define HPTE_R_KEY_BIT1		ASM_CONST(0x1000000000000000)
>  #define HPTE_R_RPN_SHIFT	12
>  #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
>  #define HPTE_R_RPN_3_0		ASM_CONST(0x01fffffffffff000)
> @@ -104,6 +106,9 @@
>  #define HPTE_R_C		ASM_CONST(0x0000000000000080)
>  #define HPTE_R_R		ASM_CONST(0x0000000000000100)
>  #define HPTE_R_KEY_LO		ASM_CONST(0x0000000000000e00)
> +#define HPTE_R_KEY_BIT2		ASM_CONST(0x0000000000000800)
> +#define HPTE_R_KEY_BIT3		ASM_CONST(0x0000000000000400)
> +#define HPTE_R_KEY_BIT4		ASM_CONST(0x0000000000000200)
> 

Should we indicate/document how these 5 bits are not contiguous
in the HPTE format for any given real page ?

>  #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
>  #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 0f3dca8..9b6820d 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -27,6 +27,13 @@
>  		((vm_flags & VM_PKEY_BIT3) ? H_PAGE_PKEY_BIT1 : 0x0UL) |     \
>  		((vm_flags & VM_PKEY_BIT4) ? H_PAGE_PKEY_BIT0 : 0x0UL))
> 
> +#define calc_pte_to_hpte_pkey_bits(pteflags)	\
> +	(((pteflags & H_PAGE_PKEY_BIT0) ? HPTE_R_KEY_BIT0 : 0x0UL) |	\
> +	((pteflags & H_PAGE_PKEY_BIT1) ? HPTE_R_KEY_BIT1 : 0x0UL) |	\
> +	((pteflags & H_PAGE_PKEY_BIT2) ? HPTE_R_KEY_BIT2 : 0x0UL) |	\
> +	((pteflags & H_PAGE_PKEY_BIT3) ? HPTE_R_KEY_BIT3 : 0x0UL) |	\
> +	((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL))
> +

We can drop calc_ in here. pte_to_hpte_pkey_bits should be
sufficient.
