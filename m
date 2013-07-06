Return-Path: <RA8135@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 312152C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 15:01:20 +1000 (EST)
Date: Sat, 6 Jul 2013 00:01:11 -0500
From: James Yang <James.Yang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 2/2] powerpc/booke: revert PTRACE_SINGLEBLOCK to
 BookE behavior
In-Reply-To: <1373070115.4446.13.camel@pasglop>
Message-ID: <alpine.LRH.2.00.1307052327580.20815@ra8135-ec1.am.freescale.net>
References: <1373062265-4267-1-git-send-email-James.Yang@freescale.com>
 <1373062265-4267-3-git-send-email-James.Yang@freescale.com>
 <1373070115.4446.13.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: James Yang <James.Yang@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 6 Jul 2013, Benjamin Herrenschmidt wrote:

> On Fri, 2013-07-05 at 17:11 -0500, James Yang wrote:
> > A BookE branch taken debug exception followed by a single step does not
> > accurately simulate Server's branch execute debug exception.  BookE's
> > branch taken debug exception stops before the branch is to be executed
> > and only happens if the branch will actually be taken.  Server's branch
> > execute trace exception stops on the instruction after the branch
> > executes, regardless of whether or not the branch redirected the program
> > counter.
> > 
> > The existing PTRACE_SINGLEBLOCK support for BookE hardcodes a single
> > step after the branch taken exception is taken in order to simulate
> > Server's behavior, but this misses fall-through branch instructions
> > (i.e., branches that are NOT taken).  Also, the si_code became masked as
> > TRAP_TRACE instead of TRAP_BRANCH.
> 
> But that changes the user visible behaviour, won't that break gdb
> expectations ?

I am having a difficult time finding any use of PTRACE_SINGLEBLOCK in 
any arch in the various versions of gdb source trees I downloaded.  
Would you please provide a pointer or at least a hint as to where you 
think it would be?  I don't know gdb internals at all, but grepping 
the sources for PTRACE_SINGLEBLOCK returns nothing.


> Another way to "fix" it is to instead use lib/sstep.c to emulate the
> single step maybe ?

I don't think there's any issue any more with the hard coded single 
step with the fixes that Scott and Bharat recently provided.  
Actually, I don't even know if this feature was practically useful on 
BookE before those fixes due to the hangs and non-deterministic 
behavior.

Hypothetically, sstep.c could let server to emulate BookE's behavior..


> On the other hand, I tend to think that trapping before the branch is
> actually more useful especially if you don't have the CFAR register.

And there's no exception for fall-through branches.

So, yeah, this really is the question:  are there actually any tools 
that rely on PTRACE_SINGLEBLOCK behaving in the different ways it 
currently does on the two Power subarchiectures?  For BookE targes, 
how do they handle not being able to catch fall-through branches?  
For server targets, how do they capture the old LR value for blrl 
after the branch?  (I'm guessing not even sstep emulation can provide 
this information, though it might not be practically useful.)
