Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37153DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 06:02:25 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4SK2IOW010357
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 13:02:20 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4SK2Hw7001875
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 15:02:17 -0500 (CDT)
Date: Thu, 28 May 2009 15:02:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Nancy Isaac <nancy.isaac@pobox.com>
Subject: Re: 8544 external interrupt configuration problems
Message-ID: <20090528200215.GA9793@b07421-ec1.am.freescale.net>
References: <1bcc666d0905281205p63ee8119td5578a749bce8377@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1bcc666d0905281205p63ee8119td5578a749bce8377@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 28, 2009 at 12:05:52PM -0700, Nancy Isaac wrote:
> My device tree has the following entry for my fpga:
> 
> CpuCpld\@f0000000{
>                         compatible = "MPC8544DS";
>                         device_type = "CpuCpld";
>                         reg = <f0000000 00000040>;
>                         interrupts = <41 2 42 2 43 2>;
>                         interrupt-parent = <&mpic>;
> };

Where did you get those interrupt numbers from?  External interrupt
numbers start at zero on MPIC.

Is the level/sense information correct?

> My driver does the mapping to the virq:
> 
>  np = of_find_node_by_type(NULL, "CpuCpld");
>     if (!np) {
>         ret = -ENODEV;
>     }
>     cpldCpuDrv->MateIntIrq = irq_of_parse_and_map(np, 0);
>     cpldCpuDrv->FtaIrq =  irq_of_parse_and_map(np, 1);
>     cpldCpuDrv->ExtractIrq =  irq_of_parse_and_map(np, 2);
>     cpldCpuDrv->XauiIrq =  irq_of_parse_and_map(np, 0);
> 
>     of_node_put(np);

Looks good (other than that you should be using compatible (with a more
specific name) rather than device_type).

> Does anyone know what the virq should be for these external interrupts?

They're dynamically assigned.

> I've tried specifying the actual irq numbers 1,2 and 3 and that doesn't work
> either.

Specifying them where?  In the device tree or as virq numbers?  Never
hard-code virq numbers.

> Is there some PCI configuration that's getting in the way?  I've tried
> disabling the FSL_PCIE and I get the same behavior.

Barring an unusual bug, PCI should have nothing to do with the interrupt
routing of things that aren't on the PCI bus.

-Scott
