Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18195.63500.188527.311716@cargo.ozlabs.ibm.com>
Date: Tue, 16 Oct 2007 09:30:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: RE: Override timer interrupt
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B037D4F05@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B037D4BA9@ismail.innsys.innovsys.com>
	<20071012213041.GB22894@mag.az.mvista.com>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
	<1192229894.22054.29.camel@pasglop>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4F05@ismail.innsys.innovsys.com>
Cc: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen writes:

> The main couse is that our main bus frequency cannort be divided into
> 1kHz evently by the decrementer.
> Main bus freq = 99532800 Hz.
> Decrementer then becomes 24883, which gives us 999991.9624485600nsec per
> jiffy.
> That is not a number easilly converted into time without drift.

That shouldn't be a problem any more with the CONFIG_GENERIC_TIME
stuff.  What happens is that update_wall_time will accumulate
clock->xtime_interval to xtime for every clock->cycle_interval
timebase ticks.  The clock->xtime_interval is in units of 2^-22
nanoseconds, so it is very accurate.  It is computed from
clock->cycle_interval and clock->mult in
clocksource_calculate_interval() (in include/linux/clocksource.h).

Paul.
