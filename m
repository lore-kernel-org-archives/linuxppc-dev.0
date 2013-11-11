Return-Path: <James.Yang@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC15E2C00A1
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Nov 2013 07:11:55 +1100 (EST)
Date: Mon, 11 Nov 2013 14:11:46 -0600
From: James Yang <James.Yang@freescale.com>
To: pegasus <aijazbaig1.new@gmail.com>
Subject: Re: BookE "branch taken" behavior vis-a-vis updating the NIP register
In-Reply-To: <1384156293077-78004.post@n7.nabble.com>
Message-ID: <alpine.LRH.2.00.1311111312390.25474@ra8135-ec1.am.freescale.net>
References: <1383907583944-77960.post@n7.nabble.com>
 <alpine.LRH.2.00.1311101509570.9815@ra8135-ec1.am.freescale.net>
 <1384156293077-78004.post@n7.nabble.com>
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

On Mon, 11 Nov 2013, pegasus wrote:

> And this is due to the pipelining feature that is inherent in all 
> processors.

No, it has nothing to do with pipelining at all.  It is just the 
convention that IBM defined as to how the branch taken exception works 
in BookE Power ISA.  The pipeline behavior is not visible from the 
architected state.

 
> But I still have a question about how one would then be able to 
> signal to the userspace who might be interpreting this information 
> differently? I mean if SRR0 contains, not the branch instruction 
> address but the address of the branch target, how would any debugger 
> be able to catch function calls?

On Server and the BookE-mimicking-Server, PT_NIP would point to the 
start of the function you are calling.  However, you do not get the 
callsite address unless you know you stopped after a function-calling 
branch-and-link executed, single step again and read the LR and 
subtract 4.  If you don't know if the branch that caused the exception 
was actually a branch-and-link, you don't know if you are at the 
beginning of a function or not, unless you keep a table of the address 
of all possible functions and look up each PT_NIP to see if you are.  
But that wouldn't be 100% accurate either, since a non-linking branch 
could just redirect to the beginning of the function.  In the other 
thread, Ben said they have the CFAR register, but from the way it is 
described in the ISA document, you will not always get the address of 
the callsite, e.g. if your target is in the same cache black, the CFAR 
might not change.  So, I don't think it can work in a simple way.

On BookE with my patch to NOT mimic server, you will stop before the 
branch executes, so PT_NIP points to the branch itself, so that there 
is your callsite information.  If you want the function target, you 
decode the instruction to see if it is a branch-and-link, and then 
compute the target address or manually singlestep and grab the new 
PT_NIP.


> May be there is a trick involved here and hence gdb or for that 
> matter the other debuggers are still in the market. 

Per the other thread, and my inquiry through my company's gdb experts 
and upstream on the gdb mailing list, gdb does NOT use hardware branch 
tracing, at least not using PTRACE_SINGLEBLOCK.  I don't personally 
know of any debuggers that use it in the form that it exists in Linux.


> But then I would be immensely obliged if you could shed some light 
> on how is this accomplished. Lets say I am waiting at the userspace 
> in my own sigtrap, to watch out for branch instructions. Lets say I 
> want to profile my code to get to know how many branch instructions 
> it has generated. How could I ever do that using my own custom 
> SIGTRAP handler?

Lots of ways to skin this cat, but I don't think any of them are easy 
or simple.

- Using valgrind is probably the easiest way to get this information 
on an unmodified executable.

- You may want to recompile your program with call-arch profiling if 
you have source code.  gcc -fprofile-arcs but read the docs.

- Another method is to set up performance monitor counter to interrupt 
after a branch has executed, but callsite information may be lost as 
well and you still have the issue of discerning whether you just 
called a function or not.  

- You can use my patch for BookE, but it's just an RFC.  Also, using 
PTRACE_SINGLEBLOCK is slow.  You could also stop on every 
PTRACE_SINGLESTEP, but this is even slower.



> Coming on to PTRACE_SINGLESTEP, the sysroot that has been provided 
> to us by our vendor does not include a PTRACE_SINGLEBLOCK in 
> sys/ptrace.h:

> Although I can clearly see that PTRACE_SINGLEBLOCK is supported in the
> kernel. 
> 
> Hence I am not able to compile this simple program in userspace:

> Heres the error I get:
> testptrace.c: In function 'int main()':
> testptrace.c:47: error: invalid conversion from 'int' to '__ptrace_request'
> testptrace.c:47: error:   initializing argument 1 of 'long int
> ptrace(__ptrace_request, ...)'
> make: *** [testptrace] Error 1
> 
> How should I go about using ptrace to test this? 

I don't know. You'll probably have to request support from your vendor 
or whoever provided you with those headers.  If you are using a glibc 
based toolchain, your glibc is probably out-of-date. You can try 
adding PTRACE_SINGLEBLOCK into the enum definition just to get past 
the compiler syntax error, but I don't know if that will break things 
or not in your libc ptrace().  You may have to write your own function 
that calls the __ptrace syscall directly if the libc ptrace() does 
something to the request or the response.
