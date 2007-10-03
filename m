Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18178.59123.511480.956928@cargo.ozlabs.ibm.com>
Date: Wed, 3 Oct 2007 10:48:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH v3 2/4] Implement generic time of day clocksource for
	powerpc machines.
In-Reply-To: <20070921213552.GD9814@bakeyournoodle.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<20070921032603.07AF232C889@thor>
	<20070921145212.7e8a7b89.sfr@canb.auug.org.au>
	<20070921213552.GD9814@bakeyournoodle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds writes:

> @@ -982,6 +906,10 @@ void __init time_init(void)
>  
>  	write_sequnlock_irqrestore(&xtime_lock, flags);
>  
> +	/* Register the clocksource, if we're not running on iSeries */
> +	if (!firmware_has_feature(FW_FEATURE_ISERIES))
> +		clocksource_init();

This breaks the 32-bit compile.

Is it possible to adjust the frequency of a clocksource after it has
been registered?  Or could the timebase clocksource be unregistered
and reregistered in iSeries_tb_recal?

Paul.
