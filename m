Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A0983DDF15
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 00:26:10 +1000 (EST)
Date: Thu, 5 Jul 2007 09:36:56 -0500
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] pcmcia: CompactFlash driver for PA Semi Electra boards
Message-ID: <20070705143656.GA14343@lixom.net>
References: <20070625010311.GA31355@lixom.net>
	<024cbfe00dde1c97bb249b925f55ebee@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <024cbfe00dde1c97bb249b925f55ebee@bga.com>
From: olof@lixom.net (Olof Johansson)
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2007 at 06:20:27AM -0500, Milton Miller wrote:

> get_property is now a #define for of_get_property.  I think the use of 
> get_property is being deprecated.

Yeah, it's a pita. I've moved these over now.

> If of_get_property fails to find the property, then you will 
> dereference a NULL pointer in a probe function and will leave the 
> bus_type locked.

Fixed.

> >+       /* XXX No way to undo the io reservation at this time */
> 
> What io reservation is this comment referring to?

ioremap_explicit. I've updated the comment.

> Where is the request_irq undone?

Fixed.

> >+static int __devexit electra_cf_remove(struct of_device *ofdev)
> >+{
> >+       struct device *device = &ofdev->dev;
> >+       struct electra_cf_socket *cf;
> >+
> >+       cf = dev_get_drvdata(device);
> >+
> >+       cf->active = 0;
> >+       pcmcia_unregister_socket(&cf->socket);
> >+       free_irq(cf->irq, cf);
> >+       del_timer_sync(&cf->timer);
> >+
> >+       iounmap(cf->mem_base);
> >+       iounmap(cf->gpio_base);
> >+       release_mem_region(cf->mem_phys, cf->mem_size);
> >+       release_region(cf->io_base, cf->io_size);
> >+
> >
> 
> irq_request?

Huh?


-Olof
