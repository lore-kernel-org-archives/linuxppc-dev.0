Return-Path: <scottwood@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75DC42C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 11:23:20 +1100 (EST)
Message-ID: <1386375778.7375.203.camel@snotra.buserror.net>
Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
From: Scott Wood <scottwood@freescale.com>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 6 Dec 2013 18:22:58 -0600
In-Reply-To: <1386358226.25738.506.camel@ul30vt.home>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1384973243.2879.361.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0721D9AC@039-SN2MPN1-012.039d.mgd.msft.net>
 <1385066603.2879.414.camel@ul30vt.home>
 <1385066835.1403.489.camel@snotra.buserror.net>
 <1385067648.2879.421.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0722C180@039-SN2MPN1-012.039d.mgd.msft.net>
 <1385397493.2879.557.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0723624C@039-SN2MPN1-012.039d.mgd.msft.net>
 <1386289316.7375.107.camel@snotra.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07251EE4@039-SN2MPN1-012.039d.mgd.msft.net>
 <1386356393.7375.118.camel@snotra.buserror.net>
 <1386358226.25738.506.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "agraf@suse.de" <agraf@suse.de>,
 Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-12-06 at 12:30 -0700, Alex Williamson wrote:
> On Fri, 2013-12-06 at 12:59 -0600, Scott Wood wrote:
> > On Thu, 2013-12-05 at 22:11 -0600, Bharat Bhushan wrote:
> > > 
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Friday, December 06, 2013 5:52 AM
> > > > To: Bhushan Bharat-R65777
> > > > Cc: Alex Williamson; linux-pci@vger.kernel.org; agraf@suse.de; Yoder Stuart-
> > > > B08248; iommu@lists.linux-foundation.org; bhelgaas@google.com; linuxppc-
> > > > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
> > > >
> > > > On Thu, 2013-11-28 at 03:19 -0600, Bharat Bhushan wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Bhushan Bharat-R65777
> > > > > > Sent: Wednesday, November 27, 2013 9:39 PM
> > > > > > To: 'Alex Williamson'
> > > > > > Cc: Wood Scott-B07421; linux-pci@vger.kernel.org; agraf@suse.de;
> > > > > > Yoder Stuart- B08248; iommu@lists.linux-foundation.org;
> > > > > > bhelgaas@google.com; linuxppc- dev@lists.ozlabs.org;
> > > > > > linux-kernel@vger.kernel.org
> > > > > > Subject: RE: [PATCH 0/9 v2] vfio-pci: add support for Freescale
> > > > > > IOMMU (PAMU)
> > > > > >
> > > > > > If we just provide the size of MSI bank to userspace then userspace
> > > > > > cannot do anything wrong.
> > > > >
> > > > > So userspace does not know address, so it cannot mmap and cause any
> > > > interference by directly reading/writing.
> > > >
> > > > That's security through obscurity...  Couldn't the malicious user find out the
> > > > address via other means, such as experimentation on another system over which
> > > > they have full control?  What would happen if the user reads from their device's
> > > > PCI config space?  Or gets the information via some back door in the PCI device
> > > > they own?  Or pokes throughout the address space looking for something that
> > > > generates an interrupt to its own device?
> > > 
> > > So how to solve this problem, Any suggestion ?
> > > 
> > > We have to map one window in PAMU for MSIs and a malicious user can ask
> > > its device to do DMA to MSI window region with any pair of address and
> > > data, which can lead to unexpected MSIs in system?
> > 
> > I don't think there are any solutions other than to limit each bank to
> > one user, unless the admin turns some knob that says they're OK with the
> > partial loss of isolation.
> 
> Even if the admin does opt-in to an allow_unsafe_interrupts options, it
> should still be reasonably difficult for one guest to interfere with the
> other.  I don't think we want to rely on the blind luck of making the
> full MSI bank accessible to multiple guests and hoping they don't step
> on each other.  That probably means that vfio needs to manage the space
> rather than the guest.  Thanks,

Yes, the MSIs within a given bank would be allocated by the host kernel
in any case (presumably by the MSI driver, not VFIO itself).  This is
just about what happens if the MSI page is written to outside of the
normal mechanism.

-Scott
