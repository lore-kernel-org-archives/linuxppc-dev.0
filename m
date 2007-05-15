Return-Path: <david-b@pacbell.net>
Received: from smtp112.sbc.mail.re2.yahoo.com (smtp112.sbc.mail.re2.yahoo.com
	[68.142.229.93]) by ozlabs.org (Postfix) with SMTP id 2BEC6DDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 01:35:19 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter
Date: Tue, 15 May 2007 08:28:36 -0700
References: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
	<20070515152626.199f9d6b@hyperion.delvare>
In-Reply-To: <20070515152626.199f9d6b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705150828.37529.david-b@pacbell.net>
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

On Tuesday 15 May 2007, Jean Delvare wrote:
> On Mon, 14 May 2007 13:11:23 -0600, Grant Likely wrote:

> > --- a/drivers/i2c/busses/i2c-mpc.c
> > +++ b/drivers/i2c/busses/i2c-mpc.c
> > @@ -327,9 +327,10 @@ static int fsl_i2c_probe(struct platform_device *pdev)
> >  	platform_set_drvdata(pdev, i2c);
> >  
> >  	i2c->adap = mpc_ops;
> > +	i2c->adap.nr = pdev->id;

By the way:  mpc_ops is a static i2c_adapter, so given that
the reason for using pdev->id that way was that there might
be more than one such platform device ... shouldn't allocation
of the adapter be moved into allocation of the "i2c->" object?

Or at least, add a check to ensure that the static mpc_ops
structure isn't in use before progressing this probe().

- Dave


> >  	i2c_set_adapdata(&i2c->adap, i2c);
> >  	i2c->adap.dev.parent = &pdev->dev;
> > -	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
> > +	if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
> >  		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
> >  		goto fail_add;
> >  	}
> 
> -- 
> Jean Delvare
> 
