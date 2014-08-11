Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 780781A008C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 14:20:03 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B6F6214008F
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2014 14:20:02 +1000 (EST)
Message-ID: <1407730744.4508.67.camel@pasglop>
Subject: Re: [tip:timers/core] timekeeping: Fixup typo in
 update_vsyscall_old definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john.stultz@linaro.org
Date: Mon, 11 Aug 2014 14:19:04 +1000
In-Reply-To: <tip-953dec21aed4038464fec02f96a2f1b8701a5bce@git.kernel.org>
References: <1406349439-11785-1-git-send-email-john.stultz@linaro.org>
 <tip-953dec21aed4038464fec02f96a2f1b8701a5bce@git.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, peterz@infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-30 at 00:31 -0700, tip-bot for John Stultz wrote:
> Commit-ID:  953dec21aed4038464fec02f96a2f1b8701a5bce
> Gitweb:     http://git.kernel.org/tip/953dec21aed4038464fec02f96a2f1b8701a5bce
> Author:     John Stultz <john.stultz@linaro.org>
> AuthorDate: Fri, 25 Jul 2014 21:37:19 -0700
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Wed, 30 Jul 2014 09:26:25 +0200
> 
> timekeeping: Fixup typo in update_vsyscall_old definition
> 
> In commit 4a0e637738f0 ("clocksource: Get rid of cycle_last"),
> currently in the -tip tree, there was a small typo where cycles_t
> was used intstead of cycle_t. This broke ppc64 builds.

There's another bug in there... You fix timespec vs. timespec64 for the
first argument of update_vsyscall_old but not the second one ...
(wall_to_monotonic).

Also, in e2dff1ec0 you claim this is "minor", you seem to forget that
arch/powerpc also deals with 32-bit kernels which use the same time
keeping code, so we have a pretty serious regressions here...

BTW. Is there some documentation you can point me to to figure out what
replace that "_OLD" stuff so we can update to whatever is "new" ?

Cheers,
Ben.
