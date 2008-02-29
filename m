Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B4CCCDDED4
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 07:56:21 +1100 (EST)
Date: Fri, 29 Feb 2008 23:55:32 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 04/11] [RFC][GPIOLIB] add gpio_set_dedicated() routine
Message-ID: <20080229205532.GA26939@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
	<200802031322.08600.david-b@pacbell.net>
	<20080203233220.GA20105@zarina>
	<200802142036.40770.david-b@pacbell.net>
	<20080215114029.GA16810@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080215114029.GA16810@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 15, 2008 at 02:40:29PM +0300, Anton Vorontsov wrote:
[...]
> > > {
> > > 	qe_chip = container_of(gpio_to_chip(...), struct qe_chip, chip);
> > > 	...
> > 
> > You know, you can write all this yourself, without needing any
> > support from the GPIO framework whatsoever.  The QE stuff that
> > registered a gpio_chip interface to its hardware probably keeps
> > some records itself, sufficient for such (infrequent) mappings.
> 
> Yes, surely. And as I've said already, I do know how to workaround
> that, without GPIOLIB support. The thing is that I don't like the
> way I'm going to do it.

...please, don't force me to do these dirty hacks inside the arch code,
nobody will like them, I know it beforehand. ;-)

...if you so reluctant supporting dedicated functions inside the gpiolib,
then nothing could be easier than exporting gpio_to_chip(), so arch code
can write extensions without dirty hacks. Please?


p.s. By "dirty hacks" I mean:

a) drivers will need to fetch and store device_node in their private
   driver data, in _addition_ to gpio numbers;

b) which means that I'll have to introduce of_get_gpio_controller()
   to solely workaround gpio_to_chip() absence;

c) and all that will result in 9 * N additional lines of code to
   handle by the drivers, where N is the number of GPIOs we want to use:

   struct drvdata {
   (1) struct device_node *gpioX_controller;

   drv_probe()
   (2) drvdata->gpioX_controller = of_get_gpio_controller(...);
   (3) if (!drvdata->gpioX_controller) {
   (4)        ret = -EINVAL;
   (5)        goto gpioX_contr_failed;
   (6) }
   (7) gpioX_contr_failed:
   (8) of_put_gpio_controller(drvdata->gpioX_controller)

   drv_remove()
   {
   (9) of_put_gpio_controller(drvdata->gpioX_controller)

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
