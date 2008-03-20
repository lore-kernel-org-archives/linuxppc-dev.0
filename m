Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id E290FDDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 10:58:09 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so269049anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 16:58:08 -0700 (PDT)
Message-ID: <fa686aa40803201658g6fbdcab0he06dd1e3c83ca900@mail.gmail.com>
Date: Thu, 20 Mar 2008 17:58:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <john.linn@xilinx.com>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/3] [POWERPC] of_serial: Fix possible null dereference.
In-Reply-To: <20080320144402.6A0E3518070@mail63-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080320144402.6A0E3518070@mail63-sin.bigfish.com>
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
> From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
>  The of_serial driver queries the current-speed property and attempts
>  to use it to register the custom_divisor property of the uart_port.
>  However, if current-speed is not set, then this code will dereference
>  a bad pointer.  The fix is to only set custom_divisor when a
>  current-speed property appears in the device tree.
>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>  Signed-off-by: John Linn <john.linn@xilinx.com>

This looks correct and appropriate to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Josh/Arnd, could either of you pick this up?

Cheers,
g.

>  ---
>   drivers/serial/of_serial.c |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
>  diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
>  index a64d858..2efb892 100644
>  --- a/drivers/serial/of_serial.c
>  +++ b/drivers/serial/of_serial.c
>  @@ -56,7 +56,9 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
>         port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
>                 | UPF_FIXED_PORT;
>         port->dev = &ofdev->dev;
>  -       port->custom_divisor = *clk / (16 * (*spd));
>  +       /* If current-speed was set, then try not to change it. */
>  +       if (spd)
>  +               port->custom_divisor = *clk / (16 * (*spd));
>
>         return 0;
>   }
>  --
>  1.5.2.1
>
>
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
