Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F5241A003D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 10:19:07 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id lf10so1251784pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Sep 2014 17:19:05 -0700 (PDT)
Date: Fri, 5 Sep 2014 18:18:59 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] PCI: Increase BAR size quirk for IBM ipr SAS Crocodile
 adapters
Message-ID: <20140906001859.GO8080@google.com>
References: <20140821092652.604d7484@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140821092652.604d7484@kryten>
Cc: linux-pci@vger.kernel.org, miltonm@us.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, dllehr@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2014 at 09:26:52AM +1000, Anton Blanchard wrote:
> From: Douglas Lehr <dllehr@us.ibm.com>
> 
> The Crocodile chip occasionally comes up with 4k and 8k BAR sizes.
> Due to an errata, setting the SR-IOV page size causes the physical
> function BARs to expand to the system page size.  Since ppc64 uses
> 64k pages, when Linux tries to assign the smaller resource sizes
> to the now 64k BARs the address will be truncated and the BARs will
> overlap.
> 
> This quirk will force Linux to allocate the resource as a full page,
> which will avoid the overlap.
> 
> Cc: <stable@vger.kernel.org> 
> Signed-off-by: Douglas Lehr <dllehr@us.ibm.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Acked-by: Milton Miller <miltonm@us.ibm.com>

Applied to pci/misc for v3.18, thanks!

I tweaked it to print the expanded resource, see below.

> ---
>  drivers/pci/quirks.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 80c2d01..45b946d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -24,6 +24,7 @@
>  #include <linux/ioport.h>
>  #include <linux/sched.h>
>  #include <linux/ktime.h>
> +#include <linux/mm.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -287,6 +288,24 @@ static void quirk_citrine(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CITRINE,	quirk_citrine);
>  
> +/*  On IBM Crocodile ipr SAS adapters, expand bar size to system page size. */
> +static void quirk_extend_bar_to_page(struct pci_dev *dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
> +		struct resource *r = &dev->resource[i];
> +
> +		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
> +			dev_info(&dev->dev, "Setting Bar size to Page size");
> +			r->end = PAGE_SIZE-1;
> +			r->start = 0;
> +			r->flags |= IORESOURCE_UNSET;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM, 0x034a, quirk_extend_bar_to_page);
> +
>  /*
>   *  S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
>   *  If it's needed, re-allocate the region.
> -- 



commit 86b6431a306ab5a5204c436a45a3337fb17efa21
Author: Douglas Lehr <dllehr@us.ibm.com>
Date:   Thu Aug 21 09:26:52 2014 +1000

    PCI: Increase IBM ipr SAS Crocodile BARs to at least system page size
    
    The Crocodile chip occasionally comes up with 4k and 8k BAR sizes.  Due to
    an erratum, setting the SR-IOV page size causes the physical function BARs
    to expand to the system page size.  Since ppc64 uses 64k pages, when Linux
    tries to assign the smaller resource sizes to the now 64k BARs the address
    will be truncated and the BARs will overlap.
    
    Force Linux to allocate the resource as a full page, which avoids the
    overlap.
    
    [bhelgaas: print expanded resource, too]
    Signed-off-by: Douglas Lehr <dllehr@us.ibm.com>
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Milton Miller <miltonm@us.ibm.com>
    CC: stable@vger.kernel.org

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 80c2d014283d..e73960311fb4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -24,6 +24,7 @@
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/ktime.h>
+#include <linux/mm.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -287,6 +288,25 @@ static void quirk_citrine(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CITRINE,	quirk_citrine);
 
+/*  On IBM Crocodile ipr SAS adapters, expand BAR to system page size */
+static void quirk_extend_bar_to_page(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
+			r->end = PAGE_SIZE - 1;
+			r->start = 0;
+			r->flags |= IORESOURCE_UNSET;
+			dev_info(&dev->dev, "expanded BAR %d to page size: %pR\n",
+				 r);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM, 0x034a, quirk_extend_bar_to_page);
+
 /*
  *  S3 868 and 968 chips report region size equal to 32M, but they decode 64M.
  *  If it's needed, re-allocate the region.
