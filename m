Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59B8BDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:48:06 +1100 (EST)
Message-ID: <479664AE.9060107@freescale.com>
Date: Tue, 22 Jan 2008 15:48:30 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] Add docs for Freescale DMA & DMA channel device
	tree nodes
References: <Pine.LNX.4.64.0801221511540.24873@blarg.am.freescale.net>
	<4796605B.2000807@freescale.com>
In-Reply-To: <4796605B.2000807@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> On 83xx, all DMA channels share the same interrupt?

Yes.

> Couldn't we just 
> specify the same IRQ in each channel's node, so that they look the same 
> across 83xx, 85xx, and 86xx?

The consensus that I thought we had reached was to let 83xx specify the 
interrupt in the controller node (to make things simple for a driver 
using the shared summary register rather than registering four handlers 
for the same IRQ), but require that it also be in the channel node, and 
that if there is an interrupt in the controller node, that it be the 
same as in all the channels.

> My sound driver doesn't use Extended Mode, 
> but it does check for "fsl,8610-dma-channel".  I'm thinking that maybe I 
> should change to to look for "elo" or "eloplus", but it would be nice if 
> we could make the DMA node for an 86xx SoC compatible with a driver that 
> expects "fsl,elo-dma-channel".

Sure it'd be nice, but it's not possible without going back in time and 
convincing the hardware people to make them 100% compatible.

-Scott
