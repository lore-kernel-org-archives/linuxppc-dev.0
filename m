Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CE6D1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:19:27 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 16:49:22 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 364713940049
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:49:19 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAOBJI904522362
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:49:18 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAOBJGon008254
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:49:18 +0530
Message-ID: <565447B4.4020003@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 16:49:16 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 05/31] powerpc/mm: Move hash specific pte width and
 other defines to book3s
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> This further make a copy of pte defines to book3s/64/hash*.h. This
> remove the dependency on ppc64-4k.h and ppc64-64k.h
> 

These files are pgtable-ppc64-4k.h and pgtable-ppc64-64k.h instead.

> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

>  /* Additional PTE bits (don't change without checking asm in hash_low.S) */
>  #define _PAGE_SPECIAL	0x00000400 /* software: special page */
> @@ -74,8 +105,8 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>  #define __rpte_to_pte(r)	((r).pte)
>  #define __rpte_sub_valid(rpte, index) \
>  	(pte_val(rpte.pte) & (_PAGE_HPTE_SUB0 >> (index)))
> -
> -/* Trick: we set __end to va + 64k, which happens works for
> +/*
> + * Trick: we set __end to va + 64k, which happens works for

The above change can be avoided in this patch and should be part
of a separate cleanup patch.
