Return-Path: <littelld@verizon.net>
Received: from vms173001pub.verizon.net (vms173001pub.verizon.net
	[206.46.173.1]) by ozlabs.org (Postfix) with ESMTP id 49FFEDDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jul 2008 12:57:21 +1000 (EST)
Received: from [192.168.1.106] ([96.226.142.190]) by vms173001.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0K4U00E42LF26J01@vms173001.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Wed, 30 Jul 2008 20:57:02 -0500 (CDT)
Date: Wed, 30 Jul 2008 20:57:01 -0500
From: Dave Littell <littelld@verizon.net>
Subject: PPC440EPx skips instruction...
To: linuxppc-embedded@ozlabs.org
Message-id: <48911BED.4040903@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a rather interesting problem with a PPC440EPx-based system.  I've
localized the problem down to a single instruction in a function
prologue that stores the return address to the stack:

stw r0,0x44(r1)

(lr is written to r0 earlier in the prologue.)

This code is in a normal device driver and is not being executed at
interrupt level or in some TLB miss handler or anything arcane - it's
just regular code (execution-context-wise).

It appears that if I just let the code run the write never makes it to
the stack, thus setting the stage for very interesting function returns.
 Whatever value happened to be on the stack becomes the IP with the
accompanying "excitement" that follows.  If I single-step through the
instruction using a JTAG debugger the write to the stack always occurs
and the function does its work and returns correctly.

If I step right up to the stw, write a test value into 0x44(r1), then
allow the processor to free run I am rewarded with an attempted return
address equal to the test value I wrote to the stack - the stw memory
write never makes it to the stack.

Because the code is compiled from C I'm limited in where I can sprinkle
sync instructions but I've tried adding asm("sync") as close as possible
to before (and after) the offending write - all to no effect.  I'm at a
loss to explain this as the remainder of the system seems to be running
just fine but I get this particular behavior at will.  More like its
will than mine... :-{

Has anyone seen this kind of behavior with a PPC440 core?  Please note
that workarounds for all known CPU core errata for the PPC440EPx are
already in place (based on the AMCC errata document).


Thanks very much,
Dave
