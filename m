Message-ID: <036801c0d747$128ffcd0$4b00000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: "Brian Kuschak" <brian.kuschak@skystream.com>,
	"'Dan Malek'" <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <B25E2E5A003CD311B61E00902778AF2A0204463A@SERVER1>
Subject: Re: dcache BUG()
Date: Mon, 7 May 2001 15:43:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
