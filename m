Message-ID: <3BDF056E.B658091F@mvista.com>
Date: Tue, 30 Oct 2001 11:54:22 -0800
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: Jim Duey <jduey@ccc-dcs.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC 405 Register Model
References: <3BD813CE000007B2@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com) <3BDF0E29.8FFB2C7@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Rowand wrote:
>
> Jim Duey wrote:
> >
> > I'm needing to do some inline assembly for the Walnut board running MVista's
> > Hard Hat Linux and I'm concerned about clobbering registers.  Can someone
> > point me to docs or source code that describes the register usage of HHL on
> > the 405GP?
>
> If you use variable names instead of hard coding register numbers you
> don't have to worry about clobbering registers.

FYI, I've seen gcc pass r0 as the register that a variable gets stored
in.  Because some PPC instructions treat r0 as a literal zero instead of
the value in r0, this can be bad.  To work around this, you just need
to tell gcc that the asm uses r0 and it won't pass you a parameter in
it.  Here's an example chunk of code:


	/* Get the Time Base.  Make sure that r0 is declared as used;
	 * otherwise it can be passed to me as %0 which doesn't work
	 * very well with stw.
	 */
	asm volatile ("0:; mftbu 3; mftb 4; mftbu 0; cmpw 3,0; bne 0b; "
		      "stw 3,0(%0); stw 4,4(%0)"
		      :: "r" (&tb): "r3", "r4", "r0");

The "r0" at the tail end of the asm tells gcc that r0 is used.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
