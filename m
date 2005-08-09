Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id EAB3767FFB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 05:11:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 9 Aug 2005 14:11:33 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85941D@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Eugene Surovegin [mailto:ebs@ebshome.net]=20
> Sent: Tuesday, August 09, 2005 13:57
> > and it would be much better to just
> > use the clockrate given to the kernel than have to hardcode=20
> it into the
> > kernel.
>=20
> Nothing prevents you from defining this macro as a function call for=20
> example. If this is needed for your CPU/board port. Probably common
> case will be a constant, though.

Problem is that time_nsec is not directly set to CLOCK_TICK_RATE but
goes through some calculations I'd rather not have to lots of times in
runtime (maybe I'm not seeing how it could be done)

Anyways, the #define chain leading to time_nsec is:

unsigned long tick_nsec =3D TICK_NSEC;		/* ACTHZ period (nsec)
*/	kernel/time.c:562

#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
asm-ppc/timex.h:14

Include/linux/jiffies.h:45 and out
/* LATCH is used in the interval timer and ftape setup. */
#define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */

/* Suppose we want to devide two numbers NOM and DEN: NOM/DEN, the we
can
 * improve accuracy by shifting LSH bits, hence calculating:
 *     (NOM << LSH) / DEN
 * This however means trouble for large NOM, because (NOM << LSH) may no
 * longer fit in 32 bits. The following way of calculating this gives us
 * some slack, under the following conditions:
 *   - (NOM / DEN) fits in (32 - LSH) bits.
 *   - (NOM % DEN) fits in (32 - LSH) bits.
 */
#define SH_DIV(NOM,DEN,LSH) (   ((NOM / DEN) << LSH)
\
                             + (((NOM % DEN) << LSH) + DEN / 2) / DEN)

/* HZ is the requested value. ACTHZ is actual HZ ("<< 8" is for
accuracy) */
#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))

/* TICK_NSEC is the time between ticks in nsec assuming real ACTHZ */
#define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))


I cannot se a clean easy way of changing time_nsec or TIME_NSEC runtime
without messing with code that probably should not be messed with.
Of course I am probably wrong.
