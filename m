Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D7ED72C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 10:02:46 +1000 (EST)
Message-ID: <1376092951.15633.93.camel@snotra.buserror.net>
Subject: Re: [v2] Enhanced support for MPC8xx/8xxx watchdog
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Fri, 9 Aug 2013 19:02:31 -0500
In-Reply-To: <520331C1.4060406@c-s.fr>
References: <201302280852.r1S8qMYu003742@localhost.localdomain>
 <20130625230431.GA29393@home.buserror.net> <520331C1.4060406@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wim Van Sebroeck <wim@iguana.be>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-08 at 07:50 +0200, leroy christophe wrote:
> Le 26/06/2013 01:04, Scott Wood a =C3=A9crit :
> > What happens if there's a race?  If another CPU updates wdt_last_ping=
 in
> > parallel, then you could see wdt_last_ping greater than the value you
> > read for jiffies.  Since this is an unsigned comparison, it will fail=
 to
> > call keepalive.  You might get saved by pinging it twice as often as
> > necessary, but you shouldn't rely on that.
> Euh ... This watchdog is integrated inside the CPU, so there is no=20
> chance that any external CPU get access to it.

Hmm, it looks like mpc8641d (which is the only multi-core SoC among mpc8x=
x/mpc83xx/mpc86xx) does not have this watchdog, even though mpc8610 does.

So pretend I said "what if you get preempted?". :-)

> >> +		mpc8xxx_wdt_keepalive();
> >> +		/* We're pinging it twice faster than needed, to be sure. */
> >> +		mod_timer(&wdt_timer, jiffies + HZ * hw_timo_sec / 2);
> >> +	}
> >> +}
> >> +
> >> +static void mpc8xxx_wdt_sw_keepalive(void)
> >> +{
> >> +	wdt_last_ping =3D jiffies;
> >> +	mpc8xxx_wdt_timer_ping(0);
> >>   }
> > This isn't new with this patch, but it looks like
> > mpc8xxx_wdt_keepalive() can be called either from timer context, or w=
ith
> > interrupts enabled... yet it uses a bare spin_lock() rather than an
> > irq-safe version.  This should be fixed.
> Ok, I'll propose another patch for that. Indeed, is the spin_lock neede=
d=20
> at all ? If we get two writes interleaved, it will make it anyway.

I suppose...  I don't like relying on things like that, though.

-Scott
