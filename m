Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 510D9B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 05:41:52 +1100 (EST)
Received: from mail31-va3 (localhost.localdomain [127.0.0.1])	by
	mail31-va3-R.bigfish.com (Postfix) with ESMTP id 10C1012706C0	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  1 Dec 2010 18:41:48 +0000 (UTC)
Received: from VA3EHSMHS001.bigfish.com (unknown [10.7.14.252])	by
	mail31-va3.bigfish.com (Postfix) with ESMTP id A429B1A0004F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  1 Dec 2010 18:41:47 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB1IhhSx025656	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 11:43:43 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB1IwXUt027449	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 1 Dec 2010 12:58:34 -0600 (CST)
Date: Wed, 1 Dec 2010 12:41:42 -0600
From: Scott Wood <scottwood@freescale.com>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Message-ID: <20101201124142.15f75af7@udp111988uds.am.freescale.net>
In-Reply-To: <201012011735.58769.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<1291205941.11595.9.camel@concordia>
	<201012011735.58769.dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Dec 2010 17:35:58 +0100
Guillaume Dargaud <dargaud@lpsc.in2p3.fr> wrote:

> OK, here goes then: how do I get the IRQ number so that I can install an 
> interrupt handler on it ?
> 
> In my dts file I have:
> 		xps_acqui_data_0: xps-acqui-data@c9800000 {
> 			compatible = "xlnx,xps-acqui-data-3.00.a";
> 			interrupt-parent = <&xps_intc_0>;
> 			interrupts = < 0 2 >;
> 			reg = < 0xc9800000 0x10000 >;
> 			xlnx,family = "virtex4";
> 			xlnx,include-dphase-timer = <0x1>;
> 			xlnx,mplb-awidth = <0x20>;
> 			xlnx,mplb-clk-period-ps = <0x2710>;
> 			xlnx,mplb-dwidth = <0x40>;
> 			xlnx,mplb-native-dwidth = <0x40>;
> 			xlnx,mplb-p2p = <0x0>;
> 			xlnx,mplb-smallest-slave = <0x20>;
> 		} ;
> 
> In my minimal driver init, I have:
>   first = MKDEV (my_major, my_minor);
>   register_chrdev_region(first, count, NAME);
>   cdev_init(my_cdev, &fops);
>   cdev_add (my_cdev, first, count);
> So far so good.
> 
> Now how do I connect the dots between the hardware definitions from the dts and 
> my driver ?

How was your driver probed?  If you can get a pointer to the device
node, use irq_of_parse_and_map() to get a virtual irq that you can pass
to request_irq().

> But first I'm not sure where to find the IRQ in there, and also I'm not sure if 
> reading the filesystem from a module is allowed.

There's no need; there are much easier ways to access the device tree
from within the kernel.

> How do I know if this interrupt is shared or not (is it important ?)

Can your driver tolerate it being shared?  If so, request it as shared.

-Scott
