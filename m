Return-Path: <James.Yang@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9120D2C00C6
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Nov 2013 09:22:46 +1100 (EST)
Date: Sun, 10 Nov 2013 16:22:37 -0600
From: James Yang <James.Yang@freescale.com>
To: pegasus <aijazbaig1.new@gmail.com>
Subject: Re: BookE "branch taken" behavior vis-a-vis updating the NIP register
In-Reply-To: <1383907583944-77960.post@n7.nabble.com>
Message-ID: <alpine.LRH.2.00.1311101509570.9815@ra8135-ec1.am.freescale.net>
References: <1383907583944-77960.post@n7.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 8 Nov 2013, pegasus wrote:

> Hello.
> 
> I was reading the source code for the debug exception under powerpc. I saw
> that BookE processors stop before (actually) taking a branch. Hence in order
> to force it to take that branch and then stop, the source code for it had to
> be "hacked'  to (temporarily) enable single step until the branch
> instruction has been taken, thereby mimicing the BookS behavior. 

Have a look at this thread:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-July/108618.html


> By doing this, I believe we would want the exception to be triggered after
> the branch has been successfully taken. Hence I put a printk to print the
> value of the instruction that actually caused the exception. I was assuming
> that initially a debug breakpoint would be hit on the branch instruction
> (assuming the branch is supposed to be taken). Now since at this point in
> time, the branch instruction has NOT finished, the kernel, after merely
> disabling the BT bit in DBCR0 and enabling IC bit in DBCR0, returns. At this
> point I was assuming we will see another exception at the very same
> instruction in userspace. However, when printing the NIP it becomes clear
> that when it gets to the debug exception handler after being (temporarily)
> set to single step, NIP points to the instruction after the branch
> instruction. To me, it appears that, after disabling BT (branch taken) debug
> event monitoring (and enabling single stepping), it does not catch an
> exception at that very same branch instruction, instead it catches an
> exception for the subsequent instruction. Sorry for the repetition but I
> wanted to clarify what I am seeing here.
>
> May be this IS the way it is supposed to behave (which means my thinking
> about it is flawed). I am a bit confused here. 

You have it correct, that is the behavior of what is there.  The 
Server branch execute debug exception occurs after the branch 
completes, and the SRR0 (the value in PT_NIP) points to the address of 
the instruction that is to be executed after the branch.  BookE branch 
exception occurs before the branch is executed, but only if the branch 
will be taken.  The hack tries to make BookE return an exception to 
the process with the same timing as Server: exception signal sent to 
process after the branch completes.

I think some of the confusion is due to the existence of the hack.  
Its existence implies that BookE can perfectly emulate Server, but 
this is not possible because BookE would only take the exception if 
the branch's condition would cause the branch to be actually taken 
(that the branch condition, if present, is true). Therefore, even with 
this hack, untaken branches are not signaled at all on BookE while 
they would on Server.

Note that PTRACE_SINGLESTEP works the same on both Server and BookE. 
The exception occurs after an instruction completes, and the SRR0 / 
NIP points to the instruction that will be executed next.
