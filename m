Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6E3F5B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 14:43:06 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id n834eUoh026093
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2009 14:40:30 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n834h4xx1196266
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2009 14:43:04 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n834h2YT023868
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2009 14:43:03 +1000
Date: Thu, 3 Sep 2009 10:12:53 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v4 PATCH 1/5]: cpuidle: Cleanup drivers/cpuidle/cpuidle.c
Message-ID: <20090903044253.GA31928@linux.vnet.ibm.com>
References: <20090901113704.GG7599@linux.vnet.ibm.com>
	<20090901113840.GH7599@linux.vnet.ibm.com>
	<1251870144.7547.48.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1251870144.7547.48.camel@twins>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-09-02 07:42:24]:

> On Tue, 2009-09-01 at 17:08 +0530, Arun R Bharadwaj wrote:
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-01 17:07:04]:
> > 
> > Cleanup drivers/cpuidle/cpuidle.c
> > 
> > Cpuidle maintains a pm_idle_old void pointer because, currently in x86
> > there is no clean way of registering and unregistering a idle function.
> 
> Right, and instead of fixing that, they build this cpuidle crap on top,
> instead of replacing the current crap with it.
> 
> > So remove pm_idle_old and leave the responsibility of maintaining the
> > list of registered idle loops to the architecture specific code. If the
> > architecture registers cpuidle_idle_call as its idle loop, only then
> > this loop is called.
> 
> OK, that's a start I guess. Best would be to replace all of pm_idle with
> cpuidle, which is what should have been done from the very start.
> 
> If cpuidle cannot fully replace the pm_idle functionality, then it needs
> to fix that. But having two layers of idle functions is just silly.
> 
> Looking at patch 2 and 3, you're making the same mistake on power, after
> those patches there are multiple ways of registering idle functions, one
> through some native interface and one through cpuidle, this strikes me
> as undesirable.
> 
> If cpuidle is a good idle function manager, then it should be good
> enough to be the sole one, if its not, then why bother with it at all.
> 

Okay, I'm giving this approach a shot now. i.e. trying to make cpuidle
as _the_ sole idle function manager. This would mean doing away with
pm_idle and ppc_md.power_save. And, cpuidle_idle_call() which is the
main idle loop of cpuidle, present in drivers/cpuidle/cpuidle.c will
have to be called from arch specific code of cpu_idle()

Also this would mean enabling cpuidle for all platforms, even if the
platform doesn't have multiple idle states. So suppose a platform doesnt
have multiple states, it wouldn't want the bloated code of cpuidle
governors, and would want just a simple cpuidle loop.

--arun
> 
