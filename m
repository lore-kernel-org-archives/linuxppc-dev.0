Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7A420DE088
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 22:21:56 +1000 (EST)
Date: Tue, 3 Jun 2008 16:21:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 1/2] [POWERPC] rtc_cmos_setup: assign interrupts only
	if there is i8259 PIC
Message-ID: <20080603122155.GB2407@polina.dev.rtsoft.ru>
References: <20080505185538.GA4906@polina.dev.rtsoft.ru>
	<20080506081914.269180@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080506081914.269180@gmx.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 06, 2008 at 10:19:14AM +0200, Gerhard Pircher wrote:
> 
> -------- Original-Nachricht --------
> > Datum: Mon, 5 May 2008 22:55:38 +0400
> > Von: Anton Vorontsov <avorontsov@ru.mvista.com>
> > An: Kumar Gala <galak@kernel.crashing.org>
> > CC: linuxppc-dev@ozlabs.org
> > Betreff: [PATCH 1/2] [POWERPC] rtc_cmos_setup: assign interrupts only if	there is i8259 PIC
> 
> > Sometimes (particularly on MPC8610HPCD) we want IRQ-less CMOS RTC for
> > the boards without (or disabled) i8259 PICs.
> > 
> > We lookup the device tree for "chrp,iic" compatible devices, and if not
> > found we do not assign RTC IRQ.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  arch/powerpc/sysdev/rtc_cmos_setup.c |   21 +++++++++++++++------
> >  1 files changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/rtc_cmos_setup.c
> > b/arch/powerpc/sysdev/rtc_cmos_setup.c
> > index c09ddc0..e5d0bcb 100644
> > --- a/arch/powerpc/sysdev/rtc_cmos_setup.c
> > +++ b/arch/powerpc/sysdev/rtc_cmos_setup.c
> > @@ -21,6 +21,7 @@ static int  __init add_rtc(void)
> >  	struct device_node *np;
> >  	struct platform_device *pd;
> >  	struct resource res[2];
> > +	unsigned int num_res = 1;
> >  	int ret;
> >  
> >  	memset(&res, 0, sizeof(res));
> > @@ -41,14 +42,22 @@ static int  __init add_rtc(void)
> >  	if (res[0].start != RTC_PORT(0))
> >  		return -EINVAL;
> >  
> > -	/* Use a fixed interrupt value of 8 since on PPC if we are using this
> > -	 * its off an i8259 which we ensure has interrupt numbers 0..15. */
> > -	res[1].start = 8;
> > -	res[1].end = 8;
> > -	res[1].flags = IORESOURCE_IRQ;
> > +	np = of_find_compatible_node(NULL, NULL, "chrp,iic");
> Could you add a check for "pnpPNP,000" (PNP ID for i8259), as not all
> platforms use the CHRP names?

Ok, will do.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
