Date: Mon, 16 Apr 2001 13:25:56 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] gettimeofday stability
In-Reply-To: <20010412010756.A668@ibrium.se>
Message-ID: <Pine.HPX.4.10.10104161316490.1891-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Apr 2001, Samuel Rydh wrote:

> On Wed, Apr 11, 2001 at 09:42:58PM +0200, Gabriel Paubert wrote:
> > > Normally, delta should be strictly positive. However, if
> > > coherency between DEC and TB is lost, then delta might turn
> > > out to be (slightly) negative, which results in a
> > > bogus time stamp.
> > >
> > > The main reason why I want this modification is that MOL
> > > touches both DEC and TB. I've not managed to maintain
> > > exact coherency (appears to be more or less impossible).
> > > The fix above would guard against an occasional drift.
> >
> > Why in the hell does it touch TB ? I could understand touching the
> > decrementer, but the TB should be sacred. It is the only absolute time
> > reference we have, and apart from being synchronized at boot on SMP, it
> > should never be changed.
>
> Ideally, TB should not be touched. Indeed, MOL can run without
> touching TB (but DEC is essential). However, TB needs to be
> modified for 'save session' feature to work. Basically, the RAM
> and cpu state of MacOS is flushed to disk. At a later time,
> MacOS can be restarted instantly. The problem is that MacOS can't
> deal with the TB skip that occurs if the timebase is not restored
> (no big surprise there).

By touching the TB, you'll also break all other Linux applications which
may have a valid use for the TB.

BTW: how do you handle multiple MOL sessions ?


>
> > If you touch the TB, you will lose the nicely spaced regular interrupts
> > that we have and screw up NTP for example, get occasionally shorter or
> > longer jiffies etc... I wrote the code carefully to avoid all these kinds
> > of problems.
>
> Yes, that is probably unavoidable. My though was to let the user
> choose the use of the save session feature at the price of slightly
> less regularly spaced DEC interrupts while MOL is running (there
> will probably be a minor clock drift too).

Well, I'd say that losing the timebase is unacceptable. Screwing up the
rest of the system for the sake of a single application is never
acceptable. And on top of this, you suggest a patch which cures the
symptom, not the cause.


>
> >Besides that, you have to touch all TB simultaneously on SMP,
> > it's not as easy as it seems.
>
> I know :-). It is difficult enough to keep DEC and TB coherent
> on a single processor system (i.e. I don't think there is a
> simple way - loading them simultaneously just after a clock
> edge does not work since mtdec/mttb requires too many processor
> cycles on certains CPUs).
>
> > Finally, if you _really_ run into this problem, given the delay between
> > the decrementer interrupt and the update of tb_last_stamp, it means that
> > you likely introduce uncertainties of several microseconds.
>
> Yes, that is probably true.

I keep my clocks very well synchronized, this would break everything.



>
> > I forgot also to mention that, to complicate matters, you have to
> > check CPU type before you touch the TB (601 versus all others).
>
> Well, the TB/RTC issue is a minor problem compared to the other differences
> (in particular, the unified BATs and the lack of a no-execute bit
> in the segment registers).
>
> Anyway, the negative offset check is desirable even if it is
> only the DEC that is touched.

No, it is not, is is a textbook case of curing the symptom instead of the
cause.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
