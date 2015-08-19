Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B5EE1A04EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 10:44:46 +1000 (AEST)
Message-ID: <1439945086.23217.5.camel@ellerman.id.au>
Subject: Re: [PATCH 1/2] PCI: Make pci_msi_setup_pci_dev() non-static for
 use by arch code
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org
Date: Wed, 19 Aug 2015 10:44:46 +1000
In-Reply-To: <1439932430-13375-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1439932430-13375-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932430-13375-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Guilherme,

Thanks for the patches.

On Tue, 2015-08-18 at 18:13 -0300, Guilherme G. Piccoli wrote:
> Commit 1851617cd2 ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI") changed the location of the code that disables
> MSI/MSI-X interrupts at PCI probe time in devices that have this flag set.
> It moved the code from pci_msi_init_pci_dev() to a new function named
> pci_msi_setup_pci_dev(), called by pci_setup_device().

OK.

> Since then, the pSeries platform of the powerpc architecture needs to
> disable MSI at PCI probe time manually, as the code flow doesn't
> reach pci_setup_device(). 
>
> For doing so, it wants to call
> pci_msi_setup_pci_dev(). This patch makes the required function
> non-static, so that it will be called on PCI probe path on powerpc pSeries
> platform in next patch.

I didn't follow that entirely, I think you mean something like:

  The pseries PCI probing code does not call pci_setup_device(), so since
  commit 1851617cd2 pci_msi_setup_pci_dev() is not called and MSIs are left
  enabled, which is a bug.

  To fix this the pseries PCI probe should manually call
  pci_msi_setup_pci_dev(), so make it non-static.


Does that look OK?

Also you haven't CC'ed the original author of the commit, or the PCI
maintainer, or the relevant lists.

That would be:

    Michael S. Tsirkin <mst@redhat.com>
    Bjorn Helgaas <bhelgaas@google.com>
    linux-pci@vger.kernel.org
    linux-kernel@vger.kernel.org


And finally both patches should have a fixes line, such as:

Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")

cheers
