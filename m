Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whnfm4KPvzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 20:17:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras  <paulus@samba.org>
Subject: Re: [PATCH] powerpc/mm/radix: Only add X for pages overlapping kernel
 text
In-Reply-To: <CAKTCnzmUPUBP_NQjzcUO_z+iVtn_ArwHpzWToGYvQVV-zjoB7w@mail.gmail.com>
References: <1496728137-19655-1-git-send-email-mpe@ellerman.id.au>
 <CAKTCnzmUPUBP_NQjzcUO_z+iVtn_ArwHpzWToGYvQVV-zjoB7w@mail.gmail.com>
Date: Tue, 06 Jun 2017 20:17:02 +1000
Message-ID: <87zidlpgip.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:
> On Tue, Jun 6, 2017 at 3:48 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Currently we map the whole linear mapping with PAGE_KERNEL_X. Instead we
>> should check if the page overlaps the kernel text and only then add
>> PAGE_KERNEL_X.
...
>> @@ -145,8 +147,14 @@ static int __meminit create_physical_mapping(unsigned long start,
>>                         start = addr;
>>                 }
>>
>> -               rc = radix__map_kernel_page((unsigned long)__va(addr), addr,
>> -                                           PAGE_KERNEL_X, mapping_size);
>> +               vaddr = (unsigned long)__va(addr);
>> +
>> +               if (overlaps_kernel_text(vaddr, vaddr + mapping_size))
>> +                       prot = PAGE_KERNEL_X;
>> +               else
>> +                       prot = PAGE_KERNEL;
>
> Do we need the kvm tmp/trampoline bits like hash?

Ugh, I hope not. What is that crap.

It appears to be epapr paravirt only:

  static int __init kvm_guest_init(void)
  {
  	if (!kvm_para_available())
  		goto free_tmp;
  
  	if (!epapr_paravirt_enabled)
  		goto free_tmp;


But I can't convince myself whether epapr_paravirt_enabled is ever set
on Book3S guests or not.

Looking at Qemu it looks like it *could* be.

And why isn't that code in arch/powerpc/kvm ?

cheers
