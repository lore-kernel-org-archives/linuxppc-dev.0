Return-Path: <srs0=m2dg=bp=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFmzS7426zDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:27:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yFmzS611lz8t5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:27:16 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yFmzS2Vrqz9t2c
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2017 16:27:16 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9G5O5du051114
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2017 01:27:14 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dm9pt5rep-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2017 01:27:14 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 16 Oct 2017 01:27:13 -0400
Subject: Re: [PATCH v3] powerpc/xmon: Support dumping software pagetables
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <1507546335-27120-1-git-send-email-mpe@ellerman.id.au>
 <87o9p7hijp.fsf@linux.vnet.ibm.com>
 <CAKTCnzmRfNQNWt-basO+N8A6c=H2XJ=J1H4Z9fftRArgXWkmOw@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 10:57:07 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnzmRfNQNWt-basO+N8A6c=H2XJ=J1H4Z9fftRArgXWkmOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <eab17193-a79d-3337-405b-9a773fe7bf0f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/16/2017 10:43 AM, Balbir Singh wrote:
> On Mon, Oct 16, 2017 at 2:34 PM, Aneesh Kumar K.V
> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:

>>> +
>>> +#ifdef CONFIG_HUGETLB_PAGE
>>> +     if (pud_huge(*pudp)) {
>>> +             format_pte(pudp, pud_val(*pudp));
>>> +             return;
>>> +     }
>>> +#endif
>>
>> For page table walking code we don't need to put #ifdef here.
> 
> OK.. I designed this for both, I'll take the #ifdef out for kernel page tables.
> 
>   Also how
>> should we handle address that we map at pmd level even if hugetlb page
>> is disabled ? (kernel linear mapping). Also where do we handle THP
>> mapping ? You may want to look at __find_linux_pte() to write a page
>> table walking code. or better use the helper.
> 
> I wanted to avoid using __find_linux_pte in xmon(), it needs irq's disabled.
> I found the interface a bit cumbersome. If I fix the #ifdef's and make the
> walking code 64 bit only I think we should be OK? Do you agree?
> 

__find_linux_pte doesn't require irq disabled. But i would suggest we 
add a comment there explaining why it is safe to use without being 
worried about irqs/THP split (ex: find_init_mm_pte()). Being in xmon we 
are safe there. We moved all the warning about irq disabled etc to 
higher level functions.

-aneesh
