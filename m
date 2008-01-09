Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by ozlabs.org (Postfix) with ESMTP id 94A83DDF83
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 22:20:39 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so121880fkz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 03:20:37 -0800 (PST)
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 1/7] [POWERPC] Xilinx: Uartlite: Make console output
	actually work.
References: <1199820909-32341-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080108193520.402F7F68051@mail132-sin.bigfish.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 09 Jan 2008 12:20:33 +0100
In-Reply-To: <20080108193520.402F7F68051@mail132-sin.bigfish.com> (Stephen
	Neuendorffer's message of "Tue\, 8 Jan 2008 11\:35\:03 -0800")
Message-ID: <87zlvfw8hq.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Stephen" == Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> writes:

 > From: Grant Likely <grant.likely@secretlab.ca>
 > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

 > Fixed to apply against 2.6.24-rc5, and remove DEBUG information.

Please CC me and the linux-serial list on uartlite patches.

The subject seems to be wrong, as console output works ok here
(non-OF). Perhaps change to uartlite: fix OF console setup ?

 > Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
 > ---
 >  drivers/serial/uartlite.c |  121 +++++++++++++++++++++++++++++----------------
 >  1 files changed, 79 insertions(+), 42 deletions(-)

 > diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
 > index 3f59324..71e4c0a 100644
 > --- a/drivers/serial/uartlite.c
 > +++ b/drivers/serial/uartlite.c
 > @@ -9,6 +9,8 @@
 >   * kind, whether express or implied.
 >   */
 
 > +#undef DEBUG
 > +

Don't do that! What are you trying to do?

 >  #include <linux/platform_device.h>
 >  #include <linux/module.h>
 >  #include <linux/console.h>
 > @@ -321,6 +323,49 @@ static struct uart_ops ulite_ops = {
 >  	.verify_port	= ulite_verify_port
 >  };
 
 > +/**
 > + * ulite_get_port: Get the uart_port for a given port number and base addr
 > + */
 > +static struct uart_port *ulite_get_port(int id)
 > +{
 > +	struct uart_port *port;
 > +
 > +	/* if id = -1; then scan for a free id and use that */
 > +	if (id < 0) {
 > +		for (id = 0; id < ULITE_NR_UARTS; id++)
 > +			if (ulite_ports[id].mapbase == 0)
 > +				break;
 > +	}
 > +
 > +	if ((id < 0) || (id >= ULITE_NR_UARTS)) {
 > +		printk(KERN_WARNING "uartlite: invalid id: %i\n", id);

pr_warn

 > +		return NULL;
 > +	}
 > +
 > +	/* The ID is valid, so get the address of the uart_port structure */
 > +	port = &ulite_ports[id];
 > +
 > +	/* Is the structure is already initialized? */
 > +	if (port->mapbase)
 > +		return port;
 > +
 > +	/* At this point, we've got an empty uart_port struct, initialize it */
 > +	spin_lock_init(&port->lock);
 > +	port->membase = NULL;
 > +	port->fifosize = 16;
 > +	port->regshift = 2;
 > +	port->iotype = UPIO_MEM;
 > +	port->iobase = 1; /* mark port in use */
 > +	port->ops = &ulite_ops;
 > +	port->irq = NO_IRQ;
 > +	port->flags = UPF_BOOT_AUTOCONF;
 > +	port->dev = NULL;
 > +	port->type = PORT_UNKNOWN;
 > +	port->line = id;

Please put the above in a conditional istead of 2 returns, E.G.

if (!port->mapbase) {
   spin_lock_init ..

 > +
 > +	return port;
 > +}
 > +
 >  /* ---------------------------------------------------------------------
 >   * Console driver operations
 >   */
 > @@ -376,7 +421,7 @@ static void ulite_console_write(struct console *co, const char *s,
 >  }
 
 >  #if defined(CONFIG_OF)
 > -static inline void __init ulite_console_of_find_device(int id)
 > +static inline u32 __init ulite_console_of_find_device(int id)

resource_size_t?

 >  {
 >  	struct device_node *np;
 >  	struct resource res;
 > @@ -392,13 +437,14 @@ static inline void __init ulite_console_of_find_device(int id)
 >  		if (rc)
 >  			continue;
 
 > -		ulite_ports[id].mapbase = res.start;
 >  		of_node_put(np);
 > -		return;
 > +		return res.start+3;

Are all OF users big endian?

 >  	}
 > +
 > +	return 0;
 >  }
 >  #else /* CONFIG_OF */
 > -static inline void __init ulite_console_of_find_device(int id) { /* do nothing */ }
 > +static inline u32 __init ulite_console_of_find_device(int id) { return 0; }
 >  #endif /* CONFIG_OF */
 
 >  static int __init ulite_console_setup(struct console *co, char *options)
 > @@ -408,25 +454,33 @@ static int __init ulite_console_setup(struct console *co, char *options)
 >  	int bits = 8;
 >  	int parity = 'n';
 >  	int flow = 'n';
 > +	u32 base;
 
 > -	if (co->index < 0 || co->index >= ULITE_NR_UARTS)
 > -		return -EINVAL;
 > +	/* Find a matching uart port in the device tree */
 > +	base = ulite_console_of_find_device(co->index);
 
 > -	port = &ulite_ports[co->index];
 > +	/* Get the port structure */
 > +	port = ulite_get_port(co->index);
 > +	if (!port)
 > +		return -ENODEV;
 
 > -	/* Check if it is an OF device */
 > -	if (!port->mapbase)
 > -		ulite_console_of_find_device(co->index);
 > +	/* was it initialized for this device? */
 > +	if (base) {

I preferred the old way, where it was clearer that this stuff is only
done in the OF case, E.G.:

/* Check if it is an OF device */
if (!port->mapbase)
   port->mapbase = ulite_console_of_find_device(co->index);

 > +		if ((port->mapbase) && (port->mapbase != base)) {
 > +			pr_debug(KERN_DEBUG "ulite: addr mismatch; %x != %x\n",
 > +				 port->mapbase, base);
 > +			return -ENODEV; /* port used by another device; bail */

You have this both here and in ulite_assign - Couldn't this be moved
to ulite_get_port?

 > +		}
 > +		port->mapbase = base;
 > +	}
 
 > -	/* Do we have a device now? */
 > -	if (!port->mapbase) {
 > -		pr_debug("console on ttyUL%i not present\n", co->index);
 > +	if (!port->mapbase)
 >  		return -ENODEV;
 > -	}
 
 > -	/* not initialized yet? */
 > +	/* registers mapped yet? */
 >  	if (!port->membase) {
 > -		if (ulite_request_port(port))
 > +		port->membase = ioremap(port->mapbase, ULITE_REGION);
 > +		if (!port->membase)
 >  			return -ENODEV;

Why not use request_port?

 >  	}
 
 > @@ -488,39 +542,22 @@ static int __devinit ulite_assign(struct device *dev, int id, u32 base, int irq)
 >  	struct uart_port *port;
 >  	int rc;
 
 > -	/* if id = -1; then scan for a free id and use that */
 > -	if (id < 0) {
 > -		for (id = 0; id < ULITE_NR_UARTS; id++)
 > -			if (ulite_ports[id].mapbase == 0)
 > -				break;
 > -	}
 > -	if (id < 0 || id >= ULITE_NR_UARTS) {
 > -		dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
 > -		return -EINVAL;
 > +	port = ulite_get_port(id);
 > +	if (!port) {
 > +		dev_err(dev, "Cannot get uart_port structure\n");

ulite_get_port can only fail in the invalid id case, where a suitable
error message has already been printed. This doesn't really add
anything.

 > +		return -ENODEV;

Why change the error code?
 >  	}
 
 > -	if ((ulite_ports[id].mapbase) && (ulite_ports[id].mapbase != base)) {
 > -		dev_err(dev, "cannot assign to %s%i; it is already in use\n",
 > -			ULITE_NAME, id);
 > -		return -EBUSY;
 > +	/* was it initialized for this device? */
 > +	if ((port->mapbase) && (port->mapbase != base)) {
 > +		pr_debug(KERN_DEBUG "ulite: addr mismatch; %x != %x\n",
 > +			 port->mapbase, base);
 > +		return -ENODEV;

Why change the error message? I found the old better. Also use
dev_err istead of pr_debug.

You again changed the error code.

 >  	}
 
 > -	port = &ulite_ports[id];
 > -
 > -	spin_lock_init(&port->lock);
 > -	port->fifosize = 16;
 > -	port->regshift = 2;
 > -	port->iotype = UPIO_MEM;
 > -	port->iobase = 1; /* mark port in use */
 port-> mapbase = base;
 > -	port->membase = NULL;
 > -	port->ops = &ulite_ops;
 port-> irq = irq;
 > -	port->flags = UPF_BOOT_AUTOCONF;
 port-> dev = dev;
 > -	port->type = PORT_UNKNOWN;
 > -	port->line = id;
 > -
 >  	dev_set_drvdata(dev, port);
 
 >  	/* Register the port */
 > -- 
 > 1.5.3.4-dirty



 > _______________________________________________
 > Linuxppc-dev mailing list
 > Linuxppc-dev@ozlabs.org
 > https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Bye, Peter Korsgaard
