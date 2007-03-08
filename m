Return-Path: <billh@gnuppy.monkey.org>
Received: from gnuppy.monkey.org (adsl-69-232-92-238.dsl.sndg02.pacbell.net
	[69.232.92.238]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C7A0DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 12:07:59 +1100 (EST)
Date: Wed, 7 Mar 2007 16:43:44 -0800
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to raw
	ones.
Message-ID: <20070308004344.GA23200@gnuppy.monkey.org>
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi649d25qz.wl@toshiba.co.jp>
	<45EECE5C.6030100@ru.mvista.com>
	<17902.60669.945986.186995@cargo.ozlabs.ibm.com>
	<45EEF6A4.9090807@ru.mvista.com>
	<17903.4302.502364.126701@cargo.ozlabs.ibm.com>
	<45EF2CD8.3050804@ru.mvista.com>
	<17903.12035.781782.317694@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17903.12035.781782.317694@cargo.ozlabs.ibm.com>
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	"Bill Huey \(hui\)" <billh@gnuppy.monkey.org>, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 08, 2007 at 08:30:43AM +1100, Paul Mackerras wrote:
> Sergei Shtylyov writes:
> 
> >     I've floowed up to my patch with such explanation. In the context of an-rt 
> > patch itself, it was just too clear, hence I didn't go into explanations in 
> > the patch itself. :-)
> 
> Well, it might be clear, to you, now, with the context in your head.
> But if such a patch is to go into a git tree, and somebody comes along
> in 3 years time and wants to know exactly why you made that change
> (and maybe that somebody is you :), then they will need more detail -
> such as how you came to the conclusion that those locks and no others
> needed to be changed, for instance.
> 
> At least give some of the reasoning behind your choice of which locks
> to convert, so that in future, if the patch turns out to have
> introduced a bug somehow, the person debugging it can either identify
> that there was a flaw in your logic, or else understand something that
> you have seen that they missed.

Paul,

It has to do with how locking is done in the -rt patch itself. It's probably
before the time of general maintainers since the -rt patch hasn't been fully
merged, but I agree a document needs to be written outlining what needs to
be changed to spinlocks and what locks can be emulated with the rtmutex.c/rt.c
logic. There aren't that many people that know specifically unless they've
tried to map out chunks of the Linux kernel for this purpose in the first
place. I only know because of my own parallel effort to get the kernel to be
preemptive (the old mmLinux project that I abandoned for Ingo's stuff).

Generally, things that run within interrupt contexts need to be spinlocks.
The interrupt controller is one of those things obviously, the timer interrupt
for practical reasons such as performance and other places so that locking is
outside of direct control and scope of the scheduler. Of course the scheduler's
runqueues needs to be spinlocked for the reasons above otherwise your system
is stuck with a kind chicken and the egg problem interacting with the scheduler. 

The places that need to be reverted to raw spinlocks are generally either
acquired by function calls that allocate the spinlock at a terminal of the
kernel's lock graph or isolated from other callers completely (parts of the
timer for logic for instance). It's all about the collision of various lock
(preemptive and non-preemptive) subtrees and how to avoid scheduling within
atomic violations that lead to deadlocks. The -rt patch gets arbitrary
preemption abilities by shrinking the non-preemptive sub-tree bit to the bare
essentials of what will let a system to run yet still preserve all of
the expected locking semantics of a critical section.

Otherwise everything by default is backed by a blocking rtmutex identity
to provide for correct preemptivity behavior within critical sections. That
is why these reverts are needed to restore the mathematical correctness of
the kernel's locking structures.

I hope this is helpful.

bill
