Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45DEE1A00FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 11:02:29 +1000 (AEST)
Message-ID: <1440032549.13406.3.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] PCI: Make pci_msi_setup_pci_dev() non-static for
 use by arch code
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 bhelgaas@google.com, mst@redhat.com
Date: Thu, 20 Aug 2015 11:02:29 +1000
In-Reply-To: <1440009922-30248-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1439945086.23217.5.camel@ellerman.id.au>
 ,<1439932077-11427-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440009922-30248-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
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

On Wed, 2015-08-19 at 15:45 -0300, Guilherme G. Piccoli wrote:
> Thanks very much for your suggestions Michael. I agree with them all,
> so I'm sending the patch v2 (see below).
> 
> About the relevant mailing lists, I already sent to the linux-pci and
> already cc'ed Bjorn Helgaas - the problem is that I made a mistake and
> sent 2 different emails using git send-email. I'm really sorry about
> this.
> 
> Now I'm trying to correct my mistake sending this message
> simultaneously to both lists (and to a bunch of cc's) using two
> Message-IDs in my reply. Hope it works...

OK.

In future you should send a reply like the above to my mail, and then
separately send the new patch series. My preference is that the new series is
not a reply to anything, though some other maintainers may disagree on that
point.

The other question, which I neglected to ask yesterday, is what is the symptom
of the bug? ie. does the system fail to boot or otherwise crash etc.?


> Changes since v2:

This is changes *in* v2, or since v1.

And it doesn't go here, it goes below ...

>  * Made commit message more clear
>  * Added "Fixes" line
>  * Improved commit reference by using 12 first chars of SHA
> 
> >8----------8<
> 
> Commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI") changed the location of the code that disables
> MSI/MSI-X interrupts at PCI probe time in devices that have this flag
> set. It moved the code from pci_msi_init_pci_dev() to a new function
> named pci_msi_setup_pci_dev(), called by pci_setup_device().
> 
> The pseries PCI probing code does not call pci_setup_device(), so since
> the aforementioned commit the function pci_msi_setup_pci_dev() is not
> called and MSI/MSI-X interrupts are left enabled, which is a bug. To fix
> this, the pseries PCI probe should manually call pci_msi_setup_pci_dev(),
> so this patch makes it non-static.
> 
> Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI")
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---

Here.

Or anywhere after the first '---', which means the version commentary is
discarded in the final commit.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cefd636..520c5b6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1103,7 +1103,7 @@ int pci_cfg_space_size(struct pci_dev *dev)
>  
>  #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
>  
> -static void pci_msi_setup_pci_dev(struct pci_dev *dev)
> +void pci_msi_setup_pci_dev(struct pci_dev *dev)
>  {
>  	/*
>  	 * Disable the MSI hardware to avoid screaming interrupts
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8a0321a..860c751 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1202,6 +1202,7 @@ struct msix_entry {
>  	u16	entry;	/* driver uses to specify entry, OS writes */
>  };
>  
> +void pci_msi_setup_pci_dev(struct pci_dev *dev);
>  
>  #ifdef CONFIG_PCI_MSI
>  int pci_msi_vec_count(struct pci_dev *dev);


cheers
