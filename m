Message-ID: <3ACB3B0C.294FC788@mvista.com>
Date: Wed, 04 Apr 2001 11:17:32 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-embedded@lists.linuxppc.org, mlocke@mvista.com
Subject: Re: runtime check of cacheline size.
References: <3ACAE9C5.6077A4E2@opensource.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Magnus Damm wrote:

> Wouldn't it be nice with a glibc that works for all of us?

I think the MVista glibc distribution is headed that way, and
the patches are in the pipeline to the maintainers.  There is
more than just cache line size that is processor dependent, and
all of these things have to be taken into consideration.

I know people are working on it, and are testing a variety of
implementations.

We also have to be careful about the 'dcbz' instruction.  For
some reason, the behavior of this instruction changes depending
upon the silicon revision of the MPC8xx parts.  This behavior is
more than just the way it may zero a cache line, and recently has
been trouble for the TLB handler (the 'morvek' as we now affectionately
call it :-).  Sometimes it faults, sometimes not, sometimes alignment
faults, and you may not get the proper VA when recovering the
information from the registers.  It is consistent for a particular
part, but not across the parts.  For MPC8xx, I have removed the
use of this instruction from the kernel, and we may want to consider
doing that in the library as well.  To complicate the exception
handlers (the 'morvek') to accomodate all of these different
conditions doesn't seem appropriate, and we may not be able to
catch all conditions.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
