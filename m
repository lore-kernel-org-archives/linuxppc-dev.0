Return-Path: <jschopp@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 077BCB7D08
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 09:39:36 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0SMUnUm012400
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 17:30:49 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0SMdJxS113636
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 17:39:23 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0SMdIt4026106
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2010 17:39:19 -0500
Message-ID: <4B621213.2010805@austin.ibm.com>
Date: Thu, 28 Jan 2010 16:39:15 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv2 2/2] powerpc: implement arch_scale_smt_power for Power7
References: <1264017638.5717.121.camel@jschopp-laptop>	
	<1264017847.5717.132.camel@jschopp-laptop>	
	<1264548495.12239.56.camel@jschopp-laptop>
	<1264553577.3601.144.camel@pasglop>
In-Reply-To: <1264553577.3601.144.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>
> What about an early exit if !cpu_has_feature(CPU_FTR_SMT) ? That would
> de-facto compile it out for 32-bit CPU platforms that don't support SMT
> at all and avoid some overhead on POWER3,4,970...
>   
If the SD_SHARE_CPUPOWER flag isn't set for the sched domain this 
function isn't called.  So an extra check here is wasteful.
>   
>> +	unsigned long weight = cpumask_weight(sibling_map);
>> +	unsigned long smt_gain = sd->smt_gain;
>> +
>> +	if (cpu_has_feature(CPU_FTR_ASYNC_SMT4) && weight == 4) {
>>     
>
> So that will only handle the case where all 4 threads are online right ?
> There is no provision for the case where the user play tricks like
> offlining thread, in which case it will stop trying to "push down"
> processes right ? Not a big deal per-se I suppose, just something to be
> aware of.
>   
I've tested it with manually offlined threads and it behaves as I'd like 
it to.
> Also, can you add a comment as to why this is done in the code itself ?
> above the if (cpu_has_feature(...)) statement.
>   
OK. v3 coming soon with the comment.
