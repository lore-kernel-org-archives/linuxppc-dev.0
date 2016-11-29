Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSV084YW0zDvsy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 14:48:56 +1100 (AEDT)
Date: Mon, 28 Nov 2016 21:48:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 clsoto@us.ibm.com
Subject: Re: [PATCH v3 0/2] Disable VF's memory space on updating IOV BARs
Message-ID: <20161129034831.GP16033@bhelgaas-glaptop.roam.corp.google.com>
References: <1477444536-29612-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20161123234910.GN16033@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161123234910.GN16033@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 23, 2016 at 05:49:10PM -0600, Bjorn Helgaas wrote:
> On Wed, Oct 26, 2016 at 12:15:34PM +1100, Gavin Shan wrote:
> > This moves pcibios_sriov_enable() to the point before VF and VF BARs
> > are enabled on PowerNV platform. Also, pci_update_resource() is used
> > to update IOV BARs on PowerNV platform, the PF might have been functional
> > when the function is called. We shouldn't disable PF's memory decoding
> > at that point. Instead, the VF's memory space should be disabled.
> > 
> > Changelog
> > =========
> > v3:
> >   * Disable VF's memory space when IOV BARs are updated in
> >     pcibios_sriov_enable().
> > v2:
> >   * Added one patch calling pcibios_sriov_enable() before the VF
> >     and VF BARs are enabled.
> > 
> > Gavin Shan (2):
> >   PCI: Call pcibios_sriov_enable() before IOV BARs are enabled
> >   PCI: Disable VF's memory space on updating IOV BAR in
> >     pci_update_resource()
> > 
> >  drivers/pci/iov.c       | 14 +++++++-------
> >  drivers/pci/setup-res.c | 28 ++++++++++++++++++++--------
> >  2 files changed, 27 insertions(+), 15 deletions(-)
> 
> I applied these to pci/virtualization for v4.10.  Thanks for your
> patience, Gavin.

This nagged at me over the holidays, and I think that if the VF has
memory decoding enabled, it's wrong to allow a VF BAR to be updated,
even if we temporarily disable memory decoding.

If the VF is enabled, a driver may have claimed it, and that means the
driver probably has ioremapped the BAR, and if we update the BAR, that
ioremap is now stale.  The driver has no idea that anything changed.

Of course, we may know that pci_update_resource() is never called
after a driver has claimed the VF, but I think it's much better to
restructure the callers so the VF BAR updates happen *before* enabling
the VFs, as you did in patch 1.

Once we have that, there's no point in temporarily disabling memory
decoding, so I worked up some patches to make the update fail.  I'll
post those in a minute and you can see what you think.

Bjorn
