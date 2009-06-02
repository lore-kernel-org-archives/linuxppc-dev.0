Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03235DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 10:47:29 +1000 (EST)
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27-
	"no_irq_chip" error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20090528123311.GA3112@pengutronix.de>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl> <20090528123311.GA3112@pengutronix.de>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 10:47:21 +1000
Message-Id: <1243903641.591.19.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-28 at 14:33 +0200, Wolfram Sang wrote:
> > this is an example of how a simple 8313 Periodic Interval Timer (PIT) kernel driver
> > registers for the PIT IRQ (Interrupt ID 65)
> >
> > #define PIT_IRQ 65
> >
> >     virq = irq_create_mapping(NULL, PIT_IRQ);
> >     set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
> >
> >     if(request_irq(virq, (irq_handler_t)timerEvent, 0, "timer2", (void *)0)) {
> >         printk(KERN_ERR "request_irq() returned error for irq=%d virq=%d\n", PIT_IRQ, virq);
> >     }
> 
> It is some time ago, but when I did something similar I needed the
> following patch in order to use NULL for irq_create_mapping(). Have a
> try, and if it is still needed (as it looks from a glimpse), then maybe
> we should get it merged?

I would object that you wouldn't have this problem if you weren't hard
wiring your interrupt number and were using the device-tree properly
instead. As to getting your patch merged, you'll have to argue with
Scott Wood who, I think, maintains the CPM2 stuff lately.

Cheers,
Ben.

> ===
> 
> From: Wolfram Sang <w.sang@pengutronix.de>
> Subject: [PATCH] powerpc/cpm2: make cpm2_pic the default host
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  arch/powerpc/sysdev/cpm2_pic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
> index 78f1f7c..7a7d4e5 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.c
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -272,4 +272,5 @@ void cpm2_pic_init(struct device_node *node)
>  		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
>  		return;
>  	}
> +	irq_set_default_host(cpm2_pic_host);
>  }
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
