Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F00E067C23
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 08:19:25 +1100 (EST)
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
References: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
	<B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 08:19:14 +1100
Message-Id: <1166476754.19254.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
> > +extern ulong ds1374_get_rtc_time(void);
> > +extern int ds1374_set_rtc_time(ulong);
> > +
> > +static int __init mpc83xx_rtc_hookup(void)
> > +{
> > +	struct timespec tv;
> > +
> > +	ppc_md.get_rtc_time = ds1374_get_rtc_time;
> > +	ppc_md.set_rtc_time = ds1374_set_rtc_time;
> > +
> > +	tv.tv_nsec = 0;
> > +	tv.tv_sec = (ppc_md.get_rtc_time) ();
> > +	do_settimeofday(&tv);
> > +
> > +	return 0;
> > +}
> > +
> > +late_initcall(mpc83xx_rtc_hookup);
> > +#endif
> 
> This is sort of evil and we need to clean it up, but we have some  
> time for 2.6.21.  Does the MPC832x MDS have the DS1374?

Also, always test if (machine_is(xxx)) in your initcalls since they'll
be called regardless of what machine has been selected.

Ben.
