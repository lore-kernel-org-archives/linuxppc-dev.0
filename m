Return-Path: <anton@ozlabs.org>
Date: Sun, 6 Jan 2008 18:11:04 -0600
From: Anton Blanchard <anton@samba.org>
To: Bob Nelson <rrnelson@linux.vnet.ibm.com>
Subject: Re: OProfile callgraph support not working correctly on PPC processors
Message-ID: <20080107001104.GC26734@kryten>
References: <200712211115.33238.rrnelson@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200712211115.33238.rrnelson@linux.vnet.ibm.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> I have been investigating why I have not been able to get callgraph code for 
> OProfile on Cell to work correctly and I am pretty sure that I have run into 
> a problem that is common across all the Power platforms.  (At least the other 
> ones I have looked at.)  I have a simple test program that is attached 
> below.  It has a main, that calls function1, which calls function2.  Each of 
> the functions has some type of loop in it so that I can catch it spending 
> some CPU time with OProfile.  I have also attached the objdump -d output for 
> the program cut down to the three pertinent functions that shows what is 
> happening.  In a nutshell when a terminal function (calls no other function) 
> is called the compiler is making an optimization that seems to break the ABI 
> convention as far as I can tell.  It does not store the Link Register on the 
> stack like any other function.  It just leaves the return address in LR, 
> knowing that nothing should change it.  (You can see at the top of both main 
> and function1 the first thing it does is "mflr  r0" to copy the link register 
> to R0 to be saved. It does not do that in function2.)   When OProfile takes 
> an interrupt and needs to gather the callgraph information it does so by 
> grabbing the process' stack pointer (R1) and follows the chain back up the 
> stack to gather all the caller's addresses.  This works for most functions, 
> except for terminal functions for the reason noted above.

Sounds like a standard tail call optimisation. You would have a similar
problem on a normal function if you took a PMU exception in the function
prolog before the LR had been saved to the stack.

> Looking at the assembly listing I drew myself a diagram of the stack while 
> function2 is active to convince myself of what was wrong and here is what I 
> see it as...  When the interrupt is handled OProfile grabs a copy of R1, it 
> ignores the first frame on the stack because there should be no address 
> stored.  In the second frame it expects to find function2's caller but since 
> function2 doesn't store it, it grabs some random data and proceeds. The stack 
> chain is all ok so it doesn't go off into neverland trying to follow a bad 
> chain, but it grabs an invalid address for the caller.  And that is why 
> OProfile thinks terminal functions have no callers on PPC...
> 
> Any suggestions on how this can be fixed?  I am guessing that changing the 
> compiler and recompiling every program is probably not the answer.  I assume 
> the link register has to be saved in the interrupt routine when it runs, or 
> else it couldn't call anything else without crashing the program that was 
> interrupted.  Is there a safe place to find it?

You could make use of the LR itself, but you would need to work out if
the LR was in the same function as the stack saved LR, or worse still if
someone uses the LR for an indirect branch it could be completely wrong. 

To do a better job you would probably have to parse the dwarf debug
info. Maybe we could always dump the LR and stack LR and decide what one
to use when oprofile userspace parses it.

Anton
