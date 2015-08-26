Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C0171A0050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 03:14:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 22:44:40 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 384CD3940049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 22:44:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7QHEaLI63766570
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 22:44:36 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7QHEacA027716
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 22:44:36 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 00/10] KASan ppc64 support
In-Reply-To: <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com>
Date: Wed, 26 Aug 2015 22:44:35 +0530
Message-ID: <87k2sic6pw.fsf@linux.vnet.ibm.com>
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

> 2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>> Hi,
>>
>> This patchset implements kernel address sanitizer for ppc64.
>> Since ppc64 virtual address range is divided into different regions,
>> we can't have one contigous area for the kasan shadow range. Hence
>> we don't support the INLINE kasan instrumentation. With Outline
>> instrumentation, we override the shadow_to_mem and mem_to_shadow
>> callbacks, so that we map only the kernel linear range (ie,
>> region with ID 0xc). For region with ID 0xd and 0xf (vmalloc
>> and vmemmap ) we return the address of the zero page. This
>> works because kasan doesn't track both vmemmap and vmalloc address.
>>
>> Known issues:
>> * Kasan is not yet enabled for arch/powerpc/kvm
>> * kexec hang
>> * outline stack and global support
>>
>
> Is there any problem with globals or you just didn't try it yet?
> I think it should just work. You need only to add  --param
> asan-globals=0 to KBUILD_CFLAGS_MODULE
> to disable it for modules.

I am hitting BUG_ON in early vmalloc code. I still haven't got time to
debug it further. Should get to that soon.

-aneesh
