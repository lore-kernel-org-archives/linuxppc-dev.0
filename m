Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id DDADADDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 04:46:32 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2669729wxd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 10:46:30 -0700 (PDT)
Message-ID: <fa686aa40804021046n1bc0626ay6a3f9f2a251331ef@mail.gmail.com>
Date: Wed, 2 Apr 2008 11:46:30 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <john.linn@xilinx.com>, "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH 1/3][POWERPC][V2] of_serial: Fix possible null dereference.
In-Reply-To: <20080402165216.8FD2BC9807F@mail21-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080402165216.8FD2BC9807F@mail21-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 2, 2008 at 10:52 AM, John Linn <john.linn@xilinx.com> wrote:
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
Acked-by: Grant Likely <grant.likely@secretlab.ca>

Paul, can you please pick this one up for .25?  It is pure bug fix.

Thanks,
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
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
