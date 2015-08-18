Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63C101A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:43:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 15:43:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 179EC2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:43:37 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7I5hSrc23461944
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:43:37 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7I5h40i004238
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:43:04 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 0/8] KASAN ppc64 support
In-Reply-To: <CAPAsAGzLY86BLT2KwE+dc=R+rnTPbMbxH_V4eror-Nvnd=3K8w@mail.gmail.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439794492.2416.8.camel@kernel.crashing.org>
 <87mvxqp7l5.fsf@linux.vnet.ibm.com>
 <CAPAsAGzLY86BLT2KwE+dc=R+rnTPbMbxH_V4eror-Nvnd=3K8w@mail.gmail.com>
Date: Tue, 18 Aug 2015 11:12:37 +0530
Message-ID: <87zj1pnodu.fsf@linux.vnet.ibm.com>
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

> 2015-08-17 12:50 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>> Because of the above I concluded that we may not be able to do
>> inline instrumentation. Now if we are not doing inline instrumentation,
>> we can simplify kasan support by not creating a shadow mapping at all
>> for vmalloc and vmemmap region. Hence the idea of returning the address
>> of a zero page for anything other than kernel linear map region.
>>
>
> Yes, mapping zero page needed only for inline instrumentation.
> You simply don't need to check shadow for vmalloc/vmemmap.
>
> So, instead of redefining kasan_mem_to_shadow() I'd suggest to
> add one more arch hook. Something like:
>
> bool kasan_tracks_vaddr(unsigned long addr)
> {
>      return REGION_ID(addr) == KERNEL_REGION_ID;
> }
>
> And in check_memory_region():
>        if (!(kasan_enabled() && kasan_tracks_vaddr(addr)))
>                return;


But that is introducting conditionals in core code for no real benefit.
This also will break when we eventually end up tracking vmalloc ?
In that case our mem_to_shadow will esentially be a switch
statement returning different offsets for kernel region and vmalloc
region. As far as core kernel code is considered, it just need to
ask arch to get the shadow address for a memory and instead of adding
conditionals in core, my suggestion is, we handle this in an arch function.

-aneesh
