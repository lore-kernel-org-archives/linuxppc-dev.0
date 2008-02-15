Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id E3A6FDE128
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:33:42 +1100 (EST)
In-Reply-To: <47B59631.10908@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <20c4ffabf05fc65d9d2ce0e73eaed44b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] booting-without-of: add Xilinx uart 16550.
Date: Fri, 15 Feb 2008 12:34:01 -0600
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

On Sat Feb 16 00:40:01 EST 2008, Pavel Kiryukhin pkiryukhin wrote:
> Add uart 16550 properties description to Xilinx portion of 
> booting-without-of.txt

This patch description is a bit weak.  How about adding what properties 
are being added.  Also, as described below, it's going to become more 
than just adding a property.

> Signed-off-by: Pavel Kiryukhin <pkiryukhin at ru.mvista.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt 
> b/Documentation/powerpc/booting-without-of.txt
> index 7b4e8a7..dd77bbc 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2575,10 +2575,22 @@ platforms are moved over to use the 
> flattened-device-tree model.
>
>        Xilinx uartlite devices are simple fixed speed serial ports.
>
> -      Requred properties:
> +      Required properties:
>         - current-speed : Baud rate of uartlite
>
> -      v) Xilinx hwicap
> +      v) Xilinx Uart 16550
> +
> +      Xilinx uart 16550 device registers are compatible with all 
> standard 16540
> +      and 16550 UARTs.
> +
> +      Required properties:
> +       - current-speed : Baud rate of uart.
> +       - clock-frequency : Baud rate generator reference clock. May 
> be driven
> +         by OPB_Clk (100 MHz).

Freqency of the reference clock generating the baud rate.  (Sometimes 
this is connected to the OBP_Clk which is usually 100MHz).   This is 
not the documentation for the macro, its the documentation for the 
device tree.

> +       - reg-shift : registers offset shift (standard uart_port 
> field).
> +         Property is optional if regshift is zero.

As Steven said, you must define what the property means (don't say that 
the value should be 2 on chip x, describe how to determine the correct 
value and how to use it).  "When this property is present, the address 
bits selecting the different 16550 registers are shifted left this many 
bits."

Also, since this is not register compatible with previous the previous 
ns16550 binding, we need to use a new compatible string. 
ns16550-shifted or ns16550-offset would be ok with me.  When we define 
this node, refer to 16550, and state that we expect nodes that have a 
zero shfit should include the ns16550 string.

Looking in the bigger context, this binding is not Xilinx specific; but 
I don't see an obviousy better place and am not going to do more than 
mention that issue.

milton
