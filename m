Date: Thu, 8 Aug 2002 20:56:36 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Tr: xtime_lock
In-Reply-To: <20020719143525.3334@192.168.4.1>
Message-ID: <Pine.LNX.4.21.0208082010460.580-100000@ltgp.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Jul 2002, Benjamin Herrenschmidt wrote:

> I'm forwarding your message to linuxppc-dev mailing list

I'm just back from holidays trying to redice my email backlog.


>
> ---------------- Début du message transmis ----------------
> Sujet: xtime_lock
> Envoyé: vendredi 19 juillet 2002 15:31
> De: Jeroen T. Vermeulen <jtv@xs4all.nl>
> À: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Hi Ben,
>
> I was just trying to learn a bit more about the kernel's locking
> primitives and execution model, when I came across xtime_lock and your
> comment about wanting to get rid of it (arch/ppc/kernel/time.c).
>
> So here's my question: would it be feasible (and/or pointful) to replace
> the xtime_lock in do_gettimeofday() by a simple optimistic approach?  If
> the machine is fast enough compared to timer resolution, I imagine one
> could just read the clock twice and compare the results to verify that
> you got consistent data.  Of course whether that saves you any time is
> another matter; perhaps it would make sense with SMP but not for
> uniprocessor machines, or something.

I had started something like this and then got distracted as always,
but the solution I wanted is not exactly the same: you need two copies
of the variables needed to compute current time and a version number.
[I'm writing this on my notebook which is getting a new disk, no
sources yet, so I'm working from memory, variable names are not
correct etc]

unsigned xtime_version;
struct timevar {
	unsigned  version;
	unsigned  last_tb_stamp;
	struct timeval time_at_stamp;
	/* and other variables needed by gettimeofday */
	...
} timevars[2];

with preferably each timevar struct aligned and padded to a cache line.

Then gettimeofday should do:

	struct timevar *p;

	do {
		unsigned v=xtime_version;
		p = timevars + (v&1);
		/* copy needed variables to local, all architectures have
		 * more than enough registers to perform this, unless you
		 * believe that x86 deserves to be called an architecture.
		 */
		read_barrier();
	} while (v!=p->version); /* or unlikely(v!=p->version) */
	/* compute the current second/microsecond from
	 * fetched variables and timebase, fill the
	 * timeval structure and you're done.
	 */

the read barrier is necessary, but I'd rather not use a sync
(expensive). My idea would be to have a way to ensure that
all variables have been read by having the read barrier take
a parameter, for example if you define:

	ensure_read_done(val);

to expand to:

	asm ("twne %0,%0; isync": : "r" (val): "memory");

and replace the read_barrier() earlier with

	ensure_read_done(tb_stamp^sec^usec^...)

then i believe that the PPC architecture guarantees that the variables
entering the val expression are guaranteed to be read before p->version.
Tis is because the twne (conditional trap) instruction will block
the processor from going past the isync since one of the guarantees of
isync is that it has been determined that all previous instructions have
progressed past the point where they can cause an exception.

Note that you can use any operator in the expression instead of xor, I
just happen to like xor in this context, it looks like you compute a hash
of all the variables you need. I don't like the ensure_read_done name very
much either, so feel free to suggest a better name.

>
> A detail that could make it more feasible AFAICS is that you don't
> need to re-read the least significant--and most volatile!--part of the
> time value for the "second opinion" check, because you only get an
> actual inconsistent result if there's been a rollover while you were
> reading.  Or am I forgetting to take nonlinear clock changes into
> account?  OTOH they mean you get weird results anyway...

Note that the code I suggest means that you can change all the parameters
of the clock, including the tb_to_us conversion factor. This is useful
because it would allow to reduce the update frequency of this structure,
which reduces the probability of having to loop getting the variables.

Ideally, the update frequency of the structure should be a power of 2
since other values force dubious hacks in the NTP PLL algorithm and it
should be as low as possible. I consider 4 Hz as the best compromise.

After this jiffies are something completely independent of gettimeofday,
I never understood the logic which forced us to use the lost jiffies in
gettimeofday.

Note also that once we have such a lockless code, it can be mapped
readonly to user space along with relevant data to make gettimeofday
extremely cheap since syscall overhead is eliminated.

Finally you could even consider this suggestion a kind of RCU
(read-copy-update) specifically optimized for gettimeofday().


>
> Oh, and on a side note, why the loop to convert "superfluous" usecs to
> secs?  Is this because the number of iterations is so low that the
> conditional is faster than a division plus a remainder operation?

Indeed, actually if you iterate more than once your system is likely to be
toast (means you've not been able to run timer_bh for about 1 second). I'd
rather say (can't remember the BUG/BUG_ON syntax but you get the idea):

	if (usec>=1000000) {
		sec++;
		usec-=1000000;
		if (unlikely(usec>=1000000)) BUG();
	}



	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
