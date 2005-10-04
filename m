Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 2A96C68426
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Oct 2005 01:15:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 4 Oct 2005 10:15:10 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859479@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: RE: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Paul Mackerras [mailto:paulus@samba.org]=20
> Sent: Tuesday, October 04, 2005 07:49
> Subject: RE: clock skew on B/W G3
>
> I do not believe CLOCK_TICK_RATE affects timekeeping at all on ppc or
> ppc64 machines, but I could be wrong.  Can you show us where and how
> CLOCK_TICK_RATE affects things?

I looked very closely at htis thing earlier this summer because of an
embedded board that drifted quite severly (15sec a day) with a very
accureate BITS clock as clock source.

Here goes:
In arch/ppc/kernel/time.c
timer_interrupt() gets called every decrementer timeout (about every
1/CONFIG_HZ seconds, accuracy depends on how easily your decrementer
cliock can be divided by CONFIG_HZ)
this calls do_timer() to do the timer increment.

do_timer is in kernel/timer.c and calls update_times().
update_times() calls update_wall_time() which in turns calls
update_wall_time_one_tick()

update_wall_time_one_tick()uses tick_nsec to increment xtime.

tick_nsec is defined as: (kernel/timer.c:561)
unsigned long tick_nsec =3D TICK_NSEC;

TICK_NSEC is defined as: (include/linux/jiffies.h:64)
#define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))

ACTHZ is defined as: (include/linux/jiffies.h:61)
#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))

LATCH is defined as: (include/linux/jiffies.h:46)
#define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)

which means that tick_nsec depends on CLOCK_TICK_RATE to get its value.

defined as:
#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */

this clock is completely wrong for most/all ppc.=20
It happens to generate a tick_nsec of 999848 which is close enough to
1000000 that most people does not notice.
(tick_nsec is number of nsec per timer tick)

When HZ is 250, TICK_NSEC becomes 4000250.
While this might not completely explain a 20% change in clock sped, it
it clearly not acurate either.
