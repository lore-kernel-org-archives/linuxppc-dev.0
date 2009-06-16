Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EE993B71B9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 08:27:47 +1000 (EST)
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 18601DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 08:27:46 +1000 (EST)
Date: Wed, 17 Jun 2009 00:27:23 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
Message-ID: <20090616222723.GA18394@iram.es>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
	<alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
	<4A34E4A5.3040306@redhat.com>
	<18996.60235.178618.531664@cargo.ozlabs.ibm.com>
	<4A34F564.2010500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A34F564.2010500@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 14, 2009 at 04:04:36PM +0300, Avi Kivity wrote:
> Paul Mackerras wrote:
>> Avi Kivity writes:
>>
>>   
>>> An alternative implementation using 64-bit cmpxchg will recover most 
>>> of the costs of hashed spinlocks.  I assume most serious 32-bit  
>>> architectures have them?
>>>     
>>
>> Have a 64-bit cmpxchg, you mean?  x86 is the only one I know of, and
>> it already has an atomic64_t implementation using cmpxchg8b (or
>> whatever it's called).
>>   
>
> Yes (and it is cmpxchg8b).  I'm surprised powerpc doesn't have DCAS support.

Well, s390 and m68k have the equivalent (although I don't think Linux
suppiorts SMP m68k, although some dual 68040/68060 boards have existed).

But 32 bit PPC will never have it. It just does not fit in the architecture
since integer loads and stores are limited to 32 bit (or split into 32 bit
chunks). Besides that there is no instruction that performs a read-modify-write
of memory. This would make the LSU much more complex for a corner case.

Hey, Intel also botched the first implementation of cmpxchg8b on the Pentium:
the (in)famous f00f bug is actually "lock cmpxchg8b" with a register operand.

Now for these counters, other solutions could be considered, like using
the most significant bit as a lock and having "only" 63 usable bits (when 
counting ns, this overflows at 292 years). 

>
>> My thinking is that the 32-bit non-x86 architectures will be mostly
>> UP, so the overhead is just an interrupt enable/restore.  Those that
>> are SMP I would expect to be small SMP -- mostly just 2 cpus and maybe
>> a few 4-way systems.
>>   
>
> The new Nehalems provide 8 logical threads in a single socket.  All  
> those threads share a cache, and they have cmpxchg8b anyway, so this  
> won't matter.
>

The problem is not Nehalem (who wants to run 32 bit kernels on a Nehalem
anyway) or x86.

The problem is that the assumption that the largest PPC32 SMP are 4 way
may be outdated:

http://www.freescale.com/webapp/sps/site/prod_summary.jsp?fastpreview=1&code=P4080

and some products including that processor have been announced (I don't know
whether they are shipping or not) and (apparently) run Linux.

	Gabriel
