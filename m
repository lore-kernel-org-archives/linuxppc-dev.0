Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 484CCDDF82
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 03:10:24 +1000 (EST)
Date: Mon, 23 Jun 2008 12:09:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: jumpingProgrammer <rabbitzp@163.com>
Subject: Re: a question of mpc8313, maybe simple
Message-ID: <20080623170956.GA6978@loki.buserror.net>
References: <18067094.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18067094.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 05:48:07AM -0700, jumpingProgrammer wrote:
> i am working with a board of mpc8313 using default mpc8313erdb.dts.
> But i do not know how can i correctly use DMA to transport data from memory
> to a PCI device.
> i tryed this
> {
>      .....
>      request_irq(IRQ,....);
>      request_dma(.....);
>      ....
> }
> 
> In request_irq() , i do not know what is the parameter IRQ.

Use pci_dev->irq.

> And , i did not find any words about DMA in mpc8313erdb.dts .

PCI devices can do bus-mastering DMA themselves; request_dma() is for ISA
devices.

-Scott
