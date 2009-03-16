Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 194E9DDF34
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 11:49:35 +1100 (EST)
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs, and VSRs
	in the MSR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rsa@us.ibm.com
In-Reply-To: <1237042739.8874.3.camel@localhost.localdomain>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
	<FFBC9638-D064-43F9-B764-243739289710@kernel.crashing.org>
	<1237042739.8874.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 16 Mar 2009 11:49:26 +1100
Message-Id: <1237164566.25062.114.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-03-14 at 09:58 -0500, Ryan Arnold wrote:

> We can do some VMX testing on existing POWER6 machines.  The VSX
> instruction set hasn't been fully implemented in GCC yet so we'll need
> to wait a bit for that.  Does anyone have an idea for a good VMX/Altivec
> benchmark?

Note that there are two aspects to the problem:

 - Lazy save/restore on SMP. This would avoid both the save and restore
phases, thus is where the most potential gain is to be made. At the
expense of some tricky IPI work when processes migrate between CPUs.

However, it will only be useful -if- a process using FP/VMX/VSX is
"interrupted" by another process that isn't using them. For example, a
kernel thread. So it's unclear whether that's worth it in practice, ie,
does this happen that often ?

 - Always restoring the FP/VMX/VSX state on context switch "in" rather
than taking a fault. This is reasonably simple, but at the potential
expense of adding the save/restore overhead to applications that only
seldomly use these facilities. (Some heuristics might help here).

However, the question here what do this buy us ?

IE, In the worst case scenario, which is HZ=1000, so every 1ms, the
process would have the overhead of an interrupt to do the restore of the
state. IE. The restore state itself doesn't count since it would be done
either way (at context switch vs. in the unavailable interrupt), so all
we win here is the overhead of the actual interrupt, which is
implemented as a fast interrupt in assembly. So we have what here ? 1000
cycles to be pessimistic ? On a 1Ghz CPU, that is 1/1000 of the time
slice, and both of these are rather pessimistic numbers.

So that leaves us with the possible case of 2 tasks using the facility
and running a fraction of the timeslice each, for example because they
are ping-ponging with each other.

Is that something that happens in practice to make it noticeable ?

Cheers,
Ben.
