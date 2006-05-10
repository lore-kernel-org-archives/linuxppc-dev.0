Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A5B44679E6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 09:18:00 +1000 (EST)
In-Reply-To: <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
	<17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <49BB818F-DF88-43A3-8B6A-7F9F5C7A2C3C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Date: Thu, 11 May 2006 01:17:50 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, rth@twiddle.net,
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> How do you plan to address the compiler optimizing
>>  ...
>>> Across the schedule, we may have changed cpus, making the cached
>>> address invalid.
>>
>> Per-cpu variables need to be accessed only with preemption
>> disabled.  And the preemption enable/disable operations
>> provide a compiler memory barrier.
>
> No, Richard has a point, it's not the value that is the concern, it's
> the address, which gcc could assume is still valid after a barrier.
> Drat.

Would an asm clobber of GPR13 in the schedule routines (or a wrapper
for them, or whatever) work?


Segher
