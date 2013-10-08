Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E8F02C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 10:26:05 +1100 (EST)
Received: by mail-ie0-f172.google.com with SMTP id x13so42536ief.31
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Oct 2013 16:26:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381273037.7979.298.camel@snotra.buserror.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
 <1381273037.7979.298.camel@snotra.buserror.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 17:25:40 -0600
Message-ID: <CAErSpo7+7SHVcOJkHkW5cjb6pN+bqYeRdPBA=MVX0RLz=-pP6Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
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

>> -     u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
>> +     dma_addr_t msiir; /* MSIIR Address in CCSR */
>
> Are you sure dma_addr_t is right here, versus phys_addr_t?  It implies
> that it's the output of the DMA API, but I don't think the DMA API is
> used in the MSI driver.  Perhaps it should be, but we still want the raw
> physical address to pass on to VFIO.

I don't know what "msiir" is used for, but if it's an address you
program into a PCI device, then it's a dma_addr_t even if you didn't
get it from the DMA API.  Maybe "bus_addr_t" would have been a more
suggestive name than "dma_addr_t".  That said, I have no idea how this
relates to VFIO.

Bjorn
