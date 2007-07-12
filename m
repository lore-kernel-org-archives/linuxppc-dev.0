Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com
	(ip67-95-226-82.z226-95-67.customer.algx.net [67.95.226.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95290DDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 03:13:01 +1000 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.6.0)
	with ESMTP id md50000432944.msg
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 10:12:57 -0700
Subject: RE: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
From: Phil Terry <pterry@micromemory.com>
To: Wei.Zhang@freescale.com
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F3E42@zch01exm26.fsl.freescale.net>
References: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
	<4694F608.2090503@freescale.com>
	<368E1200-1315-4C24-9876-C92CCF65EFE3@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3E42@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 12 Jul 2007 10:12:55 -0700
Message-Id: <1184260375.24515.35.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: pterry@micromemory.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Excuse me butting in if I've got this whole dtc, of, device driver
model, etc., stuff wrong but I thought it was supposed to work like
this:

The DMA engine is a generic kernel service. Its a "device". You can
infer its presence without a dts/of by the fact that you have the fsl
soc but ok if you want to put it in dts/of that works too.

All its going to do is load a "driver" which makes available the
services of the "device" under a generic DMA internal api. 

Say I'm writing a sound card, video card, widget card, etc., driver.

My driver gets loaded by virtue of detecting the card/device (via of,
pci, usb, platform, whatever bus mechanisms).

My driver would benefit from using a generic DMA device so it uses the
internal api to look for one and uses the API of that device to request
a channel for its use. I don't care what channel I get, I don't need a
fixed, reserved channel of the DMA device as specified in the dts I just
need an unused channel. If no channels are available or I'm in a system
with no generic DMA service available I can either fall back to
processor copying or refuse to load.

Given the device might be a hot-insert USB device etc, there's nothing a
dts can do to help me here in this scenario, right?

I thought the idea of the dts/of was for the hardware specific boot
loader to tell the kernel about hardware that the kernel couldn't
otherwise know about, because its not detectable by a bus probe method,
etc. Its not there to tell you how to use the device or arbitrate which
other devices get to use a device when there are resource conflicts,
etc.

If the dts/of/boot loader tells the kernel its a fsl soc then it knows
how to work out which one and what level, and therefore knows what
devices, such as the DMA device are present.

I'm truly interested in understanding the correct interpretation because
we are developing a DMA based, rapidio distributed system on fsl 8641
and from lurking on here and reading the archives etc, all I see is a
constant butting of heads on what the dts/of is and how its supposed to
work.

Quite why we are using a 20 year old spec, which was never finished, and
ceased to be a formal spec 10 years ago as the "new" way forward is a
puzzle to me as well. Not flame bait, but if someone could point me to
background material it would be helpful for my education in getting up
to speed (on the rationale for using it going forwards, not all the old
sites for the spec itself).

Cheers
Phil


On Thu, 2007-07-12 at 17:48 +0800, Zhang Wei-r63237 wrote:
>  
> > -----Original Message-----
> > From: Segher Boessenkool [mailto:segher@kernel.crashing.org] 
> > Sent: Thursday, July 12, 2007 1:54 AM
> > To: Wood Scott-B07421
> > Cc: Zhang Wei-r63237; linuxppc-dev@ozlabs.org; paulus@samba.org
> > Subject: Re: [PATCH 1/4] Add DMA sector to 
> > Documentation/powerpc/booting-without-of.txt file.
> > 
> > >>> I'd rather just treat the different DMA channels as independent  
> > >>> devices,
> > >>> rather than children of a dma "bus", and change the compatible  
> > >>> name if
> > >>> they're not general purpose.  There's only one register that's  
> > >>> shared
> > >>> among the channels, and it's a superfluous status summary 
> > register.
> > >>>
> > >> Your and my ideas are both sides of a coin. :-)
> > >
> > > I think there's a substantive difference between them.  
> > Making each  
> > > channel an independent device makes it easier for other drivers to  
> > > use them.
> > 
> > True.  If the DMA channels are independent enough, putting them
> > in nodes of their own isn't too cumbersome, either.
> > 
> > 
> 
> If you want to use DMA engine driver for the reserved channel, you
> should add it to dma-controller node and assign 'reserved'.
> If you don't want to use DMA engine driver, just remove it from
> dma-controller node and put the channel to special device node.
> 
> Thanks!
> Wei.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
