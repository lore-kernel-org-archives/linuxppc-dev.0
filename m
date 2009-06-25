Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4B3C8B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 21:28:39 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F8EBDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 21:28:37 +1000 (EST)
Subject: Re: [PATCH v2] Fix RTAS watchdog driver temperature read functionality
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Utz Bacher <utz.bacher@de.ibm.com>
In-Reply-To: <OF3E26F577.90C4A946-ONC12575E0.003E09AB-C12575E0.003E67E9@de.ibm.com>
References: <OF3E26F577.90C4A946-ONC12575E0.003E09AB-C12575E0.003E67E9@de.ibm.com>
Content-Type: text/plain
Date: Thu, 25 Jun 2009 21:28:14 +1000
Message-Id: <1245929294.22312.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-25 at 13:22 +0200, Utz Bacher wrote:
> 
> Adrian Reber wrote on 11.06.2009 12:52:17: 
> > 
> > I forgot about this patch. Can this still be merged?

Probably, can you re-send it in proper format to the list so it gets
into patchwork (unless it's already there in which case I'll pick it up
anyway) ?

Cheers,
Ben.

> > 
> > On Thu, Mar 26, 2009 at 01:05:42PM +0100, Adrian Reber wrote:
> > > Using the RTAS watchdog driver to read out the temperature crashes
> > > on a PXCAB:
> > > 
> > > Unable to handle kernel paging request for data at address
> 0xfe347b50
> > > Faulting instruction address: 0xc00000000001af64
> > > Oops: Kernel access of bad area, sig: 11 [#1]
> > > 
> > > The wrong usage of "(void *)__pa(&temperature)" in rtas_call() is
> > > removed by using the function rtas_get_sensor() which does the
> > > right thing.
> > > 
> > > Signed-off-by: Adrian Reber <adrian@lisas.de>
> > > ---
> > > v2: use rtas_get_sensor(); typo fixed
> > > ---
> > >  drivers/watchdog/wdrtas.c |    8 +++-----
> > >  1 files changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
> > > index 5d3b1a8..a9f00dc 100644
> > > --- a/drivers/watchdog/wdrtas.c
> > > +++ b/drivers/watchdog/wdrtas.c
> > > @@ -214,16 +214,14 @@ static void wdrtas_timer_keepalive(void)
> > >   */
> > >  static int wdrtas_get_temperature(void)
> > >  {
> > > -   long result;
> > > +   int result;
> > >     int temperature = 0;
> > >  
> > > -   result = rtas_call(wdrtas_token_get_sensor_state, 2, 2,
> > > -            (void *)__pa(&temperature),
> > > -            WDRTAS_THERMAL_SENSOR, 0);
> > > +   result = rtas_get_sensor(WDRTAS_THERMAL_SENSOR, 0,
> &temperature);
> > >  
> > >     if (result < 0)
> > >        printk(KERN_WARNING "wdrtas: reading the thermal sensor "
> > > -             "faild: %li\n", result);
> > > +             "failed: %i\n", result);
> > >     else
> > >        temperature = ((temperature * 9) / 5) + 32; /* fahrenheit
> */
> > >  
> > > -- 
> > > 1.5.6.6
> 
> makes sense. Second version also looks good to me -- thanks! 
> 
> Acked-by: Utz Bacher <utz.bacher@de.ibm.com> 
> 
> Utz 
> 
> :wq
