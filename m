Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 89F56DE555
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:36:02 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <47B593E1.2060905@ru.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <36d7ea68f1be979009f4e96609d9905f@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v2] [POWERPC] Enable correct operation of serial ports
	with
Date: Fri, 15 Feb 2008 12:34:10 -0600
To: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Feb 16 00:30:09 EST 2008, Pavel Kiryukhin wrote:
> Add regshift reading to serial drivers.
> This enables correct operation of serial ports with
> nonzero regshift such as Xilinx opb 16550 uart.
>
> Signed-off-by: Pavel Kiryukhin <pkiryukhin at ru.mvista.com>


This patch is incomplete in that it does not add support to recognize 
any such nodes.

As discussed in the previous submissions, serial ports that attach the 
registers with offsets must get a new compatible name, as the binding 
for ns16550 does not include this reg--shift property.  It would 
therefore be wrong to claim compatibility with it, as older consumers 
of the device tree would bind to this node without the support.   (Its 
ok to check for this port always, but we should only expect it on the 
new compatible type).

We need to define this new type, add it to the doc, and add code to 
find such ports (presently we only search for ns16550 and device_type 
serial on isa bus).


> @@ -40,7 +40,7 @@ static int __devinit of_platform_serial_setup(struct 
> of_device *ofdev,
>                 dev_warn(&ofdev->dev, "no clock-frequency property 
> set\n");
>                 return -ENODEV;
>         }
> -
> +       regshift = of_get_property(np, "reg-shift", NULL);
>         ret = of_address_to_resource(np, 0, &resource);
>         if (ret) {
>                 dev_warn(&ofdev->dev, "invalid address\n");

Looking at the code I was going to say "lets put this optional property 
with the other one (spd) that doesn't have the if next to it."

However, I now see that the existence of spd (current-speed) is simply 
never checked, and if its missing this code will oops with a NULL 
pointer.  Could you prepare a patch to fix that?  I'm not sure if we 
need to fail if its not present, or we can just skip setting 
port->custom_divisor.  You will need to look at the driver to see what 
it requires.

And I think that fetching this property should be moved to the end 
instead of being mixed with the properties we require, but that is just 
my preference.

> @@ -57,6 +57,8 @@ static int __devinit of_platform_serial_setup(struct 
> of_device *ofdev,
>                 | UPF_FIXED_PORT;
>         port->dev = &ofdev->dev;
>         port->custom_divisor = *clk / (16 * (*spd));
> +       if (regshift)
> +               port->regshift = *regshift;
>
>         return 0;
>  }

milton
