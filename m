Message-ID: <B25E2E5A003CD311B61E00902778AF2A0204463D@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Dan Malek'" <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
Date: Mon, 7 May 2001 16:01:36 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If I use the 'old' atomic functions from arch/ppc/kernel/misc.S instead of
the inline functions in atomic.h, the problem doesn't seem to happen.
Normally it happens in about 15 minutes, but I've been running over an hour
now and haven't seen it.

Perhaps there is something else wrong with the __asm__ macros in atomic.h ??

-Brian


-----Original Message-----
From: Eli Chen [mailto:eli@routefree.com]
Sent: Monday, May 07, 2001 3:43 PM
To: Brian Kuschak; 'Dan Malek'
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()


> I looked at the atomic.h code and think I found one bug, however it
doesn't
> solve my problem.  See if this patch makes sense to you.  Looks like a
typo
> when the atomic_* functions were converted from assembler to inline.  The
> bne should be 'bne-' for the atomic decrement operation.

The "-" after bne is just a hint for the branch prediction mechanism I
believe (the 5th bit in the BO operand).  I couldn't figure out why every
other atomic_* function besides atomic decrement has "bne-", but that
shouldn't affect the behavior.  I have also tried changing it to "bne-", but
it has no effect.

Eli

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
