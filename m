Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slGRp0v3fzDsjg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 00:00:21 +1000 (AEST)
Date: Thu, 29 Sep 2016 09:00:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 paulus@samba.org, aik@ozlabs.ru, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v5 4/4] PCI: Add a macro to set default alignment for all
 PCI devices
Message-ID: <20160929140014.GB31048@localhost>
References: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1473757234-5284-5-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473757234-5284-5-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 13, 2016 at 05:00:34PM +0800, Yongji Xie wrote:
> When vfio passthroughs a PCI device of which MMIO BARs are
> smaller than PAGE_SIZE, guest will not handle the mmio
> accesses to the BARs which leads to mmio emulations in host.
> 
> This is because vfio will not allow to passthrough one BAR's
> mmio page which may be shared with other BARs. Otherwise,
> there will be a backdoor that guest can use to access BARs
> of other guest.
> 
> This patch adds a macro to set default alignment for all
> PCI devices. Then we could solve this issue on some platforms
> which would easily hit this issue because of their 64K page
> such as PowerNV platform by defining this macro as PAGE_SIZE.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pci.h |    4 ++++
>  drivers/pci/pci.c              |    4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
> index e9bd6cf..5e31bc2 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -28,6 +28,10 @@
>  #define PCIBIOS_MIN_IO		0x1000
>  #define PCIBIOS_MIN_MEM		0x10000000
>  
> +#ifdef CONFIG_PPC_POWERNV
> +#define PCIBIOS_DEFAULT_ALIGNMENT	PAGE_SIZE
> +#endif
> +
>  struct pci_dev;
>  
>  /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 37f8062..9c61cbe 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4959,6 +4959,10 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  	resource_size_t align = 0;
>  	char *p;
>  
> +#ifdef PCIBIOS_DEFAULT_ALIGNMENT
> +	align = PCIBIOS_DEFAULT_ALIGNMENT;
> +	*resize = false;
> +#endif

I'm a little confused about how this works.

I think this change only does something if the user specifies
"pci=resource_alignment=..." or writes to the /sys/.../resource_alignment
file, because those are the only ways to set resource_alignment_param.

If that's true, isn't the *default* to align to PAGE_SIZE?  So I don't
understand what PCIBIOS_DEFAULT_ALIGNMENT changes.

And I'm hoping we can get rid of the resize flag based on the
discussion of the previous patch.

>  	spin_lock(&resource_alignment_lock);
>  	p = resource_alignment_param;
>  	if (pci_has_flag(PCI_PROBE_ONLY)) {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
