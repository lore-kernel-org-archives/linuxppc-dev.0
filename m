Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 507A4DE0D0
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 08:07:10 +1000 (EST)
In-Reply-To: <1211402685.8297.247.camel@pasglop>
References: <20080521141056.GC8897@wotan.suse.de>
	<20080521141231.GD8897@wotan.suse.de>
	<1211383592.8297.195.camel@pasglop>
	<20080521153420.GG8897@wotan.suse.de>
	<1211384580.8297.199.camel@pasglop>
	<20080521160146.GI8897@wotan.suse.de>
	<7dc38d9080603be9c25b8f649e5df0a0@kernel.crashing.org>
	<1211402685.8297.247.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b88b9efaffd17fa5b53f1d8070a6844c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 2/2] powerpc: optimise smp_wmb
Date: Thu, 22 May 2008 00:07:00 +0200
To: benh@kernel.crashing.org
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The main question is do we care if the downgrade to sync on power3 
> hurts
> performances (and does it ?) and what do we do for 32 bits as 
> currently,
> no 32 bits implementation has lwsync afaik (though that might not be
> true for long).

Some time ago, I benchmarked (*) a loop of "stw;sync" vs. "stw;eieio"
on a 750 (yeah, great micro-benchmark, heh); and the sync version
was a factor ~100 slower.

> Also, we don't, I think, have verified that they all properly ignore 
> the
> added bit and behave as sync rather than program checking..

The architecture books don't have a programming note about this
(like they do in similar cases), so either a) it works fine on
every implementation; or b) someone forgot to add such a note.

We shouldn't use lwsync on 32-bit (it's an awful performance hit
on "classic" cpus, and who knows what it does on embedded cpus
(bookE *shudder*)).  For POWER3 and *star, i.e., all 64-bit?  Perhaps
it'll be okay there, but if as you suggest some 32-bit CPUs will add
proper lwsync support soonish, maybe a feature fixup or some such is
in order.


Segher


(*) Not on purpose.
