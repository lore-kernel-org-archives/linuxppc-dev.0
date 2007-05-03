Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 07D35DDFD7
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 23:47:57 +1000 (EST)
Resent-Message-ID: <20070503134756.GA30711@xyzzy.farnsworth.org>
Date: Thu, 3 May 2007 06:06:23 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Message-ID: <20070503130623.GB7491@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000043.GK4046@mag.az.mvista.com>
	<20070502214416.GD27253@xyzzy.farnsworth.org>
	<200705030853.17749.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705030853.17749.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 08:53:17AM +0200, Arnd Bergmann wrote:
> On Wednesday 02 May 2007, Dale Farnsworth wrote:
> > +???????static int called_count;
> > +???????int instance = called_count++;
> 
> I would think it's simpler to count the instances in the outer loop
> when looking for the devices than having a static counter here.

Maybe.  I did it with passing an outer counter in a previous
incarnation.  I'll look at it again.

> > +       pdev = platform_device_register_simple(MV64XXX_I2C_CTLR_NAME,
> > +                                              instance, r, 2);
> > +       if (IS_ERR(pdev))
> > +               return PTR_ERR(pdev);
> > +
> > +       err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
> > +       if (err) {
> > +               platform_device_unregister(pdev);
> > +               return err;
> 
> Doing the initialization in this order means that you have to add the
> devices before the driver is loaded. I haven't checked if you do
> the same thing in the oder places as well, but I think it would be
> better to do it open coded like
> 
> 	pdev = platform_device_alloc(MV64XXX_I2C_CTLR_NAME, instance);
> 	if (!pdev)
> 		return -ENOMEM;
> 	err = platform_device_add_resources(pdev, r, 2);
> 	if (err)
> 		goto error;
> 	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
> 	if (err)
> 		goto error;
> 	err = platform_device_add(pdev);
> 	if (err)
> 		goto error;
> 	return pdev;
> error:
> 	platform_device_put(pdev);
> 	return ERR_PTR(err);

Makes sense to me.  I'll change it (in all three places).

Thanks.

-Dale
