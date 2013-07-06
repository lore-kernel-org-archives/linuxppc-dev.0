Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D94FB2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 10:22:05 +1000 (EST)
Message-ID: <1373070115.4446.13.camel@pasglop>
Subject: Re: [RFC][PATCH 2/2] powerpc/booke: revert PTRACE_SINGLEBLOCK to
 BookE behavior
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Yang <James.Yang@freescale.com>
Date: Sat, 06 Jul 2013 10:21:55 +1000
In-Reply-To: <1373062265-4267-3-git-send-email-James.Yang@freescale.com>
References: <1373062265-4267-1-git-send-email-James.Yang@freescale.com>
 <1373062265-4267-3-git-send-email-James.Yang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-05 at 17:11 -0500, James Yang wrote:
> A BookE branch taken debug exception followed by a single step does not
> accurately simulate Server's branch execute debug exception.  BookE's
> branch taken debug exception stops before the branch is to be executed
> and only happens if the branch will actually be taken.  Server's branch
> execute trace exception stops on the instruction after the branch
> executes, regardless of whether or not the branch redirected the program
> counter.
> 
> The existing PTRACE_SINGLEBLOCK support for BookE hardcodes a single
> step after the branch taken exception is taken in order to simulate
> Server's behavior, but this misses fall-through branch instructions
> (i.e., branches that are NOT taken).  Also, the si_code became masked as
> TRAP_TRACE instead of TRAP_BRANCH.

But that changes the user visible behaviour, won't that break gdb
expectations ?

Another way to "fix" it is to instead use lib/sstep.c to emulate the
single step maybe ?

On the other hand, I tend to think that trapping before the branch is
actually more useful especially if you don't have the CFAR register.

Cheers,
Ben.
