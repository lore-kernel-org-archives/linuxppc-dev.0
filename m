Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vv62N5TfVzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 01:09:32 +1100 (AEDT)
Subject: Re: [RFC PATCH 2/5] soc/fsl/qbman: Use shared-dma-pool for QMan
 private memory allocations
To: roy.pledge@nxp.com, oss@buserror.net, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-3-git-send-email-roy.pledge@nxp.com>
Cc: madalin.bucur@nxp.com
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b1cd8d44-8c74-ab50-5dc9-1f978cae5bdf@arm.com>
Date: Thu, 30 Mar 2017 15:09:25 +0100
MIME-Version: 1.0
In-Reply-To: <1490822037-6752-3-git-send-email-roy.pledge@nxp.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Roy,

On 29/03/17 22:13, Roy Pledge wrote:
> Use the shared-memory-pool mechanism for frame queue descriptor and
> packed frame descriptor record area allocations.

Thanks for persevering with this - in my opinion it's now looking like
it was worth the effort :)

AFAICS the ioremap_wc() that this leads to does appear to give back
something non-cacheable on PPC (assuming "pgprot_noncached_wc" isn't
horrendously misnamed), and "no-map" should rule out any cacheable
linear map alias existing, so it would seem that this approach should
avert Scott's concerns about attribute mismatches.

> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  drivers/soc/fsl/qbman/qman_ccsr.c | 119 +++++++++++++++++++++-----------------
>  drivers/soc/fsl/qbman/qman_priv.h |   4 +-
>  drivers/soc/fsl/qbman/qman_test.h |   2 -
>  3 files changed, 68 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 90bc40c..35c59ca 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -400,63 +400,19 @@ static int qm_init_pfdr(struct device *dev, u32 pfdr_start, u32 num)
>  	return -ENODEV;
>  }
>  
> -/*
> - * Ideally we would use the DMA API to turn rmem->base into a DMA address
> - * (especially if iommu translations ever get involved).  Unfortunately, the
> - * DMA API currently does not allow mapping anything that is not backed with
> - * a struct page.
> - */
> +/* QMan needs two global memory areas initialized at boot time:
> +    1) FQD: Frame Queue Descriptors used to manage frame queues
> +    2) PFDR: Packed Frame Queue Descriptor Records used to store frames
> +   Both areas are reserved using the device tree reserved memory framework
> +   and the addresses and sizes are initialized when the QMan device is probed */
>  static dma_addr_t fqd_a, pfdr_a;
>  static size_t fqd_sz, pfdr_sz;
>  
> -static int qman_fqd(struct reserved_mem *rmem)
> -{
> -	fqd_a = rmem->base;
> -	fqd_sz = rmem->size;
> -
> -	WARN_ON(!(fqd_a && fqd_sz));
> -
> -	return 0;
> -}
> -RESERVEDMEM_OF_DECLARE(qman_fqd, "fsl,qman-fqd", qman_fqd);
> -
> -static int qman_pfdr(struct reserved_mem *rmem)
> -{
> -	pfdr_a = rmem->base;
> -	pfdr_sz = rmem->size;
> -
> -	WARN_ON(!(pfdr_a && pfdr_sz));
> -
> -	return 0;
> -}
> -RESERVEDMEM_OF_DECLARE(qman_pfdr, "fsl,qman-pfdr", qman_pfdr);
> -

I notice that patch #1 isn't removing the equivalent bman_fbpr() handler
and declaration as here - is that deliberate or just an oversight?

