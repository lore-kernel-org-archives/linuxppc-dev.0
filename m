Return-Path: <runet@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Override timer interrupt
Date: Mon, 15 Oct 2007 11:49:38 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B037D4F05@ismail.innsys.innovsys.com>
In-Reply-To: <1192229894.22054.29.camel@pasglop>
References: <DCEAAC0833DD314AB0B58112AD99B93B037D4BA9@ismail.innsys.innovsys.com>
	<20071012213041.GB22894@mag.az.mvista.com>
	<DCEAAC0833DD314AB0B58112AD99B93B037D4C1B@ismail.innsys.innovsys.com>
	<1192229894.22054.29.camel@pasglop>
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

> From: Benjamin Herrenschmidt
> In fact, I'm not sure what is your problem with the DEC=20
> proper as the TB
> will be used ultimately and thus it shouldn't drift more than the TB
> does. Can your part use an externally clocked TB ?
>=20
> If not, and you still have a drift despite calibration, you can always
> use NTP services to adjust timekeeping.

We use NTP, which is why I didn't see it until recently. (Happened to
have a board without NTP configured

The main couse is that our main bus frequency cannort be divided into
1kHz evently by the decrementer.
Main bus freq =3D 99532800 Hz.
Decrementer then becomes 24883, which gives us 999991.9624485600nsec per
jiffy.
That is not a number easilly converted into time without drift.

Changing HZ to 100 fixes it, but is for varous reasons not an option
right now.

What I did do is change the timer interrupt to be called by an ecxternal
1kHz interrupt source instead of the decrementer.

The TB register is only ued for offsets from the last jiffie, not as a
continous offset, so then it works out pretty good.
There is a discontinuity in the sub ms resolution of the clock that I
can live with. msec and up are dead accurate.
