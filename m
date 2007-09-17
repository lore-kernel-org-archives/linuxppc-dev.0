Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C5CA9DDEBA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 04:18:20 +1000 (EST)
Message-ID: <46EEC4AB.2030707@ru.mvista.com>
Date: Mon, 17 Sep 2007 22:17:15 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] usb: add device-tree-aware ehci driver
References: <20070917125039.GA29525@ru.mvista.com>	<20070917125543.GA29584@ru.mvista.com>
	<20070917232809.1221acd9.sfr@canb.auug.org.au>
In-Reply-To: <20070917232809.1221acd9.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Mon, 17 Sep 2007 16:55:43 +0400 Valentine Barshak <vbarshak@ru.mvista.com> wrote:
>> +++ linux-2.6/drivers/usb/host/ehci-ppc-of.c	2007-09-15 16:12:56.000000000 +0400
>> @@ -0,0 +1,220 @@
>> +
>> +#include <asm/of_platform.h>
>> +#include <asm/prom.h>
> 
> Please use linux/of.h and linux/of_platform.h instead.
> 
>> +static int ehci_hcd_ppc_of_shutdown(struct of_device *op)
>> +{
>> +	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
>> +
>> +        if (hcd->driver->shutdown)
>> +                hcd->driver->shutdown(hcd);
> 
> White space has gone a bit funny here.
> 
Corrected...
Sending new patch in a minute.
Looks like we'll need a patch that replaces asm/prom.h and 
asm/of_platform.h with linux/of.h and linux/of_platform.h
in other drivers.
ohci-ppc-of is definitely gonna need it.
BTW, I think the ohci_hcd_ppc_of_match stuff for ohci-ppc-of.c has to be 
  modified.
I think it should be .type="usb" instead of .name="usb" and 
.compatible="ohci-littlendian" doesn't look good to me either.
Thanks,
Valentine.
