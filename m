Return-Path: <anton@ozlabs.org>
Date: Mon, 1 Feb 2010 16:44:19 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Reduce footprint of irq_stat
Message-ID: <20100201054419.GR2996@kryten>
References: <20100112105642.GI12666@kryten> <1265001704.8287.31.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1265001704.8287.31.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> > +static inline void ack_bad_irq(unsigned int irq)
> > +{
> > +	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
> > +}
> 
> Looks like some unrelated gunk slipped into this patch :-)

We need that to link :) 

kernel/irq/handle.c: In function ‘handle_bad_irq’:
kernel/irq/handle.c:43: error: implicit declaration of function ‘ack_bad_irq’

It's basically a copy of the fallback handler in the asm-generic hardirq.h
I'm happy to change it print "IRQ on fire" :)

Anton
