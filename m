Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpzL40FnXzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 07:53:48 +1100 (AEDT)
Date: Thu, 23 Mar 2017 15:53:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v9 2/3] PCI: Add a macro to set default alignment for all
 PCI devices
Message-ID: <20170323205342.GB23612@bhelgaas-glaptop.roam.corp.google.com>
References: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1487141106-2503-3-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487141106-2503-3-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Yongji,

On Wed, Feb 15, 2017 at 02:45:05PM +0800, Yongji Xie wrote:
> When vfio passthroughs a PCI device of which MMIO BARs are
> smaller than PAGE_SIZE, guest will not handle the mmio
> accesses to the BARs which leads to mmio emulations in host.
> 
> This is because vfio will not allow to passthrough one BAR's
> mmio page which may be shared with other BARs. Otherwise,
> there will be a backdoor that guest can use to access BARs
> of other guest.

Please include a pointer to the VFIO code that enforces this.  It's
not obvious to me how it would do this.  This doesn't change the
*size* of the resource, only the alignment.  So if VFIO sees a BAR
like [mem 0x80000000-0x800000ff], it knows the BAR is aligned enough
that it *could* be the only thing on a page, but I don't know how it
could know that there will never be another BAR at 0x80000100.  Even
if there's no other BAR on that page *now*, it would have to know that
no hot-added device will ever be placed on that page.

> This patch adds a macro to set default alignment for all
> PCI devices. Then we could solve this issue on some platforms
> which would easily hit this issue because of their 64K page
> such as PowerNV platform by defining this macro as PAGE_SIZE.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pci.h |    4 ++++
>  drivers/pci/pci.c              |    3 +++
>  2 files changed, 7 insertions(+), 0 deletions(-)
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
> index a881c0d..2622e9b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4965,6 +4965,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>  	resource_size_t align = 0;
>  	char *p;
>  
> +#ifdef PCIBIOS_DEFAULT_ALIGNMENT
> +	align = PCIBIOS_DEFAULT_ALIGNMENT;
> +#endif

I'd prefer to move this #ifdef out of the code path, as in the patch
below.

I don't know how powerpc kernels are built: can you build a kernel
that will run on PowerNV as well as on different powerpc systems?  If
so, is it acceptable to force that kernel to user 64K alignment even
when it's running on non-PowerNV systems?  Or do you need a function
call here instead of a #define?

>  	spin_lock(&resource_alignment_lock);
>  	p = resource_alignment_param;
>  	if (!*p)


commit 60106ae302a264f9be15fa736dae2ea51140b988
Author: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date:   Wed Feb 15 14:45:05 2017 +0800

    PCI: Add PCIBIOS_DEFAULT_ALIGNMENT for arch-specific alignment control
    
    When VFIO passes through a PCI device to a guest, it does not allow the
    guest direct access to BARs that are smaller than PAGE_SIZE.  This is
    because a page might contain several small BARs for unrelated devices and
    a guest should not be able to access all of them.
    
    VFIO emulates guest accesses to these small BARs, which is functional but
    slow.  On systems with large page sizes, e.g., PowerNV with 64K pages, BARs
    are more likely to share a page and performance is more of a problem.
    
    Add a macro to set default alignment for all PCI devices.  An arch can set
    this to PAGE_SIZE to prevent memory BARs from sharing a page.
    
    [bhelgaas: add default PCIBIOS_DEFAULT_ALIGNMENT definition, changelog]
    Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 93eded8d3843..dc3c81ab4cc4 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -28,6 +28,10 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+#ifdef CONFIG_PPC_POWERNV
+#define PCIBIOS_DEFAULT_ALIGNMENT	PAGE_SIZE
+#endif
+
 struct pci_dev;
 
 /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02ffdb9..e9a079063fd0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4962,7 +4962,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 {
 	int seg, bus, slot, func, align_order, count;
 	unsigned short vendor, device, subsystem_vendor, subsystem_device;
-	resource_size_t align = 0;
+	resource_size_t align = PCIBIOS_DEFAULT_ALIGNMENT;
 	char *p;
 
 	spin_lock(&resource_alignment_lock);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a04e6c..618beb5809d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1630,6 +1630,10 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 #define pci_root_bus_fwnode(bus)	NULL
 #endif
 
+#ifndef PCIBIOS_DEFAULT_ALIGNMENT
+#define PCIBIOS_DEFAULT_ALIGNMENT	0
+#endif
+
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
