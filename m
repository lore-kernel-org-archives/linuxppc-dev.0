Date: Wed, 9 May 2001 13:06:34 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Brian Kuschak <brian.kuschak@skystream.com>
Cc: "'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A02044652@SERVER1>
Message-ID: <Pine.HPX.4.10.10105091149320.29518-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 8 May 2001, Brian Kuschak wrote:

> Yes, I agree.  Like I said it definitely runs longer now than it did before,
> but unfortunately shows the same symptom.  Here is a little more information
> that I gleaned last night which may or may not be useful.

Ok, so you were hitting 2 bugs (or more, shudder).

> I noticed that arch/ppc/kernel/misc.S still had the (old?) assembly
> functions for doing atomic operations.  They are similar but slighly
> different to the inline functions in atomic.h.  I ran yesterday for about 4
> hours with these "alternative" atomic functions, and I did not see the
> failure.  I'm not sure if this was just a coincidence (the timing changed
> slightly), or whether it indicates a problem with the inline atomic
> functions.

Interesting, which compiler are you using? I've been experimenting with my
own modifications to gcc, in case I hit a problem I often do objdump
--disassemble vmlinux | less and search the instruction in which I'm
interested. In your case it would be lwarx, but there are probably too
many occurrences to make the hunt worthwhile.

Note that the semaphore code has been modified over and over again
recently to make it work (I'm still unable too convince me that it is
correct, I need to study it more). But the semaphore code should be
independent of reference count handling.


> Sure, I'll post it next time I get it.  (I already cleared the one I got
> last night).

Thanks,

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
