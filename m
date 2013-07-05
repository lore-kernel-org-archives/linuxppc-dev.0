Return-Path: <ra8135@perf2farm5.am.freescale.net>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10C3F2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 08:11:20 +1000 (EST)
From: James Yang <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [RFC][PATCH 0/2] powerpc/booke: PTRACE_SINGLEBLOCK support for BookE
Date: Fri, 5 Jul 2013 17:11:03 -0500
Message-ID: <1373062265-4267-1-git-send-email-James.Yang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PTRACE_SINGLEBLOCK support for BookE currently stops on the instruction
after taken branches.  This is different from the behavior on Server
where it stops after all branches.  

BookE was made to simulate Server by taking a single step after the
branch taken exception.  It is understood that the reason for making
PTRACE_SINGLEBLOCK on BookE to simulate Server was to make the semantics
exposed to user space identicial on both, but this is not really
possible due to the fundamental difference that untaken branches do not
trigger the branch taken exception in BookE.

BookE ISA's branch taken exception triggers before a branch that will be
taken executes.  This allows software to examine the branch and the
conditions under which it will be taken.  It also means software can
tell where basic blocks end (at least the ones which are terminated by
taken branches).  There are no architected registers that report the
address of the branch instruction after it has executed.

Server's branch trace exception triggers after a branch executes
regardless of whether or not it was taken.  The exception stops on the
instruction after fall-through branches.

Two mutually-exclusive patches are provided for RFC that expose BookE's
branch taken debug exception behavior accessible through
PTRACE_SINGLEBLOCK:  

- The first patch keeps the semantic behavior of the existing support by
  using the ptrace() addr parameter to select between the modes.  This
  requires a new bit in the TIF as well as changes in kernel/ptrace.c.

- The second patch makes PTRACE_SINGLEBLOCK reflect the BookE native
  behavior, which stops on the branch instruction.  The changes are
  isolated to arch/powerpc/kernel/traps.c.

IMHO, the only reason not to do the 2nd patch would be to maintain
compatibility for any tools that actually rely on the inaccurate
simulation of Server's behavior when run on a BookE system.  Are there
any tools that actually rely upon the behavior currently implemented for
BookE in Linux -- SIGTRAP only after taken branches?  Even if there are,
it should be possible to modify such a tool to issue a PTRACE_SINGLESTEP
after receiving the SIGTRAP on the branch to retain equivalent
functionality.
