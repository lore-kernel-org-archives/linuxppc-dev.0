Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 851FD2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 10:35:36 +1100 (EST)
Message-ID: <1381275325.7979.320.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
From: Scott Wood <scottwood@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 18:35:25 -0500
In-Reply-To: <CAErSpo7+7SHVcOJkHkW5cjb6pN+bqYeRdPBA=MVX0RLz=-pP6Q@mail.gmail.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
 <1381273037.7979.298.camel@snotra.buserror.net>
 <CAErSpo7+7SHVcOJkHkW5cjb6pN+bqYeRdPBA=MVX0RLz=-pP6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Alexander Graf <agraf@suse.de>, Joerg Roedel <joro@8bytes.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Bharat Bhushan <r65777@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-08 at 17:25 -0600, Bjorn Helgaas wrote:
> >> -     u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
> >> +     dma_addr_t msiir; /* MSIIR Address in CCSR */
> >
> > Are you sure dma_addr_t is right here, versus phys_addr_t?  It implies
> > that it's the output of the DMA API, but I don't think the DMA API is
> > used in the MSI driver.  Perhaps it should be, but we still want the raw
> > physical address to pass on to VFIO.
> 
> I don't know what "msiir" is used for, but if it's an address you
> program into a PCI device, then it's a dma_addr_t even if you didn't
> get it from the DMA API.  Maybe "bus_addr_t" would have been a more
> suggestive name than "dma_addr_t".  That said, I have no idea how this
> relates to VFIO.

It's a bit awkward because it gets used both as something to program
into a PCI device (and it's probably a bug that the DMA API doesn't get
used), and also (if I understand the current plans correctly) as a
physical address to give to VFIO to be a destination address in an IOMMU
mapping.  So I think the value we keep here should be a phys_addr_t (it
comes straight from the MMIO address in the device tree), which gets
trivially turned into a dma_addr_t by the non-VFIO code path because
there's currently no translation there.

-Scott
