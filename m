Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3y9qP05HK2zDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 06:02:11 +1100 (AEDT)
Date: Mon, 9 Oct 2017 20:02:13 +0100
From: Will Deacon <will.deacon@arm.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 sam@ravnborg.org, mgorman@techsingularity.net,
 Steve Sistare <steven.sistare@oracle.com>,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
Message-ID: <20171009190213.GF30828@arm.com>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
 <20171009182217.GC30828@arm.com>
 <CAOAebxu1310eCrk88EC=Oaw3n90-9RuHZ1KBhPvLu_DyXBNZFQ@mail.gmail.com>
 <20171009184834.GE30828@arm.com>
 <CAOAebxs5s3DKV8f+Zw+LFVB98PE6cs=RwcOH8qEiU_MPLM9RvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOAebxs5s3DKV8f+Zw+LFVB98PE6cs=RwcOH8qEiU_MPLM9RvQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pavel,

On Mon, Oct 09, 2017 at 02:59:09PM -0400, Pavel Tatashin wrote:
> > We have two table walks even with your patch series applied afaict: one in
> > our definition of vmemmap_populate (arch/arm64/mm/mmu.c) and this one
> > in the core code.
> 
> I meant to say implementing two new page table walkers, not at runtime.

Ok, but I'm still missing why you think that is needed. What would be the
second page table walker that needs implementing?

> > My worry is that these are actually highly arch-specific, but will likely
> > grow more users in mm/ that assume things for all architectures that aren't
> > necessarily valid.
> 
> I see, how about moving new kasan_map_populate() implementation into
> arch dependent code:
> 
> arch/x86/mm/kasan_init_64.c
> arch/arm64/mm/kasan_init.c
> 
> This way we won't need to add pmd_large()/pud_large() macros for arm64?

I guess we could implement that on arm64 using our current vmemmap_populate
logic and an explicit memset.

Will
