Return-Path: <munroesj@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 561B1DDEFE
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 04:32:00 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m68IVtmC008330
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 14:31:55 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m68IVrHE136944
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 12:31:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m68IVqvo031721
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 12:31:53 -0600
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
From: Steven Munroe <munroesj@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1215478091.8970.183.camel@pasglop>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
	<1215411800.8970.91.camel@pasglop>
	<20080707063522.5FE55154246@magilla.localdomain>
	<je8wwet9p6.fsf@sykes.suse.de>
	<20080707093151.8798A154246@magilla.localdomain>
	<je63rirp1x.fsf@sykes.suse.de> <1215471393.8970.157.camel@pasglop>
	<20080708003127.6D3B9154244@magilla.localdomain>
	<1215478091.8970.183.camel@pasglop>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 13:35:23 -0500
Message-Id: <1215542123.4065.285.camel@spokane1.rchland.ibm.com>
Mime-Version: 1.0
Cc: Steve Munroe <sjmunroe@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Nathan Lynch <ntl@pobox.com>, Roland McGrath <roland@redhat.com>
Reply-To: munroesj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-08 at 10:48 +1000, Benjamin Herrenschmidt wrote:
> Adding Steve to the CC list as I'd like his input from the
> glibc/powerpc side as he's the requester of that feature in the first
> place.
> 
> Steve: Roland is proposing to ues dsocaps instead of AT_BASE_PLATFORM.
> 

I am will to discuss better solutions with Roland. It seems like I am
finally on the air for linuxppc-dev but it seems some of my earlier
notes got lost.

So I will restate. AT_BASE_PLATFORM is proposed solution to several
problems including CPU tuned library selection. If dsocaps is better
solution for library select I am happy to consider and discuss this.

However it is not clear that dsocaps is solution to all requires we need
to address for virtualization and partition migration of applications.
This required a durable and public API accessible form any application
or library.

First the problem:

We want to support migration of running partitions (including the kernel
and all running applications) abd we have to deal with mixed platform
clusters. If we want to migrate freely between POWER5+ and POWER6 (or
POWER7) systems then we need to make sure the application and its
libraries restrict themselves to the lowest ISA Version level (2.04 in
this case).

So the hardware and hypervisor support and enforce CPU compatibility
modes. For a partition is created on a POWER6 to run in POWER5+ mode.
There are HID bits set to restrict instruction set to the POWER5+
subset. So running a program that uses new POWER6 instruction on this
partition will SIGILL. 

So while this is really a POWER6 machine it is wrong for the kernel to
return AT_PLATFORM=power6. The /lib/power6/libc.so and libm.so do use
the new ISA V2.05 instructions that will SIGILL in this (POWER5+
compatible) partition. 

In this case the kernel should return AT_PLATFORM=power5+
because /lib/power5+/libc.so is build --with-cpu=power5+ and only uses
the ISA V2.04 instructions.

But that introduces some new problems. The processor, internal pipeline
(micro-architecture), and performance monitor unit (PMU events have to
match the pipeline structure) have not changed (still POWER6/7). This
implications on application performance and many performance tools.

For example oProfile/PAPI/libpfm need to know what the processor really
is because miss programing the PMU get bogus results or even crash the
systems. Another example is a JVM/JIT compiler which needs to know what
supported ISA level is (from AT_PLATFORM and AT_HWCAP), but can generate
better code if, it knows that base platform is different, and what the
actual micro-architecture is. For these examples the
AT_PLATFORM/AT_HWCAP based library selection mechanism does not apply.
And except for oProfile these examples are user mode
applications/libraries that need this information from a simple and
durable and public API. To me AT_BASE_PLATFORM seems like the minimal,
simplest, and most general solution to these problem.

Ok now back to library selection and dsocaps. Running power5+ libraries
on a power6 will execute (will not SIGILL) but may not be optimal. the
best performance also require careful instruction selection and
scheduling. For example the performance of memset/memcpy/memcmp depend
on tuning to the detail timing of the Load/Store pipelines, Store Queue
depth, and L2 cache clocking. This can be very different between
processor generations.

For this power5+ compatible partitions, we would like the option to
build libraries for -mcpu=power5+ -mtune=power6! etc!. The details of
how this will work are TBD. I put forth AT_BASE_PLATFORM with thought
that it could be search modifier in addition to AT_PLATFORM
(i.e. /lib/power5+/power6/libc.so.

If dsocaps is a better mechanism for library selection I am more then
will to discuss how dsocaps works and how it can be applied to this
specific case.
