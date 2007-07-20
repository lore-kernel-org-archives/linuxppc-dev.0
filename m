Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF695DDED2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 09:48:55 +1000 (EST)
Date: Fri, 20 Jul 2007 16:48:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH v3] pcmcia: CompactFlash driver for PA Semi Electra boards
Message-Id: <20070720164823.95608e43.akpm@linux-foundation.org>
In-Reply-To: <20070705144914.GA14284@lixom.net>
References: <20070625010311.GA31355@lixom.net>
	<20070625171221.GA6684@lixom.net>
	<20070625193909.GA26021@infradead.org>
	<20070625204341.GA8865@lixom.net>
	<20070705144914.GA14284@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jul 2007 09:49:14 -0500
olof@lixom.net (Olof Johansson) wrote:

> Driver for the CompactFlash slot on the PA Semi Electra eval board. It's
> a simple device sitting on localbus, with interrupts and detect/voltage
> control over GPIO.
> 
> The driver is implemented as an of_platform driver, and adds localbus
> as a bus being probed by the of_platform framework.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> On Mon, Jun 25, 2007 at 03:43:41PM -0500, olof wrote:
> 
> > The ifdef is needed since for CONFIG_PCMCIA=n builds, the bus notifier
> > isn't available. I wanted to do the bus notifier registration explicitly
> > before the of_platform bus probe to avoid later surprises due to reordered
> > initcalls in case it was split up in it's own initcall.
> > 
> > I could add the code under ifdef as well, but it didn't seem too
> > critical. Once the second major board comes along I'll probably move it
> > out to a per-board file, there's no real need for it just yet.
> 
> Alright, turns out I still need to declare the extern bus type, which would mean
> two #ifdefs in one function. Moving it out instead.
> 
> I've addressed Milton's comments as well.
> 
> Who's maintaining PCMCIA? MAINTAINERS only lists a mailing list, no person. Seems
> weird for a component that's marked as maintained.

Dominik Brodowski.  He's having a bit of downtime at present (exams, I
think).  He expects to return.  Meanwhile, cc'ing me usually has some
effect.

>
> ...
>
> +static const char driver_name[] = "electra-cf";
>
> ...
>
> +static struct of_device_id electra_cf_match[] =
> +{
> +	{
> +		.compatible   = "electra-cf",
> +	},
> +	{},
> +};

Could have reused driver_name[] here, if that was appropriate.

> +static struct of_platform_driver electra_cf_driver =
> +{
> +	.name	   = (char *)driver_name,

ug.  But it's not your fault - we should have always made it const.

> --- mainline.orig/arch/powerpc/platforms/pasemi/setup.c
> +++ mainline/arch/powerpc/platforms/pasemi/setup.c

I never know who maintains random-scruffy-ppc code like this.  From a peek
in the git-whatchanged output, it appears to be yourself.


Have a few little fixies:

--- a/drivers/pcmcia/electra_cf.c~pcmcia-compactflash-driver-for-pa-semi-electra-boards-fix
+++ a/drivers/pcmcia/electra_cf.c
@@ -201,9 +201,7 @@ static int __devinit electra_cf_probe(st
 	if (!cf)
 		return -ENOMEM;
 
-	init_timer(&cf->timer);
-	cf->timer.function = electra_cf_timer;
-	cf->timer.data = (unsigned long) cf;
+	setup_timer(&cf->timer, electra_cf_timer, (unsigned long)cf);
 	cf->irq = NO_IRQ;
 
 	cf->ofdev = ofdev;
@@ -340,16 +338,14 @@ static int __devexit electra_cf_remove(s
 	return 0;
 }
 
-static struct of_device_id electra_cf_match[] =
-{
+static struct of_device_id electra_cf_match[] = {
 	{
 		.compatible   = "electra-cf",
 	},
 	{},
 };
 
-static struct of_platform_driver electra_cf_driver =
-{
+static struct of_platform_driver electra_cf_driver = {
 	.name	   = (char *)driver_name,
 	.match_table    = electra_cf_match,
 	.probe	  = electra_cf_probe,
@@ -371,4 +367,3 @@ module_exit(electra_cf_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR ("Olof Johansson <olof@lixom.net>");
 MODULE_DESCRIPTION("PA Semi Electra CF driver");
-
_
