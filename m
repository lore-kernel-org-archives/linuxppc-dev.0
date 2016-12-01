Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVBZr0HQMzDw1t
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 09:21:23 +1100 (AEDT)
Date: Thu, 1 Dec 2016 16:21:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
 benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 0/7] Disable VF's memory space on updating IOV BARs
Message-ID: <20161201222116.GB15867@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2016 at 10:13:41PM -0600, Bjorn Helgaas wrote:
> This is a v4 of Gavin's series for handling VF BAR updates.  The
> important piece is the first patch ("PCI: Do any VF BAR updates before
> enabling the BARs").  That makes sure that if we update VF BARs, we do
> it before enabling the VFs, and that is unchanged from v3.
> 
> The second patch in Gavin's series ("PCI: Disable VF's memory space on
> updating IOV BAR in pci_update_resource()") temporarily disabled VF
> memory space during an update.  Since the first patch does the update
> before enabling VFs, this case shouldn't happen in practice.
> 
> But even if we want to update a VF BAR while VF memory space is
> enabled, I think temporarily disabling it is wrong.  So I replaced
> the second patch with a few patches that make that such an update
> fail.
> 
> Please comment.  These are on my pci/virtualization branch.
> 
> Changelog
> =========
> v4:
>   * Don't disable VF's memory space when IOV BARs are updated; fail the
>     update instead. 
>   * Split IOV BAR updates from standard BAR updates so IOV updates can go
>     in pci/iov.c.
>   * Remove pci_resource_bar() and pci_iov_resource_bar() (the relevant
>     code is simpler when inlined into the callers).
>   * Cleanup IORESOURCE_ROM_ENABLE usage.
>   * Add comments about why ROMs are updated differently.
> v3:
>   * Disable VF's memory space when IOV BARs are updated in
>     pcibios_sriov_enable().
> v2:
>   * Added one patch calling pcibios_sriov_enable() before the VF
>     and VF BARs are enabled.
> 
> ---
> 
> Bjorn Helgaas (6):
>       PCI: Ignore BAR updates on virtual functions
>       PCI: Separate VF BAR updates from standard BAR updates
>       PCI: Don't update VF BARs while VF memory space is enabled
>       PCI: Remove pci_resource_bar() and pci_iov_resource_bar()
>       PCI: Decouple IORESOURCE_ROM_ENABLE and PCI_ROM_ADDRESS_ENABLE
>       PCI: Add comments about ROM BAR updating
> 
> Gavin Shan (1):
>       PCI: Do any VF BAR updates before enabling the BARs
> 
> 
>  drivers/pci/iov.c       |   69 +++++++++++++++++++++++++++++++++++++----------
>  drivers/pci/pci.c       |   34 -----------------------
>  drivers/pci/pci.h       |    7 +----
>  drivers/pci/probe.c     |    3 +-
>  drivers/pci/rom.c       |    5 +++
>  drivers/pci/setup-res.c |   37 ++++++++++++++++++-------
>  6 files changed, 88 insertions(+), 67 deletions(-)

I applied this on pci/virtualization for v4.10.
