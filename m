Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1FE71A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 19:51:03 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 15:20:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5054E394005A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 15:20:58 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H9oHg229688022
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 15:20:18 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H9oFAE001787
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 15:20:16 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 0/8] KASAN ppc64 support
In-Reply-To: <1439794492.2416.8.camel@kernel.crashing.org>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439794492.2416.8.camel@kernel.crashing.org>
Date: Mon, 17 Aug 2015 15:20:14 +0530
Message-ID: <87mvxqp7l5.fsf@linux.vnet.ibm.com>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2015-08-17 at 12:06 +0530, Aneesh Kumar K.V wrote:
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
> So bear with me, I don't know anything about KASAN, but if you want a
> shadow, can't you just add a fixed offset to the address and thus
> effectively shadow each region independently while keeping the inline
> helpers ?
>

For kernel linear mapping, our address space looks like
0xc000000000000000 - 0xc0003fffffffffff  (64TB)

We can't have virtual address(effective address) above that range
in 0xc region. Hence in-order to shadow the linear mapping, I am using
region 0xe. ie, the shadow mapping now looks like

0xc000000000000000 -> 0xe000000000000000 

ie, shadow offset now is 0xc800000000000000

For inline instrumentation, we need to have a constant shadow offset. We
can't use the same shadow offset for region 0xd and 0xf because, the
mapping would then end up as
vmalloc:
0xc800000000000000 +  (0xd000000000000000ULL >> 3)  
0xe200000000000000

vmemmap:
0xc800000000000000 +  (0xf000000000000000ULL >> 3)  
0xe600000000000000

and we can't have that logical address range, because our valid ranges
are

0xc000000000000000 - 0xc0003fffffffffff 
0xd000000000000000 - 0xd0003fffffffffff 
0xe000000000000000 - 0xe0003fffffffffff 
0xf000000000000000 - 0xf0003fffffffffff 
 
Because of the above I concluded that we may not be able to do
inline instrumentation. Now if we are not doing inline instrumentation,
we can simplify kasan support by not creating a shadow mapping at all
for vmalloc and vmemmap region. Hence the idea of returning the address
of a zero page for anything other than kernel linear map region.

Another reason why inline instrumentation is difficult is that for
inline instrumentation to work, we need to create a mapping for _possible_
virtual address space before kasan is fully initialized. ie, we need
to create page table entries for the shadow of the entire 64TB range,
with zero page, even though we have lesser ram. We definitely can't bolt
those entries. I am yet to get the shadow for kernel linear mapping to
work without bolting. Also we will have to get the page table allocated
for that, because we can't share page table entries. Our fault
path use pte entries for storing hash slot index.


NOTE:
If we are ok to steal part of that 64TB range, for kasan mapping , ie
we make shadow of each region part of the same region, may be we can
get inline instrumentation to work. But that still doesn't solve the
page table allocation overhead issue mentioned above.

-aneesh
