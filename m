Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2953C2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 04:09:35 +1100 (EST)
Message-ID: <1381252156.7979.247.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
From: Scott Wood <scottwood@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 12:09:16 -0500
In-Reply-To: <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
 <20130924235812.GD9302@google.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "agraf@suse.de" <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-08 at 10:47 -0600, Bjorn Helgaas wrote:
> On Thu, Oct 3, 2013 at 11:19 PM, Bhushan Bharat-R65777
> <R65777@freescale.com> wrote:
> 
> >> I don't know enough about VFIO to understand why these new interfaces are
> >> needed.  Is this the first VFIO IOMMU driver?  I see vfio_iommu_spapr_tce.c and
> >> vfio_iommu_type1.c but I don't know if they're comparable to the Freescale PAMU.
> >> Do other VFIO IOMMU implementations support MSI?  If so, do they handle the
> >> problem of mapping the MSI regions in a different way?
> >
> > PAMU is an aperture type of IOMMU while other are paging type, So they are completely different from what PAMU is and handle that differently.
> 
> This is not an explanation or a justification for adding new
> interfaces.  I still have no idea what an "aperture type IOMMU" is,
> other than that it is "different."  But I see that Alex is working on
> this issue with you in a different thread, so I'm sure you guys will
> sort it out.

PAMU is a very constrained IOMMU that cannot do arbitrary page mappings.
Due to these constraints, we cannot map the MSI I/O page at its normal
address while also mapping RAM at the address we want.  The address we
can map it at depends on the addresses of other mappings, so it can't be
hidden in the IOMMU driver -- the user needs to be in control.

Another difference is that (if I understand correctly) PCs handle MSIs
specially, via interrupt remapping, rather than being translated as a
normal memory access through the IOMMU.

-Scott
