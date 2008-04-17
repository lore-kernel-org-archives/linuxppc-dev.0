Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 84D53DE296
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:13:06 +1000 (EST)
Date: Thu, 17 Apr 2008 19:13:05 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080417151305.GA6130@polina.dev.rtsoft.ru>
References: <20080311172106.GA4766@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
	<200804171624.02769.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200804171624.02769.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 04:23:56PM +0200, Laurent Pinchart wrote:
[...]
> > +	/*
> > +	 * We have two 8 bit prescalers -- primary and secondary (psr, sps),
> > +	 * plus "slow go" mode (clk / 16). So, total prescale value is
> > +	 * 16 * (psr + 1) * (sps + 1).
> > +	 */
> > +	if (prescaler > 256 * 256 * 16)
> > +		return -EINVAL;
> > +
> > +	if (prescaler > 256 * 256) {
> > +		iclk = GTMDR_ICLK_SLGO;
> > +		prescaler /= 16;
> > +	}
> > +
> > +	if (prescaler > 256) {
> > +		psr = 256 - 1;
> > +		sps = prescaler / 256 - 1;
> > +	} else {
> > +		psr = prescaler - 1;
> > +		sps = 1 - 1;
> > +	}
> 
> Don't forget that the CPM2 doesn't support the primary prescaler.

I didn't know that, how can I possibly forget it? Oh, now I can.
Thanks for the info. :-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
