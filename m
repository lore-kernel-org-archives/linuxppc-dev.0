Return-Path: <runet@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FW: Override timer interrupt
Date: Mon, 15 Oct 2007 17:15:59 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B037D517E@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Benjamin Herrenschmidt =20
> > Things have changed a lot since I last delved deep into=20
> > this to try to
> > ge an accurate freerunning clock (2.6.12).
>=20
> Hrm... 2.6.18 doesn't have clock sources in the first place,=20
> what kernel
> are you using ?
>=20

2.6.18
And I'm starting at the clocksource code right now...

>From jiffies.c:
static int __init init_jiffies_clocksource(void)
{
	return clocksource_register(&clocksource_jiffies);
}

module_init(init_jiffies_clocksource);

from: kernel/timer.c
/*
 * update_wall_time - Uses the current clocksource to increment the wall
time
 *
 * Called from the timer interrupt, must hold a write on xtime_lock.
 */
static void update_wall_time(void)
{
	cycle_t offset;

	/* Make sure we're fully resumed: */
	if (unlikely(timekeeping_suspended))
		return;

#ifdef CONFIG_GENERIC_TIME
	offset =3D (clocksource_read(clock) - clock->cycle_last) &
clock->mask;
#else
	offset =3D clock->cycle_interval;
#endif
	clock->xtime_nsec +=3D (s64)xtime.tv_nsec << clock->shift;

	/* normally this loop will run just once, however in the
	 * case of lost or late ticks, it will accumulate correctly.
	 */
	while (offset >=3D clock->cycle_interval) {
		/* accumulate one interval */
		clock->xtime_nsec +=3D clock->xtime_interval;
		clock->cycle_last +=3D clock->cycle_interval;
		offset -=3D clock->cycle_interval;

		if (clock->xtime_nsec >=3D (u64)NSEC_PER_SEC <<
clock->shift) {
			clock->xtime_nsec -=3D (u64)NSEC_PER_SEC <<
clock->shift;
			xtime.tv_sec++;
			second_overflow();
		}

		/* interpolator bits */
		time_interpolator_update(clock->xtime_interval
						>> clock->shift);
		/* increment the NTP state machine */
		update_ntp_one_tick();

		/* accumulate error between NTP and clock interval */
		clock->error +=3D current_tick_length();
		clock->error -=3D clock->xtime_interval <<
(TICK_LENGTH_SHIFT - clock->shift);
	}

	/* correct the clock when NTP error is too big */
	clocksource_adjust(clock, offset);

	/* store full nanoseconds into xtime */
	xtime.tv_nsec =3D (s64)clock->xtime_nsec >> clock->shift;
	clock->xtime_nsec -=3D (s64)xtime.tv_nsec << clock->shift;

	/* check to see if there is a new clocksource to use */
	if (change_clocksource()) {
		clock->error =3D 0;
		clock->xtime_nsec =3D 0;
		clocksource_calculate_interval(clock, tick_nsec);
	}
}
