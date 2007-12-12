Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 724AFDDF47
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:00:34 +1100 (EST)
Date: Wed, 12 Dec 2007 19:03:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH RFC 3/7] [POWERPC] CPM2: implement GPIO API
Message-ID: <20071212160336.GA26814@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204845.GC32278@localhost.localdomain>
	<4760031A.6020005@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4760031A.6020005@scram.de>
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

On Wed, Dec 12, 2007 at 04:49:46PM +0100, Jochen Friedrich wrote:
> Hi Anton,
> 
> > +int gpio_direction_input(unsigned int gpio)
> > +{
> > +	unsigned long flags;
> > +	int port = gpio / 32;
> > +	int pin = gpio % 32;
> > +
> > +	spin_lock_irqsave(&cpm2_port_locks[port], flags);
> > +
> > +	cpm2_set_pin(port, pin, CPM_PIN_INPUT | CPM_PIN_GPIO);
> 
> > +int gpio_direction_output(unsigned int gpio, int value)
> > +{
> > +	struct cpm2_ioports __iomem *iop =
> > +		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
> > +	int port = gpio / 32;
> > +	int pin = gpio % 32;
> > +	unsigned long flags;
> > +
> > +	pin = 1 << (31 - pin);
> > +
> > +	spin_lock_irqsave(&cpm2_port_locks[port], flags);
> > +
> > +	cpm2_set_pin(port, pin, CPM_PIN_OUTPUT | CPM_PIN_GPIO);
> 
> You seem to do the pin -> bitmask conversation twice in gpio_direction_output().
> 
> cpm2_set_pin() must be executed before pin = 1 << (31 - pin);

Yup, found this just after posting. ;-) I've tried to move as much as
possible out of spinlocked section, but done it obviously wrong.
Will fix.

Anyhow, much thanks for looking into this.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
