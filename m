Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BEC6CDDF7F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 02:16:04 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <35d250938c0c5d7dae6a8735343059b7@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 12/13] powerpc: Add bootwrapper support for Motorola
	PrPMC2800 platform
Date: Mon, 30 Apr 2007 11:15:23 -0500
To: Mark A. Greer <mgreer@mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu Apr 26 10:02:27 EST 2007, Mark A. Greer wrote:
> Add support for Motorola ECC PrPMC280/PrPMC2800 Platform.
> The PrPMC280 sits on an F101 baseboard and the PrPMC2800 sits on a
> F101e baseboard.  Logic has been added to determine which board
> (and variant thereof) the code is being run on.

>
> +       /* Update /mv64x60/device_type, if this is a mv64362 */
> +       if (bip->bridge_type == BRIDGE_TYPE_MV64362) {
> +               devp = finddevice("/mv64x60");
> +               if (devp == NULL)
> +                       fatal("Error: Missing /mv64x60 device tree 
> node\n\r");
> +               setprop(devp, "device_type", "mv64362", 
> strlen("mv64362") + 1);
> +       }
> +

That is not a device_type.   It might be a model,   Or even a 
compatable.
but not a type.

> +       platform_ops.exit = prpmc2800_reset;

No delay to let the user know see what is wrong?

> +
> +/* Following code is put at very beginning of zImage (64KB into ELF 
> file) */
> +asm (" .globl _zimage_start\n\
> +       _zimage_start:\n\
> +               mfmsr   10\n\
> +               rlwinm  10,10,0,~(1<<15)        /* Clear MSR_EE */\n\
> +               sync\n\
> +               mtmsr   10\n\
> +               isync\n\
> +               b _zimage_start_lib\n\
> +");
>

That comment is very wrong.   This object might be the first to be 
linked,
and the text will be near the top.  But there is nothing in that 
fragment
to make it be the beginning of the image.  Not even in the text section.

That label will be the entrypoiint, so make the comment to that effect.

Also, the 1<<15 seems magic.  I would like to see it as a constant in
reg.h, but to use that you would have to pass it as an i parameter, so
I'm not sure it would improve.

milton
