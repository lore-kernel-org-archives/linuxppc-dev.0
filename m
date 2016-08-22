Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHjrD4pxmzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 16:11:24 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M68QFj006955
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 02:11:22 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y31bw61d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 02:11:22 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 00:11:20 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 2/5] powerpc/mm: Add radix flush all with IS=3
In-Reply-To: <1471823733.19495.88.camel@kernel.crashing.org>
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471596759-3396-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471823733.19495.88.camel@kernel.crashing.org>
Date: Mon, 22 Aug 2016 11:41:13 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87shtxib9a.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2016-08-19 at 14:22 +0530, Aneesh Kumar K.V wrote:
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> =C2=A0arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |=C2=A0=C2=A01=
 +
>> =C2=A0arch/powerpc/mm/tlb-radix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 15
>> +++++++++++++++
>> =C2=A02 files changed, 16 insertions(+)
>
> Don't we need two ? One for partition scoped and one for process scoped
> ?


With invalid selector value 3 (IS =3D 3), we will invalidate all entries
when executed with MSR[HV] =3D 1. I guess that should take out all the
translation cache, including implementation dependent one ?

Also note thar PRS =3D 0. ie, we are partition scoped. ie, we are doing
invalidate with

PRS =3D0, IS =3D 3 HV =3D 1 RIC =3D 2

>
>> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
>> b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
>> index 65037762b120..a9e19cb2f7c5 100644
>> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
>> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
>> @@ -41,4 +41,5 @@ extern void radix__flush_tlb_page_psize(struct
>> mm_struct *mm, unsigned long vmad
>> =C2=A0extern void radix__flush_tlb_lpid_va(unsigned long lpid, unsigned
>> long gpa,
>> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long page_size);
>> =C2=A0extern void radix__flush_tlb_lpid(unsigned long lpid);
>> +extern void radix__flush_tlb_all(void);
>> =C2=A0#endif
>> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-
>> radix.c
>> index 48df05ef5231..517feb47ebe4 100644
>> --- a/arch/powerpc/mm/tlb-radix.c
>> +++ b/arch/powerpc/mm/tlb-radix.c
>> @@ -400,3 +400,18 @@ void radix__flush_pmd_tlb_range(struct
>> vm_area_struct *vma,
>> =C2=A0	radix__flush_tlb_range_psize(vma->vm_mm, start, end,
>> MMU_PAGE_2M);
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL(radix__flush_pmd_tlb_range);
>> +
>> +void radix__flush_tlb_all(void)
>> +{
>> +	unsigned long rb,prs,r;
>> +	unsigned long ric =3D RIC_FLUSH_ALL;
>> +
>> +	rb =3D 0x3 << PPC_BITLSHIFT(53); /* IS =3D 3 */
>> +	prs =3D 0; /* partition scoped */
>> +	r =3D 1;=C2=A0=C2=A0=C2=A0/* raidx format */
>> +
>> +	asm volatile("ptesync": : :"memory");
>> +	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
>> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: : "r"(rb), "i"(r), "i"(prs), "i"(ric)=
, "r"(0)
>> : "memory");
>> +	asm volatile("eieio; tlbsync; ptesync": : :"memory");
>> +}
