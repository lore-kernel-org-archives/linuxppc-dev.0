Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A93EDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 12:42:44 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2L1gV9j020794
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 21:42:31 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2L1gVgB125298
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 19:42:31 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2L1gUaC025826
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 19:42:31 -0600
Date: Thu, 20 Mar 2008 20:41:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] [POWERPC] of_serial: Fix possible null dereference.
Message-ID: <20080320204103.1f744e27@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40803201658g6fbdcab0he06dd1e3c83ca900@mail.gmail.com>
References: <20080320144402.6A0E3518070@mail63-sin.bigfish.com>
	<fa686aa40803201658g6fbdcab0he06dd1e3c83ca900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Mar 2008 17:58:07 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Thu, Mar 20, 2008 at 8:43 AM, John Linn <john.linn@xilinx.com> wrote:
> > From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> >
> >  The of_serial driver queries the current-speed property and attempts
> >  to use it to register the custom_divisor property of the uart_port.
> >  However, if current-speed is not set, then this code will dereference
> >  a bad pointer.  The fix is to only set custom_divisor when a
> >  current-speed property appears in the device tree.
> >
> >  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> >  Signed-off-by: John Linn <john.linn@xilinx.com>
> 
> This looks correct and appropriate to me.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Agreed.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

> Josh/Arnd, could either of you pick this up?

Arnd, can you send this on to Andrew?  Or if you are busy I can.

josh

> >  ---
> >   drivers/serial/of_serial.c |    4 +++-
> >   1 files changed, 3 insertions(+), 1 deletions(-)
> >
> >  diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
> >  index a64d858..2efb892 100644
> >  --- a/drivers/serial/of_serial.c
> >  +++ b/drivers/serial/of_serial.c
> >  @@ -56,7 +56,9 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
> >         port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
> >                 | UPF_FIXED_PORT;
> >         port->dev = &ofdev->dev;
> >  -       port->custom_divisor = *clk / (16 * (*spd));
> >  +       /* If current-speed was set, then try not to change it. */
> >  +       if (spd)
> >  +               port->custom_divisor = *clk / (16 * (*spd));
> >
> >         return 0;
> >   }
> >  --
> >  1.5.2.1
> >
> >
> >
> >  _______________________________________________
> >  Linuxppc-dev mailing list
> >  Linuxppc-dev@ozlabs.org
> >  https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> 
> 
> 
