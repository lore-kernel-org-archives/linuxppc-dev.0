Date: Tue, 30 Oct 2001 15:53:32 -0500
Message-Id: <200110302053.f9UKrWw16806@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: scott_anderson@mvista.com
Cc: frowand@mvista.com, jduey@ccc-dcs.com,
	linuxppc-embedded@lists.linuxppc.org
In-reply-to: <3BDF056E.B658091F@mvista.com> (message from Scott Anderson on
	Tue, 30 Oct 2001 11:54:22 -0800)
Subject: Re: PPC 405 Register Model
References: <3BD813CE000007B2@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com) <3BDF0E29.8FFB2C7@mvista.com> <3BDF056E.B658091F@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>FYI, I've seen gcc pass r0 as the register that a variable gets stored
>in.  Because some PPC instructions treat r0 as a literal zero instead of
>the value in r0, this can be bad.  To work around this, you just need
>to tell gcc that the asm uses r0 and it won't pass you a parameter in
>it.  Here's an example chunk of code:
>
>
>	/* Get the Time Base.  Make sure that r0 is declared as used;
>	 * otherwise it can be passed to me as %0 which doesn't work
>	 * very well with stw.
>	 */
>	asm volatile ("0:; mftbu 3; mftb 4; mftbu 0; cmpw 3,0; bne 0b; "
>		      "stw 3,0(%0); stw 4,4(%0)"
>		      :: "r" (&tb): "r3", "r4", "r0");
>
>The "r0" at the tail end of the asm tells gcc that r0 is used.

1) You use r0 as a temporary value, so you have to tell gcc that
   r0 is being clobbered.

2) You specified that &tb can be placed in a "r" register class
   which includes r0.  If you change the register class to "b", then
   &tb would select any register that can be used as a base address,
   which is any general register *except* r0.

3) Since you are modifying the value in memory at the address
   contained in tb, you should add "memory" to the clobber list so the
   compiler won't assume that any memory values cached in registers
   are valid.

You could rewrite this asm statement as:

{   unsigned int tmp1, tmp2, tmp3;
 asm volatile("0:; mtfbu %0; mtfb %1; mtfb %2; cmp %0,%2; bne 0b; "
    "stw %0,0(%4); stw %1,4(%4)"
     : "=&r" (tmp1), "=&r" (tmp2), "=&r" (tmp3)
     : "b" (&tb)
     : "memory");
}

All the output operands (tmp1/2/3) need to have "=" in the descriptor
to indicate that they are output values, and also need "&" to indicate
that they can not be shared with the intput value since these are
clobbered in the asm template before the input operand is consumed.

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
