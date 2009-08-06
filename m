Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9EEDAB70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 23:58:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02F11DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 23:58:43 +1000 (EST)
Message-Id: <F93D43D2-FBFC-47E5-B847-290E8A8FD029@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kenneth Johansson <kenneth@southpole.se>
In-Reply-To: <1249512585.13069.9.camel@localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: kexec on e300 core / mpc5121
Date: Thu, 6 Aug 2009 08:58:20 -0500
References: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
	<1249512585.13069.9.camel@localhost>
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 5, 2009, at 5:49 PM, Kenneth Johansson wrote:

> On Wed, 2009-08-05 at 01:06 +0200, Sebastian Andrzej Siewior wrote:
>> I've tried kexec on e300 core which should be easy since it is  
>> possible
>> to disable the MMU on that core. However it does not work.
>
> Is it not possible to disable the mmu on all cpu's that have one ??

Nope.  Book-E class PPC parts always have the mmu.

>> Once I disable the MMU, I can't access my MBAR and print chars on the
>> serial port. Is this "normal" or do I have still some caches on?
>
> Yes cache and mmu is separate. the 5121 is not cache coherent and do  
> not
> limit cache to only memory regions so serial port or any memory mapped
> register is a no no unless you have cache off or cache on and mmu on
> with a correct setting for what address range to cache.
>
> Before you turn off the cache you need to flush out all dirty data.  
> best
> done by simply reading in 32kb of crap from somewhere. otherwise you  
> are
> sure to loose at least the stack and you do not want that.

- k
