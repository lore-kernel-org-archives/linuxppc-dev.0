Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep15-int.chello.at (viefep15-int.chello.at [62.179.121.35])
	by bilbo.ozlabs.org (Postfix) with ESMTP id B3A03B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 15:47:40 +1000 (EST)
Subject: Re: [v4 PATCH 1/5]: cpuidle: Cleanup drivers/cpuidle/cpuidle.c
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20090901113840.GH7599@linux.vnet.ibm.com>
References: <20090901113704.GG7599@linux.vnet.ibm.com>
	<20090901113840.GH7599@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 07:42:24 +0200
Message-Id: <1251870144.7547.48.camel@twins>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-01 at 17:08 +0530, Arun R Bharadwaj wrote:
> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-01 17:07:04]:
> 
> Cleanup drivers/cpuidle/cpuidle.c
> 
> Cpuidle maintains a pm_idle_old void pointer because, currently in x86
> there is no clean way of registering and unregistering a idle function.

Right, and instead of fixing that, they build this cpuidle crap on top,
instead of replacing the current crap with it.

> So remove pm_idle_old and leave the responsibility of maintaining the
> list of registered idle loops to the architecture specific code. If the
> architecture registers cpuidle_idle_call as its idle loop, only then
> this loop is called.

OK, that's a start I guess. Best would be to replace all of pm_idle with
cpuidle, which is what should have been done from the very start.

If cpuidle cannot fully replace the pm_idle functionality, then it needs
to fix that. But having two layers of idle functions is just silly.

Looking at patch 2 and 3, you're making the same mistake on power, after
those patches there are multiple ways of registering idle functions, one
through some native interface and one through cpuidle, this strikes me
as undesirable.

If cpuidle is a good idle function manager, then it should be good
enough to be the sole one, if its not, then why bother with it at all.
