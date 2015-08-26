Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D19141A0CBA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 22:23:13 +1000 (AEST)
In-Reply-To: <1440420167-8879-2-git-send-email-mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
 gpiccoli@linux.vnet.ibm.com
Subject: Re: [2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe time
 in OF case
Message-Id: <20150826122313.9E26A140338@ozlabs.org>
Date: Wed, 26 Aug 2015 22:23:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-24-08 at 12:42:47 UTC, Michael Ellerman wrote:
> From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
> 
> Since commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if
> kernel doesn't support MSI"), the setup of dev->msi_cap/msix_cap and the
> disable of MSI/MSI-X interrupts isn't being done at PCI probe time, as
> the logic responsible for this was moved in the aforementioned commit
> from pci_device_add() to pci_setup_device(). The latter function is not
> reachable on PowerPC pseries platform during Open Firmware PCI probing
> time.
> 
> This exhibits as drivers not being able to enable MSI, eg:
> 
>   bnx2x 0000:01:00.0: no msix capability found
> 
> This patch calls pci_msi_setup_pci_dev() explicitly to disable MSI/MSI-X
> during PCI probe time on pSeries platform.
> 
> Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")
> [mpe: Flesh out change log and clarify comment]
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/4d9aac397a5d8f4ee26a4178

cheers
