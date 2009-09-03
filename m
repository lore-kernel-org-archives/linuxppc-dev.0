Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep19-int.chello.at (viefep19-int.chello.at [62.179.121.39])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 75A83B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 19:45:44 +1000 (EST)
Subject: Re: [v4 PATCH 1/5]: cpuidle: Cleanup drivers/cpuidle/cpuidle.c
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20090903044253.GA31928@linux.vnet.ibm.com>
References: <20090901113704.GG7599@linux.vnet.ibm.com>
	<20090901113840.GH7599@linux.vnet.ibm.com>
	<1251870144.7547.48.camel@twins>
	<20090903044253.GA31928@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Thu, 03 Sep 2009 11:40:38 +0200
Message-Id: <1251970838.7447.23.camel@twins>
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

On Thu, 2009-09-03 at 10:12 +0530, Arun R Bharadwaj wrote:

> > OK, that's a start I guess. Best would be to replace all of pm_idle with
> > cpuidle, which is what should have been done from the very start.
> > 
> > If cpuidle cannot fully replace the pm_idle functionality, then it needs
> > to fix that. But having two layers of idle functions is just silly.
> > 
> > Looking at patch 2 and 3, you're making the same mistake on power, after
> > those patches there are multiple ways of registering idle functions, one
> > through some native interface and one through cpuidle, this strikes me
> > as undesirable.
> > 
> > If cpuidle is a good idle function manager, then it should be good
> > enough to be the sole one, if its not, then why bother with it at all.
> > 
> 
> Okay, I'm giving this approach a shot now. i.e. trying to make cpuidle
> as _the_ sole idle function manager. This would mean doing away with
> pm_idle and ppc_md.power_save. And, cpuidle_idle_call() which is the
> main idle loop of cpuidle, present in drivers/cpuidle/cpuidle.c will
> have to be called from arch specific code of cpu_idle()
> 
> Also this would mean enabling cpuidle for all platforms, even if the
> platform doesn't have multiple idle states. So suppose a platform doesnt
> have multiple states, it wouldn't want the bloated code of cpuidle
> governors, and would want just a simple cpuidle loop.

Do talk to the powerpc maintainers about this. But yes, something like
that should be doable.

AFAICT the whole governor thing is optional and cpuidle provides a
spinning idle loop by default, and platforms can always register a
simple alternative when they set up bits -- the only thing to be careful
about is not creating a chicken-egg problem where the platform setup
runs before cpuidle is able to register a new handler or something.

I'd be delighted to see the end of pm_idle on x86.
