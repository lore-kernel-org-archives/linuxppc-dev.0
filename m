Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6AE6E67B61
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 20:41:21 +1000 (EST)
In-Reply-To: <17671.54461.77700.184852@cargo.ozlabs.ibm.com>
References: <17671.54461.77700.184852@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4EB1450F-687F-472E-BFB0-4803B61617E0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix MMIO ops to provide expected barrier behaviour
Date: Wed, 13 Sep 2006 12:41:01 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This changes the writeX family of functions to have a sync instruction
> before the MMIO store rather than after, because the generally  
> expected
> behaviour is that the device receiving the MMIO store can be  
> guaranteed
> to see the effects of any preceding writes to normal memory.

Yay, progress!

> To preserve ordering between writeX and readX, the readX family of
> functions have had an eieio added before the load.

readX() is supposed to be ordered to memory as well; the only
example I can think of where the difference would would show is
a readX() setting off a DMA; maybe such devices do not exist
anyway, but if you care, the eieio should be a full sync.

> Although writeX followed by spin_unlock is not officially guaranteed
> to keep the writeX inside the spin-locked region unless an mmiowb()
> is used, there are currently drivers that depend on the previous
> behaviour on powerpc, which was that the mmiowb wasn't actually  
> required.
> Therefore we have a per-cpu flag that is set by writeX, cleared by
> __raw_spin_lock and mmiowb, and tested by __raw_spin_unlock.  If it is
> set, __raw_spin_unlock does a sync and clears it.

Why is this done on 64-bit systems only?


Segher
