Return-Path: <aijazbaig1.new@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 502542C0087
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 18:37:18 +1100 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <aijazbaig1.new@gmail.com>) id 1Vg8XD-0006ml-59
 for linuxppc-dev@ozlabs.org; Mon, 11 Nov 2013 23:37:15 -0800
Date: Mon, 11 Nov 2013 23:37:15 -0800 (PST)
From: pegasus <aijazbaig1.new@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1384241835150-78036.post@n7.nabble.com>
In-Reply-To: <alpine.LRH.2.00.1311111312390.25474@ra8135-ec1.am.freescale.net>
References: <1383907583944-77960.post@n7.nabble.com>
 <alpine.LRH.2.00.1311101509570.9815@ra8135-ec1.am.freescale.net>
 <1384156293077-78004.post@n7.nabble.com>
 <alpine.LRH.2.00.1311111312390.25474@ra8135-ec1.am.freescale.net>
Subject: Re: BookE "branch taken" behavior vis-a-vis updating the NIP register
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I re-read the link you posted earlier and this time it made more sense to me.
The kind of questions which are coming into my mind were being discussed.

So, off I went and downloaded the latest version of
arch/powerpc/kernel/traps.c hoping to see those very changes in them.
However it didn't match one on one with what was written in that thread.
Ditto for the other files in your patch. Looks like your patch didn't make
it to upstream but it looks exactly like what I need here. So allow me to
discuss certain finer points of it, to make sure I understand what it does
correctly.

In that thread you say 
James Yang wrote
> BookE ISA's branch taken exception triggers before a branch that will be
> taken executes.  This allows software to examine the branch and the
> conditions under which it will be taken.  It also means software can tell
> where basic blocks end (at least the ones which are terminated by taken
> branches).  
*
> There are no architected registers that report the address of the branch
> instruction after it has executed.
*
My thoughts exactly! 

In the first patch's description, you say 
James Yang wrote
> This patch makes available the unmodified BookE branch taken debug
> exception through PTRACE_SINGLEBLOCK if the ptrace() addr parameter is set
> to 2.  (The existing behavior of PTRACE_SINGLEBLOCK is retained for any
> other addr parameter value, e.g., 0.)  
*
> SIGTRAP will be signaled with the NIP pointing to the branch instruction
> before it has executed.  The ptrace-calling program can then examine the
> program state.
*
>   
/
> It should then request a PTRACE_SINGLESTEP in order to advance the program
> to the next instruction or a PTRACE_CONT to resume normal program
> execution.
/
>  The si_code now also reports TRAP_BRANCH.

 So requesting PTRACE_CONT has to happen inside the SIGTRAP signal handler
right? So as to advance the branch instruction (and since we are talking
BookE here, we are dead sure this branch will be taken). Now as for the
second patch, as far as I can see, implements the same functionality.
However it makes the change permanent and any tool which is used to the NIP
pointing to the branch target will be broken. 

Anyways, for me either of them will work. But I think the first patch makes
everyone happy by using the 'addr' field of ptrace. This also means I will
have to make my (broken) ptrace working which, it seems is not as easy
adding an enum field as you suggested. May be theres a check somewhere in
the actual ptrace code which checks for illegal values and hence even after
adding an enum, it is being reported as illegal in my case. However getting
that to work is another story.

Please confirm my understanding of your patches and since these patches have
not made their way to the upstream kernel, will have to use them myself
directly. By the way, I'm using 2.6.32.10 (you know..the long-term kernel)
and I couldn't find any of your changes in them but then again I couldn't
find it in the latest 3.12 version either.




--
View this message in context: http://linuxppc.10917.n7.nabble.com/BookE-branch-taken-behavior-vis-a-vis-updating-the-NIP-register-tp77960p78036.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
