Return-Path: <rick.jones2@hp.com>
Received: from g5t0006.atlanta.hp.com (g5t0006.atlanta.hp.com [15.192.0.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37B8EDDF18
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 02:44:03 +1000 (EST)
Message-ID: <4821D9D5.9000103@hp.com>
Date: Wed, 07 May 2008 09:33:25 -0700
From: Rick Jones <rick.jones2@hp.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [RFC] gianfar: low gigabit throughput
References: <20080506192008.GA30148@polina.dev.rtsoft.ru>	<4820BA72.3090903@hp.com>
	<20080507132823.GA10988@polina.dev.rtsoft.ru>
In-Reply-To: <20080507132823.GA10988@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>I have _got_ to make CPU utilization enabled by default one of these  
>>days :)  At least for mechanisms which don't require calibration.
> 
> 
> Heh, I've skipped the calibration chapter in the netperf manual. :-D
> Should revert to it.

Under linux, the CPU utilization mechanism in netperf does not require 
calibration, so you can add a -c (and -C if the remote is also linux) to 
the global command line options.  Netperf will the report CPU util and 
calculate the "service demand" which will be the quantity of CPU 
consumed per unit of work.

> So things becomes much better when the message size increases
> (I think the netperf then eating less cpu, and gives some precessing
> time to the kernel?).

Unless the compiler isn't doing a very good job, or perhaps if you've 
enabled histograms (./configure --enable-histogram) and set verbosity to 
2 or more (not the case here), netperf itself shouldn't be consuming 
very much CPU at all up in user space.  Now, as the size of the buffers 
passed to the transport increases, it does mean fewer system calls per 
KB transferred, which should indeed be more efficient.

>>What is the nature of the DMA stream between the two tests?  I find it  
>>interesting that the TCP Mb/s went up by more than the CPU MHz and  
>>wonder how much the Bus MHz came into play there - perhaps there were  
>>more DMA's to setup or across a broader memory footprint for TCP than  
>>for UDP.
> 
> 
> The gianfar indeed does a lot of dma on the "buffer descriptors", so
> probably the bus speed matters a lot. And combination of CPU and Bus
> gives the final result.

Do you have any way to calculate bus utilization - logic analyzer, or 
perhaps some performance counters in the hardware?

If you have an HP-UX or Solaris system handy to act as a receiver, you 
might give that a try - it would be interesting to see the effect of 
their ACK avoidance heuristics on TCP throughput.  One non-trivial 
difference I keep forgetting to mention is that TCP will have that 
returning ACK stream that UDP will not.

rick jones
