Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH3Gk0xh8zF0l3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 09:15:10 +1100 (AEDT)
Date: Wed, 10 Jan 2018 16:14:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] PCI: Add #defines for Completion Timeout Disable feature
Message-ID: <20180110221324.GE241460@bhelgaas-glaptop.roam.corp.google.com>
References: <20171215225711.176712.65146.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171215225711.176712.65146.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 15, 2017 at 04:57:11PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add #defines for the Completion Timeout Disable feature and use them.  No
> functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied with Michael's ack to pci/misc for v4.16.

> ---
>  arch/powerpc/platforms/powernv/eeh-powernv.c |    6 +++---
>  include/uapi/linux/pci_regs.h                |    2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 4650fb294e7a..2f7cd0ef3cdc 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1654,14 +1654,14 @@ static int pnv_eeh_restore_vf_config(struct pci_dn *pdn)
>  		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>  				      2, devctl);
>  
> -		/* Disable Completion Timeout */
> +		/* Disable Completion Timeout if possible */
>  		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
>  				     4, &cap2);
> -		if (cap2 & 0x10) {
> +		if (cap2 & PCI_EXP_DEVCAP2_COMP_TMOUT_DIS) {
>  			eeh_ops->read_config(pdn,
>  					     edev->pcie_cap + PCI_EXP_DEVCTL2,
>  					     4, &cap2);
> -			cap2 |= 0x10;
> +			cap2 |= PCI_EXP_DEVCTL2_COMP_TMOUT_DIS;
>  			eeh_ops->write_config(pdn,
>  					      edev->pcie_cap + PCI_EXP_DEVCTL2,
>  					      4, cap2);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 70c2b2ade048..9dc67643fc18 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -622,6 +622,7 @@
>   * safely.
>   */
>  #define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
> +#define  PCI_EXP_DEVCAP2_COMP_TMOUT_DIS	0x00000010 /* Completion Timeout Disable supported */
>  #define  PCI_EXP_DEVCAP2_ARI		0x00000020 /* Alternative Routing-ID */
>  #define  PCI_EXP_DEVCAP2_ATOMIC_ROUTE	0x00000040 /* Atomic Op routing */
>  #define PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* Atomic 64-bit compare */
> @@ -631,6 +632,7 @@
>  #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
>  #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
>  #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
> +#define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
>  #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
>  #define PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
>  #define PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
> 
