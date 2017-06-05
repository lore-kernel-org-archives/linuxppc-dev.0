Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh6QS6vFnzDqPc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 17:49:04 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v557mjUg038973
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 03:49:02 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aw19dmc7y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 03:49:00 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 17:48:58 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v557mkKC1769776
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 17:48:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v557mDst016941
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 17:48:14 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 christophe leroy <christophe.leroy@c-s.fr>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/mm/hugetlb: Add support for reserving
 gigantic huge pages via kernel command line
In-Reply-To: <87bmq72irn.fsf@concordia.ellerman.id.au>
References: <1496327441-7368-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1496327441-7368-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <b785b7b4-d6ee-3884-c140-74499171518c@c-s.fr>
 <1fc6f24e-2022-883a-fc90-8d629a181285@linux.vnet.ibm.com>
 <87bmq72irn.fsf@concordia.ellerman.id.au>
Date: Mon, 05 Jun 2017 13:17:55 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <878tl63mfo.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>> On 06/01/2017 09:42 AM, christophe leroy wrote:
>>> Le 01/06/2017 =C3=A0 16:30, Aneesh Kumar K.V a =C3=A9crit :
>>>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powe=
rpc/include/asm/book3s/64/mmu-hash.h
>>>> index 6981a52b3887..67766e60a6b6 100644
>>>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>>> @@ -468,7 +468,7 @@ extern int htab_bolt_mapping(unsigned long vstart,=
 unsigned long vend,
>>>>  			     int psize, int ssize);
>>>>  int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>>>>  			int psize, int ssize);
>>>> -extern void add_gpage(u64 addr, u64 page_size, unsigned long number_o=
f_pages);
>>>> +extern void pSeries_add_gpage(u64 addr, u64 page_size, unsigned long =
number_of_pages);
>>>=20
>>> Linux kernel coding style says 'mixed-case names are frowned upon'
>>
>> True, but there is precedent within arch/powerpc/platforms/pseries seein=
g as "pSeries_" is
>> already used heavily to prefix function names.
>
> True, but it's still horrible. Any new names should just use "pseries".

I will update in the next iteration. I will wait to get feedback on
FSL/8xx before posting the next version.

-aneesh
