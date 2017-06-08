Return-Path: <srs0=0i0f=5n=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjyHB6NHHzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 17:49:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wjyHB4vfgz8t6D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 17:49:10 +1000 (AEST)
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wjyH965CKz9s78
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2017 17:49:09 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id w1so6451838qtg.0
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Jun 2017 00:49:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zidlpgip.fsf@concordia.ellerman.id.au>
References: <1496728137-19655-1-git-send-email-mpe@ellerman.id.au>
 <CAKTCnzmUPUBP_NQjzcUO_z+iVtn_ArwHpzWToGYvQVV-zjoB7w@mail.gmail.com>
 <87zidlpgip.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 8 Jun 2017 17:49:07 +1000
Message-ID: <CAKTCnz=CwHdkoXB6BvEX8Tm8=BwPS3rRxnxF5GSuCC0W7LY7Jw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm/radix: Only add X for pages overlapping kernel
 text
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 6, 2017 at 8:17 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>> On Tue, Jun 6, 2017 at 3:48 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Currently we map the whole linear mapping with PAGE_KERNEL_X. Instead we
>>> should check if the page overlaps the kernel text and only then add
>>> PAGE_KERNEL_X.
> ...
>>> @@ -145,8 +147,14 @@ static int __meminit create_physical_mapping(unsigned long start,
>>>                         start = addr;
>>>                 }
>>>
>>> -               rc = radix__map_kernel_page((unsigned long)__va(addr), addr,
>>> -                                           PAGE_KERNEL_X, mapping_size);
>>> +               vaddr = (unsigned long)__va(addr);
>>> +
>>> +               if (overlaps_kernel_text(vaddr, vaddr + mapping_size))
>>> +                       prot = PAGE_KERNEL_X;
>>> +               else
>>> +                       prot = PAGE_KERNEL;
>>
>> Do we need the kvm tmp/trampoline bits like hash?
>
> Ugh, I hope not. What is that crap.
>
> It appears to be epapr paravirt only:
>
>   static int __init kvm_guest_init(void)
>   {
>         if (!kvm_para_available())
>                 goto free_tmp;
>
>         if (!epapr_paravirt_enabled)
>                 goto free_tmp;
>
>
> But I can't convince myself whether epapr_paravirt_enabled is ever set
> on Book3S guests or not.
>
> Looking at Qemu it looks like it *could* be.
>
> And why isn't that code in arch/powerpc/kvm ?

Not sure, for now

Acked-by: Balbir Singh <bsingharora@gmail.com>
