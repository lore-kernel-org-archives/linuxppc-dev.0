Return-Path: <msteckly@ixiacom.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BDFBAB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 07:43:24 +1000 (EST)
Message-ID: <4FCD2BEB.3000900@ixiacom.com>
Date: Mon, 4 Jun 2012 17:43:07 -0400
From: Michael Steckly <msteckly@ixiacom.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Serial RAPID IO kernel hang on maintenance read transaction
References: <15E2FEE7DC073B4FA1F33D10F5FAAFB1098F8EED@ECS-EXG-P-MB01.win.lanl.gov>
In-Reply-To: <15E2FEE7DC073B4FA1F33D10F5FAAFB1098F8EED@ECS-EXG-P-MB01.win.lanl.gov>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: mcp@lanl.gov
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2012 04:40 PM, Proicou, Mike wrote:
>
> I've been struggling with a kernel hang during bootup + enumeration of
> a Rapid IO system.
>
> My current system contains a N.A.T MCH (using the IDT/Tundra Tsi 578
> switch) and a Vadatech AMC719 card using the Freescale P4080
> processor.  There will be other cards added to the system, but I'm
> testing with just this for now.
>
> I'm using a Linux kernel version 2.6.34.6.  I've set riohdid=0 on the
> kernel command line, and I'm expecting Linux to fully enumerate and
> configure the Rapid IO fabric. (This may be a bad assumption on my part.)
>
> After lots of tracing, I've determined that the kernel is hanging on
> the first maintenance transaction to the switch.  The hang will often
> be followed by a "machine check in kernel mode" exception and panic.
>
Though we're running the 3.0.6 kernel we encountered an almost identical
situation and the crash/traceback also appears to be the same.

In our case, the lock-up was due to a bug in the Freescale machine check
exception handler and the trigger for this was an AckID mis-match on our
switch ports.

Specifically, the AckID mis-matched triggered an sRIO error.  This
triggers a machine check via the routine machine_check_e500mc.  This
routine checks to see if the MCSR_BUS_RBERR flag in SPRN_MCSR is set to
determine if it should run the fsl_rio_mcheck_exception code which will
handle the fixups to keep the machine check from crashing the system.

However, what I found out was the MCSR_BUS_RBERR is a BookE architecture
bit that isn't implemented on the powerPC architecture--or at least on
the p4080/e500MC processor/core specifically.  In fact, as near as I can
determine, the only clue you have that this is a rapidio error is the
fact that you've received a machine check error--though I'm sure there's
something clever that could be done to narrow it down a bit better.

So basically, you have to modify the machine check handler to decide
whether or not to call the fsl_rio_mcheck_exception code based on the
rapidIO error registers (SRIO_LTLEDCSR and SRIO_PxESCSR) rather than on
the SPRN_MCSR register. 

I handled this by hacking the machine check handler to always call the
fsl_rio_mcheck_exception routine for any load/guarded load error--we
weren't having issues with writes--and then modified the
fsl_rio_mcheck_exception routine to do the fixups if there was a pending
rapidio error and return the "recoverable" bit to the top level handler
or "0" if a rapidio error wasn't detected; It's crude but it worked.

Now, this didn't solve our whole problem in that the exception handler
doesn't perform or setup any bus-recovery code, this just keeps the
error from crashing your kernel.

In the end, we disabled the default enumeration/discovery code and added
our own code layered on top of the Freescale rio driver code--nothing
that can or even should be submitted to a general code tree.  It's
messy, but we were tight on time, already had an existing driver that
implemented custom functions for our stuff and didn't have to time to
work out the proper kernel internals  to change.

I'm sorry I cannot give you anything more useful, but hopefully this
will help a bit.

    Mike
