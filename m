Return-Path: <john.stultz@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 503871A0225
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 01:30:47 +1000 (EST)
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA5641400A0
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2014 01:30:46 +1000 (EST)
Received: by mail-pd0-f174.google.com with SMTP id fp1so12748004pdb.19
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2014 08:30:44 -0700 (PDT)
Message-ID: <53EA3320.90908@linaro.org>
Date: Tue, 12 Aug 2014 08:30:40 -0700
From: John Stultz <john.stultz@linaro.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [tip:timers/core] timekeeping: Fixup typo in update_vsyscall_old
 definition
References: <1406349439-11785-1-git-send-email-john.stultz@linaro.org>	
 <tip-953dec21aed4038464fec02f96a2f1b8701a5bce@git.kernel.org>
 <1407730744.4508.67.camel@pasglop>
In-Reply-To: <1407730744.4508.67.camel@pasglop>
Content-Type: text/plain; charset=utf-8
Cc: sfr@canb.auug.org.au, peterz@infradead.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, hpa@zytor.com, tglx@linutronix.de,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2014 09:19 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2014-07-30 at 00:31 -0700, tip-bot for John Stultz wrote:
>> Commit-ID:  953dec21aed4038464fec02f96a2f1b8701a5bce
>> Gitweb:     http://git.kernel.org/tip/953dec21aed4038464fec02f96a2f1b8=
701a5bce
>> Author:     John Stultz <john.stultz@linaro.org>
>> AuthorDate: Fri, 25 Jul 2014 21:37:19 -0700
>> Committer:  Thomas Gleixner <tglx@linutronix.de>
>> CommitDate: Wed, 30 Jul 2014 09:26:25 +0200
>>
>> timekeeping: Fixup typo in update_vsyscall_old definition
>>
>> In commit 4a0e637738f0 ("clocksource: Get rid of cycle_last"),
>> currently in the -tip tree, there was a small typo where cycles_t
>> was used intstead of cycle_t. This broke ppc64 builds.
> There's another bug in there... You fix timespec vs. timespec64 for the=

> first argument of update_vsyscall_old but not the second one ...
> (wall_to_monotonic).
>
> Also, in e2dff1ec0 you claim this is "minor", you seem to forget that
> arch/powerpc also deals with 32-bit kernels which use the same time
> keeping code, so we have a pretty serious regressions here...
Yikes. My apologies. I had missed that issue and had forgotten ppc32 has
the vsyscall support as well.

Thanks for pointing it out. I'll send a fix here shortly (though I only
have the ppc64le toolchain handy, so forgive me if its not quite right).


> BTW. Is there some documentation you can point me to to figure out what=

> replace that "_OLD" stuff so we can update to whatever is "new" ?

So there's not exactly documentation, but the idea is rather then doing:

nsecs +  (mult*(now - cycle_last) >>shift);

We're preserving the sub-nanosecond precision, and doing:

(shifted_nsecs + mult*(now-cycle_last)) >> shift

This avoids the rounding up 1ns every tick, which we did to avoid errors
from truncating the precision.

I think the hard part for ppc, is if I recall, ppc's vsyscall exports
the xsec unit, which less granular then nanoseconds, so it had its own
version of the same precision truncation issues. I recall Paul working
on that, and I thought his solution was to reduce the multiplier by one
so the inter-tick time was slightly slower, then the tick update would
catch up causing a slight stair-step, which isn't ideal but is better
then the inconsistencies that came out of not-handling the precision
properly. That said, skimming the ppc code, I don't see that logic right
off, and have a fuzzy memory that maybe that solution was RHEL5 specific
or something like that.

thanks
-john
