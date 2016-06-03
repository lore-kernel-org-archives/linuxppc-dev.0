Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLTNQ14zvzDqkk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 13:00:05 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 21:00:01 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/mm/radix: Flush page walk cache when freeing
 page table
In-Reply-To: <1464915818.26773.7.camel@kernel.crashing.org>
References: <1464860789-3672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1464860789-3672-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1464915818.26773.7.camel@kernel.crashing.org>
Date: Fri, 03 Jun 2016 08:29:53 +0530
Message-ID: <87mvn3vuxi.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2016-06-02 at 15:16 +0530, Aneesh Kumar K.V wrote:
>>=20
>>=20
>> +/*
>> + * flush the page walk cache for the address
>> + */
>> +void flush_tlb_pgtable(struct mmu_gather *tlb, unsigned long address)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mm_struct *mm =3D tlb-=
>mm;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * flush the page table walk =
cache on freeing page table. We already
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * have marked the upper/high=
er level page table entry none by now.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * So it is safe to flush PWC=
 here.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!radix_enabled())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0radix__flush_tlb_mm_pwc(mm);
>
> That means that on hash, we pay the price of a useless function call
> and return. Shouldn't we put the radix_enabled() test in the caller
> instead ?
>

I wil convert that to static inline.

-aneesh
