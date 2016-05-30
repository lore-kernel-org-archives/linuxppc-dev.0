Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x22d.google.com (mail-qk0-x22d.google.com
 [IPv6:2607:f8b0:400d:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJHHK3n6xzDr3F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:18:05 +1000 (AEST)
Received: by mail-qk0-x22d.google.com with SMTP id h185so83319382qke.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 06:18:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160530091504.GN2527@techsingularity.net>
References: <1462435033-15601-1-git-send-email-oohall@gmail.com>
 <20160526142142.b16f7f3f18204faf0823ac65@linux-foundation.org>
 <20160530091504.GN2527@techsingularity.net>
Date: Mon, 30 May 2016 23:18:03 +1000
Message-ID: <CAOSf1CGCMxExXztXZ233DTDSEVbrd7Kj7U4JRY_rP2KFmXtY5g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/init: fix zone boundary creation
From: oliver <oohall@gmail.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 30, 2016 at 7:15 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
> On Thu, May 26, 2016 at 02:21:42PM -0700, Andrew Morton wrote:
>> On Thu,  5 May 2016 17:57:13 +1000 "Oliver O'Halloran" <oohall@gmail.com> wrote:
>>
>> > As a part of memory initialisation the architecture passes an array to
>> > free_area_init_nodes() which specifies the max PFN of each memory zone.
>> > This array is not necessarily monotonic (due to unused zones) so this
>> > array is parsed to build monotonic lists of the min and max PFN for
>> > each zone. ZONE_MOVABLE is special cased here as its limits are managed by
>> > the mm subsystem rather than the architecture. Unfortunately, this special
>> > casing is broken when ZONE_MOVABLE is the not the last zone in the zone
>> > list. The core of the issue is:
>> >
>> >     if (i == ZONE_MOVABLE)
>> >             continue;
>> >     arch_zone_lowest_possible_pfn[i] =
>> >             arch_zone_highest_possible_pfn[i-1];
>> >
>> > As ZONE_MOVABLE is skipped the lowest_possible_pfn of the next zone
>> > will be set to zero. This patch fixes this bug by adding explicitly
>> > tracking where the next zone should start rather than relying on the
>> > contents arch_zone_highest_possible_pfn[].
>>
>> hm, this is all ten year old Mel code.
>>
>
> ZONE_MOVABLE at the time always existed at the end of a node during
> initialisation time. It was allowed because the memory was always "stolen"
> from the end of the node where it could have the same limitations as
> ZONE_HIGHMEM if necessary. It was also safe to assume that zones never
> overlapped as zones were about addressing limitations. If ZONE_CMA or
> ZONE_DEVICE can overlap with other zones during initialisation time then
> there may be a few gremlins hiding in there. Unfortunately I have not
> done an audit searching for problems with overlapping zones.

I think it's still reasonable to assume there is no overlap in early init. The
interface to free_area_init_nodes() ensures that zones are disjoint and as far
as I can tell the only way to get an overlapping zone at that point is to hit
the bug this patch fixes. ZONE_CMA is only populated when core_initcall()s are
processed and ZONE_DEVICE is hotplugged by drivers so it should appear even
later.
