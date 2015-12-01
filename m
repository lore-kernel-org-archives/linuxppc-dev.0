Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54FB91A01DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 23:41:53 +1100 (AEDT)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 10:41:47 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 1FA371DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 07:41:42 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB1CdUfp26018266
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 10:39:30 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB1CfhQD020183
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 07:41:43 -0500
Subject: Re: [PATCH] Enable MSI/MSI-X caps and disable MSI interrupts at PCI
 probe time - code move
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20151201013540.GB9306@localhost>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, mst@redhat.com, shangw@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <565D9586.4050605@linux.vnet.ibm.com>
Date: Tue, 1 Dec 2015 10:41:42 -0200
MIME-Version: 1.0
In-Reply-To: <20151201013540.GB9306@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/30/2015 11:35 PM, Bjorn Helgaas wrote:
> Thanks for your patience, Guilherme.

Hello Bjorn, thank you for the very deep review of my patch. Much 
appreciated!


> I applied this to pci/msi for v4.5.  I reworked the changelog and made
> pci_msi_setup_pci_dev() static, since I think it's now only called
> from drivers/pci/probe.c.

Thanks. Regarding pci_msi_setup_pci_dev(), it really should be static. I 
changed it because PowerPC arch was calling this since my last patch, 
but this patch remove the call from PowerPC arch, so it's great to see 
this function static again.


> I didn't quite follow the last paragraph about reverting 1851617cd2da.
> 1851617cd2da moved the MSI init (dev->msi_cap init and MSI disable)
> from pci/msi.c (where it was only done when CONFIG_PCI_MSI=y) to
> pci/probe.c (where we did it for all non-OF arches, regardless of
> CONFIG_PCI_MSI).  So I would characterize this patch as doing the MSI
> init for *all* arches, regardless of CONFIG_PCI_MSI.

Well, my English skills aren't so good, so I possibly I wrote confusing 
text. What I meant is that, from practical viewpoint, what we did here 
has the same effect of reverting those patches (in the sense of 
initializing MSI caps). But you can ignore my statement, and I 
appreciate that you removed it from the commit message if it was 
confusing heh


> While looking at this, I noticed that pci_msi_init_pci_dev() is now
> always empty, so I'll remove that in a separate patch.
>
> Please let me know if this doesn't make sense:

The patch below is great, thanks for the modifications and for removing 
pci_msi_init_pci_dev() in a separated patch.


> commit e80e7edc55ba711f3fe23975061b3f1c336ceb95
> Author: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Date:   Wed Oct 21 12:17:35 2015 -0200
>
>      PCI/MSI: Initialize MSI capability for all architectures
>
>      1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't
>      support MSI") moved dev->msi_cap and dev->msix_cap initialization from the
>      pci_init_capabilities() path (used on all architectures) to the
>      pci_setup_device() path (not used on Open Firmware architectures).
>
>      This broke MSI or MSI-X on Open Firmware machines.  4d9aac397a5d
>      ("powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe time in OF case")
>      fixed it for PowerPC but not for SPARC.
>
>      Set up MSI and MSI-X (initialize msi_cap and msix_cap and disable MSI and
>      MSI-X) in pci_init_capabilities() so all architectures do it the same way.
>
>      This reverts 4d9aac397a5d since this patch fixes the problem generically
>      for both PowerPC and SPARC.
>
>      [bhelgaas: changelog, make pci_msi_setup_pci_dev() static]
>      Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")
>      Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
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
> index edb1984..cd94737 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1145,7 +1145,7 @@ int pci_cfg_space_size(struct pci_dev *dev)
>
>   #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
>
> -void pci_msi_setup_pci_dev(struct pci_dev *dev)
> +static void pci_msi_setup_pci_dev(struct pci_dev *dev)
>   {
>   	/*
>   	 * Disable the MSI hardware to avoid screaming interrupts
> @@ -1212,8 +1212,6 @@ int pci_setup_device(struct pci_dev *dev)
>   	/* "Unknown power state" */
>   	dev->current_state = PCI_UNKNOWN;
>
> -	pci_msi_setup_pci_dev(dev);
> -
>   	/* Early fixups, before probing the BARs */
>   	pci_fixup_device(pci_fixup_early, dev);
>   	/* device class may be changed after fixup */
> @@ -1606,6 +1604,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	/* MSI/MSI-X list */
>   	pci_msi_init_pci_dev(dev);
>
> +	/* Setup MSI caps & disable MSI/MSI-X interrupts */
> +	pci_msi_setup_pci_dev(dev);
> +
>   	/* Buffers for saving PCIe and PCI-X capabilities */
>   	pci_allocate_cap_save_buffers(dev);
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e828e7b..f9f79ad 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1248,8 +1248,6 @@ struct msix_entry {
>   	u16	entry;	/* driver uses to specify entry, OS writes */
>   };
>
> -void pci_msi_setup_pci_dev(struct pci_dev *dev);
> -
>   #ifdef CONFIG_PCI_MSI
>   int pci_msi_vec_count(struct pci_dev *dev);
>   void pci_msi_shutdown(struct pci_dev *dev);
>

Cheers,


Guilherme Piccoli
