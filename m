Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7FDDDDDF87
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 00:18:17 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m84EIAAU009331
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 07:18:11 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m84EI9Ls015236
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 09:18:09 -0500 (CDT)
Date: Thu, 4 Sep 2008 09:18:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: =?iso-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
Subject: Re: irq
Message-ID: <20080904141808.GA2377@ld0162-tx32.am.freescale.net>
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
	<48BEA106.9090307@selcomgroup.com>
	<319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
	<6a6049b80809030905u561043ecr1438d20aebf5598d@mail.gmail.com>
	<48BEBD17.1030705@gmail.com>
	<20080903170815.GA10979@loki.buserror.net>
	<48BEFB5D.3040903@gmail.com> <1220497366.4879.27.camel@pasglop>
	<319b0ac50809040127l2c506007vd6400a5edf912b71@mail.gmail.com>
	<319b0ac50809040623q1c32049ake8a5ea21fd5972cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <319b0ac50809040623q1c32049ake8a5ea21fd5972cd@mail.gmail.com>
Cc: M B <super.firetwister@googlemail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2008 at 03:23:21PM +0200, Sébastien Chrétien wrote:
> I try to write a device tree about irq :
> 
> IT_controller: irq_controller@20006000 {
>                clock-frequency = <0>;
>                interrupt-controller;
>             #address-cells = <0>;
>                reg = <0x20006000 0x100>;
>                compatible = "it";
>                device_type = "it";
>                big-endian;
>            };
> 
>            uart@200b1000{
>                device_type="uart";
>                compatible="uart";
>                interrupts = <0x18 0>;
>                interrupt-parent=<&IT_controller>;
>            };
> 
> 
> uart_irq=of_find_node_by_type(NULL, "uart");
>     if(uart_irq==NULL)
>          printk("%s: No uart node found !\n", __func__);
> 
>     virt=irq_of_parse_and_map(uart_irq, 0);
>     printk("Virtual irq : %d \n",virt);
> 
> 
> When I boot linux, virt=0;
> 
> What is wrong ?

You're missing #interrupt-cells, for one.  Also, you need your interrupt
controller driver to register with the IRQ subsystem properly (see other
chained IRQ drivers in the tree).

You should also get rid of device_type, big-endian, and clock-frequency,
and use better compatible names.

-Scott
