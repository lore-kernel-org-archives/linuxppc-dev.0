Return-Path: <jschopp@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BEBF6B7DC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 09:44:18 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0KMUPDY007546
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 15:30:25 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o0KMi8Nx076458
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 15:44:08 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0KMi4fv030535
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 15:44:04 -0700
Message-ID: <4B578731.2060709@austin.ibm.com>
Date: Wed, 20 Jan 2010 16:44:01 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] powerpc: implement arch_scale_smt_power for Power7
References: <1264017638.5717.121.camel@jschopp-laptop>	
	<1264017847.5717.132.camel@jschopp-laptop>
	<1264020517.4283.1117.camel@laptop>
In-Reply-To: <1264020517.4283.1117.camel@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ego@in.ibm.com, Andreas Herrmann <andreas.herrmann3@amd.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra wrote:
> On Wed, 2010-01-20 at 14:04 -0600, Joel Schopp wrote:
>   
>> On Power7 processors running in SMT4 mode with 2, 3, or 4 idle threads 
>> there is performance benefit to idling the higher numbered threads in
>> the core.  
>>     
>
> So this is an actual performance improvement, not only power savings?
>   
Yes.

>
>
> And you just wrecked x86 ;-)
>
> It has an smt_power implementation that tries to measure smt gains using
> aperf/mperf, trouble is that this represents the actual performance not
> the capacity. This has the problem that when idle it represents 0
> capacity and will not attract work.
>
> Coming up with something that actually works there is on the todo list,
> I was thinking perhaps temporal maximums from !idle.
>
> So if you want to go with this, you'll need to stub out
> arch/x86/kernel/cpu/sched.c
>   

OK.  Guess I now will have a 3 patch series, with a patch to stub out 
the x86 broken version.

Care to take Gautham's bugfix patch (patch 1/2) now, since it just fixes 
a bug?  You'll need it if you ever try to make the x86 broken version work.
