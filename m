Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76A4ADDE1A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 12:27:00 +1100 (EST)
Subject: Re: Reorg of 32-bit dma code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <bgill@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0802061802310.1616@monty.am.freescale.net>
References: <Pine.LNX.4.64.0802061802310.1616@monty.am.freescale.net>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 12:26:34 +1100
Message-Id: <1202347594.7079.107.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-06 at 18:32 -0600, Becky Bruce wrote:
> 
> I've been looking at converting 32-bit powerpc's DMA code over to the 
> 64-bit method, where there is a dma_ops structure inside archdata
> that tells us which operations a device should use for DMA.  I'll be 
> needing this shortly because I need to implement swiotlb to deal with 
> PCI and large amounts of RAM on 32-bit systems that support 36-bit
> physical addressing. (Yes, I know.  Fun for me.  Woohoo.)
> 
> Anyway, I have an initial booting first pass, and wanted to get some 
> feedback.  What I've done at this point is to make dma_64 common to both 
> architectures (will rename it when I send a real patch...).  The 
> dma_direct_* functions have been changed to work on both 32/64, and the 
> old dma_* functionality in dma-mapping.h has been removed.   For now, to 
> avoid whacking on every 32-bit platform, the get_dma_ops() function has 
> been changed to return &dma_direct_ops if the device pointer exists but 
> the dma_ops field is NULL.   I'm not sure if this needs to be ifdef'd for 
> 64-bit?

I'd prefer so yes.

> I've copied a bit of code over from pci_64.c into pci_common.c - some of 
> it isn't in use yet but will be once I start doing actual setup in the 
> platform code. pcibios_setup_new_device() becomes common as well.

Cool !

>   I've 
> also temporarily hacked the 32-bit code to set archdata.dma_data to 
> PCI_DRAM_OFFSET, so we can eliminate the use of virt_to_bus() and instead 
> use the 64-bit method, which gets rid of some ugly ifdefs in the dma code.  

Ok.

> That's really about it - the preliminary patch is below - clearly it will 
> need some cleanup, but I wanted to post early and often.  Any feedback or 
> suggestions on cleaning this up are greatly appreciated. 

I'll have a look asap, thanks for doing this !

Ben.
