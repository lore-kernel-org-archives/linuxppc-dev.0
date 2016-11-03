Return-Path: <Paul.Burton@imgtec.com>
Received: from imgpgp01.kl.imgtec.org (mailapp01.imgtec.com [195.59.15.196])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8yTh4zNyzDvRP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 08:17:12 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC: Larry Finger <Larry.Finger@lwfinger.net>, Michael Ellerman
 <mpe@ellerman.id.au>, Andreas Schwab <schwab@linux-m68k.org>, Andrew Morton
 <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Petr Mladek
 <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
Date: Thu, 3 Nov 2016 21:17:01 +0000
Message-ID: <2317993.vxfTP7Yo3N@np-p-burton>
In-Reply-To: <20161103174040.GB423@swordfish>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <20161103125758.3415-1-paul.burton@imgtec.com>
 <20161103174040.GB423@swordfish>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3610523.7cgrJ2oKS4";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart3610523.7cgrJ2oKS4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Sergey,

On Friday, 4 November 2016 02:40:40 GMT Sergey Senozhatsky wrote:
> On (11/03/16 12:57), Paul Burton wrote:
> > If a device tree specified a preferred device for kernel console output
> > via the stdout-path or linux,stdout-path chosen node properties there's
> > no guarantee that it will have specified a device for which we have a
> > driver. It may also be the case that we do have a driver but it doesn't
> > call of_console_check() to register as a preferred console (eg. offb
> > driver as used on powermac systems).
> 
> so why that driver doesn't call of_console_check() then? if there is a
> misconfiguration then why do we want to fix it/fallback in printk code?

Ideally I think the driver (or perhaps fbdev/fbcon) ought to call 
of_console_check() which would allow the console to be enabled earlier again. 
However there isn't any single place I can see that currently has all the 
information required to do so - the device tree node, the name & index of the 
console.

Even if we change that in the future & do call of_console_check(), I can't 
guarantee that offb is the only driver that would encounter this case, and it 
still wouldn't cover the case of us not having any driver for the specified 
stdout-path device. The fallback thus seems like a sensible thing to do.

