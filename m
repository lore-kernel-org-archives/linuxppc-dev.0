Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711101144r3f8745dbs572aefa8658e1312@mail.gmail.com>
Date: Sat, 10 Nov 2007 14:44:28 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>
Subject: IRQs in i2c-mpc.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm doing final clean up the i2c open firmware support. What is the
intention of this code? Is it meant for a missing IRQ attribute to
return a zero and not get an IRQ for the device? Does the device
function without an IRQ? If so, it needs a comment explaining things.
Otherwise IRQ of zero should be an error.

	i2c->irq = irq_of_parse_and_map(op->node, 0);
	if (i2c->irq <= 0) {
		result = -ENXIO;
		goto fail_irq;
	}
	
	if (i2c->irq != 0)
		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
					  	IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
			printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
			goto fail_irq;
		}

-- 
Jon Smirl
jonsmirl@gmail.com
