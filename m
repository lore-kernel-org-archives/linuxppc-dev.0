Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Nov 2008 10:08:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: rtc-ppc
Message-ID: <20081105230825.GA28465@yookeroo.seuss>
References: <20081105021901.49dffc3e@i1501.lan.towertech.it>
	<1225923526.3882.3.camel@macbook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1225923526.3882.3.camel@macbook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 05, 2008 at 11:18:46PM +0100, David Woodhouse wrote:
> On Wed, 2008-11-05 at 02:19 +0100, Alessandro Zummo wrote:
> >   I was checking a few drivers for compliance and noticed that
> >  the rtc-ppc driver registers a platform device instead of
> >  a platform driver.
> > 
> >   Wouldn't be possible to have the ppc arch doing the device
> >  thing and cleanup the driver?
> 
> It would be possible, yes -- but it would be better to have the various
> PPC platforms just register RTC-class devices _directly_, and ditch the
> RTC bits from ppc_md altogether.
> 
> I think we're waiting until the RTC class works with NTP before we can
> contemplate that, though.

Yeah, I tried writing some ppc_md hooks which backended onto the rtc
class drivers as an interim measure, but the hooks are called from
places the rtc class stuff can't safely be called (too early, IIRC,
but it's a while since I checked).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