> 
> [..]
> 
> > @@ -260,10 +260,18 @@ void console_set_by_of(void)
> > 
> >  {
> >  
> >  	of_specified_console = true;
> >  
> >  }
> > 
> > +
> > +static void clear_of_specified_console(void)
> > +{
> > +	of_specified_console = false;
> > +}
> > 
> >  #else
> >  # define of_specified_console false
> > 
> > +static void clear_of_specified_console(void) { }
> > 
> >  #endif
> > 
> > +struct console *of_fallback_console;
> > +
> > 
> >  /* Flag: console code may call schedule() */
> >  static int console_may_schedule;
> > 
> > @@ -2657,10 +2665,26 @@ void register_console(struct console *newcon)
> > 
> >  	 *	didn't select a console we take the first one
> >  	 *	that registers here.
> >  	 */
> > 
> > -	if (preferred_console < 0 && !of_specified_console) {
> > +	if (preferred_console < 0) {
> > 
> >  		if (newcon->index < 0)
> >  		
> >  			newcon->index = 0;
> > 
> > -		if (newcon->setup == NULL ||
> > +		if (of_specified_console) {
> > +			/*
> > +			 * The device tree stdout-path chosen node property was
> > +			 * specified so we don't want to enable the first
> > +			 * registered console just now in order to give the
> > +			 * device indicated by stdout-path a chance to be
> > +			 * registered first. Do however keep track of the
> > +			 * first console we see so that we can fall back to
> > +			 * using it if we don't see the desired device, either
> > +			 * because stdout-path isn't valid, or because we have
> > +			 * no driver for the device or our driver doesn't call
> > +			 * of_console_check(). See printk_late_init() for this
> > +			 * fallback.
> 
> if the path is not valid then correct the path. no?

...but what if the path is valid and we simply don't have a driver for the 
device it references? As I said in that comment we may not have a driver at 
all.

> 
> > +			 */
> > +			if (!of_fallback_console)
> > +				of_fallback_console = newcon;
> > +		} else if (newcon->setup == NULL ||
> > 
> >  		    newcon->setup(newcon, NULL) == 0) {
> >  			
> >  			newcon->flags |= CON_ENABLED;
> >  			if (newcon->device) {
> > 
> > @@ -2844,6 +2868,22 @@ static int __init printk_late_init(void)
> > 
> >  {
> >  
> >  	struct console *con;
> > 
> > +	if (of_specified_console && of_fallback_console &&
> > +	    (!console_drivers || !(console_drivers->flags & CON_CONSDEV))) {
> > +		/*
> > +		 * The system has a device tree which specified stdout-path,
> > +		 * but we haven't seen a console associated with the device
> > +		 * specified by the stdout-path chosen node property.
> > +		 *
> > +		 * We do however know which console would have been used
> > +		 * if stdout-path weren't specified at all, so in an attempt
> > +		 * to provide some output we'll re-register that console
> > +		 * pretending that we never saw stdout-path.
> > +		 */
> 
> DT screwed up, so why would printk() care? does any other
> sub-system/driver fixes up a DT misconfiguration?
> 
> 	-ss

...and again, it may not be a misconfiguration - that's one possibility of a 
few that I mentioned. Even if the DT is misconfigured & stdout-path is 
completely bonkers it's still arguable that falling back to the first console 
registered (ie. our previous behaviour) is the sensible thing to do. Perhaps 
we ought to warn in such cases, but even then we can't distinguish between the 
3 cases I mentioned (invalid stdout-path, driver which doesn't call 
of_console_check() or no driver at all) so we'd certainly end up warning on 
systems like these affected PowerPC systems, which makes me think that may be 
a better warning to introduce once we expect systems to not hit it.

Thanks,
    Paul

> 
> > +		clear_of_specified_console();
> > +		register_console(of_fallback_console);
> > +	}
> > +
> > 
> >  	for_each_console(con) {
> >  	
> >  		if (!keep_bootcon && con->flags & CON_BOOT) {
> >  		
> >  			/*


--nextPart3610523.7cgrJ2oKS4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYG6lNAAoJEIIg2fppPBxloPMP/2YAJEYA+v7ppsBznxCEWcUH
acShMRXJq9uIoC+HmXwcyJr1laAz9zs5E3zI+5NcIEF8K6/kUsEXvMpsMDlhBfky
4XooFX5y+z5bknYNdH+Kes6yTRYq8PkKlnjcTZl61Q1Jun5GgjIRXAzhF0iFYhFT
kr56E464aPP2P5nfjFsboorCePVHLh5wy4tkO4MhwVjc3SA3HgveTYAvzU6t7Yl/
yyfsw1YAc5+sHR0x2IbjiJ9I8FEfucQEfDgh1rQhJKBkdM/3wbG30Fuj81kNh8JP
O5Jku+ugvGgVwkPUBSClzlKfy+pn2Glr2/zwRGddcOH0sYsxFxXlBiZ4PGXitCTm
S7Ga1usK3HET3OrwmESon2UMzGValh/Yu08wMn7QyYUFt2FjBdSiEGMotv1GiDBo
aHHExiplUJiDKtEMqPjES5/3i7jcmKI2EcSk/ZAldTmFjo1ZBZ9C8q1ydKRx+0xN
ecy3wEpj7VMHf/OK5pJQbPj2sEwKxqpUVD2UyUUkJQZ3o8BSIrhzDsO7EUihQltT
BPS8R/abiZUqvyqrbFZA+jf0ni1+jtqv+la84/xEibVx+aliFECviO0HV5Z/5SIA
TTkJyTYXX1yFARGH90V1lXZIOuiwhKtNurqP9958pS1s9WqKFlye14GP28zgM7+E
hfZabUavsJKc/BBiwKpP
=Aqe4
-----END PGP SIGNATURE-----

--nextPart3610523.7cgrJ2oKS4--
