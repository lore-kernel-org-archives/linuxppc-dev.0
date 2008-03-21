Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 70546DDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 11:19:08 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so270779anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 17:19:07 -0700 (PDT)
Message-ID: <fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
Date: Thu, 20 Mar 2008 18:19:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <john.linn@xilinx.com>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
In-Reply-To: <20080320144402.3063517C005D@mail148-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 8:43 AM, John Linn <john.linn@xilinx.com> wrote:
> The Xilinx 16550 uart core is not a standard 16550, because it uses
>  word-based addressing rather than byte-based addressing.  As a result,
>  it is not compatible with the open firmware 'ns16550' compatible
>  binding.  This code introduces new bindings, which pass the correct
>  register base and regshift properties to the uart driver to enable
>  this core to be used.  Doing this cleanly required some refactoring of
>  the existing code.

Personally, I'm not fond of this approach.  There is already some
traction to using the reg-shift property to specify spacing, and I
think it would be appropriate to also define a reg-offset property to
handle the +3 offset and then let the xilinx 16550 nodes use those.

More comments below.

>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>  Signed-off-by: John Linn <john.linn@xilinx.com>
>  ---
>   drivers/serial/of_serial.c |   47 ++++++++++++++++++++++++++++++-------------
>   1 files changed, 33 insertions(+), 14 deletions(-)
>
>  diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
>  index 2efb892..910c94f 100644
>  --- a/drivers/serial/of_serial.c
>  +++ b/drivers/serial/of_serial.c
>  @@ -20,13 +20,15 @@
>   struct of_serial_info {
>         int type;
>         int line;
>  +       int regshift;
>  +       int regoffset;
>   };
>
>   /*
>   * Fill a struct uart_port for a given device node
>   */
>   static int __devinit of_platform_serial_setup(struct of_device *ofdev,
>  -                                       int type, struct uart_port *port)
>  +                                       struct of_serial_info *info, struct uart_port *port)
>   {
>         struct resource resource;
>         struct device_node *np = ofdev->node;
>  @@ -48,17 +50,16 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
>         }
>
>         spin_lock_init(&port->lock);
>  -       port->mapbase = resource.start;
>  +       port->mapbase = resource.start + info->regoffset;
>         port->irq = irq_of_parse_and_map(np, 0);
>         port->iotype = UPIO_MEM;
>  -       port->type = type;
>  +       port->type = info->type;
>  +       port->regshift = info->regshift;
>         port->uartclk = *clk;
>         port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
>                 | UPF_FIXED_PORT;
>         port->dev = &ofdev->dev;
>  -       /* If current-speed was set, then try not to change it. */
>  -       if (spd)
>  -               port->custom_divisor = *clk / (16 * (*spd));
>  +       port->custom_divisor = *clk / (16 * (*spd));

Oops, looks like you're undoing your previous patch here.

>
>         return 0;
>   }
>  @@ -81,8 +82,9 @@ static int __devinit of_platform_serial_probe(struct of_device *ofdev,
>         if (info == NULL)
>                 return -ENOMEM;
>
>  -       port_type = (unsigned long)id->data;
>  -       ret = of_platform_serial_setup(ofdev, port_type, &port);
>  +       memcpy(info, id->data, sizeof(struct of_serial_info));
>  +       port_type = info->type;
>  +       ret = of_platform_serial_setup(ofdev, info, &port);
>         if (ret)
>                 goto out;
>
>  @@ -100,7 +102,6 @@ static int __devinit of_platform_serial_probe(struct of_device *ofdev,
>         if (ret < 0)
>                 goto out;
>
>  -       info->type = port_type;
>         info->line = ret;
>         ofdev->dev.driver_data = info;
>         return 0;
>  @@ -128,15 +129,33 @@ static int of_platform_serial_remove(struct of_device *ofdev)
>         return 0;
>   }
>
>  +static struct of_serial_info __devinitdata ns8250_info = { .type = PORT_8250 };
>  +static struct of_serial_info __devinitdata ns16450_info = { .type = PORT_16450 };
>  +static struct of_serial_info __devinitdata ns16550_info = { .type = PORT_16550 };
>  +static struct of_serial_info __devinitdata ns16750_info = { .type = PORT_16750 };
>  +static struct of_serial_info __devinitdata xilinx_16550_info = {
>  +       .type = PORT_16550,
>  +       .regshift = 2,
>  +       .regoffset = 3,
>  +};
>  +static struct of_serial_info __devinitdata unknown_info = { .type = PORT_UNKNOWN };

In support of my argument; the fact that you need a table of data says
to me that this data should really be encoded in the device tree.  :-)

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
