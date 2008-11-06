Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03F40DDF36
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Nov 2008 05:30:44 +1100 (EST)
Message-ID: <49133792.9080000@freescale.com>
Date: Thu, 06 Nov 2008 12:29:38 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
References: <OF1BC63DE0.D024D14C-ON882574F9.000ABAA9-882574F9.000BA2A1@selinc.com>
In-Reply-To: <OF1BC63DE0.D024D14C-ON882574F9.000ABAA9-882574F9.000BA2A1@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:
> In the Cafe driver, Linux Device Drivers 3rd Edition, and DMA-mapping.txt 
> everyone talks about how to allocate buffers using 
> dma/pci_alloc_coherent(), but no one talks about how to actually use it. 
> I'm pretty sure (even in my ignorance) that just allocating a DMA coherent 
> buffer and then copying in and out of it does NOT actually engage the 
> underlying hardware and perform a DMA transfer.

Generally, you program the device itself to peform the transfer.  I'm 
assuming that your custom NAND controller can't do DMA by itself, though.

> With some digging I've found the Freescale Elo/Elo Plus DMA driver which 
> supports my processor.  What I'm not clear on is how to actually make use 
> of it.  How do I tie my NAND driver to the Freescale DMA driver and 
> actually get the hardware to work?  Any pointers are greatly appreciated.

Tell the DMA controller where to move data from, and where to move it to.

-Scott
