Date: Tue, 17 Apr 2001 13:22:16 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Karim Yaghmour <karym@opersys.com>
Cc: Samuel Rydh <samuel@ibrium.se>, linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] gettimeofday stability
In-Reply-To: <3AD4B9E7.C96F1088@opersys.com>
Message-ID: <Pine.HPX.4.10.10104171039390.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 11 Apr 2001, Karim Yaghmour wrote:

>
> Gabriel Paubert wrote:
> >
> > Finally, if you _really_ run into this problem, given the delay between
> > the decrementer interrupt and the update of tb_last_stamp, it means that
> > you likely introduce uncertainties of several microseconds. I forgot also
> > to mention that, to complicate matters, you have to check CPU type before
> > you touch the TB (601 versus all others).
> >
>
> While porting the Linux Trace Toolkit to PPC I noticed a problem
> that may be explained by the symptoms described. The way it works
> is that LTT uses do_gettimeofday() to stamp the events that occur.
> Occasionnaly, a trace would contain entries where the timestamp
> will jump (from one event to the next) of approximately 4295 seconds.
> Later on, this would come back to a "normal" value. And the
> 4295 seconds are 2^32/1000000. Hence the underflow.

Wiat a minute, my explanation was wrong. When you skip forward by 4295
seconds this means that the result of the mulhwu instruction has several
of the most signficant bits set. The problem is that mulhwu(x, tb_to_us)
can never return a value larger than tb_to_us, or x for that matter.

An early decrementer interrupt would make the time jump forward by ~2^32
tb ticks, or closer to 256 seconds with a 16 MHz timebase for example.
Still unacceptable of course, but a _very_ different symptom.

That's even more puzzling than the previous hypothesis, and I would
certainly like to know if you can still reproduce it. I suspect now a
problem with lost ticks handling. Actually, this lost tick thing is a bad
implementation, it is the clock maintenance routine in the bottom half
handler that should change the values of the point of reference
(tb_last_stamp), killing more global variable references in gettimeofday.

I have started to write some code to do this with two structures
alternatively referenced and a generation counter (this allows to make a
spinlock free do_gettimeofday()). It should scale better on SMP of course
but it's not yet in a publishable state however :-(

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
