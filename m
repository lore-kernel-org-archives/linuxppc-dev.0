Date: Mon, 16 Apr 2001 13:56:29 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Karim Yaghmour <karym@opersys.com>
Cc: Samuel Rydh <samuel@ibrium.se>, linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] gettimeofday stability
In-Reply-To: <3AD7F303.FAD9EA51@opersys.com>
Message-ID: <Pine.HPX.4.10.10104161339130.1891-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 14 Apr 2001, Karim Yaghmour wrote:

>
> Gabriel Paubert wrote:
> >
> > Given that time handling is completely different in 2.2 and 2.4, it is
> > surprising. This would indicate that a decrementer interrupt has happened
> > too early.
> >
> > How often does it happen ? Does it still happen with recent kernels ?
> > Were you running something that touches the decrementer (MOL, RTLINUX) ?
> >
>
> I can't tell you if the interrupt is happening too early or not,
> although code could be added to check this.

Yes, currently the decrementer interrupt assumes that it is the only user.
This is quite simple however, use a while() {} instead of a do {}
while() in the loop that catches up on pending decrementer interrupts.


> I can tell you that this has been noticed by more than one person.
> I noticed this and so did the person at MontaVista that contributed
> the cross-platform reading code (to enable traces to be read accross
> different endian machines).
>
> If you really want to see what I mean I could forward you a textual
> trace sample to proove my point.

This could be very helpful (but from a recent kernel, please).

>
> The latest kernel I've tested this on is 2.4.0-test10.

Ok, the new code was introduced with test9. I'm very surprised since I've
heavily tested it (time stamping lots of interrupts+NTP), but I'm going to
add more thorough checks to see if I can catch some problem. I'll come
back after a few billion do_gettimeofday() calls.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
