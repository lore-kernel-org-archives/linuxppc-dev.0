Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3012C1A0CBA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 22:23:13 +1000 (AEST)
In-Reply-To: <1440420167-8879-1-git-send-email-mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
 gpiccoli@linux.vnet.ibm.com
Subject: Re: [1/2] PCI: Make pci_msi_setup_pci_dev() non-static for use by
 arch code
Message-Id: <20150826122313.0568114028E@ozlabs.org>
Date: Wed, 26 Aug 2015 22:23:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-24-08 at 12:42:46 UTC, Michael Ellerman wrote:
> From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
> 
> Commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI") changed the location of the code that initialises
> dev->msi_cap/msix_cap and then disables MSI/MSI-X interrupts at PCI
> probe time in devices that have this flag set. It moved the code from
> pci_msi_init_pci_dev() to a new function named pci_msi_setup_pci_dev(),
> called by pci_setup_device().
> 
> The pseries PCI probing code does not call pci_setup_device(), so since
> the aforementioned commit the function pci_msi_setup_pci_dev() is not
> called and MSI/MSI-X interrupts are left enabled. Additionally because
> dev->msi_cap/msix_cap are not initialised no driver can ever enable
> MSI/MSI-X.
> 
> To fix this, the pseries PCI probe should manually call
> pci_msi_setup_pci_dev(), so this patch makes it non-static.
> 
> Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")
> [mpe: Update change log to mention dev->msi_cap/msix_cap]
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/22b6839b914bbe5d94de11bb

cheers
