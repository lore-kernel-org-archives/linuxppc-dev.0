Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64C361A1C0C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 18:13:56 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F9F51402B0
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 18:13:55 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 13:43:50 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8FBF83940062
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 13:43:44 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T8Dfcn50987114
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 13:43:42 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T8DeJK022368
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 13:43:41 +0530
Message-ID: <55B88B34.1030808@linux.vnet.ibm.com>
Date: Wed, 29 Jul 2015 13:43:40 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: [4/5] powerpc/perf: Change name & type of 'pred' in
 power_pmu_bhrb_read
References: <20150729032555.CE6CB140E41@ozlabs.org>
In-Reply-To: <20150729032555.CE6CB140E41@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2015 08:55 AM, Michael Ellerman wrote:
> On Tue, 2015-30-06 at 08:20:30 UTC, Anshuman Khandual wrote:
>> > Branch record attributes 'mispred' and 'predicted' are single bit
>> > fields as defined in the perf ABI. Hence the data type of the field
>> > 'pred' used during BHRB processing should be changed from integer
>> > to bool. This patch also changes the name of the variable from 'pred'
>> > to 'mispred' making the logical inversion process more meaningful
>> > and readable.
> This whole function is a mess.
> 
> There's no good reason why we're doing the assignment to pred/mispred in two
> places to begin with, so if that was eliminated we wouldn't need a local for
> mispred to begin with.

Not sure whether I got this right. We are assigning mispred once with
the value (val & BHRB_PREDICTION) and then assigning mispred and it's
inversion to two different fields of the branch entry as required.

> 
> Then there's the type juggling, all of which probably works but is fishy and
> horrible.

With this patch and one more (2nd patch of the BHRB SW filter series)
patch, we are trying to make it better.

> 
> You take a u64, bitwise and it with a mask, assign that to a boolean, then take

So that any residual positive value after the "AND" operation will
become logical TRUE for the boolean. We dont use any shifting here
as BHRB_PREDICTION checks for the right most (least significant) bit
in the sequence.

> the boolean, *bitwise* negate that and assign the result to a single bit
> bitfield.

This is getting fixed with a subsequent patch (2nd patch of the BHRB
SW filter series) in a new function called insert_branch.

+static inline void insert_branch(struct cpu_hw_events *cpuhw,
+                       int index, u64 from, u64 to, bool mispred)
+{
+       cpuhw->bhrb_entries[index].from = from;
+       cpuhw->bhrb_entries[index].to = to;
+       cpuhw->bhrb_entries[index].mispred = mispred;
+       cpuhw->bhrb_entries[index].predicted = !mispred;
+}
