Reply-To: <fabidi@ultsol.com>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: "'Mark Chambers'" <markc@mail.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: JTAG debuggers for Motorola 8xx/82xx/85xx 
Date: Fri, 18 Jun 2004 10:19:53 -0400
Message-ID: <81C69D96BDD30640952C7A404004AA250186B9@h0007e95d9fa7.ne.client2.attbi.com>
In-Reply-To: <81C69D96BDD30640952C7A404004AA25092CE9@h0007e95d9fa7.ne.client2.attbi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark,

The 82xx and 85xx have very Similar Jtag Headers. From the BDI's perspective
the JTAG interface was the same for both, the target JTAG cable we provide
is the same for both the 85xx and 82xx, the JTAG pinouts are the same for
both.

The things that have changed (from the BDI's perspective) are:

Register set has been changed-- the BDI needs to be aware of a whole
different set of registers to access to determine the state of the processor
and set breakpoints.

Startup Sequence has changed,BDI will bring up the 82xx processor set an
initial breakpoint (at the boot vector), then run the processor till we hit
the breakpoint. For the 85xx breakpoints do not work until the debug vectors
point to valid code. Hence it is not possible for the BDI to stop the 85xx
processor by setting a breakpoint at startup like the 82xx series. The work
around is that we loop endlessly in L2SRAM and halt the processor there.
Then unmap the L2SRAM, at which point you can set a breakpoint on the
bootvector and run the processor till it hits the breakpoint. MPC85xx Rev1
will let you single step right from the L2SRAM where as MPC85xx rev2 needs
to hit the bootvector before single stepping is possible.

I attached the PowerQuiccIII Jtag interface guide for you to see, the
interface is exactly the same as for the 82xx.

Fahd

-----Original Message-----
From: Mark Chambers
Sent: Friday, June 18, 2004 8:10 AM
Subject: Re: JTAG debuggers for Motorola 8xx/82xx/85xx

Thanks for this information Wolfgang. We've been trying to decide
between 5200 and an 8xxx for a project and have gotten the distinct
feeling that 5200 is somehow not from the same part of the company as
8xxx, and not supported in the same way. Do you know, do the 82xx or
85xx processors have similar restrictions?

Mark Chambers

> Wolfgang wrote:
> So far we can only support the BDM interface; to implement interface
> software for the JTAG/COP port as used on 60x based systems (including
> the MPC5200) you need special documentation from Motorola, which
> is only available under a pretty strict NDA. The terms of this NDA
> prevent any open source implementation, so we cannot add this to GDB.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
