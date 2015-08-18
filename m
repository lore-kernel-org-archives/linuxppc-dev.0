Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FA491A0239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 19:22:09 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 19:22:08 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5A1582CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 19:22:06 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7I9LxTG22609992
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 19:22:07 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7I9LXC0027692
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 19:21:34 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 0/8] KASAN ppc64 support
In-Reply-To: <CAPAsAGz40+1+P7ANVjU0WKCsiF4=sKNEs2+Jx_gdcKpkL5nL+A@mail.gmail.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439794492.2416.8.camel@kernel.crashing.org>
 <87mvxqp7l5.fsf@linux.vnet.ibm.com>
 <CAPAsAGzLY86BLT2KwE+dc=R+rnTPbMbxH_V4eror-Nvnd=3K8w@mail.gmail.com>
 <87zj1pnodu.fsf@linux.vnet.ibm.com>
 <CAPAsAGz40+1+P7ANVjU0WKCsiF4=sKNEs2+Jx_gdcKpkL5nL+A@mail.gmail.com>
Date: Tue, 18 Aug 2015 14:51:06 +0530
Message-ID: <87wpwtne9p.fsf@linux.vnet.ibm.com>
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

> 2015-08-18 8:42 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>> Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:
>>
>>
>> But that is introducting conditionals in core code for no real benefit.
>> This also will break when we eventually end up tracking vmalloc ?
>
> Ok, that's a very good reason to not do this.
>
> I see one potential problem in the way you use kasan_zero_page, though.
> memset/memcpy of large portions of memory ( > 8 * PAGE_SIZE) will end up
> in overflowing kasan_zero_page when we check shadow in memory_is_poisoned_n()
>

Any suggestion on how to fix that ? I guess we definitely don't want to
check for addr and size in memset/memcpy. The other option is to
do zero page mapping as is done for other architectures. That is we map
via page table a zero page. But we still have the issue of memory we
need to map the entire vmalloc range (page table memory). I was hoping to
avoid all those complexities.


-aneesh
