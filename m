Date: Mon, 21 Aug 2000 14:18:19 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: diekema_jon <diekema@bucks.si.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: decrementer_count, count_period_num, and count_period_den has
 disappeared
In-Reply-To: <m13QqLg-001SzbC@bucks>
Message-ID: <Pine.HPX.4.10.10008211412090.15550-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 21 Aug 2000, diekema_jon wrote:

>
> It appears the decrementer_count, count_period_num, and
> count_period_den variables from arch/ppc/kernel/time.c have changed.
> This is causing arch/ppc/kernel/m8260_setup.c to not compile.

Yes, that's my fault (but seriously the previous code was wrong).

> m8260_setup.c: In function `abort':
> m8260_setup.c:105: warning: `noreturn' function does return
> m8260_setup.c: In function `m8260_calibrate_decr':
> m8260_setup.c:116: `decrementer_count' undeclared (first use in this function)
> m8260_setup.c:116: (Each undeclared identifier is reported only once
> m8260_setup.c:116: for each function it appears in.)
> m8260_setup.c:117: `count_period_num' undeclared (first use in this function)
> m8260_setup.c:118: `count_period_den' undeclared (first use in this function)
>
> I believe that decrementer_count was renamed to tb_ticks_per_jiffy, and
> count_period_num/count_period_den are converted somehow into tb_to_us.

tb_to_us is a factor to convert with a single multiply high (mulhwu) the
difference between current tb and the current tb into microseconds.

> Could someone tell me the relationship between
> count_period_num/count_period_den and tb_to_us?

Have a look at the recent patches on prep_time/pmac_time/chrp_time:

- tb_to_us can be computed by mulhwu_scale_factor(decrementer_frequency,
1000000). There is no simple relationship.

Tell me if the timebase frequency is <1 MHz, I'll produce a specific patch
to help this case which can't work with the current algorithm (which made
gettimeday faster by removing an ugly integer divide).

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
