Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36A411A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 08:06:09 +1100 (AEDT)
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 24 Nov 2015 19:06:03 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 7A6B83520066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 16:05:57 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAOL3lxO32899406
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 19:03:48 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAOL5xgA023283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 19:05:59 -0200
Subject: Re: [PATCH] Enable MSI/MSI-X caps and disable MSI interrupts at PCI
 probe time - code move
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, mpe@ellerman.id.au, mst@redhat.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5654D134.5000302@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 19:05:56 -0200
MIME-Version: 1.0
In-Reply-To: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/21/2015 12:17 PM, Guilherme G. Piccoli wrote:
> Commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI") changed the location of the code that initializes
> dev->msi_cap/msix_cap and disables MSI/MSI-X interrupts at PCI probe
> time in devices that have this flag set. It moved the code from
> pci_msi_init_pci_dev() to a new function named pci_msi_setup_pci_dev(),
> called by pci_setup_device().
>
> In Open Firmware code path (PowerPC pSeries/SPARC archs) the function
> pci_setup_device() is not called, so MSI capabilities are never enabled,
> leading to error messages as:
>
> 	bnx2x 0000:01:00.0: no msix capability found
>
> Commit 4d9aac397a5d ("powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
> probe time in OF case") solved the issue on PowerPC pSeries arch calling
> manually pci_msi_setup_pci_dev() on appropriate place. However, this
> modification does not solve the general case (SPARC arch should be
> modified too) and duplicates a lot of code, as pointed by Bjorn Helgaas.
> As suggested by him, worth to reorganize the code to generally solve the
> MSI caps issue and avoid too much code duplication.
>
> This patch does exactly this: we remove both the pci_msi_setup_pci_dev()
> call from pci_setup_device() and the same call in OF code path of PowerPC
> pSeries arch. Then, we call pci_msi_setup_pci_dev() directly from
> pci_init_capabilities(). So, we can initialize MSI caps and disable MSI
> interruptions during PCI probe in general fashion, avoiding code
> duplication.
>
> Notice that this patch has the same practical effect of reverting
> commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI") and commit 4d9aac397a5d ("powerpc/PCI: Disable
> MSI/MSI-X interrupts at PCI probe time in OF case"). Regarding the
> former, the author called pci_msi_setup_pci_dev() from pci_setup_device()
> because there was an early quirk used in pci_msi_off(), which depended on
> pci_msi_setup_pci_dev(). Since pci_msi_off() was completely removed by
> commit c6201cd8513d ("PCI/MSI: Remove unused pci_msi_off()"), we can call
> pci_msi_setup_pci_dev() directly from pci_init_capabilities().
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/pci_of_scan.c | 3 ---
>   drivers/pci/probe.c               | 5 +++--
>   2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 2e710c1..526ac67 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -187,9 +187,6 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>
>   	pci_device_add(dev, bus);
>
> -	/* Setup MSI caps & disable MSI/MSI-X interrupts */
> -	pci_msi_setup_pci_dev(dev);
> -
>   	return dev;
>   }
>   EXPORT_SYMBOL(of_create_pci_dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8361d27..0aac86e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1209,8 +1209,6 @@ int pci_setup_device(struct pci_dev *dev)
>   	/* "Unknown power state" */
>   	dev->current_state = PCI_UNKNOWN;
>
> -	pci_msi_setup_pci_dev(dev);
> -
>   	/* Early fixups, before probing the BARs */
>   	pci_fixup_device(pci_fixup_early, dev);
>   	/* device class may be changed after fixup */
> @@ -1600,6 +1598,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	/* MSI/MSI-X list */
>   	pci_msi_init_pci_dev(dev);
>
> +	/* Setup MSI caps & disable MSI/MSI-X interrupts */
> +	pci_msi_setup_pci_dev(dev);
> +
>   	/* Buffers for saving PCIe and PCI-X capabilities */
>   	pci_allocate_cap_save_buffers(dev);
>

Michael, Bjorn: any news on this one?

Thanks,



Guilherme
