Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 596B0DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:00:24 +1100 (EST)
Message-Id: <F9F2D66C-87E9-4CED-8E8E-C7B3BB855DB9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <479664AE.9060107@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Add docs for Freescale DMA & DMA channel device
	tree nodes
Date: Tue, 22 Jan 2008 16:00:16 -0600
References: <Pine.LNX.4.64.0801221511540.24873@blarg.am.freescale.net>
	<4796605B.2000807@freescale.com> <479664AE.9060107@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 22, 2008, at 3:48 PM, Scott Wood wrote:

> Timur Tabi wrote:
>> On 83xx, all DMA channels share the same interrupt?
>
> Yes.
>
>> Couldn't we just specify the same IRQ in each channel's node, so  
>> that they look the same across 83xx, 85xx, and 86xx?
>
> The consensus that I thought we had reached was to let 83xx specify  
> the interrupt in the controller node (to make things simple for a  
> driver using the shared summary register rather than registering  
> four handlers for the same IRQ), but require that it also be in the  
> channel node, and that if there is an interrupt in the controller  
> node, that it be the same as in all the channels.

This was my understanding.. however we might not be documentation that  
clearly at this point.

>> My sound driver doesn't use Extended Mode, but it does check for  
>> "fsl,8610-dma-channel".  I'm thinking that maybe I should change to  
>> to look for "elo" or "eloplus", but it would be nice if we could  
>> make the DMA node for an 86xx SoC compatible with a driver that  
>> expects "fsl,elo-dma-channel".
>
> Sure it'd be nice, but it's not possible without going back in time  
> and convincing the hardware people to make them 100% compatible.

exactly.  You forget minor things like 83xx reg set is little endian  
and 85xx/86xx is big endian.

- k
