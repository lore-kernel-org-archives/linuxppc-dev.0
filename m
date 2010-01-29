Return-Path: <jschopp@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC196B7D18
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Jan 2010 05:41:54 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0TIRjt5030925
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 11:27:45 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0TIfeUU092294
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 11:41:41 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0TIfd8A014313
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 11:41:40 -0700
Message-ID: <4B632BE2.9020106@austin.ibm.com>
Date: Fri, 29 Jan 2010 12:41:38 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv3 2/2] powerpc: implement arch_scale_smt_power for Power7
References: <1264017638.5717.121.camel@jschopp-laptop>	
	<1264017847.5717.132.camel@jschopp-laptop>	
	<1264548495.12239.56.camel@jschopp-laptop>	
	<1264720855.9660.22.camel@jschopp-laptop>	
	<1264721088.10385.1.camel@jschopp-laptop>
	<1264728185.20211.34.camel@pasglop>
In-Reply-To: <1264728185.20211.34.camel@pasglop>
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

Benjamin Herrenschmidt wrote:
> On Thu, 2010-01-28 at 17:24 -0600, Joel Schopp wrote:
>   
>> On Power7 processors running in SMT4 mode with 2, 3, or 4 idle threads 
>> there is performance benefit to idling the higher numbered threads in
>> the core.  
>>
>> This patch implements arch_scale_smt_power to dynamically update smt
>> thread power in these idle cases in order to prefer threads 0,1 over
>> threads 2,3 within a core.
>>     
>
> Almost there :-) Joel, Peter, can you help me figure something out tho ?
>
> On machine that don't have SMT, I would like to avoid calling
> arch_scale_smt_power() at all if possible (in addition to not compiling
> it in if SMT is not enabled in .config).
>
> Now, I must say I'm utterly confused by how the domains are setup and I
> haven't quite managed to sort it out... it looks to me that
> SD_SHARE_CPUPOWER is always going to be set on all CPUs when the config
> option is set (though each CPU will have its own domain) or am I
> misguided ? IE. Is there any sense in having at least a fast exit path
> out of arch_scale_smt_power() for non-SMT CPUs ?
>
> Joel, can you look at compiling it out when SMT is not set ? We don't
> want to bloat SMP kernels for 32-bit non-SMT embedded platforms.
>   
I can wrap the powerpc definition of arch_scale_smt in an #ifdef, if 
it's not there the scheduler uses the default, which is the same as it 
uses if SMT isn't compiled. 
