Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8D31DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 00:46:23 +1000 (EST)
Date: Fri, 2 May 2008 16:46:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
Message-ID: <20080502164610.277ec04b@hyperion.delvare>
In-Reply-To: <9e4733910805020723p7900c132j872893113f9d739e@mail.gmail.com>
References: <20080121200740.13800.20524.stgit@terra.home>
	<20080219174221.5b18cba8@hyperion.delvare>
	<9e4733910805020723p7900c132j872893113f9d739e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Fri, 2 May 2008 10:23:01 -0400, Jon Smirl wrote:
> On 2/19/08, Jean Delvare <khali@linux-fr.org> wrote:
> >  >       i2c->irq = platform_get_irq(pdev, 0);
> >  > -     if (i2c->irq < 0) {
> >  > +     if (i2c->irq < NO_IRQ) {
> >
> >
> > I am skeptical about this one. Can platform_get_irq() really return
> >  NO_IRQ? I thought that the IRQ resource would be plain missing if the
> >  device has no IRQ, so I would expect:
> >
> >
> >         i2c->irq = platform_get_irq(pdev, 0);
> >         if (i2c->irq < 0)
> >
> >                 i2c->irq = NO_IRQ; /* Use polling */
> >
> >  Testing against NO_IRQ suggests that devices with no IRQ would still
> >  have an IRQ resource defined and explicitly set to NO_IRQ. Sounds weird
> >  to me. Can you please clarify this point?
> 
> Your fix is correct. I'm not sure polling worked in the original driver.

OK, can you send an updated patch then?

Thanks.

> >  For what it's worth, no other kernel driver checks for irq < NO_IRQ.
> >  They all check for irq < 0 after calling platform_get_irq().
> >
> >
> >  >               result = -ENXIO;
> >  >               goto fail_get_irq;
> >  >       }

-- 
Jean Delvare
