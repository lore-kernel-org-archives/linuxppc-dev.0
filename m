Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wf8DF482rzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 13:03:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 christophe leroy <christophe.leroy@c-s.fr>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/mm/hugetlb: Add support for reserving
 gigantic huge pages via kernel command line
In-Reply-To: <1fc6f24e-2022-883a-fc90-8d629a181285@linux.vnet.ibm.com>
References: <1496327441-7368-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1496327441-7368-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <b785b7b4-d6ee-3884-c140-74499171518c@c-s.fr>
 <1fc6f24e-2022-883a-fc90-8d629a181285@linux.vnet.ibm.com>
Date: Fri, 02 Jun 2017 13:03:24 +1000
Message-ID: <87bmq72irn.fsf@concordia.ellerman.id.au>
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

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> On 06/01/2017 09:42 AM, christophe leroy wrote:
>> Le 01/06/2017 =C3=A0 16:30, Aneesh Kumar K.V a =C3=A9crit :
>>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/power=
pc/include/asm/book3s/64/mmu-hash.h
>>> index 6981a52b3887..67766e60a6b6 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> @@ -468,7 +468,7 @@ extern int htab_bolt_mapping(unsigned long vstart, =
unsigned long vend,
>>>  			     int psize, int ssize);
>>>  int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>>>  			int psize, int ssize);
>>> -extern void add_gpage(u64 addr, u64 page_size, unsigned long number_of=
_pages);
>>> +extern void pSeries_add_gpage(u64 addr, u64 page_size, unsigned long n=
umber_of_pages);
>>=20
>> Linux kernel coding style says 'mixed-case names are frowned upon'
>
> True, but there is precedent within arch/powerpc/platforms/pseries seeing=
 as "pSeries_" is
> already used heavily to prefix function names.

True, but it's still horrible. Any new names should just use "pseries".

cheers
