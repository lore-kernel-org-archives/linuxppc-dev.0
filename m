Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 078041A06D7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 18:06:14 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1C56B140B9E
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Feb 2016 18:06:12 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 00:06:10 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/9] powerpc/mm/book3s-64: Use physical addresses in upper
 page table tree levels
In-Reply-To: <1456108880-27464-4-git-send-email-paulus@ozlabs.org>
References: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
 <1456108880-27464-4-git-send-email-paulus@ozlabs.org>
Date: Mon, 22 Feb 2016 12:36:03 +0530
Message-ID: <871t85i5r8.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> From: Paul Mackerras <paulus@samba.org>
>
> This changes the Linux page tables to store physical addresses
> rather than kernel virtual addresses in the upper levels of the
> tree (pgd, pud and pmd) for 64-bit Book 3S machines.
>
> This frees up some high order bits, and will be needed with
> PowerISA v3.0 machines which read the page table tree in hardware
> in radix mode.
>

Radix mark the top two bits at upper level page table tree.

ie,


static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
{
	pud_set(pud, __pgtable_ptr_val(pmd));
}

static inline void rpud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
{
	*pud = __pud(__pa(pmd) | RPUD_VAL_BITS);
}


I guess we will do the same with hash to keep them same ?

-aneesh
