Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-vk0-x22d.google.com (mail-vk0-x22d.google.com
 [IPv6:2607:f8b0:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 365C11A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 19:12:20 +1000 (AEST)
Received: by vkao123 with SMTP id o123so5711312vka.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 02:12:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87egj1p3ke.fsf@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439793400-18147-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGxs8NhxJ22DXOgcbBkuALzd0zd7WL+SCGeNmsWCrMi3nA@mail.gmail.com>
 <87egj1p3ke.fsf@linux.vnet.ibm.com>
Date: Tue, 18 Aug 2015 12:12:17 +0300
Message-ID: <CAPAsAGxmwfPMX4WOJxMCx4W2BP8LVtzN-M_54Xx_hqk2OhZYHw@mail.gmail.com>
Subject: Re: [RFC PATCH V1 4/8] kasan: Don't use kasan shadow pointer in
 generic functions
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-18 8:29 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:
>
>> On 08/17/2015 09:36 AM, Aneesh Kumar K.V wrote:
>>> We can't use generic functions like print_hex_dump to access kasan
>>> shadow region. This require us to setup another kasan shadow region
>>> for the address passed (kasan shadow address). Most architecture won't
>>> be able to do that. Hence remove dumping kasan shadow region dump. If
>>> we really want to do this we will have to have a kasan internal implemen
>>> tation of print_hex_dump for which we will disable address sanitizer
>>> operation.
>>>
>>
>> I didn't understand that.
>> Yes, you don't have shadow for shadow. But, for shadow addresses you
>> return return (void *)kasan_zero_page in kasan_mem_to_shadow(), so we
>> should be fine to access shadow in generic code.
>>
>
> But in general IMHO it is not correct to pass shadow address to generic
> functions, because that requires arch to setup shadow for the shadow.

Yes, we have this shadow for shadow in x86_64/arm64.

> With one of the initial implementation of ppc64 support, I had page
> table entries setup for vmalloc and vmemmap shadow and that is when I
> hit the issue. We cannot expect arch to setup shadow regions like what is
> expected here. If we really need to print the shadow memory content, we
> could possibly make a copy of print_hex_dump in kasan_init.c . Let me
> know whether you think printing shadow area content is needed.
>

It was quite useful sometimes, so I think we should keep it.
But I agree with you, that it would be better to avoid accesses to shadow memory
in generic code.
Another way to deal with this would be to copy shadow content in buffer,
and then print_hex_dump() it.

> -aneesh
>
