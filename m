Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-232-tuesday.dmz.nerim.net
	[195.5.254.232]) by ozlabs.org (Postfix) with ESMTP id 76FC2DDF1B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 23:23:43 +1000 (EST)
Received: from mallaury.nerim.net (smtp-102-tuesday.noc.nerim.net
	[62.4.17.102])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id B9CB81A58B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 15:23:34 +0200 (CEST)
Date: Tue, 15 May 2007 15:24:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [i2c] [patch/rft 4/4] rtc-ds1307 platform update, powerpc
	mpc834x_itx and mpc8313_rdb
Message-ID: <20070515152428.576ca987@hyperion.delvare>
In-Reply-To: <200705141149.27858.david-b@pacbell.net>
References: <200705140946.41993.david-b@pacbell.net>
	<528646bc0705141044s244ce3ecyad5096c441134203@mail.gmail.com>
	<200705141125.59266.david-b@pacbell.net>
	<200705141149.27858.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 14 May 2007 11:49:27 -0700, David Brownell wrote:
> 
> > > > @@ -329,7 +330,7 @@ static int fsl_i2c_probe(struct platform
> > > >         i2c->adap = mpc_ops;
> > > >         i2c_set_adapdata(&i2c->adap, i2c);
> > > >         i2c->adap.dev.parent = &pdev->dev;
> > > > -       if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
> > > > +       if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
> > > >                 printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
> > > >                 goto fail_add;
> > > >         }
> > > 
> > > ... 
> > > 
> > > I think you need to add this line before the call to i2c_add_numbered_adapter:
> > > 
> > > i2c->adap.nr = pdev->id;
> > 
> > If these chips do have multiple instances of that adapter logic,
> > that would be an appropriate change.  The only "gotcha" might be
> > that some platforms use the "pdev->id = -1" trick when there's
> > only a single instance ... that would probably map to zero.
> > 
> > I'll hope that whoever makes all this work will resolve those
> > particular questions ...
> 
> Oh, and by the way:  patches updating I2C adapter drivers to work
> with new-style drivers look to be OK to get into 2.6.22 with just
> an Ack from Jean, via the MM tree.  (Right, Jean?)

Correct. I will happily ack such patches, but I won't be pushing them
upstream - unless waiting until 2.6.23 is OK for you.

-- 
Jean Delvare
