Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kj760wW5zF3Jl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 12:48:33 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8Q2dHRL087548
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:48:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mr052jub4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:48:31 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 26 Sep 2018 03:48:29 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 18/22] powerpc/mm: Extend pte_fragment functionality to
 nohash/32
In-Reply-To: <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
Date: Wed, 26 Sep 2018 08:18:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87in2tgeix.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> In order to allow the 8xx to handle pte_fragments, this patch
> extends the use of pte_fragments to nohash/32 platforms.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/mmu_context.h       |  2 +-
>  arch/powerpc/include/asm/nohash/32/mmu-40x.h |  1 +
>  arch/powerpc/include/asm/nohash/32/mmu-44x.h |  1 +
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  1 +
>  arch/powerpc/include/asm/nohash/32/mmu.h     |  4 ++-
>  arch/powerpc/include/asm/nohash/32/pgalloc.h | 52 +++++++++++++---------------
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 11 ++++--
>  arch/powerpc/include/asm/nohash/mmu-book3e.h |  1 +
>  arch/powerpc/mm/Makefile                     |  3 ++
>  arch/powerpc/mm/mmu_context_nohash.c         | 14 ++++++++
>  10 files changed, 57 insertions(+), 33 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index b2f89b621b15..7f2c37a3f99d 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
>  	return 0;
>  }
>  
> -#ifndef CONFIG_PPC_BOOK3S_64
> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
>  static inline void arch_exit_mmap(struct mm_struct *mm)
>  {
>  }


Can we do that with #ifndef arch_exit_mmap? This should handle every
platform that doesn't use pte_frag right?


> diff --git a/arch/powerpc/include/asm/nohash/32/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
> index 74f4edb5916e..7c77ceed71d6 100644
> --- a/arch/powerpc/include/asm/nohash/32/mmu-40x.h
> +++ b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
> @@ -58,6 +58,7 @@ typedef struct {
>  	unsigned int	id;
>  	unsigned int	active;
>  	unsigned long	vdso_base;

-aneesh
