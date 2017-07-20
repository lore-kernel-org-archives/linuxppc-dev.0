Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCjzq4CsmzDqnl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 16:05:11 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K64jTF087669
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 02:05:09 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btjhmgn43-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 02:05:09 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 16:05:06 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K64vot31588450
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 16:05:05 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K64WuU011408
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 16:04:33 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net,
 mingo@redhat.com, mhocko@kernel.org
Subject: Re: [RFC v6 11/62] powerpc: initial pkey plumbing
In-Reply-To: <1500177424-13695-12-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-12-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:34:10 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shhrprtx.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> basic setup to initialize the pkey system. Only 64K kernel in HPT
> mode, enables the pkey system.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/Kconfig                   |   16 ++++++++++
>  arch/powerpc/include/asm/mmu_context.h |    5 +++
>  arch/powerpc/include/asm/pkeys.h       |   51 ++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup_64.c         |    4 ++
>  arch/powerpc/mm/Makefile               |    1 +
>  arch/powerpc/mm/hash_utils_64.c        |    1 +
>  arch/powerpc/mm/pkeys.c                |   18 +++++++++++
>  7 files changed, 96 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/pkeys.h
>  create mode 100644 arch/powerpc/mm/pkeys.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index bf4391d..5c60fd6 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -855,6 +855,22 @@ config SECCOMP
>
>  	  If unsure, say Y. Only embedded should say N here.
>
> +config PPC64_MEMORY_PROTECTION_KEYS
> +	prompt "PowerPC Memory Protection Keys"
> +	def_bool y
> +	# Note: only available in 64-bit mode
> +	depends on PPC64 && PPC_64K_PAGES
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	select ARCH_HAS_PKEYS
> +	---help---
> +	  Memory Protection Keys provides a mechanism for enforcing
> +	  page-based protections, but without requiring modification of the
> +	  page tables when an application changes protection domains.
> +
> +	  For details, see Documentation/vm/protection-keys.txt
> +
> +	  If unsure, say y.
> +
>  endmenu


Shouldn't this come as the last patch ? Or can we enable this config by
this patch ? If so what does it do ? Did you test boot each of this
patch to make sure we don't break git bisect ?

>
>  config ISA_DMA_API
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index da7e943..4b93547 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -181,5 +181,10 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>  	/* by default, allow everything */


-aneesh
