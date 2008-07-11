Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 12F5DDDF22
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 05:19:32 +1000 (EST)
Date: Fri, 11 Jul 2008 23:19:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Message-ID: <20080711191930.GA23723@polina.dev.rtsoft.ru>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<4877B046.8070206@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4877B046.8070206@scram.de>
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

On Fri, Jul 11, 2008 at 09:11:02PM +0200, Jochen Friedrich wrote:
> Hi Anton,
> 
> > diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> > index b2ccdcb..95a24de 100644
> > --- a/drivers/of/of_i2c.c
> > +++ b/drivers/of/of_i2c.c
> > @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
> >  		if (info.irq == NO_IRQ)
> >  			info.irq = -1;
> >  
> > -		if (of_find_i2c_driver(node, &info) < 0) {
> > -			irq_dispose_mapping(info.irq);
> > -			continue;
> > -		}
> > +		if (of_find_i2c_driver(node, &info) < 0)
> > +			goto err;
> >  
> >  		info.addr = *addr;
> >  
> > @@ -107,9 +105,12 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
> >  			printk(KERN_ERR
> >  			       "of-i2c: Failed to load driver for %s\n",
> >  			       info.type);
> > -			irq_dispose_mapping(info.irq);
> > -			continue;
> > +			goto err;
> >  		}
> > +		continue;
> > +err:
> > +		if (info.irq > 0)
> > +			irq_dispose_mapping(info.irq);
> 
> Shouldn't this be:
> 		if (info.irq != NO_IRQ)

Maybe, maybe not. See

http://lkml.org/lkml/2005/11/21/211

I.e. maybe we should use "if (irq)". Or if we should use NO_IRQ, then we
need to fixup all the users of .irq.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
