Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9nqv4qhdzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 04:51:54 +1100 (AEDT)
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v99Hpn0D025544
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 17:51:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v99HpmBZ006671
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 17:51:48 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v99Hpmjf023190
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 17:51:48 GMT
Received: by mail-oi0-f53.google.com with SMTP id v9so28912265oif.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 10:51:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171009171337.GE30085@arm.com>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 9 Oct 2017 13:51:47 -0400
Message-ID: <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
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

I can go back to that approach, if Michal OK with it. But, that would
mean that I would need to touch every single architecture that
implements vmemmap_populate(), and also pass flags at least through
these functions on every architectures (some have more than one
decided by configs).:

vmemmap_populate()
vmemmap_populate_basepages()
vmemmap_populate_hugepages()
vmemmap_pte_populate()
__vmemmap_alloc_block_buf()
alloc_block_buf()
vmemmap_alloc_block()

IMO, while I understand that it looks strange that we must walk page
table after creating it, it is a better approach: more enclosed as it
effects kasan only, and more universal as it is in common code. We are
also somewhat late in the review process, means we will need again to
get ACKs from the maintainers of other arches.

Pavel

On Mon, Oct 9, 2017 at 1:13 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Oct 03, 2017 at 03:48:46PM +0100, Mark Rutland wrote:
>> On Wed, Sep 20, 2017 at 04:17:11PM -0400, Pavel Tatashin wrote:
>> > During early boot, kasan uses vmemmap_populate() to establish its shadow
>> > memory. But, that interface is intended for struct pages use.
>> >
>> > Because of the current project, vmemmap won't be zeroed during allocation,
>> > but kasan expects that memory to be zeroed. We are adding a new
>> > kasan_map_populate() function to resolve this difference.
>>
>> Thanks for putting this together.
>>
>> I've given this a spin on arm64, and can confirm that it works.
>>
>> Given that this involes redundant walking of page tables, I still think
>> it'd be preferable to have some common *_populate() helper that took a
>> gfp argument, but I guess it's not the end of the world.
>>
>> I'll leave it to Will and Catalin to say whether they're happy with the
>> page table walking and the new p{u,m}d_large() helpers added to arm64.
>
> To be honest, it just looks completely backwards to me; we're walking the
> page tables we created earlier on so that we can figure out what needs to
> be zeroed for KASAN. We already had that information before, hence my
> preference to allow propagation of GFP_FLAGs to vmemmap_alloc_block when
> it's needed. I know that's not popular for some reason, but is walking the
> page tables really better?
>
> Will
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
