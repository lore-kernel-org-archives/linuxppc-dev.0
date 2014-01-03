Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0152.outbound.protection.outlook.com [207.46.163.152])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1AECE2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 09:33:20 +1100 (EST)
Date: Fri, 3 Jan 2014 16:33:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [03/12,v3] pci: fsl: add PCI indirect access support
Message-ID: <20140103223306.GC22546@home.buserror.net>
References: <1382524894-15164-3-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1382524894-15164-3-git-send-email-Minghuan.Lian@freescale.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 23, 2013 at 06:41:25PM +0800, Minghuan Lian wrote:
> The patch adds PCI indirect read/write functions. The main code
> is ported from arch/powerpc/sysdev/indirect_pci.c. We use general
> IO API iowrite32be/ioread32be instead of out_be32/in_be32, and
> use structure fsl_Pci instead of PowerPC's pci_controller.
> The patch also provides fsl_pcie_check_link() to check PCI link.
> The weak function fsl_arch_pci_exclude_device() is provided to
> call ppc_md.pci_exclude_device() for PowerPC architecture.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> ---
> change log:
> v1-v3:
> Derived from http://patchwork.ozlabs.org/patch/278965/
> 
> Based on upstream master.
> Based on the discussion of RFC version here
> http://patchwork.ozlabs.org/patch/274487/
> 
>  drivers/pci/host/pci-fsl-common.c | 169 ++++++++++++++++++++++++++++++++------
>  include/linux/fsl/pci-common.h    |   6 ++
>  2 files changed, 151 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
> index 69d338b..8bc9a64 100644
> --- a/drivers/pci/host/pci-fsl-common.c
> +++ b/drivers/pci/host/pci-fsl-common.c
> @@ -35,52 +35,173 @@
>  #include <sysdev/fsl_soc.h>
>  #include <sysdev/fsl_pci.h>
>  
> -static int fsl_pcie_check_link(struct pci_controller *hose)
> +/* Indirect type */
> +#define INDIRECT_TYPE_EXT_REG			0x00000002
> +#define INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	0x00000004
> +#define INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
> +#define INDIRECT_TYPE_BIG_ENDIAN		0x00000010
> +#define INDIRECT_TYPE_FSL_CFG_REG_LINK		0x00000040

Why are these here rather than in the header, given that you have
indirect_type in the struct in the header?

> +int __weak fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn)
> +{
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int fsl_pci_read_config(struct fsl_pci *pci, int bus, int devfn,
> +				int offset, int len, u32 *val)
> +{
> +	u32 bus_no, reg, data;
> +
> +	if (pci->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
> +		if (bus != pci->first_busno)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		if (devfn != 0)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +	}

A lot of this seems duplicated from arch/powerpc/sysdev/indirect_pci.c.

How generally applicable is that file to non-PPC implementations?  At a
minimum I see a similar file in arch/microblaze.  It should probably
eventually be moved to common code, rather than duplicated again.  A
prerequisite for that would be making common the dependencies it has on
the rest of what is currently arch PCI infrastructure; until then, it's
probably better to just have the common fsl-pci code know how to
interface with the appropriate PPC/ARM code rather than trying to copy
the infrastructure as well.

-Scott
