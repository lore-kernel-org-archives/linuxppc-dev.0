Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4001DDDECD
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 05:10:12 +1000 (EST)
Message-ID: <46967C8C.9010602@freescale.com>
Date: Thu, 12 Jul 2007 14:10:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: pterry@micromemory.com
Subject: Re: [PATCH 1/4] Add DMA sector
	to	Documentation/powerpc/booting-without-of.txt file.
References: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>	
	<4694F608.2090503@freescale.com>	
	<368E1200-1315-4C24-9876-C92CCF65EFE3@kernel.crashing.org>	
	<46B96294322F7D458F9648B60E15112C6F3E42@zch01exm26.fsl.freescale.net>
	<1184260375.24515.35.camel@pterry-fc6.micromemory.com>
In-Reply-To: <1184260375.24515.35.camel@pterry-fc6.micromemory.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Phil Terry wrote:
> Say I'm writing a sound card, video card, widget card, etc., driver.
> 
> My driver gets loaded by virtue of detecting the card/device (via of,
> pci, usb, platform, whatever bus mechanisms).
> 
> My driver would benefit from using a generic DMA device so it uses the
> internal api to look for one and uses the API of that device to request
> a channel for its use. I don't care what channel I get, I don't need a
> fixed, reserved channel of the DMA device as specified in the dts I just
> need an unused channel. If no channels are available or I'm in a system
> with no generic DMA service available I can either fall back to
> processor copying or refuse to load.

The audio device example was not about using the DMA engine for generic 
memory copying; it was about an audio device that is hardwired to a 
certain DMA channel.  There is no way to do audio without using that 
specific channel.

> If the dts/of/boot loader tells the kernel its a fsl soc then it knows
> how to work out which one and what level, and therefore knows what
> devices, such as the DMA device are present.

All you'd be doing then is moving the device trees into the kernel.  The 
dtc syntax is a convenient way of expressing the information that has to 
live *somewhere*.

> Quite why we are using a 20 year old spec, which was never finished, and
> ceased to be a formal spec 10 years ago as the "new" way forward is a
> puzzle to me as well.

Probably because there was already code there to support it. :-P

It's not that bad in most respects, though unlike some, I don't think we 
need to stick dogmatically to the exact way that Open Firmware(tm) did 
everything.

-Scott
