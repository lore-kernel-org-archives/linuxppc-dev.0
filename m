Return-Path: <jschopp@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF0D4B7D1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Jan 2010 05:34:53 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0TIPDaq013955
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 13:25:13 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0TIYnDd1871900
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 13:34:49 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0TIYmbA015143
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 16:34:48 -0200
Message-ID: <4B632A47.4070103@austin.ibm.com>
Date: Fri, 29 Jan 2010 12:34:47 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv3 2/2] powerpc: implement arch_scale_smt_power for Power7
References: <1264017638.5717.121.camel@jschopp-laptop>	
	<1264017847.5717.132.camel@jschopp-laptop>	
	<1264548495.12239.56.camel@jschopp-laptop>	
	<1264720855.9660.22.camel@jschopp-laptop>	
	<1264721088.10385.1.camel@jschopp-laptop>	
	<1264728185.20211.34.camel@pasglop>
	<1264760027.4283.2164.camel@laptop>
In-Reply-To: <1264760027.4283.2164.camel@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> That said, I'm still not entirely convinced I like this usage of
> cpupower, its supposed to be a normalization scale for load-balancing,
> not a placement hook.
>   
Even if you do a placement hook you'll need to address it in the load 
balancing as well.  Consider a single 4 thread SMT core with 4 running 
tasks.  If 2 of them exit the remaining 2 will need to be load balanced 
within the core in a way that takes into account the dynamic nature of 
the thread power.  This patch does that.
> I'd be much happier with a SD_GROUP_ORDER or something like that, that
> works together with SD_PREFER_SIBLING to pack active tasks to cpus in
> ascending group order.
>
>   
I don't see this load-balancing patch as mutually exclusive with a patch 
to fix placement.  But even if it is a mutually exclusive solution there 
is no reason we can't fix things now with this patch and then later take 
it out when it's fixed another way.  This patch series is 
straightforward, non-intrusive, and without it the scheduler is broken 
on this processor. 
