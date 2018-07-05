Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M3Lw6BngzF26p
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 02:33:12 +1000 (AEST)
Subject: Re: [PATCH V2 00/10] KASan ppc64 support
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com>
 <87k2sic6pw.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7d459964-ce68-db1c-3d28-ae206d5ebdb0@c-s.fr>
Date: Thu, 5 Jul 2018 18:33:08 +0200
MIME-Version: 1.0
In-Reply-To: <87k2sic6pw.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

Are you still working on support for KASan for ppc64 ?

Thanks,
Christophe


Le 26/08/2015 à 19:14, Aneesh Kumar K.V a écrit :
> Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:
> 
>> 2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>>> Hi,
>>>
>>> This patchset implements kernel address sanitizer for ppc64.
>>> Since ppc64 virtual address range is divided into different regions,
>>> we can't have one contigous area for the kasan shadow range. Hence
>>> we don't support the INLINE kasan instrumentation. With Outline
>>> instrumentation, we override the shadow_to_mem and mem_to_shadow
>>> callbacks, so that we map only the kernel linear range (ie,
>>> region with ID 0xc). For region with ID 0xd and 0xf (vmalloc
>>> and vmemmap ) we return the address of the zero page. This
>>> works because kasan doesn't track both vmemmap and vmalloc address.
>>>
>>> Known issues:
>>> * Kasan is not yet enabled for arch/powerpc/kvm
>>> * kexec hang
>>> * outline stack and global support
>>>
>>
>> Is there any problem with globals or you just didn't try it yet?
>> I think it should just work. You need only to add  --param
>> asan-globals=0 to KBUILD_CFLAGS_MODULE
>> to disable it for modules.
> 
> I am hitting BUG_ON in early vmalloc code. I still haven't got time to
> debug it further. Should get to that soon.
> 
> -aneesh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
