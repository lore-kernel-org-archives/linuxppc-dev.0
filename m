Return-Path: <benh@kernel.crashing.org>
Subject: RE: Override timer interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B037D4F05@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B037D4BA9@ismail.innsys.innovsys.com>
	<20071012213041.GB22894@mag.az.mvista.com>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
	<1192229894.22054.29.camel@pasglop>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4F05@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 06:55:53 +1000
Message-Id: <1192481753.11795.25.camel@pasglop>
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


On Mon, 2007-10-15 at 11:49 -0500, Rune Torgersen wrote:
> 
> The main couse is that our main bus frequency cannort be divided into
> 1kHz evently by the decrementer.
> Main bus freq = 99532800 Hz.
> Decrementer then becomes 24883, which gives us 999991.9624485600nsec
> per
> jiffy.
> That is not a number easilly converted into time without drift.
> 
> Changing HZ to 100 fixes it, but is for varous reasons not an option
> right now.
> 
> What I did do is change the timer interrupt to be called by an
> ecxternal
> 1kHz interrupt source instead of the decrementer.
> 
> The TB register is only ued for offsets from the last jiffie, not as a
> continous offset, so then it works out pretty good.
> There is a discontinuity in the sub ms resolution of the clock that I
> can live with. msec and up are dead accurate.

The date is derived from the absolute TB value though...

Ben.
