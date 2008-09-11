Return-Path: <jbrower@signalogic.com>
Received: from nuntius.signalogic.com
	(adsl-64-219-188-225.dsl.rcsntx.swbell.net [64.219.188.225])
	by ozlabs.org (Postfix) with ESMTP id 3DC4CDDF5E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Sep 2008 10:47:44 +1000 (EST)
Message-ID: <48C86A0B.5EDE904C@signalogic.com>
Date: Wed, 10 Sep 2008 19:44:59 -0500
From: Jeff Brower <jbrower@signalogic.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: driver replacements for kmalloc and __pa()
References: <48C6F217.406CFDC0@signalogic.com> <48C6F7AA.2000608@freescale.com>
Content-Type: text/plain; charset=us-ascii
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

Scott-

> > What are the up-to-date APIs we should be using for DMA memory allocation and
> > virtual-to-physical address translation?  We have another driver for another device
> > that's working fine on this board and it uses pci_alloc_consistent().  What about
> > bus_space_vaddr()?  I'm hoping to get a recommendation for what's currently
> > appropriate and most future-proof for drivers that depend on external PCI DMA.
> 
> Documentation/DMA-API.txt.

Thanks very much Scott.  It appears that dma_alloc_coherent() is the recommended
path.  Is there a good reason to use this instead of pci_alloc_consistent()?  I can
find comments about using the GFP_KERNEL flag with dma_alloc_coherent(), which is
supposed to help when the system is low on memory.  But we wouldn't expect that to
occur in a situation where the driver is loaded/initialized at boot-time.

-Jeff
