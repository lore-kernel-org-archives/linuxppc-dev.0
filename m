Return-Path: <michael@ellerman.id.au>
Date: Mon, 22 Apr 2013 09:34:36 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130421233436.GB22246@concordia>
References: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366363965-23281-3-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366363965-23281-3-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 19, 2013 at 05:32:45PM +0800, Gavin Shan wrote:
> The EOI handler of MSI/MSI-X interrupts for P8 (PHB3) need additional
> steps to handle the P/Q bits in IVE before EOIing the corresponding
> interrupt. The patch changes the EOI handler to cover that.

> diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
> index 48861d3..289355e 100644
> --- a/arch/powerpc/sysdev/xics/icp-native.c
> +++ b/arch/powerpc/sysdev/xics/icp-native.c
> @@ -27,6 +27,10 @@
>  #include <asm/xics.h>
>  #include <asm/kvm_ppc.h>
>  
> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
> +extern int pnv_pci_msi_eoi(unsigned int hw_irq);
> +#endif

You don't need to #ifdef the extern. But it should be in a header, not
here.

> @@ -89,6 +93,24 @@ static void icp_native_eoi(struct irq_data *d)
>  	icp_native_set_xirr((xics_pop_cppr() << 24) | hw_irq);
>  }
>  
> +static void icp_p8_native_eoi(struct irq_data *d)
> +{
> +	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
> +	int ret;
> +
> +	/* Let firmware handle P/Q bits */
> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
> +	if (hw_irq != XICS_IPI) {
> +		ret = pnv_pci_msi_eoi(hw_irq);
> +		WARN_ON_ONCE(ret);
> +	}
> +#endif

Why the ifdef in here? You only ever hook this function up if those are
true, so why do you need to check them again?

> @@ -296,6 +318,15 @@ int __init icp_native_init(void)
>  	if (found == 0)
>  		return -ENODEV;
>  
> +	/* Change the EOI handler for P8 */
> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)

This would be neater if you created CONFIG_POWERNV_MSI, like we have
CONFIG_PSERIES_MSI.

cheers
