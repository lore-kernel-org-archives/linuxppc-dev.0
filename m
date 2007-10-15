Return-Path: <runet@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Override timer interrupt
Date: Mon, 15 Oct 2007 16:50:53 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B037D5152@ismail.innsys.innovsys.com>
In-Reply-To: <1192481753.11795.25.camel@pasglop>
References: <DCEAAC0833DD314AB0B58112AD99B93B037D4BA9@ismail.innsys.innovsys.com>
	<20071012213041.GB22894@mag.az.mvista.com>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
	<1192229894.22054.29.camel@pasglop>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4F05@ismail.innsys.innovsys.com>
	<1192481753.11795.25.camel@pasglop>
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

> From: Benjamin Herrenschmidt>=20
> > The TB register is only ued for offsets from the last=20
> jiffie, not as a
> > continous offset, so then it works out pretty good.
>
> The date is derived from the absolute TB value though...

Huh? Not in 2.6.18/arch/ppc at least, unless I'm completely
misundrstanding the code.
ppc/powerpc seems to be using clocksource_jiffies as the clock source,
and teh gettimeofday gets xtime + a offset from last jiffie, and xtime
is updated with a fixed amount per tick.

Things have changed a lot since I last delved deep into this to try to
ge an accurate freerunning clock (2.6.12).
