Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9qKb2vJPzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 05:59:13 +1100 (AEDT)
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v99IxBj1014372
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 18:59:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v99IxBBs026883
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 18:59:11 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v99IxBPv028356
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 18:59:11 GMT
Received: by mail-oi0-f41.google.com with SMTP id v132so22025221oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 11:59:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171009184834.GE30828@arm.com>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
 <20171009182217.GC30828@arm.com>
 <CAOAebxu1310eCrk88EC=Oaw3n90-9RuHZ1KBhPvLu_DyXBNZFQ@mail.gmail.com>
 <20171009184834.GE30828@arm.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 9 Oct 2017 14:59:09 -0400
Message-ID: <CAOAebxs5s3DKV8f+Zw+LFVB98PE6cs=RwcOH8qEiU_MPLM9RvQ@mail.gmail.com>
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 sam@ravnborg.org, mgorman@techsingularity.net,
 Steve Sistare <steven.sistare@oracle.com>, daniel.m.jordan@oracle.com,
 bob.picco@oracle.com
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

> We have two table walks even with your patch series applied afaict: one in
> our definition of vmemmap_populate (arch/arm64/mm/mmu.c) and this one
> in the core code.

I meant to say implementing two new page table walkers, not at runtime.

> My worry is that these are actually highly arch-specific, but will likely
> grow more users in mm/ that assume things for all architectures that aren't
> necessarily valid.

I see, how about moving new kasan_map_populate() implementation into
arch dependent code:

arch/x86/mm/kasan_init_64.c
arch/arm64/mm/kasan_init.c

This way we won't need to add pmd_large()/pud_large() macros for arm64?

Pavel
