Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20DDADDE06
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 14:27:44 +1000 (EST)
Date: Wed, 3 Oct 2007 06:00:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 2/4] Implement generic time of day clocksource for
	powerpc machines.
In-Reply-To: <18178.59123.511480.956928@cargo.ozlabs.ibm.com>
Message-ID: <alpine.LRH.0.999.0710030554550.15610@www.tglx.de>
References: <1190345162.620000.305760830507.qpush@thor>
	<20070921032603.07AF232C889@thor>
	<20070921145212.7e8a7b89.sfr@canb.auug.org.au>
	<20070921213552.GD9814@bakeyournoodle.com>
	<18178.59123.511480.956928@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, John Stultz <johnstul@us.ibm.com>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 3 Oct 2007, Paul Mackerras wrote:

> Tony Breeds writes:
> 
> > @@ -982,6 +906,10 @@ void __init time_init(void)
> >  
> >  	write_sequnlock_irqrestore(&xtime_lock, flags);
> >  
> > +	/* Register the clocksource, if we're not running on iSeries */
> > +	if (!firmware_has_feature(FW_FEATURE_ISERIES))
> > +		clocksource_init();
> 
> This breaks the 32-bit compile.
> 
> Is it possible to adjust the frequency of a clocksource after it has
> been registered?  Or could the timebase clocksource be unregistered
> and reregistered in iSeries_tb_recal?

There is no unregister interface right now. But we need some mechanism to 
tell the core code that you changed it. I have a look if John does not 
beat me.

	tglx
