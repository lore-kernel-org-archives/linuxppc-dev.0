Date: Wed, 11 Apr 2001 21:42:58 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] gettimeofday stability
In-Reply-To: <20010411210021.A4894@ibrium.se>
Message-ID: <Pine.HPX.4.10.10104112111330.1891-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 11 Apr 2001, Samuel Rydh wrote:

>
> I'd like to suggest the following modification of do_gettimeofday():
>
>
> ===== time.c 1.8 vs edited =====
> --- 1.8/arch/ppc/kernel/time.c  Mon Apr  2 03:36:42 2001
> +++ edited/time.c       Wed Apr 11 20:38:42 2001
> @@ -212,6 +212,10 @@
>         sec = xtime.tv_sec;
>         usec = xtime.tv_usec;
>         delta = tb_ticks_since(tb_last_stamp);
> +
> +       if( (int)delta < 0 )
> +               delta = 0;
> +
>  #ifdef CONFIG_SMP
>         /* As long as timebases are not in sync, gettimeofday can only
>          * have jiffy resolution on SMP.
>
>
> Normally, delta should be strictly positive. However, if
> coherency between DEC and TB is lost, then delta might turn
> out to be (slightly) negative, which results in a
> bogus time stamp.
>
> The main reason why I want this modification is that MOL
> touches both DEC and TB. I've not managed to maintain
> exact coherency (appears to be more or less impossible).
> The fix above would guard against an occasional drift.

Why in the hell does it touch TB ? I could understand touching the
decrementer, but the TB should be sacred. It is the only absolute time
reference we have, and apart from being synchronized at boot on SMP, it
should never be changed.

If you touch the TB, you will lose the nicely spaced regular interrupts
that we have and screw up NTP for example, get occasionally shorter or
longer jiffies etc... I wrote the code carefully to avoid all these kinds
of problems. Besides that, you have to touch all TB simultaneously on SMP,
it's not as easy as it seems.

Finally, if you _really_ run into this problem, given the delay between
the decrementer interrupt and the update of tb_last_stamp, it means that
you likely introduce uncertainties of several microseconds. I forgot also
to mention that, to complicate matters, you have to check CPU type before
you touch the TB (601 versus all others).

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
