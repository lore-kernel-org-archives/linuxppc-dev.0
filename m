Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18ADBDDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 10:19:25 +1100 (EST)
Message-ID: <4918C138.9040701@freescale.com>
Date: Mon, 10 Nov 2008 17:18:16 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: wael showair <showair2003@yahoo.com>
Subject: Re: How to add my device node in the device tree
References: <20389723.post@talk.nabble.com>
In-Reply-To: <20389723.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

wael showair wrote:
> i want to add a node for the DMA in this tree. the PIC PDF tells me that DMA
> channel 0 is connected to Internal interrupt number 4 so i add the following
> node just before the pic node & after the serial node:
> 
> ******************************************
> 
> 		DMA@21100 {
> 			reg = <21100 44>;
> 			interrupts = <4 2>;  
> 			interrupt-parent = <40000>;		
> 		};
> ******************************************

Copy the dma (eloplus) node in one of the existing device trees, rather 
than make up a new binding.  BTW, internal interrupts on the MPIC have 
to have 16 added to the interrupt number.

> but when i called the of_find_node_by_name(NULL, "DMA");
> unfortunately it returns NULL & i cant the a node with such a name.
> i have checked this by printing all of the nodes in my tree which are:
> cpus
> PowerPC,8555
> memory
> soc8555
> i2c
> mdio
> ...
> serial
> pic
> choosen
> choosen
> 
> without a node of name DMA for sure.
> so what else should i do to create this node?
> thanks in advance for your help.

Not sure, are you sure you properly rebuilt the device tree, and are 
using the new blob rather than the old one?

-Scott
