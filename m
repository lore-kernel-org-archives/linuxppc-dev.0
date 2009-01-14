Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5C64DDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:43:21 +1100 (EST)
Message-ID: <496E15E8.2060106@freescale.com>
Date: Wed, 14 Jan 2009 10:42:16 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] fsldma: print correct IRQ on mpc83xx
References: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>	<496E0E85.7060801@freescale.com>
	<87iqohc19b.fsf@macbook.be.48ers.dk>	<496E1317.9070804@freescale.com>
	<87eiz5c074.fsf@macbook.be.48ers.dk>
In-Reply-To: <87eiz5c074.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:

> Documentation/powerpc/dts-bindings/fsl/dma.txt and
> The NO_IRQ check in fsldma.c:fsl_dma_chan_probe()
> 
> And it makes sense, there's no per-channel DMAC interrupts on mpc83xx.

But the device trees do have IRQs in the channels:

arch/powerpc/boot/dts/mpc836x_mds.dts:

dma@82a8 {
	...
	interrupt-parent = <&ipic>;
	interrupts = <71 8>;
	dma-channel@0 {
		compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
		reg = <0 0x80>;
		cell-index = <0>;
		interrupt-parent = <&ipic>;
		interrupts = <71 8>;
	};
	...

So I don't see what bug you're trying to fix.  If you're saying that the
interrupts should not be specific DMA channels, then the proper fix is to have
the DMA driver pick up the interrupts from the DMA controller's node when
necessary.  Hacking up a printk doesn't fix anything.

-- 
Timur Tabi
Linux kernel developer at Freescale
