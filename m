Date: Thu, 12 Apr 2001 20:09:16 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Karim Yaghmour <karym@opersys.com>
Cc: Samuel Rydh <samuel@ibrium.se>, linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] gettimeofday stability
In-Reply-To: <3AD4B9E7.C96F1088@opersys.com>
Message-ID: <Pine.HPX.4.10.10104121947440.1891-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 11 Apr 2001, Karim Yaghmour wrote:

> While porting the Linux Trace Toolkit to PPC I noticed a problem
> that may be explained by the symptoms described. The way it works
> is that LTT uses do_gettimeofday() to stamp the events that occur.
> Occasionnaly, a trace would contain entries where the timestamp
> will jump (from one event to the next) of approximately 4295 seconds.
> Later on, this would come back to a "normal" value. And the
> 4295 seconds are 2^32/1000000. Hence the underflow.
>
> This has been noticed with both 2.2.x and 2.4.x kernels.

Given that time handling is completely different in 2.2 and 2.4, it is
surprising. This would indicate that a decrementer interrupt has happened
too early.

How often does it happen ? Does it still happen with recent kernels ?
Were you running something that touches the decrementer (MOL, RTLINUX) ?

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
