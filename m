Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40A7CDDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 19:18:48 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1201094056.9052.52.camel@thor.sulgenrain.local>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201091798.6341.49.camel@lappy>
	<1201094056.9052.52.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=utf-8
Date: Thu, 24 Jan 2008 19:18:05 +1100
Message-Id: <1201162685.6815.53.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-23 at 14:14 +0100, Michel Dänzer wrote:
> > Does ppc32 (or your instance thereof) have a high resolution
> > sched_clock()?
> 
> I'm not sure (FWIW, we did get support for NO_HZ and HIGH_RES_TIMERS
> in
> 2.6.24-rc as well, but playing with these config options and even
> reverting the code didn't seem to have any effect), can someone from
> the
> linuxppc-dev list answer this?

We do have a hires sched_clock() based on the processor internal
timebase and scaled to ns. Maybe we screwed something up there ? The
implementation is in arch/powerpc/kernel/timer.c

/*
 * Scheduler clock - returns current time in nanosec units.
 *
 * Note: mulhdu(a, b) (multiply high double unsigned) returns
 * the high 64 bits of a * b, i.e. (a * b) >> 64, where a and b
 * are 64-bit unsigned numbers.
 */
unsigned long long sched_clock(void)
{
	if (__USE_RTC())
		return get_rtc();
	return mulhdu(get_tb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
}

(You can mostly ignore the RTC() case which is the native ns clock of
the old 601 processor.

Ben.
