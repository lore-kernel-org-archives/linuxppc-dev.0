Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9pyV4plfzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 05:42:42 +1100 (AEDT)
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v99IgdvP026894
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 18:42:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v99IgcMw030585
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 18:42:38 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v99IgcCp022045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 18:42:38 GMT
Received: by mail-oi0-f49.google.com with SMTP id j126so41340757oia.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 11:42:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171009182217.GC30828@arm.com>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
 <20171009182217.GC30828@arm.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 9 Oct 2017 14:42:32 -0400
Message-ID: <CAOAebxu1310eCrk88EC=Oaw3n90-9RuHZ1KBhPvLu_DyXBNZFQ@mail.gmail.com>
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, sam@ravnborg.org,
 mgorman@techsingularity.net, Steve Sistare <steven.sistare@oracle.com>,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Will,

In addition to what Michal wrote:

> As an interim step, why not introduce something like
> vmemmap_alloc_block_flags and make the page-table walking opt-out for
> architectures that don't want it? Then we can just pass __GFP_ZERO from
> our vmemmap_populate where necessary and other architectures can do the
> page-table walking dance if they prefer.

I do not see the benefit, implementing this approach means that we
would need to implement two table walks instead of one: one for x86,
another for ARM, as these two architectures support kasan. Also, this
would become a requirement for any future architecture that want to
add kasan support to add this page table walk implementation.

>> IMO, while I understand that it looks strange that we must walk page
>> table after creating it, it is a better approach: more enclosed as it
>> effects kasan only, and more universal as it is in common code.
>
> I don't buy the more universal aspect, but I appreciate it's subjective.
> Frankly, I'd just sooner not have core code walking early page tables if
> it can be avoided, and it doesn't look hard to avoid it in this case.
> The fact that you're having to add pmd_large and pud_large, which are
> otherwise unused in mm/, is an indication that this isn't quite right imo.

 28 +#define pmd_large(pmd)         pmd_sect(pmd)
 29 +#define pud_large(pud)         pud_sect(pud)

it is just naming difference, ARM64 calls them pmd_sect, common mm and
other arches call them
pmd_large/pud_large. Even the ARM has these defines in

arm/include/asm/pgtable-3level.h
arm/include/asm/pgtable-2level.h

Pavel
