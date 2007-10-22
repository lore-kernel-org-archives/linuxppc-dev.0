Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1CA4DDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 06:33:51 +1000 (EST)
Subject: Re: request_irq fails to get interrupt 12
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Bennett <embedded@akb.net>
In-Reply-To: <bfa0697f0710221255ubbe8c91pa09640f9b9cd0775@mail.gmail.com>
References: <bfa0697f0710221255ubbe8c91pa09640f9b9cd0775@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 06:33:44 +1000
Message-Id: <1193085224.6745.102.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-22 at 13:55 -0600, Alan Bennett wrote:
> Ok, so what does it take to expose an interrupt vector on a pq2 PIC??
> -Alan

Also, if it's the default PIC or if you happen to have the PIC struct
irq_host pointer at hand, a quickish way for internal device interrupts
is to directly call irq_create_mapping() though using the device-tree is
nicer.

Ben.

> Current:
>         /
>               localbus{
>         ...
>  	       fundevice1 {
> 		       interrupts = <c 8>;
> 		       interrupt-parent = <&PIC>;
> 	       };
>           ...
>                soc@e0000000 {
>                       PIC: interrupt-controller@10c00 {
>                           #interrupt-cells = <2>;
>                           interrupt-controller;
>                           reg = <10c00 80>;
>                           compatible = "fsl,mpc8248-pic", "fsl,pq2-pic";
>                         };
> Is the above device tree enough on its own?
> Do I have to write some platform code beyond:
>   static void __init ep8248_pic_init(void)
>   {
> 	struct device_node *np = of_find_compatible_node(NULL,   NULL, "fsl,pq2-pic");
> 	if (!np) {
> 		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
> 		return;
> 	}
> 
> 	cpm2_pic_init(np);
> 	of_node_put(np);
> }
> 
> -Alan
> 
> Hello,
> 
> > Freescale experts.  Why on earth can't I request the IRQ for Timer1?
> 
> Please consule my question on [1] and the answers.
> 
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042061.html
> 
> bye
> Silvio Fricke
> 
> --
> -- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
>    Diplom-Informatiker (FH)
>    Linux-Entwicklung
> ----------------------------------------------------------------------------
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
