Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7M804TBszDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:42:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andi Kleen <andi@firstfloor.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [GIT PULL] Please pull JSON files for Power9 PMU events
In-Reply-To: <20170712144611.GN27350@kernel.org>
References: <20170712020827.GB31223@us.ibm.com>
 <87a849luvr.fsf@concordia.ellerman.id.au> <20170712144611.GN27350@kernel.org>
Date: Thu, 13 Jul 2017 13:42:06 +1000
Message-ID: <871splknox.fsf@concordia.ellerman.id.au>
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

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Wed, Jul 12, 2017 at 10:09:12PM +1000, Michael Ellerman escreveu:
>> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
>> > Please pull the JSON files for POWER9 PMU events.
>
>> >       perf vendor events: Add POWER9 PMU events
>> >       perf vendor events: Add POWER9 PVRs to mapfile
>  
>> I think the PVRs need work.
>  
>> You have:
>  
>> +004e0100,1,power9.json,core
>> +004e0000,1,power9.json,core
>  
>> The first is P9 DD1, but the second doesn't exist. We have it in the
>> kernel, but with a mask of 0xffff0000. From memory the perf code doesn't
>> do any masking or anything fancy, it looks for an exact match.
>  
>> So for starters you should probably drop that one and add 0x004e1200 and
>> 0x004e0200.
>
> Could this check be somehow done automatically? Using whatever is in the
> kernel sources or some IBM released document?

Not really no.

The kernel defines the major versions in arch/powerpc/include/asm/reg.h.

eg:

#define PVR_POWER8E	0x004B
#define PVR_POWER8NVL	0x004C
#define PVR_POWER8	0x004D
#define PVR_POWER9	0x004E


But that's only the top part of the value perf is looking for. To match
the full value you also need the minor revision.

I don't actually have an exhaustive list of all the Power8 revisions
that were/will ever be made. And for Power9 I definitely can't give you
a full list yet.

We do want to be able to match against the full PVR, in case we need a
different set of events for a particularly CPU revision.

But we could make it easier to maintain by making the search iterative.
ie. instead of just looking for an exact match, we could say that the
mapfile is sorted, and the first entry that matches will be used.

With a mapfile like:

004e0100,1,power9.json,core
004e,1,power9.json,core

That would match Power9 DD1 on the first line, but all other Power9 CPUs
would hit the second line. Obviously get_cpuid_str() would need to be
reworked to be match_cpuid_str() or something.

cheers
