Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <9e4733910711101144r3f8745dbs572aefa8658e1312@mail.gmail.com>
References: <9e4733910711101144r3f8745dbs572aefa8658e1312@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3DBBAC12-579B-4C1F-9C9E-D085FB22B687@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: IRQs in i2c-mpc.c
Date: Sat, 10 Nov 2007 17:09:56 -0600
To: Jon Smirl <jonsmirl@gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 10, 2007, at 1:44 PM, Jon Smirl wrote:

> I'm doing final clean up the i2c open firmware support. What is the
> intention of this code? Is it meant for a missing IRQ attribute to
> return a zero and not get an IRQ for the device? Does the device
> function without an IRQ? If so, it needs a comment explaining things.
> Otherwise IRQ of zero should be an error.
>
> 	i2c->irq = irq_of_parse_and_map(op->node, 0);
> 	if (i2c->irq <= 0) {
> 		result = -ENXIO;
> 		goto fail_irq;
> 	}
> 	
> 	if (i2c->irq != 0)
> 		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
> 					  	IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
> 			printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
> 			goto fail_irq;
> 		}

Looking at the current driver it looks like we could get ride of if  
check since the previous code checked the return of platform_get_irq().

- k
