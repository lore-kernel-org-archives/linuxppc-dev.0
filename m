Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id 314EE67A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 04:18:51 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] Export PowerPC atomic operations to userspace
Date: Mon, 15 May 2006 13:18:50 -0500
References: <200605151154.52599.bcook@bpointsys.com>
	<20060515171629.GC22868@smtp.west.cox.net>
In-Reply-To: <20060515171629.GC22868@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605151318.50251.bcook@bpointsys.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 15 May 2006 12:16, Tom Rini wrote:
> On Mon, May 15, 2006 at 11:54:52AM -0500, Brent Cook wrote:
> > The atomic operations in asm/atomic.h are really useful from userspace
> > too. Other architectures (i386, x86_64, mips) export these to userspace,
> > but the powerpc versions are guarded by __KERNEL__ for some reason. Can
> > we remove these if there is no good reason to guard them?
> >
> > Signed-off-by: Brent Cook <bcook@bpointsys.com>
>
> NAK.  i386, x86_64 and mips are broken in this regard.  Please google up
> the previous threads that explain why you can't always get atomic
> operations on all architectures and why exporting this is bad.

OK, I see that possibly the only reason atomic_t is even exported is so that 
sem.h works. Hopefully sem.h will get fixed and people like me will not be 
even tempted by atomic.h.

What I really want is just a standard way to do atomic inc/dec in userspace; 
I'm sure that people are going to continue wanting to have atomic_t 
workalikes for their code.

After reading this thread: 
http://www.developerweb.net/forum/archive/index.php/t-3294.html
it appears that just wrapping an integer in a pthreads mutex on an NPTL 
machine wouldn't be much more overhead than using an atomic_t directly.

Looking at glibc's sources for powerpc nptl:

nptl/sysdeps/unix/sysv/linux/powerpc/lowlevellock.h

confirms that a futex lock is really similar to an atomic_t.

Thanks!

 - Brent
