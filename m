Date: Mon, 10 Nov 2003 23:53:55 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmac_halt() bug
Message-ID: <20031111085355.GR3648@plato.local.lan>
References: <7AFDCF4E-FCCB-11D6-8F24-003065F22EAA@mindspring.com> <booek6$vvl$1@sea.gmane.org> <1068508789.31229.70.camel@gaston> <EE1CD888-1419-11D8-9936-00039382032A@mindspring.com> <1068539125.13038.87.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1068539125.13038.87.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 11, 2003 at 07:25:25PM +1100, Benjamin Herrenschmidt wrote:
>
> >
> > That's precisely it.  Some (all?) pmacs with server mode don't
> > automatically turn on after an intentional shutdown, only after power
> > is lost.  So the idea is to have the UPS signal the computer to halt,
> > and then have the UPS cut power once it's safe.  Later the UPS switches
> > power back on and the computer will automatically boot.
>
> Ok, 2 things:
>
> - How does the UPS knows it's "safe" ?

varies, the UPS i have has a smart monitoring program run over a
serial line, the UPS informs the daemon when it believes there is only
5 minutes of power remaining, and the daemon initiates a halt, the UPS
shuts down when there is only 2 minutes of power remaining, so your
shutdown process better not take longer then 3 minutes.

> - And right, I need to disable server mode to be able to shut down :) So
> I indeed to that on those machines

and there is the problem. on x86 many bioses provide an option which
lets you choose behavior post powerfail, on an x86 i have one option
is to bootup whenever AC power is lost and then restored, regardless
of previous shutdown state, for others the only way is to just halt
the machine without a powerdown.

pmac seems to have no way to accomplish either atm.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
