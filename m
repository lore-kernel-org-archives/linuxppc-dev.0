Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B83BDDD0D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 01:23:59 +1000 (EST)
Message-ID: <4694F608.2090503@freescale.com>
Date: Wed, 11 Jul 2007 10:23:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
References: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zhang Wei-r63237 wrote:
>>Or don't call it anything.  The ability to do extended chain mode is
>>implicit in being compatible with fsl,mpc8548-dma.
> 
> 
> The basic mode could be used for mpc83xx silicons.

Yes, and the 83xx device trees will list the compatible as 
fsl,mpc8349-dma, not fsl,mpc8548-dma.  This will tell the driver whether 
extended chain mode can be used (though I don't really see the benefit 
to using it even if it is there).

>>I'd rather just treat the different DMA channels as 
>>independent devices,
>>rather than children of a dma "bus", and change the compatible name if
>>they're not general purpose.  There's only one register that's shared
>>among the channels, and it's a superfluous status summary register.
>>
> 
> 
> Your and my ideas are both sides of a coin. :-)

I think there's a substantive difference between them.  Making each 
channel an independent device makes it easier for other drivers to use them.

-Scott
