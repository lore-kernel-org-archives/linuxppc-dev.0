Date: Sat, 21 Apr 2001 17:21:51 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] gettimeofday stability
In-Reply-To: <20010419224332.A1021@ibrium.se>
Message-ID: <Pine.HPX.4.10.10104211630120.2724-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Apr 2001, Samuel Rydh wrote:

> > By touching the TB, you'll also break all other Linux applications which
> > may have a valid use for the TB.
>
> The only noticeable effect is a small clock drift originating from
> the loading and restoring of the timebase (and of course, only when
> MOL is running). Whatever MOL puts into TB/DEC is completely
> invisible to other processes.
>
> Anyway, I'll see if I can locate and patch away the use of
> the timebase register in MacOS - that would allow the
> save-session feature to work without having to touch the TB.
>
> > BTW: how do you handle multiple MOL sessions ?
>
> Mutli-session support was actually added a few days ago -
> a matter of making sure the MOL kernel module keeps session
> specific data in a single struct, passed as a parameter.

Hmm, I'm not satisfied by the answer: consider the case of an SMP system
in which you have two processors running two instances of MOL which want a
different timebase. Now an interrupt comes in one processor, and this
handler needs a timestamp with do_gettimeofday(), how do you guarantee
that the time stamp does not depend on the processor on which the
interrupt arrives ?

Don't tell me that you fix the TB on each interrupt, please.

> Well, what I was looking for was a change to remove the assumption
> that the timer code was the sole user of the DEC register. Pauls
> change seems fix that neatly.

Yes, I fully agree with Paul's patch, it is the Right Thing (TM) to do.
This wrong assumption of my part only resulted in a micro-optimization in
the branch structure of the code. Certainly not worth it for the
correctness in case the decrementer is used for other purposes (and
overall robustness if not).

I'm still worried by the reports of 4295 seconds time jump, however. But
as I explained earlier I don't understand how this can be due to the
decrementer interrupt code; basically the timestamp is computed as

	tv_sec = xtime.tv_sec
	tv_usec = xtime.tv_usec+mulhwu(tb_to_us, expression)
	while (tv_usec>=1000000) {tv_usec -=1000000; tv_sec++}
	tv->tv_sec = tv_sec; tv->tv_usec= tv_usec

The only way to iterate 4295 times in the loop is to have tv_usec close to
2**32, but since the upper bound of the result of mulhwu is tb_to_us-1,
which is typically of the order of 2**27-2**28 (and this would require
an extremely large value of delta or of lost_ticks), the only explanation
I have now is that xtime.tb_usec was corrupt. I've been looking at the
clock maintenance code and I don't think it can happen, furthermore it's
generic and shared by (almost?) all architectures so it has been heavily
tested. I'm still looking for the problem, but I'm unable to reproduce it.


	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
