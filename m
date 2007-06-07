Return-Path: <philippe.lachenal@hotmail.fr>
Received: from bay0-omc2-s38.bay0.hotmail.com (bay0-omc2-s38.bay0.hotmail.com
	[65.54.246.174]) by ozlabs.org (Postfix) with ESMTP id 0BC48DDED5
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 21:29:57 +1000 (EST)
Message-ID: <BAY122-F20901751968A5E85E76FBB85260@phx.gbl>
In-Reply-To: <200706061615.11380.arnd@arndb.de>
From: "Philippe Lachenal" <philippe.lachenal@hotmail.fr>
To: arnd@arndb.de, linuxppc-dev@ozlabs.org
Subject: Re: MPC8349ea Random Number Generator driver
Date: Thu, 07 Jun 2007 13:29:52 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: sl@powerlinux.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

Thank you for your answer :)


>Looks good from the point of integration into the driver framework.
>I can't judge the hwrng specific parts, but don't see anything
>fundamentally wrong there.
>
> > +static int __init mpc834x_itx_declare_of_platform_devices(void)
> > +{
> > +       if (!machine_is(mpc834x_itx)){
> > +               printk("__init mpc834x_itx_declare_of_platform_devices 
>error\n");
> > +               return 0;
> > +       }
>
>I would think that it's not strictly an error to be running on some other
>hardware than yours ;-)
>
>Just remove the printk here.

I would think that you're right.. ;)





> > +       err = of_address_to_resource(rng_np, 0, &res);
> > +       if (err)
> > +               return -ENODEV; > +       rng_regs = ioremap(res.start, 
>(res.end - res.start));
>
>This can be done in one step with the new 'of_iomap' function.


nice :)

... I've checked this function, (yours ? ;) ) and  there's a very small 
difference between it and what I've done :

+-static void __iomem *of_iomap(struct device_node *np)
+-{
+-	struct resource res;
+-
+-	if (of_address_to_resource(np, 0, &res))
+-		return NULL;
+-
+-	pr_debug("Resource start: 0x%lx\n", res.start);
+-	pr_debug("Resource end: 0x%lx\n", res.end);
+-
+-	return ioremap(res.start, 1 + res.end - res.start);
+-}


why is there a  1+ res.end-res.start ? Am I wrong in not adding one in my 
code ?








> > +       printk(KERN_INFO "Registering Talitos RNG\n");
> > +
> > +       err = hwrng_register(&talitos_rng);
> > +       if (err){
> > +               printk(".............. failure\n");
> > +               iounmap(rng_regs);
> > +       }
>
>This printk should have a KERN_ERROR or similar level.
>Ideally, replace all instances of printk in your driver with 'dev_err',
>'dev_info' or similar calls from <linux/device.h>.
>
>	Arnd <><


ok, I will remove those ugly printks ;)

Phil

_________________________________________________________________
Personnalisez votre Messenger avec Live.com 
http://www.windowslive.fr/livecom/
