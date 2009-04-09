Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0335DDFAF
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 16:21:38 +1000 (EST)
Subject: Re: tracking of PCI address space
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <E942C580-7C39-44AB-B207-C65CDE0B5292@kernel.crashing.org>
References: <E942C580-7C39-44AB-B207-C65CDE0B5292@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 09 Apr 2009 08:21:31 +0200
Message-Id: <1239258091.7279.22.camel@pasglop>
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-08 at 15:53 -0500, Kumar Gala wrote:
> I was wondering if we have anything that tracks regions associated  
> with the "inbound" side of a pci_bus.
> 
> What I mean is on embedded PPC we have window/mapping registers for  
> both inbound (accessing memory on the SoC) and outbound (access PCI  
> device MMIO, IO etc).  The combination of the inbound & outbound  
> convey what exists in the PCI address space vs CPU physical address  
> space (and how to map from one to the other).  Today in the PPC land  
> we only attach outbound windows to the pci_bus.  So technically the  
> inbound side information (like what subset of physical memory is  
> visible on the PCI bus) seems to be lost.

On powerpc, we do keep track of the offset, but that's about it.

Tracking inbound ranges is very platform specific though. You can have
multiple inbound windows with different translations, in some cases some
via iommu and some not, or windows aliasing the same target memory but
with different attributes, etc...

I don't think there's that much interest in trying to create generic
code to keep track.

Ben.
