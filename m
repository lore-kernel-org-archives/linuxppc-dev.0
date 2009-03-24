Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AAEA1DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 08:00:47 +1100 (EST)
Subject: Re: [PATCH] Fix RTAS watchdog driver temperature read functionality
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Reber <adrian@lisas.de>
In-Reply-To: <20090324114505.GB24724@lisas.de>
References: <20090316123543.GG15530@lisas.de>
	<1237868838.25062.712.camel@pasglop> <20090324114505.GB24724@lisas.de>
Content-Type: text/plain
Date: Wed, 25 Mar 2009 08:00:33 +1100
Message-Id: <1237928433.25062.725.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-24 at 12:45 +0100, Adrian Reber wrote:
> On Tue, Mar 24, 2009 at 03:27:18PM +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2009-03-16 at 13:35 +0100, Adrian Reber wrote:
> > > Using the RTAS watchdog driver to read out the temperature crashes
> > > on a PXCAB:
> > > 
> > > Unable to handle kernel paging request for data at address 0xfe347b50
> > > Faulting instruction address: 0xc00000000001af64
> > > Oops: Kernel access of bad area, sig: 11 [#1]
> > > 
> > > This (removing "(void *)__pa") fixes it.
> > 
> > Looks correct, but why not use rtas_get_sensor() instead ? (Exported by
> > arch/powerpc/kernel/rtas.c
> 
> Ah, you mean something like?

Right, now turn it into a proper patch submission :-)

Cheers,
Ben.

>  drivers/watchdog/wdrtas.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
> index 5d3b1a8..af2bbfa 100644
> --- a/drivers/watchdog/wdrtas.c
> +++ b/drivers/watchdog/wdrtas.c
> @@ -214,16 +214,14 @@ static void wdrtas_timer_keepalive(void)
>   */
>  static int wdrtas_get_temperature(void)
>  {
> -	long result;
> +	int result;
>  	int temperature = 0;
>  
> -	result = rtas_call(wdrtas_token_get_sensor_state, 2, 2,
> -			   (void *)__pa(&temperature),
> -			   WDRTAS_THERMAL_SENSOR, 0);
> +	result = rtas_get_sensor(WDRTAS_THERMAL_SENSOR, 0, &temperature);
>  
>  	if (result < 0)
>  		printk(KERN_WARNING "wdrtas: reading the thermal sensor "
> -		       "faild: %li\n", result);
> +		       "faild: %i\n", result);
>  	else
>  		temperature = ((temperature * 9) / 5) + 32; /* fahrenheit */
> 
> 		Adrian
