Return-Path: <benh@kernel.crashing.org>
Subject: RE: Override timer interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B037D4BA9@ismail.innsys.innovsys.com>
	<20071012213041.GB22894@mag.az.mvista.com>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Sat, 13 Oct 2007 08:58:14 +1000
Message-Id: <1192229894.22054.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-10-12 at 16:39 -0500, Rune Torgersen wrote:
> > From: Mark A. Greer 
> > > Is there an easy way to use something other than the decrementer for
> the
> > > timer interrupt?
> 
> > Check out the clocksource stuff.  It let's you set up numerous clock
> > sources and set the rating of each one.  You can start looking in
> > arch/powerpc/kernel/time.c for example code.
> 
> Thanks I will. 
> Currently our board port lives in /arch/ppc (2.6.18) but I will take a
> look in powerpc.

Beware though... there a quite a few bits in there that assume the
timebase is being used as the main timekeeping source, like the vdso.

In fact, I'm not sure what is your problem with the DEC proper as the TB
will be used ultimately and thus it shouldn't drift more than the TB
does. Can your part use an externally clocked TB ?

If not, and you still have a drift despite calibration, you can always
use NTP services to adjust timekeeping.

Ben.
 
