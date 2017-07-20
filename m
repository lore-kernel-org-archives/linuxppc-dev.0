Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCjpY417vzDrDK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:57:09 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6K5v76d069565
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:57:07 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2btjhmgcjy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:57:06 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 15:57:04 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6K5v1r227328660
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:57:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6K5uxNS018543
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 15:57:00 +1000
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
Subject: Re: [RFC v6 03/62] powerpc: introduce pte_set_hash_slot() helper
In-Reply-To: <1500177424-13695-4-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-4-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:26:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874lu7r6qi.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> Introduce pte_set_hash_slot().It  sets the (H_PAGE_F_SECOND|H_PAGE_F_GIX)
> bits at  the   appropriate   location   in   the   PTE  of  4K  PTE.  For
> 64K PTE, it  sets  the  bits  in  the  second  part  of  the  PTE. Though
> the implementation  for the former just needs the slot parameter, it does
> take some additional parameters to keep the prototype consistent.
>
> This function  will  be  handy  as  we   work   towards  re-arranging the
> bits in the later patches.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |   15 +++++++++++++++
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |   25 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index d2cf949..dc153c6 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -53,6 +53,21 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
>  }
>  #endif
>
> +/*
> + * 4k pte format is  different  from  64k  pte  format.  Saving  the
> + * hash_slot is just a matter of returning the pte bits that need to
> + * be modified. On 64k pte, things are a  little  more  involved and
> + * hence  needs   many   more  parameters  to  accomplish  the  same.
> + * However we  want  to abstract this out from the caller by keeping
> + * the prototype consistent across the two formats.
> + */
> +static inline unsigned long pte_set_hash_slot(pte_t *ptep, real_pte_t rpte,
> +			unsigned int subpg_index, unsigned long slot)
> +{
> +	return (slot << H_PAGE_F_GIX_SHIFT) &
> +		(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>
>  static inline char *get_hpte_slot_array(pmd_t *pmdp)
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index c281f18..89ef5a9 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -67,6 +67,31 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>  	return ((rpte.hidx >> (index<<2)) & 0xfUL);
>  }
>
> +/*
> + * Commit the hash slot and return pte bits that needs to be modified.
> + * The caller is expected to modify the pte bits accordingly and
> + * commit the pte to memory.
> + */
> +static inline unsigned long pte_set_hash_slot(pte_t *ptep, real_pte_t rpte,
> +		unsigned int subpg_index, unsigned long slot)
> +{
> +	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> +
> +	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
> +	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
> +	/*
> +	 * Commit the hidx bits to memory before returning.
> +	 * Anyone reading  pte  must  ensure hidx bits are
> +	 * read  only  after  reading the pte by using the
> +	 * read-side  barrier  smp_rmb(). __real_pte() can
> +	 * help ensure that.
> +	 */
> +	smp_wmb();
> +
> +	/* no pte bits to be modified, return 0x0UL */
> +	return 0x0UL;
> +}
> +
>  #define __rpte_to_pte(r)	((r).pte)
>  extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
>  /*
> -- 
> 1.7.1
