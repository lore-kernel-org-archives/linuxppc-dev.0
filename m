Message-ID: <3AD4B9E7.C96F1088@opersys.com>
Date: Wed, 11 Apr 2001 16:09:11 -0400
From: Karim Yaghmour <karym@opersys.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Samuel Rydh <samuel@ibrium.se>, linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] gettimeofday stability
References: <Pine.HPX.4.10.10104112111330.1891-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> Finally, if you _really_ run into this problem, given the delay between
> the decrementer interrupt and the update of tb_last_stamp, it means that
> you likely introduce uncertainties of several microseconds. I forgot also
> to mention that, to complicate matters, you have to check CPU type before
> you touch the TB (601 versus all others).
>

While porting the Linux Trace Toolkit to PPC I noticed a problem
that may be explained by the symptoms described. The way it works
is that LTT uses do_gettimeofday() to stamp the events that occur.
Occasionnaly, a trace would contain entries where the timestamp
will jump (from one event to the next) of approximately 4295 seconds.
Later on, this would come back to a "normal" value. And the
4295 seconds are 2^32/1000000. Hence the underflow.

This has been noticed with both 2.2.x and 2.4.x kernels.

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
