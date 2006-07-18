Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A8B967B83
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 04:39:25 +1000 (EST)
Subject: RE: AltiVec in the kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: matt@genesi-usa.com
In-Reply-To: <005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
References: <005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 14:39:13 -0400
Message-Id: <1153247953.5905.63.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I don't think people investigate it too much because the first
> thing they hit is lack of documentation, and then "well we don't
> really recommend it". I think this makes Linux the worst OS a
> developer would want to run on a G4 and G5, then? :D

It's not recommended for the same reason the FPU isn't used in the
kernel and x86 doesn't use SSE / MMX there neither except in a few
places where it does make sense like the RAID code. It's possible that
it might be interesting to do it for some of the crypto modules as well
and we certainly welcome any patch using altivec to improve some other
aspect of the kernel provided that it does indeed... improve
performances :)

Part of the problem is the cost of enabling/disabling it and
saving/restoring the vector registers that get clobbered when using it.

Essentially, the kernel entry only saves and restores GPRs. Not FPRs,
not VRs. This is done to keep the cost of kernel entry low. Which means
that at any given point in time, the altivec and FPU units contain
whatever context last used by userland. If the kernel wants to use it
for it's own, in thus needs to flush that context to the thread struct
(which also means that the unit will be disabled on the way back to
userland and re-faulted in when used again). That's what
enable_kernel_altivec() does (and the similar enable_kernel_fp()). This
cannot happen at interrupt time though and you shouldn't be holding
locks thus it may be a problem with some of the crypto stuffs as I think
they can be used in some weird code path. It's also important that no
scheduling happen until you are done with the unit, which is why you
have to disable preemption, since otherwise, the unit could be re-used
by userland behind your back.

Another alternative which can work at interrupt time, but requires a bit
of assembly hackery, is to manually enable MSR:VEC (if not already set)
and save and restore all the altivec registers modified by the code.

Ben.
