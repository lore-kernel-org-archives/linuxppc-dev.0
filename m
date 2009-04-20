Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B711DDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 01:55:17 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3KFtD83012320
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 08:55:13 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3KFtC1Z016177
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 10:55:12 -0500 (CDT)
Date: Mon, 20 Apr 2009 10:55:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: lhthanh <lhthanh@kobekara.com>
Subject: Re: MPC8349E's DMA controller like ISA controller but with more
	feature?
Message-ID: <20090420155511.GA25470@ld0162-tx32.am.freescale.net>
References: <49EC6CB5.2020300@kobekara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49EC6CB5.2020300@kobekara.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 20, 2009 at 07:38:13PM +0700, lhthanh wrote:
> <body bgcolor="#ffffff" text="#000000">
> <font size="+1">Hi EveryOne!<br>
> <br>
> This is first time I send a letter to everyone. If I make mistake,
> please free to correct me. :)<br>

Please post in plaintext, not HTML.

> MPC8349's DMA controller like ISA controller but with more features? 

No.  It is for software-directed memory-to-memory transfers (where
"memory" can be main-memory, or the buffer of a device that doesn't do
DMA itself).

There is no need for anything like ISA's DMA controller, as devices that
want to initiate DMA can master the bus themselves.

> So in DMA APIs such as dma_addr_t dma_map_single(struct device *dev,
> void *cpu_addr, size_t size, enum dma_data_direction direction)
> *dev will pointer to DMA controller or to peripheral device(FPGA,
> ISA device)?

It is whatever device is going to be doing the DMA.

> From dmatest.c , *dev seem to pointer to a channel of DMA
> controller. 

That's because in that case, the DMA controller is the peripheral
device being used.

> I want to DMA from device to memory. 

What kind of device?

> So how to I can get address of peripheral device ?

If you have to ask that, it probably means you don't have a specific
device buffer in mind that you want an external entity to stuff data into
(or suck data from), but rather are dealing with device-initiated DMA. 
In that case, ignore the DMA controller.

-Scott
