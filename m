Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B2490DDD07
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 05:10:40 +1000 (EST)
Date: Sun, 26 Aug 2007 21:10:42 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH, RFC] linkstation: implement standby
In-Reply-To: <20070826110830.dfe6ea24.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.60.0708262110010.3791@poirot.grange>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
	<20070826110830.dfe6ea24.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 26 Aug 2007, Stephen Rothwell wrote:

> On Sun, 26 Aug 2007 02:03:49 +0200 (CEST) Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> >
> > +static int ls_pm_enter(suspend_state_t state)
> > +{
> > +	char ier;
> > +	int ret = 0;
> > +	u64 tb;
> > +
> > +	if ((ret = mpc10x_suspend(state)) < 0)
> > +		return ret;
> > +
> > +	/* Get timebase */
> > +	tb = get_tb();
> > +
> > +	/* put CPU to sleep, re-enabling interrupts */
> > +	mpc6xx_enter_sleep();
> > +
> > +	local_irq_disable();
> > +
> > +	set_tb(tb >> 32, tb & 0xfffffffful);
> > +
> > +fail:
> 
> Unused label?

Right, will fix in the next version, thanks.

Guennadi
---
Guennadi Liakhovetski