>  static unsigned int qm_get_fqid_maxcnt(void)
>  {
>  	return fqd_sz / 64;
>  }
>  
> -/*
> - * Flush this memory range from data cache so that QMAN originated
> - * transactions for this memory region could be marked non-coherent.
> - */
> -static int zero_priv_mem(struct device *dev, struct device_node *node,
> -			 phys_addr_t addr, size_t sz)
> -{
> -	/* map as cacheable, non-guarded */
> -	void __iomem *tmpp = ioremap_prot(addr, sz, 0);
> -
> -	if (!tmpp)
> -		return -ENOMEM;
> -
> -	memset_io(tmpp, 0, sz);
> -	flush_dcache_range((unsigned long)tmpp,
> -			   (unsigned long)tmpp + sz);
> -	iounmap(tmpp);
> -
> -	return 0;
> -}
> -
>  static void log_edata_bits(struct device *dev, u32 bit_count)
>  {
>  	u32 i, j, mask = 0xffffffff;
> @@ -687,11 +643,12 @@ static int qman_resource_init(struct device *dev)
>  static int fsl_qman_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *node = dev->of_node;
> +	struct device_node *mem_node, *node = dev->of_node;
>  	struct resource *res;
>  	int ret, err_irq;
>  	u16 id;
>  	u8 major, minor;
> +	u64 size;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> @@ -727,10 +684,66 @@ static int fsl_qman_probe(struct platform_device *pdev)
>  		qm_channel_caam = QMAN_CHANNEL_CAAM_REV3;
>  	}
>  
> -	ret = zero_priv_mem(dev, node, fqd_a, fqd_sz);
> -	WARN_ON(ret);
> -	if (ret)
> +	/* Order of memory regions is assumed as FQD followed by PFDR
> +	   in order to ensure allocations from the correct regions the
> +	   driver initializes then allocates each piece in order */
> +
> +	ret = of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
> +	if (ret) {
> +		dev_err(dev, "of_reserved_mem_device_init_by_idx(0) failed 0x%x\n",
> +			ret);
> +		return -ENODEV;
> +	}
> +	mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (mem_node) {
> +		ret = of_property_read_u64(mem_node, "size", &size);
> +		if (ret) {
> +			dev_err(dev, "FQD: of_address_to_resource fails 0x%x\n", ret);

Nit: of_address_to_resource?

> +			return -ENODEV;
> +		}
> +		fqd_sz = size;
> +	} else {
> +		dev_err(dev, "No memory-region found for FQD\n");
> +		return -ENODEV;
> +	}
> +	if (!dma_zalloc_coherent(dev, fqd_sz, &fqd_a, 0)) {
> +		dev_err(dev, "Alloc FQD memory failed\n");
> +		return -ENODEV;
> +	}

Between here, below, and patch #1, it looks like this "init, get size,
alloc" pattern could be nicely factored out into a common helper function.

> +
> +	dev_info(dev, "Allocated FQD 0x%llx 0x%zx\n", fqd_a, fqd_sz);
> +
> +	/* Disassociate the FQD reseverd memory area from the device because
> +	   a device can only have one DMA memory area. This should be fine
> +	   since the memory is allocated and initalized and only ever accessed
> +	   by the QMan device from now on */

Typos: reserved, initialized.

> +	of_reserved_mem_device_release(dev);

I see the driver does not implement a .remove method where you would
otherwise be technically expected to balance the allocation with a
dma_free_coherent(), so I think this trick is acceptable. If anyone
wants to change that in future, it wouldn't seem unreasonable to extend
the core code to handle multiple areas per device (and at worst, I guess
you could deviously juggle dev->dma_mem around the DMA API calls).

Other than those first few nits, and any possible PPC-specific angles
I'm not aware of, I think the series is looking good!

Thanks,
Robin.

> +
> +	/* Setup PFDR memory */
> +	ret = of_reserved_mem_device_init_by_idx(dev, dev->of_node, 1);
> +	if (ret) {
> +		dev_err(dev, "of_reserved_mem_device_init(1) failed 0x%x\n",
> +			ret);
> +		return -ENODEV;
> +	}
> +	mem_node = of_parse_phandle(dev->of_node, "memory-region", 1);
> +	if (mem_node) {
> +		ret = of_property_read_u64(mem_node, "size", &size);
> +		if (ret) {
> +			dev_err(dev, "PFDR: of_address_to_resource fails 0x%x\n", ret);
> +			return -ENODEV;
> +		}
> +		pfdr_sz = size;
> +	} else {
> +		dev_err(dev, "No memory-region found for PFDR\n");
> +		return -ENODEV;
> +	}
> +	if (!dma_zalloc_coherent(dev, pfdr_sz, &pfdr_a, 0)) {
> +		dev_err(dev, "Alloc PFDR Failed size 0x%zx\n", pfdr_sz);
>  		return -ENODEV;
> +	}
> +
> +	dev_info(dev, "Allocated PFDR 0x%llx 0x%zx\n", pfdr_a, pfdr_sz);
>  
>  	ret = qman_init_ccsr(dev);
>  	if (ret) {
> diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
> index 22725bd..1e998ea5 100644
> --- a/drivers/soc/fsl/qbman/qman_priv.h
> +++ b/drivers/soc/fsl/qbman/qman_priv.h
> @@ -28,12 +28,12 @@
>   * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include "dpaa_sys.h"
>  
>  #include <soc/fsl/qman.h>
>  #include <linux/iommu.h>
> +#include <linux/dma-contiguous.h>
> +#include <linux/of_address.h>
>  
>  #if defined(CONFIG_FSL_PAMU)
>  #include <asm/fsl_pamu_stash.h>
> diff --git a/drivers/soc/fsl/qbman/qman_test.h b/drivers/soc/fsl/qbman/qman_test.h
> index d5f8cb2..41bdbc48 100644
> --- a/drivers/soc/fsl/qbman/qman_test.h
> +++ b/drivers/soc/fsl/qbman/qman_test.h
> @@ -30,7 +30,5 @@
>  
>  #include "qman_priv.h"
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  int qman_test_stash(void);
>  int qman_test_api(void);
> 
