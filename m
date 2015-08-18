Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6F211A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:29:26 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 10:59:24 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 203151258019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 10:58:40 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7I5TLmE61341752
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 10:59:21 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7I5TL7E016314
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 10:59:21 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 4/8] kasan: Don't use kasan shadow pointer in
 generic functions
In-Reply-To: <CAPAsAGxs8NhxJ22DXOgcbBkuALzd0zd7WL+SCGeNmsWCrMi3nA@mail.gmail.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439793400-18147-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGxs8NhxJ22DXOgcbBkuALzd0zd7WL+SCGeNmsWCrMi3nA@mail.gmail.com>
Date: Tue, 18 Aug 2015 10:59:21 +0530
Message-ID: <87egj1p3ke.fsf@linux.vnet.ibm.com>
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

Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:

> On 08/17/2015 09:36 AM, Aneesh Kumar K.V wrote:
>> We can't use generic functions like print_hex_dump to access kasan
>> shadow region. This require us to setup another kasan shadow region
>> for the address passed (kasan shadow address). Most architecture won't
>> be able to do that. Hence remove dumping kasan shadow region dump. If
>> we really want to do this we will have to have a kasan internal implemen
>> tation of print_hex_dump for which we will disable address sanitizer
>> operation.
>>
>
> I didn't understand that.
> Yes, you don't have shadow for shadow. But, for shadow addresses you
> return return (void *)kasan_zero_page in kasan_mem_to_shadow(), so we
> should be fine to access shadow in generic code.
>

But in general IMHO it is not correct to pass shadow address to generic
functions, because that requires arch to setup shadow for the shadow.
With one of the initial implementation of ppc64 support, I had page
table entries setup for vmalloc and vmemmap shadow and that is when I
hit the issue. We cannot expect arch to setup shadow regions like what is
expected here. If we really need to print the shadow memory content, we
could possibly make a copy of print_hex_dump in kasan_init.c . Let me
know whether you think printing shadow area content is needed.

-aneesh
