Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10A74DE763
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:44:51 +1000 (EST)
Subject: Re: [patch 2/2] powerpc: optimise smp_wmb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <7dc38d9080603be9c25b8f649e5df0a0@kernel.crashing.org>
References: <20080521141056.GC8897@wotan.suse.de>
	<20080521141231.GD8897@wotan.suse.de>
	<1211383592.8297.195.camel@pasglop>
	<20080521153420.GG8897@wotan.suse.de>
	<1211384580.8297.199.camel@pasglop>
	<20080521160146.GI8897@wotan.suse.de>
	<7dc38d9080603be9c25b8f649e5df0a0@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 21 May 2008 16:44:45 -0400
Message-Id: <1211402685.8297.247.camel@pasglop>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 22:12 +0200, Segher Boessenkool wrote:
> No idea about POWER6; for CBE, the backend works similar to the
> 970 one.
> 
> Given that the architecture says to use lwsync for cases like this,
> it would be very surprising if it performed (much) worse than eieio,
> eh? ;-)  So I think your patch is a win; just wanted to clarify on
> your five-time slowdown number.

It makes sense to use lwsync rather than eieio for smb_wmb() as this is
not supposed to be used to order with cache inhibited storage. It's
really a data barrier used by the kernel for normal cacheable storage.

The main question is do we care if the downgrade to sync on power3 hurts
performances (and does it ?) and what do we do for 32 bits as currently,
no 32 bits implementation has lwsync afaik (though that might not be
true for long).

Also, we don't, I think, have verified that they all properly ignore the
added bit and behave as sync rather than program checking..

Ben.
