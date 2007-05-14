Return-Path: <david-b@pacbell.net>
Received: from smtp113.sbc.mail.mud.yahoo.com (smtp113.sbc.mail.mud.yahoo.com
	[68.142.198.212]) by ozlabs.org (Postfix) with SMTP id BCB2DDDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 04:49:31 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [patch/rft 4/4] rtc-ds1307 platform update,
	powerpc mpc834x_itx and mpc8313_rdb
Date: Mon, 14 May 2007 11:49:27 -0700
References: <200705140946.41993.david-b@pacbell.net>
	<528646bc0705141044s244ce3ecyad5096c441134203@mail.gmail.com>
	<200705141125.59266.david-b@pacbell.net>
In-Reply-To: <200705141125.59266.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705141149.27858.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, rtc-linux@googlegroups.com,
	James Chapman <jchapman@katalix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > > @@ -329,7 +330,7 @@ static int fsl_i2c_probe(struct platform
> > >         i2c->adap = mpc_ops;
> > >         i2c_set_adapdata(&i2c->adap, i2c);
> > >         i2c->adap.dev.parent = &pdev->dev;
> > > -       if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
> > > +       if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
> > >                 printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
> > >                 goto fail_add;
> > >         }
> > 
> > ... 
> > 
> > I think you need to add this line before the call to i2c_add_numbered_adapter:
> > 
> > i2c->adap.nr = pdev->id;
> 
> If these chips do have multiple instances of that adapter logic,
> that would be an appropriate change.  The only "gotcha" might be
> that some platforms use the "pdev->id = -1" trick when there's
> only a single instance ... that would probably map to zero.
> 
> I'll hope that whoever makes all this work will resolve those
> particular questions ...

Oh, and by the way:  patches updating I2C adapter drivers to work
with new-style drivers look to be OK to get into 2.6.22 with just
an Ack from Jean, via the MM tree.  (Right, Jean?)

In this case I'll hope someone else does the real submission, after
testing.  I just wanted to nudge the process along.

- Dave
