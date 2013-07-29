Return-Path: <B16395@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 794322C0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2013 22:14:49 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Sethi Varun-B16395 <B16395@freescale.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, Yoder Stuart-B08248 <B08248@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/3 v18] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Mon, 29 Jul 2013 12:14:36 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A3D623D@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1373863857-27239-1-git-send-email-Varun.Sethi@freescale.com>
 <1373863857-27239-3-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1373863857-27239-3-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Timur Tabi <timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joerg,
Do you have any further comments on this patch set?

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Monday, July 15, 2013 10:21 AM
> To: joro@8bytes.org; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> benh@kernel.crashing.org; galak@kernel.crashing.org;
> alex.williamson@redhat.com; Yoder Stuart-B08248; Wood Scott-B07421
> Cc: Sethi Varun-B16395; Timur Tabi
> Subject: [PATCH 3/3 v18] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
>=20
> Following is a brief description of the PAMU hardware:
> PAMU determines what action to take and whether to authorize the action
> on
> the basis of the memory address, a Logical IO Device Number (LIODN), and
> PAACT table (logically) indexed by LIODN and address. Hardware devices
> which
> need to access memory must provide an LIODN in addition to the memory
> address.
>=20
> Peripheral Access Authorization and Control Tables (PAACTs) are the
> primary
> data structures used by PAMU. A PAACT is a table of peripheral access
> authorization and control entries (PAACE).Each PAACE defines the range of
> I/O bus address space that is accessible by the LIOD and the associated
> access
> capabilities.
>=20
> There are two types of PAACTs: primary PAACT (PPAACT) and secondary PAACT
> (SPAACT).A given physical I/O device may be able to act as one or more
> independent logical I/O devices (LIODs). Each such logical I/O device is
> assigned an identifier called logical I/O device number (LIODN). A LIODN
> is
> allocated a contiguous portion of the I/O bus address space called the
> DSA window
> for performing DSA operations. The DSA window may optionally be divided
> into
> multiple sub-windows, each of which may be used to map to a region in
> system
> storage space. The first sub-window is referred to as the primary sub-
> window
> and the remaining are called secondary sub-windows.
>=20
> This patch provides the PAMU driver (fsl_pamu.c) and the corresponding
> IOMMU
> API implementation (fsl_pamu_domain.c). The PAMU hardware driver
> (fsl_pamu.c)
> has been derived from the work done by Ashish Kalra and Timur Tabi.
>=20
> [For iommu group support]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>=20
> Signed-off-by: Timur Tabi <timur@tabi.org>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>=20
> ---
> changes in v19:
> - rebased to 3.11-rc1
> changes in v18:
> - Merged the two loops for searching shared iommu_group
> in to a single loop.
> - Renamed function used for searching shared iommu groups.
> changes in v17
> - Fixed iommu group check for peer/parent bus devices.
> - Check for ACS till root node while allocating device
> groups.
> - Fix the reference to pdev instead of dma_dev.
> changes in v16
> - rebased to kernel 3.10-rc6
> changes in v15:
> - Updated path for fsl_pamu_stash.h.
> changes in v14:
> - Use updated PAMU specific attributes.
> changes in v13:
> - Use the new header drivers/iommu/pci.h
> - fix geometry configured check.
> changes in v12:
> - Use is_power_of_2 for checking alignement.
> - Check for multifucntion PCI device ACS flags for determining device
> groups.
> - Fix get_stash_id function.
> - Don't crash in case of access violations, disable the LIODN.
> - Don't use list_empty while traversing list using list for each entry.
> - Move stash structure and ids to PAMU header files.
> - Fix geometry size calculation.
> changes in v11:
> - changed iova to dma_addr_t in iova_to_phys API.
> changes in v10:
> - Support for new guts compatibe string for T4 & B4 devices.
> - Modified comment about port ID and mentioned the errata number.
> - Fixed the issue where data pointer was not freed in case of a an error.
> - Pass data pointer while freeing irq.
> - Whle initializing the SPAACE entry clear the valid bit.
> changes in v9:
> - Merged and createad a single function to delete
> a device from domain list.
> - Refactored the add_device API code.
> - Renamed the paace and spaace init fucntions.
> - Renamed functions for mapping windows and subwindows.
> - Changed the MAX LIODN value to MAX value u-boot can
> program.
> - Hard coded maximum number of subwindows.
> changes in v8:
> - implemented the new API for window based IOMMUs.
> changes in v7:
> - Set max_subwidows in the geometry attribute.
> - Add checking for maximum supported LIODN value.
> - Use upper_32_bits and lower_32_bits macros while
>   intializing PAMU data structures.
> changes in v6:
> - Simplified complex conditional statements.
> - Fixed indentation issues.
> - Added comments for IOMMU API implementation.
> changes in v5:
> - Addressed comments from Timur.
> changes in v4:
> - Addressed comments from Timur and Scott.
> changes in v3:
> - Addressed comments by Kumar Gala
> - dynamic fspi allocation
> - fixed alignment check in map and unmap
>  arch/powerpc/sysdev/fsl_pci.h   |    5 +
>  drivers/iommu/Kconfig           |   10 +
>  drivers/iommu/Makefile          |    1 +
>  drivers/iommu/fsl_pamu.c        | 1309
> +++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/fsl_pamu.h        |  410 ++++++++++++
>  drivers/iommu/fsl_pamu_domain.c | 1172
> +++++++++++++++++++++++++++++++++++
>  drivers/iommu/fsl_pamu_domain.h |   85 +++
>  7 files changed, 2992 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/iommu/fsl_pamu.c
>  create mode 100644 drivers/iommu/fsl_pamu.h
>  create mode 100644 drivers/iommu/fsl_pamu_domain.c
>  create mode 100644 drivers/iommu/fsl_pamu_domain.h
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.h
> b/arch/powerpc/sysdev/fsl_pci.h
> index 72b5625..1e01291 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -16,6 +16,11 @@
>=20
>  struct platform_device;
>=20
> +
> +/* FSL PCI controller BRR1 register */
> +#define PCI_FSL_BRR1      0xbf8
> +#define PCI_FSL_BRR1_VER 0xffff
> +
>  #define PCIE_LTSSM	0x0404		/* PCIE Link Training and
> Status */
>  #define PCIE_LTSSM_L0	0x16		/* L0 state */
>  #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version
> Rev2.2 */
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 820d85c..fe302e3 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -17,6 +17,16 @@ config OF_IOMMU
>         def_bool y
>         depends on OF
>=20
> +config FSL_PAMU
> +	bool "Freescale IOMMU support"
> +	depends on PPC_E500MC
> +	select IOMMU_API
> +	select GENERIC_ALLOCATOR
> +	help
> +	  Freescale PAMU support. PAMU is the IOMMU present on Freescale
> QorIQ platforms.
> +	  PAMU can authorize memory access, remap the memory address, and
> remap I/O
> +	  transaction types.
> +
>  # MSM IOMMU support
>  config MSM_IOMMU
>  	bool "MSM IOMMU Support"
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index bbe7041..14c1f47 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
>  obj-$(CONFIG_SHMOBILE_IOMMU) +=3D shmobile-iommu.o
>  obj-$(CONFIG_SHMOBILE_IPMMU) +=3D shmobile-ipmmu.o
> +obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> new file mode 100644
> index 0000000..a831fee
> --- /dev/null
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -0,0 +1,1309 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
> USA.
> + *
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + */
> +
> +#define pr_fmt(fmt)    "fsl-pamu: %s: " fmt, __func__
> +
> +#include <linux/init.h>
> +#include <linux/iommu.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/of_platform.h>
> +#include <linux/bootmem.h>
> +#include <linux/genalloc.h>
> +#include <asm/io.h>
> +#include <asm/bitops.h>
> +#include <asm/fsl_guts.h>
> +
> +#include "fsl_pamu.h"
> +
> +/* define indexes for each operation mapping scenario */
> +#define OMI_QMAN        0x00
> +#define OMI_FMAN        0x01
> +#define OMI_QMAN_PRIV   0x02
> +#define OMI_CAAM        0x03
> +
> +#define make64(high, low) (((u64)(high) << 32) | (low))
> +
> +struct pamu_isr_data {
> +	void __iomem *pamu_reg_base;	/* Base address of PAMU regs*/
> +	unsigned int count;		/* The number of PAMUs */
> +};
> +
> +static struct paace *ppaact;
> +static struct paace *spaact;
> +static struct ome *omt;
> +
> +/*
> + * Table for matching compatible strings, for device tree
> + * guts node, for QorIQ SOCs.
> + * "fsl,qoriq-device-config-2.0" corresponds to T4 & B4
> + * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
> + * string would be used.
> +*/
> +static const struct of_device_id guts_device_ids[] =3D {
> +	{ .compatible =3D "fsl,qoriq-device-config-1.0", },
> +	{ .compatible =3D "fsl,qoriq-device-config-2.0", },
> +	{}
> +};
> +
> +
> +/*
> + * Table for matching compatible strings, for device tree
> + * L3 cache controller node.
> + * "fsl,t4240-l3-cache-controller" corresponds to T4,
> + * "fsl,b4860-l3-cache-controller" corresponds to B4 &
> + * "fsl,p4080-l3-cache-controller" corresponds to other,
> + * SOCs.
> +*/
> +static const struct of_device_id l3_device_ids[] =3D {
> +	{ .compatible =3D "fsl,t4240-l3-cache-controller", },
> +	{ .compatible =3D "fsl,b4860-l3-cache-controller", },
> +	{ .compatible =3D "fsl,p4080-l3-cache-controller", },
> +	{}
> +};
> +
> +/* maximum subwindows permitted per liodn */
> +static u32 max_subwindow_count;
> +
> +/* Pool for fspi allocation */
> +struct gen_pool *spaace_pool;
> +
> +/**
> + * pamu_get_max_subwin_cnt() - Return the maximum supported
> + * subwindow count per liodn.
> + *
> + */
> +u32 pamu_get_max_subwin_cnt()
> +{
> +	return max_subwindow_count;
> +}
> +
> +/**
> + * pamu_get_ppaace() - Return the primary PACCE
> + * @liodn: liodn PAACT index for desired PAACE
> + *
> + * Returns the ppace pointer upon success else return
> + * null.
> + */
> +static struct paace *pamu_get_ppaace(int liodn)
> +{
> +	if (!ppaact || liodn >=3D PAACE_NUMBER_ENTRIES) {
> +		pr_debug("PPAACT doesn't exist\n");
> +		return NULL;
> +	}
> +
> +	return &ppaact[liodn];
> +}
> +
> +/**
> + * pamu_enable_liodn() - Set valid bit of PACCE
> + * @liodn: liodn PAACT index for desired PAACE
> + *
> + * Returns 0 upon success else error code < 0 returned
> + */
> +int pamu_enable_liodn(int liodn)
> +{
> +	struct paace *ppaace;
> +
> +	ppaace =3D pamu_get_ppaace(liodn);
> +	if (!ppaace) {
> +		pr_debug("Invalid primary paace entry\n");
> +		return -ENOENT;
> +	}
> +
> +	if (!get_bf(ppaace->addr_bitfields, PPAACE_AF_WSE)) {
> +		pr_debug("liodn %d not configured\n", liodn);
> +		return -EINVAL;
> +	}
> +
> +	/* Ensure that all other stores to the ppaace complete first */
> +	mb();
> +
> +	set_bf(ppaace->addr_bitfields, PAACE_AF_V, PAACE_V_VALID);
> +	mb();
> +
> +	return 0;
> +}
> +
> +/**
> + * pamu_disable_liodn() - Clears valid bit of PACCE
> + * @liodn: liodn PAACT index for desired PAACE
> + *
> + * Returns 0 upon success else error code < 0 returned
> + */
> +int pamu_disable_liodn(int liodn)
> +{
> +	struct paace *ppaace;
> +
> +	ppaace =3D pamu_get_ppaace(liodn);
> +	if (!ppaace) {
> +		pr_debug("Invalid primary paace entry\n");
> +		return -ENOENT;
> +	}
> +
> +	set_bf(ppaace->addr_bitfields, PAACE_AF_V, PAACE_V_INVALID);
> +	mb();
> +
> +	return 0;
> +}
> +
> +/* Derive the window size encoding for a particular PAACE entry */
> +static unsigned int map_addrspace_size_to_wse(phys_addr_t
> addrspace_size)
> +{
> +	/* Bug if not a power of 2 */
> +	BUG_ON(!is_power_of_2(addrspace_size));
> +
> +	/* window size is 2^(WSE+1) bytes */
> +	return __ffs(addrspace_size) - 1;
> +}
> +
> +/* Derive the PAACE window count encoding for the subwindow count */
> +static unsigned int map_subwindow_cnt_to_wce(u32 subwindow_cnt)
> +{
> +       /* window count is 2^(WCE+1) bytes */
> +       return __ffs(subwindow_cnt) - 1;
> +}
> +
> +/*
> + * Set the PAACE type as primary and set the coherency required domain
> + * attribute
> + */
> +static void pamu_init_ppaace(struct paace *ppaace)
> +{
> +	set_bf(ppaace->addr_bitfields, PAACE_AF_PT, PAACE_PT_PRIMARY);
> +
> +	set_bf(ppaace->domain_attr.to_host.coherency_required,
> PAACE_DA_HOST_CR,
> +	       PAACE_M_COHERENCE_REQ);
> +}
> +
> +/*
> + * Set the PAACE type as secondary and set the coherency required domain
> + * attribute.
> + */
> +static void pamu_init_spaace(struct paace *spaace)
> +{
> +	set_bf(spaace->addr_bitfields, PAACE_AF_PT, PAACE_PT_SECONDARY);
> +	set_bf(spaace->domain_attr.to_host.coherency_required,
> PAACE_DA_HOST_CR,
> +	       PAACE_M_COHERENCE_REQ);
> +}
> +
> +/*
> + * Return the spaace (corresponding to the secondary window index)
> + * for a particular ppaace.
> + */
> +static struct paace *pamu_get_spaace(struct paace *paace, u32 wnum)
> +{
> +	u32 subwin_cnt;
> +	struct paace *spaace =3D NULL;
> +
> +	subwin_cnt =3D 1UL << (get_bf(paace->impl_attr, PAACE_IA_WCE) + 1);
> +
> +	if (wnum < subwin_cnt)
> +		spaace =3D &spaact[paace->fspi + wnum];
> +	else
> +		pr_debug("secondary paace out of bounds\n");
> +
> +	return spaace;
> +}
> +
> +/**
> + * pamu_get_fspi_and_allocate() - Allocates fspi index and reserves
> subwindows
> + *                                required for primary PAACE in the
> secondary
> + *                                PAACE table.
> + * @subwin_cnt: Number of subwindows to be reserved.
> + *
> + * A PPAACE entry may have a number of associated subwindows. A
> subwindow
> + * corresponds to a SPAACE entry in the SPAACT table. Each PAACE entry
> stores
> + * the index (fspi) of the first SPAACE entry in the SPAACT table. This
> + * function returns the index of the first SPAACE entry. The remaining
> + * SPAACE entries are reserved contiguously from that index.
> + *
> + * Returns a valid fspi index in the range of 0 - SPAACE_NUMBER_ENTRIES
> on success.
> + * If no SPAACE entry is available or the allocator can not reserve the
> required
> + * number of contiguous entries function returns ULONG_MAX indicating a
> failure.
> + *
> +*/
> +static unsigned long pamu_get_fspi_and_allocate(u32 subwin_cnt)
> +{
> +	unsigned long spaace_addr;
> +
> +	spaace_addr =3D gen_pool_alloc(spaace_pool, subwin_cnt *
> sizeof(struct paace));
> +	if (!spaace_addr)
> +		return ULONG_MAX;
> +
> +	return (spaace_addr - (unsigned long)spaact) / (sizeof(struct
> paace));
> +}
> +
> +/* Release the subwindows reserved for a particular LIODN */
> +void pamu_free_subwins(int liodn)
> +{
> +	struct paace *ppaace;
> +	u32 subwin_cnt, size;
> +
> +	ppaace =3D pamu_get_ppaace(liodn);
> +	if (!ppaace) {
> +		pr_debug("Invalid liodn entry\n");
> +		return;
> +	}
> +
> +	if (get_bf(ppaace->addr_bitfields, PPAACE_AF_MW)) {
> +		subwin_cnt =3D 1UL << (get_bf(ppaace->impl_attr, PAACE_IA_WCE)
> + 1);
> +		size =3D (subwin_cnt - 1) * sizeof(struct paace);
> +		gen_pool_free(spaace_pool, (unsigned long)&spaact[ppaace-
> >fspi], size);
> +		set_bf(ppaace->addr_bitfields, PPAACE_AF_MW, 0);
> +	}
> +}
> +
> +/*
> + * Function used for updating stash destination for the coressponding
> + * LIODN.
> + */
> +int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value)
> +{
> +	struct paace *paace;
> +
> +	paace =3D pamu_get_ppaace(liodn);
> +	if (!paace) {
> +		pr_debug("Invalid liodn entry\n");
> +		return -ENOENT;
> +	}
> +	if (subwin) {
> +		paace =3D pamu_get_spaace(paace, subwin - 1);
> +		if (!paace) {
> +			return -ENOENT;
> +		}
> +	}
> +	set_bf(paace->impl_attr, PAACE_IA_CID, value);
> +
> +	mb();
> +
> +	return 0;
> +}
> +
> +/* Disable a subwindow corresponding to the LIODN */
> +int pamu_disable_spaace(int liodn, u32 subwin)
> +{
> +	struct paace *paace;
> +
> +	paace =3D pamu_get_ppaace(liodn);
> +	if (!paace) {
> +		pr_debug("Invalid liodn entry\n");
> +		return -ENOENT;
> +	}
> +	if (subwin) {
> +		paace =3D pamu_get_spaace(paace, subwin - 1);
> +		if (!paace) {
> +			return -ENOENT;
> +		}
> +		set_bf(paace->addr_bitfields, PAACE_AF_V,
> +			 PAACE_V_INVALID);
> +	} else {
> +		set_bf(paace->addr_bitfields, PAACE_AF_AP,
> +			 PAACE_AP_PERMS_DENIED);
> +	}
> +
> +	mb();
> +
> +	return 0;
> +}
> +
> +
> +/**
> + * pamu_config_paace() - Sets up PPAACE entry for specified liodn
> + *
> + * @liodn: Logical IO device number
> + * @win_addr: starting address of DSA window
> + * @win-size: size of DSA window
> + * @omi: Operation mapping index -- if ~omi =3D=3D 0 then omi not define=
d
> + * @rpn: real (true physical) page number
> + * @stashid: cache stash id for associated cpu -- if ~stashid =3D=3D 0 t=
hen
> + *	     stashid not defined
> + * @snoopid: snoop id for hardware coherency -- if ~snoopid =3D=3D 0 the=
n
> + *	     snoopid not defined
> + * @subwin_cnt: number of sub-windows
> + * @prot: window permissions
> + *
> + * Returns 0 upon success else error code < 0 returned
> + */
> +int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t
> win_size,
> +		       u32 omi, unsigned long rpn, u32 snoopid, u32 stashid,
> +		       u32 subwin_cnt, int prot)
> +{
> +	struct paace *ppaace;
> +	unsigned long fspi;
> +
> +	if (!is_power_of_2(win_size) || win_size < PAMU_PAGE_SIZE) {
> +		pr_debug("window size too small or not a power of two
> %llx\n", win_size);
> +		return -EINVAL;
> +	}
> +
> +	if (win_addr & (win_size - 1)) {
> +		pr_debug("window address is not aligned with window size\n");
> +		return -EINVAL;
> +	}
> +
> +	ppaace =3D pamu_get_ppaace(liodn);
> +	if (!ppaace) {
> +		return -ENOENT;
> +	}
> +
> +	/* window size is 2^(WSE+1) bytes */
> +	set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE,
> +		map_addrspace_size_to_wse(win_size));
> +
> +	pamu_init_ppaace(ppaace);
> +
> +	ppaace->wbah =3D win_addr >> (PAMU_PAGE_SHIFT + 20);
> +	set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL,
> +	       (win_addr >> PAMU_PAGE_SHIFT));
> +
> +	/* set up operation mapping if it's configured */
> +	if (omi < OME_NUMBER_ENTRIES) {
> +		set_bf(ppaace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
> +		ppaace->op_encode.index_ot.omi =3D omi;
> +	} else if (~omi !=3D 0) {
> +		pr_debug("bad operation mapping index: %d\n", omi);
> +		return -EINVAL;
> +	}
> +
> +	/* configure stash id */
> +	if (~stashid !=3D 0)
> +		set_bf(ppaace->impl_attr, PAACE_IA_CID, stashid);
> +
> +	/* configure snoop id */
> +	if (~snoopid !=3D 0)
> +		ppaace->domain_attr.to_host.snpid =3D snoopid;
> +
> +	if (subwin_cnt) {
> +		/* The first entry is in the primary PAACE instead */
> +		fspi =3D pamu_get_fspi_and_allocate(subwin_cnt - 1);
> +		if (fspi =3D=3D ULONG_MAX) {
> +			pr_debug("spaace indexes exhausted\n");
> +			return -EINVAL;
> +		}
> +
> +		/* window count is 2^(WCE+1) bytes */
> +		set_bf(ppaace->impl_attr, PAACE_IA_WCE,
> +		       map_subwindow_cnt_to_wce(subwin_cnt));
> +		set_bf(ppaace->addr_bitfields, PPAACE_AF_MW, 0x1);
> +		ppaace->fspi =3D fspi;
> +	} else {
> +		set_bf(ppaace->impl_attr, PAACE_IA_ATM,
> PAACE_ATM_WINDOW_XLATE);
> +		ppaace->twbah =3D rpn >> 20;
> +		set_bf(ppaace->win_bitfields, PAACE_WIN_TWBAL, rpn);
> +		set_bf(ppaace->addr_bitfields, PAACE_AF_AP, prot);
> +		set_bf(ppaace->impl_attr, PAACE_IA_WCE, 0);
> +		set_bf(ppaace->addr_bitfields, PPAACE_AF_MW, 0);
> +	}
> +	mb();
> +
> +	return 0;
> +}
> +
> +/**
> + * pamu_config_spaace() - Sets up SPAACE entry for specified subwindow
> + *
> + * @liodn:  Logical IO device number
> + * @subwin_cnt:  number of sub-windows associated with dma-window
> + * @subwin: subwindow index
> + * @subwin_size: size of subwindow
> + * @omi: Operation mapping index
> + * @rpn: real (true physical) page number
> + * @snoopid: snoop id for hardware coherency -- if ~snoopid =3D=3D 0 the=
n
> + *			  snoopid not defined
> + * @stashid: cache stash id for associated cpu
> + * @enable: enable/disable subwindow after reconfiguration
> + * @prot: sub window permissions
> + *
> + * Returns 0 upon success else error code < 0 returned
> + */
> +int pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin,
> +		       phys_addr_t subwin_size, u32 omi, unsigned long rpn,
> +		       u32 snoopid, u32 stashid, int enable, int prot)
> +{
> +	struct paace *paace;
> +
> +
> +	/* setup sub-windows */
> +	if (!subwin_cnt) {
> +		pr_debug("Invalid subwindow count\n");
> +		return -EINVAL;
> +	}
> +
> +	paace =3D pamu_get_ppaace(liodn);
> +	if (subwin > 0 && subwin < subwin_cnt && paace) {
> +		paace =3D pamu_get_spaace(paace, subwin - 1);
> +
> +		if (paace && !(paace->addr_bitfields & PAACE_V_VALID)) {
> +			pamu_init_spaace(paace);
> +			set_bf(paace->addr_bitfields, SPAACE_AF_LIODN, liodn);
> +		}
> +	}
> +
> +	if (!paace) {
> +		pr_debug("Invalid liodn entry\n");
> +		return -ENOENT;
> +	}
> +
> +	if (!is_power_of_2(subwin_size) || subwin_size < PAMU_PAGE_SIZE) {
> +		pr_debug("subwindow size out of range, or not a power of
> 2\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rpn =3D=3D ULONG_MAX) {
> +		pr_debug("real page number out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	/* window size is 2^(WSE+1) bytes */
> +	set_bf(paace->win_bitfields, PAACE_WIN_SWSE,
> +	       map_addrspace_size_to_wse(subwin_size));
> +
> +	set_bf(paace->impl_attr, PAACE_IA_ATM, PAACE_ATM_WINDOW_XLATE);
> +	paace->twbah =3D rpn >> 20;
> +	set_bf(paace->win_bitfields, PAACE_WIN_TWBAL, rpn);
> +	set_bf(paace->addr_bitfields, PAACE_AF_AP, prot);
> +
> +	/* configure snoop id */
> +	if (~snoopid !=3D 0)
> +		paace->domain_attr.to_host.snpid =3D snoopid;
> +
> +	/* set up operation mapping if it's configured */
> +	if (omi < OME_NUMBER_ENTRIES) {
> +		set_bf(paace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
> +		paace->op_encode.index_ot.omi =3D omi;
> +	} else if (~omi !=3D 0) {
> +		pr_debug("bad operation mapping index: %d\n", omi);
> +		return -EINVAL;
> +	}
> +
> +	if (~stashid !=3D 0)
> +		set_bf(paace->impl_attr, PAACE_IA_CID, stashid);
> +
> +	smp_wmb();
> +
> +	if (enable)
> +		set_bf(paace->addr_bitfields, PAACE_AF_V, PAACE_V_VALID);
> +
> +	mb();
> +
> +	return 0;
> +}
> +
> +/**
> +* get_ome_index() - Returns the index in the operation mapping table
> +*                   for device.
> +* @*omi_index: pointer for storing the index value
> +*
> +*/
> +void get_ome_index(u32 *omi_index, struct device *dev)
> +{
> +	if (of_device_is_compatible(dev->of_node, "fsl,qman-portal"))
> +		*omi_index =3D OMI_QMAN;
> +	if (of_device_is_compatible(dev->of_node, "fsl,qman"))
> +		*omi_index =3D OMI_QMAN_PRIV;
> +}
> +
> +/**
> + * get_stash_id - Returns stash destination id corresponding to a
> + *                cache type and vcpu.
> + * @stash_dest_hint: L1, L2 or L3
> + * @vcpu: vpcu target for a particular cache type.
> + *
> + * Returs stash on success or ~(u32)0 on failure.
> + *
> + */
> +u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
> +{
> +	const u32 *prop;
> +	struct device_node *node;
> +	u32 cache_level;
> +	int len, found =3D 0;
> +	int i;
> +
> +	/* Fastpath, exit early if L3/CPC cache is target for stashing */
> +	if (stash_dest_hint =3D=3D PAMU_ATTR_CACHE_L3) {
> +		node =3D of_find_matching_node(NULL, l3_device_ids);
> +		if (node) {
> +			prop =3D of_get_property(node, "cache-stash-id", 0);
> +			if (!prop) {
> +				pr_debug("missing cache-stash-id at %s\n", node-
> >full_name);
> +				of_node_put(node);
> +				return ~(u32)0;
> +			}
> +			of_node_put(node);
> +			return be32_to_cpup(prop);
> +		}
> +		return ~(u32)0;
> +	}
> +
> +	for_each_node_by_type(node, "cpu") {
> +		prop =3D of_get_property(node, "reg", &len);
> +		for (i =3D 0; i < len / sizeof(u32); i++) {
> +			if (be32_to_cpup(&prop[i]) =3D=3D vcpu) {
> +				found =3D 1;
> +				goto found_cpu_node;
> +			}
> +		}
> +	}
> +found_cpu_node:
> +
> +	/* find the hwnode that represents the cache */
> +	for (cache_level =3D PAMU_ATTR_CACHE_L1; (cache_level <
> PAMU_ATTR_CACHE_L3) && found; cache_level++) {
> +		if (stash_dest_hint =3D=3D cache_level) {
> +			prop =3D of_get_property(node, "cache-stash-id", 0);
> +			if (!prop) {
> +				pr_debug("missing cache-stash-id at %s\n", node-
> >full_name);
> +				of_node_put(node);
> +				return ~(u32)0;
> +			}
> +			of_node_put(node);
> +			return be32_to_cpup(prop);
> +		}
> +
> +		prop =3D of_get_property(node, "next-level-cache", 0);
> +		if (!prop) {
> +			pr_debug("can't find next-level-cache at %s\n",
> +				node->full_name);
> +			of_node_put(node);
> +			return ~(u32)0;  /* can't traverse any further */
> +		}
> +		of_node_put(node);
> +
> +		/* advance to next node in cache hierarchy */
> +		node =3D of_find_node_by_phandle(*prop);
> +		if (!node) {
> +			pr_debug("Invalid node for cache hierarchy %s\n",
> +				node->full_name);
> +			return ~(u32)0;
> +		}
> +	}
> +
> +	pr_debug("stash dest not found for %d on vcpu %d\n",
> +	          stash_dest_hint, vcpu);
> +	return ~(u32)0;
> +}
> +
> +/* Identify if the PAACT table entry belongs to QMAN, BMAN or QMAN
> Portal */
> +#define QMAN_PAACE 1
> +#define QMAN_PORTAL_PAACE 2
> +#define BMAN_PAACE 3
> +
> +/**
> + * Setup operation mapping and stash destinations for QMAN and QMAN
> portal.
> + * Memory accesses to QMAN and BMAN private memory need not be coherent,
> so
> + * clear the PAACE entry coherency attribute for them.
> + */
> +static void setup_qbman_paace(struct paace *ppaace, int  paace_type)
> +{
> +	switch (paace_type) {
> +	case QMAN_PAACE:
> +		set_bf(ppaace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
> +		ppaace->op_encode.index_ot.omi =3D OMI_QMAN_PRIV;
> +		/* setup QMAN Private data stashing for the L3 cache */
> +		set_bf(ppaace->impl_attr, PAACE_IA_CID,
> get_stash_id(PAMU_ATTR_CACHE_L3, 0));
> +		set_bf(ppaace->domain_attr.to_host.coherency_required,
> PAACE_DA_HOST_CR,
> +		       0);
> +		break;
> +	case QMAN_PORTAL_PAACE:
> +		set_bf(ppaace->impl_attr, PAACE_IA_OTM, PAACE_OTM_INDEXED);
> +		ppaace->op_encode.index_ot.omi =3D OMI_QMAN;
> +		/*Set DQRR and Frame stashing for the L3 cache */
> +		set_bf(ppaace->impl_attr, PAACE_IA_CID,
> get_stash_id(PAMU_ATTR_CACHE_L3, 0));
> +		break;
> +	case BMAN_PAACE:
> +		set_bf(ppaace->domain_attr.to_host.coherency_required,
> PAACE_DA_HOST_CR,
> +		       0);
> +		break;
> +	}
> +}
> +
> +/**
> + * Setup the operation mapping table for various devices. This is a
> static
> + * table where each table index corresponds to a particular device. PAMU
> uses
> + * this table to translate device transaction to appropriate corenet
> + * transaction.
> + */
> +static void __init setup_omt(struct ome *omt)
> +{
> +	struct ome *ome;
> +
> +	/* Configure OMI_QMAN */
> +	ome =3D &omt[OMI_QMAN];
> +
> +	ome->moe[IOE_READ_IDX] =3D EOE_VALID | EOE_READ;
> +	ome->moe[IOE_EREAD0_IDX] =3D EOE_VALID | EOE_RSA;
> +	ome->moe[IOE_WRITE_IDX] =3D EOE_VALID | EOE_WRITE;
> +	ome->moe[IOE_EWRITE0_IDX] =3D EOE_VALID | EOE_WWSAO;
> +
> +	ome->moe[IOE_DIRECT0_IDX] =3D EOE_VALID | EOE_LDEC;
> +	ome->moe[IOE_DIRECT1_IDX] =3D EOE_VALID | EOE_LDECPE;
> +
> +	/* Configure OMI_FMAN */
> +	ome =3D &omt[OMI_FMAN];
> +	ome->moe[IOE_READ_IDX]  =3D EOE_VALID | EOE_READI;
> +	ome->moe[IOE_WRITE_IDX] =3D EOE_VALID | EOE_WRITE;
> +
> +	/* Configure OMI_QMAN private */
> +	ome =3D &omt[OMI_QMAN_PRIV];
> +	ome->moe[IOE_READ_IDX]  =3D EOE_VALID | EOE_READ;
> +	ome->moe[IOE_WRITE_IDX] =3D EOE_VALID | EOE_WRITE;
> +	ome->moe[IOE_EREAD0_IDX] =3D EOE_VALID | EOE_RSA;
> +	ome->moe[IOE_EWRITE0_IDX] =3D EOE_VALID | EOE_WWSA;
> +
> +	/* Configure OMI_CAAM */
> +	ome =3D &omt[OMI_CAAM];
> +	ome->moe[IOE_READ_IDX]  =3D EOE_VALID | EOE_READI;
> +	ome->moe[IOE_WRITE_IDX] =3D EOE_VALID | EOE_WRITE;
> +}
> +
> +/*
> + * Get the maximum number of PAACT table entries
> + * and subwindows supported by PAMU
> + */
> +static void get_pamu_cap_values(unsigned long pamu_reg_base)
> +{
> +	u32 pc_val;
> +
> +	pc_val =3D in_be32((u32 *)(pamu_reg_base + PAMU_PC3));
> +	/* Maximum number of subwindows per liodn */
> +	max_subwindow_count =3D 1 << (1 + PAMU_PC3_MWCE(pc_val));
> +}
> +
> +/* Setup PAMU registers pointing to PAACT, SPAACT and OMT */
> +int setup_one_pamu(unsigned long pamu_reg_base, unsigned long
> pamu_reg_size,
> +	           phys_addr_t ppaact_phys, phys_addr_t spaact_phys,
> +		   phys_addr_t omt_phys)
> +{
> +	u32 *pc;
> +	struct pamu_mmap_regs *pamu_regs;
> +
> +	pc =3D (u32 *) (pamu_reg_base + PAMU_PC);
> +	pamu_regs =3D (struct pamu_mmap_regs *)
> +		(pamu_reg_base + PAMU_MMAP_REGS_BASE);
> +
> +	/* set up pointers to corenet control blocks */
> +
> +	out_be32(&pamu_regs->ppbah, upper_32_bits(ppaact_phys));
> +	out_be32(&pamu_regs->ppbal, lower_32_bits(ppaact_phys));
> +	ppaact_phys =3D ppaact_phys + PAACT_SIZE;
> +	out_be32(&pamu_regs->pplah, upper_32_bits(ppaact_phys));
> +	out_be32(&pamu_regs->pplal, lower_32_bits(ppaact_phys));
> +
> +	out_be32(&pamu_regs->spbah, upper_32_bits(spaact_phys));
> +	out_be32(&pamu_regs->spbal, lower_32_bits(spaact_phys));
> +	spaact_phys =3D spaact_phys + SPAACT_SIZE;
> +	out_be32(&pamu_regs->splah, upper_32_bits(spaact_phys));
> +	out_be32(&pamu_regs->splal, lower_32_bits(spaact_phys));
> +
> +	out_be32(&pamu_regs->obah, upper_32_bits(omt_phys));
> +	out_be32(&pamu_regs->obal, lower_32_bits(omt_phys));
> +	omt_phys =3D omt_phys + OMT_SIZE;
> +	out_be32(&pamu_regs->olah, upper_32_bits(omt_phys));
> +	out_be32(&pamu_regs->olal, lower_32_bits(omt_phys));
> +
> +	/*
> +	 * set PAMU enable bit,
> +	 * allow ppaact & omt to be cached
> +	 * & enable PAMU access violation interrupts.
> +	 */
> +
> +	out_be32((u32 *)(pamu_reg_base + PAMU_PICS),
> +			PAMU_ACCESS_VIOLATION_ENABLE);
> +	out_be32(pc, PAMU_PC_PE | PAMU_PC_OCE | PAMU_PC_SPCC |
> PAMU_PC_PPCC);
> +	return 0;
> +}
> +
> +/* Enable all device LIODNS */
> +static void __init setup_liodns(void)
> +{
> +	int i, len;
> +	struct paace *ppaace;
> +	struct device_node *node =3D NULL;
> +	const u32 *prop;
> +
> +	for_each_node_with_property(node, "fsl,liodn") {
> +		prop =3D of_get_property(node, "fsl,liodn", &len);
> +		for (i =3D 0; i < len / sizeof(u32); i++) {
> +			int liodn;
> +
> +			liodn =3D be32_to_cpup(&prop[i]);
> +			if (liodn >=3D PAACE_NUMBER_ENTRIES) {
> +				pr_debug("Invalid LIODN value %d\n", liodn);
> +				continue;
> +			}
> +			ppaace =3D pamu_get_ppaace(liodn);
> +			pamu_init_ppaace(ppaace);
> +			/* window size is 2^(WSE+1) bytes */
> +			set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE, 35);
> +			ppaace->wbah =3D 0;
> +			set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
> +			set_bf(ppaace->impl_attr, PAACE_IA_ATM,
> +				PAACE_ATM_NO_XLATE);
> +			set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
> +				PAACE_AP_PERMS_ALL);
> +			if (of_device_is_compatible(node, "fsl,qman-portal"))
> +				setup_qbman_paace(ppaace, QMAN_PORTAL_PAACE);
> +			if (of_device_is_compatible(node, "fsl,qman"))
> +				setup_qbman_paace(ppaace, QMAN_PAACE);
> +			if (of_device_is_compatible(node, "fsl,bman"))
> +				setup_qbman_paace(ppaace, BMAN_PAACE);
> +			mb();
> +			pamu_enable_liodn(liodn);
> +		}
> +	}
> +}
> +
> +irqreturn_t pamu_av_isr(int irq, void *arg)
> +{
> +	struct pamu_isr_data *data =3D arg;
> +	phys_addr_t phys;
> +	unsigned int i, j, ret;
> +
> +	pr_emerg("fsl-pamu: access violation interrupt\n");
> +
> +	for (i =3D 0; i < data->count; i++) {
> +		void __iomem *p =3D data->pamu_reg_base + i * PAMU_OFFSET;
> +		u32 pics =3D in_be32(p + PAMU_PICS);
> +
> +		if (pics & PAMU_ACCESS_VIOLATION_STAT) {
> +			u32 avs1 =3D in_be32(p + PAMU_AVS1);
> +			struct paace *paace;
> +
> +			pr_emerg("POES1=3D%08x\n", in_be32(p + PAMU_POES1));
> +			pr_emerg("POES2=3D%08x\n", in_be32(p + PAMU_POES2));
> +			pr_emerg("AVS1=3D%08x\n", avs1);
> +			pr_emerg("AVS2=3D%08x\n", in_be32(p + PAMU_AVS2));
> +			pr_emerg("AVA=3D%016llx\n", make64(in_be32(p +
> PAMU_AVAH),
> +				in_be32(p + PAMU_AVAL)));
> +			pr_emerg("UDAD=3D%08x\n", in_be32(p + PAMU_UDAD));
> +			pr_emerg("POEA=3D%016llx\n", make64(in_be32(p +
> PAMU_POEAH),
> +				in_be32(p + PAMU_POEAL)));
> +
> +			phys =3D make64(in_be32(p + PAMU_POEAH),
> +				in_be32(p + PAMU_POEAL));
> +
> +			/* Assume that POEA points to a PAACE */
> +			if (phys) {
> +				u32 *paace =3D phys_to_virt(phys);
> +
> +				/* Only the first four words are relevant */
> +				for (j =3D 0; j < 4; j++)
> +					pr_emerg("PAACE[%u]=3D%08x\n", j,
> in_be32(paace + j));
> +			}
> +
> +			/* clear access violation condition */
> +			out_be32((p + PAMU_AVS1), avs1 & PAMU_AV_MASK);
> +			paace =3D pamu_get_ppaace(avs1 >> PAMU_AVS1_LIODN_SHIFT);
> +			BUG_ON(!paace);
> +			/* check if we got a violation for a disabled LIODN */
> +			if (!get_bf(paace->addr_bitfields, PAACE_AF_V)) {
> +				/*
> +				 * As per hardware erratum A-003638, access
> +				 * violation can be reported for a disabled
> +				 * LIODN. If we hit that condition, disable
> +				 * access violation reporting.
> +				 */
> +				pics &=3D ~PAMU_ACCESS_VIOLATION_ENABLE;
> +			} else {
> +				/* Disable the LIODN */
> +				ret =3D pamu_disable_liodn(avs1 >>
> PAMU_AVS1_LIODN_SHIFT);
> +				BUG_ON(ret);
> +				pr_emerg("Disabling liodn %x\n", avs1 >>
> PAMU_AVS1_LIODN_SHIFT);
> +			}
> +			out_be32((p + PAMU_PICS), pics);
> +		}
> +	}
> +
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#define LAWAR_EN		0x80000000
> +#define LAWAR_TARGET_MASK	0x0FF00000
> +#define LAWAR_TARGET_SHIFT	20
> +#define LAWAR_SIZE_MASK		0x0000003F
> +#define LAWAR_CSDID_MASK	0x000FF000
> +#define LAWAR_CSDID_SHIFT	12
> +
> +#define LAW_SIZE_4K		0xb
> +
> +struct ccsr_law {
> +	u32	lawbarh;	/* LAWn base address high */
> +	u32	lawbarl;	/* LAWn base address low */
> +	u32	lawar;		/* LAWn attributes */
> +	u32	reserved;
> +};
> +
> +/*
> + * Create a coherence subdomain for a given memory block.
> + */
> +static int __init create_csd(phys_addr_t phys, size_t size, u32
> csd_port_id)
> +{
> +	struct device_node *np;
> +	const __be32 *iprop;
> +	void __iomem *lac =3D NULL;	/* Local Access Control registers */
> +	struct ccsr_law __iomem *law;
> +	void __iomem *ccm =3D NULL;
> +	u32 __iomem *csdids;
> +	unsigned int i, num_laws, num_csds;
> +	u32 law_target =3D 0;
> +	u32 csd_id =3D 0;
> +	int ret =3D 0;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,corenet-law");
> +	if (!np)
> +		return -ENODEV;
> +
> +	iprop =3D of_get_property(np, "fsl,num-laws", NULL);
> +	if (!iprop) {
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	num_laws =3D be32_to_cpup(iprop);
> +	if (!num_laws) {
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	lac =3D of_iomap(np, 0);
> +	if (!lac) {
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	/* LAW registers are at offset 0xC00 */
> +	law =3D lac + 0xC00;
> +
> +	of_node_put(np);
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,corenet-cf");
> +	if (!np) {
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	iprop =3D of_get_property(np, "fsl,ccf-num-csdids", NULL);
> +	if (!iprop) {
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	num_csds =3D be32_to_cpup(iprop);
> +	if (!num_csds) {
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	ccm =3D of_iomap(np, 0);
> +	if (!ccm) {
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* The undocumented CSDID registers are at offset 0x600 */
> +	csdids =3D ccm + 0x600;
> +
> +	of_node_put(np);
> +	np =3D NULL;
> +
> +	/* Find an unused coherence subdomain ID */
> +	for (csd_id =3D 0; csd_id < num_csds; csd_id++) {
> +		if (!csdids[csd_id])
> +			break;
> +	}
> +
> +	/* Store the Port ID in the (undocumented) proper CIDMRxx register
> */
> +	csdids[csd_id] =3D csd_port_id;
> +
> +	/* Find the DDR LAW that maps to our buffer. */
> +	for (i =3D 0; i < num_laws; i++) {
> +		if (law[i].lawar & LAWAR_EN) {
> +			phys_addr_t law_start, law_end;
> +
> +			law_start =3D make64(law[i].lawbarh, law[i].lawbarl);
> +			law_end =3D law_start +
> +				(2ULL << (law[i].lawar & LAWAR_SIZE_MASK));
> +
> +			if (law_start <=3D phys && phys < law_end) {
> +				law_target =3D law[i].lawar & LAWAR_TARGET_MASK;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (i =3D=3D 0 || i =3D=3D num_laws) {
> +		/* This should never happen*/
> +		ret =3D -ENOENT;
> +		goto error;
> +	}
> +
> +	/* Find a free LAW entry */
> +	while (law[--i].lawar & LAWAR_EN) {
> +		if (i =3D=3D 0) {
> +			/* No higher priority LAW slots available */
> +			ret =3D -ENOENT;
> +			goto error;
> +		}
> +	}
> +
> +	law[i].lawbarh =3D upper_32_bits(phys);
> +	law[i].lawbarl =3D lower_32_bits(phys);
> +	wmb();
> +	law[i].lawar =3D LAWAR_EN | law_target | (csd_id <<
> LAWAR_CSDID_SHIFT) |
> +		(LAW_SIZE_4K + get_order(size));
> +	wmb();
> +
> +error:
> +	if (ccm)
> +		iounmap(ccm);
> +
> +	if (lac)
> +		iounmap(lac);
> +
> +	if (np)
> +		of_node_put(np);
> +
> +	return ret;
> +}
> +
> +/*
> + * Table of SVRs and the corresponding PORT_ID values. Port ID
> corresponds to a
> + * bit map of snoopers for a given range of memory mapped by a LAW.
> + *
> + * All future CoreNet-enabled SOCs will have this erratum(A-004510)
> fixed, so this
> + * table should never need to be updated.  SVRs are guaranteed to be
> unique, so
> + * there is no worry that a future SOC will inadvertently have one of
> these
> + * values.
> + */
> +static const struct {
> +	u32 svr;
> +	u32 port_id;
> +} port_id_map[] =3D {
> +	{0x82100010, 0xFF000000},	/* P2040 1.0 */
> +	{0x82100011, 0xFF000000},	/* P2040 1.1 */
> +	{0x82100110, 0xFF000000},	/* P2041 1.0 */
> +	{0x82100111, 0xFF000000},	/* P2041 1.1 */
> +	{0x82110310, 0xFF000000},	/* P3041 1.0 */
> +	{0x82110311, 0xFF000000},	/* P3041 1.1 */
> +	{0x82010020, 0xFFF80000},	/* P4040 2.0 */
> +	{0x82000020, 0xFFF80000},	/* P4080 2.0 */
> +	{0x82210010, 0xFC000000},       /* P5010 1.0 */
> +	{0x82210020, 0xFC000000},       /* P5010 2.0 */
> +	{0x82200010, 0xFC000000},	/* P5020 1.0 */
> +	{0x82050010, 0xFF800000},	/* P5021 1.0 */
> +	{0x82040010, 0xFF800000},	/* P5040 1.0 */
> +};
> +
> +#define SVR_SECURITY	0x80000	/* The Security (E) bit */
> +
> +static int __init fsl_pamu_probe(struct platform_device *pdev)
> +{
> +	void __iomem *pamu_regs =3D NULL;
> +	struct ccsr_guts __iomem *guts_regs =3D NULL;
> +	u32 pamubypenr, pamu_counter;
> +	unsigned long pamu_reg_off;
> +	unsigned long pamu_reg_base;
> +	struct pamu_isr_data *data =3D NULL;
> +	struct device_node *guts_node;
> +	u64 size;
> +	struct page *p;
> +	int ret =3D 0;
> +	int irq;
> +	phys_addr_t ppaact_phys;
> +	phys_addr_t spaact_phys;
> +	phys_addr_t omt_phys;
> +	size_t mem_size =3D 0;
> +	unsigned int order =3D 0;
> +	u32 csd_port_id =3D 0;
> +	unsigned i;
> +	/*
> +	 * enumerate all PAMUs and allocate and setup PAMU tables
> +	 * for each of them,
> +	 * NOTE : All PAMUs share the same LIODN tables.
> +	 */
> +
> +	pamu_regs =3D of_iomap(pdev->dev.of_node, 0);
> +	if (!pamu_regs) {
> +		dev_err(&pdev->dev, "ioremap of PAMU node failed\n");
> +		return -ENOMEM;
> +	}
> +	of_get_address(pdev->dev.of_node, 0, &size, NULL);
> +
> +	irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (irq =3D=3D NO_IRQ) {
> +		dev_warn(&pdev->dev, "no interrupts listed in PAMU node\n");
> +		goto error;
> +	}
> +
> +	data =3D kzalloc(sizeof(struct pamu_isr_data), GFP_KERNEL);
> +	if (!data) {
> +		dev_err(&pdev->dev, "PAMU isr data memory allocation
> failed\n");
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +	data->pamu_reg_base =3D pamu_regs;
> +	data->count =3D size / PAMU_OFFSET;
> +
> +	/* The ISR needs access to the regs, so we won't iounmap them */
> +	ret =3D request_irq(irq, pamu_av_isr, 0, "pamu", data);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "error %i installing ISR for irq %i\n",
> +			ret, irq);
> +		goto error;
> +	}
> +
> +	guts_node =3D of_find_matching_node(NULL, guts_device_ids);
> +	if (!guts_node) {
> +		dev_err(&pdev->dev, "could not find GUTS node %s\n",
> +			pdev->dev.of_node->full_name);
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	guts_regs =3D of_iomap(guts_node, 0);
> +	of_node_put(guts_node);
> +	if (!guts_regs) {
> +		dev_err(&pdev->dev, "ioremap of GUTS node failed\n");
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	/* read in the PAMU capability registers */
> +	get_pamu_cap_values((unsigned long)pamu_regs);
> +	/*
> +	 * To simplify the allocation of a coherency domain, we allocate
> the
> +	 * PAACT and the OMT in the same memory buffer.  Unfortunately,
> this
> +	 * wastes more memory compared to allocating the buffers
> separately.
> +	 */
> +	/* Determine how much memory we need */
> +	mem_size =3D (PAGE_SIZE << get_order(PAACT_SIZE)) +
> +		(PAGE_SIZE << get_order(SPAACT_SIZE)) +
> +		(PAGE_SIZE << get_order(OMT_SIZE));
> +	order =3D get_order(mem_size);
> +
> +	p =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	if (!p) {
> +		dev_err(&pdev->dev, "unable to allocate PAACT/SPAACT/OMT
> block\n");
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	ppaact =3D page_address(p);
> +	ppaact_phys =3D page_to_phys(p);
> +
> +	/* Make sure the memory is naturally aligned */
> +	if (ppaact_phys & ((PAGE_SIZE << order) - 1)) {
> +		dev_err(&pdev->dev, "PAACT/OMT block is unaligned\n");
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	spaact =3D (void *)ppaact + (PAGE_SIZE << get_order(PAACT_SIZE));
> +	omt =3D (void *)spaact + (PAGE_SIZE << get_order(SPAACT_SIZE));
> +
> +	dev_dbg(&pdev->dev, "ppaact virt=3D%p phys=3D0x%llx\n", ppaact,
> +		(unsigned long long) ppaact_phys);
> +
> +	/* Check to see if we need to implement the work-around on this SOC
> */
> +
> +	/* Determine the Port ID for our coherence subdomain */
> +	for (i =3D 0; i < ARRAY_SIZE(port_id_map); i++) {
> +		if (port_id_map[i].svr =3D=3D (mfspr(SPRN_SVR) & ~SVR_SECURITY))
> {
> +			csd_port_id =3D port_id_map[i].port_id;
> +			dev_dbg(&pdev->dev, "found matching SVR %08x\n",
> +				port_id_map[i].svr);
> +			break;
> +		}
> +	}
> +
> +	if (csd_port_id) {
> +		dev_dbg(&pdev->dev, "creating coherency subdomain at address
> "
> +			"0x%llx, size %zu, port id 0x%08x", ppaact_phys,
> +			mem_size, csd_port_id);
> +
> +		ret =3D create_csd(ppaact_phys, mem_size, csd_port_id);
> +		if (ret) {
> +			dev_err(&pdev->dev, "could not create coherence "
> +				"subdomain\n");
> +			return ret;
> +		}
> +	}
> +
> +	spaact_phys =3D virt_to_phys(spaact);
> +	omt_phys =3D virt_to_phys(omt);
> +
> +	spaace_pool =3D gen_pool_create(ilog2(sizeof(struct paace)), -1);
> +	if (!spaace_pool) {
> +		ret =3D -ENOMEM;
> +		dev_err(&pdev->dev, "PAMU : failed to allocate spaace gen
> pool\n");
> +		goto error;
> +	}
> +
> +	ret =3D gen_pool_add(spaace_pool, (unsigned long)spaact, SPAACT_SIZE,
> -1);
> +	if (ret)
> +		goto error_genpool;
> +
> +	pamubypenr =3D in_be32(&guts_regs->pamubypenr);
> +
> +	for (pamu_reg_off =3D 0, pamu_counter =3D 0x80000000; pamu_reg_off <
> size;
> +	     pamu_reg_off +=3D PAMU_OFFSET, pamu_counter >>=3D 1) {
> +
> +		pamu_reg_base =3D (unsigned long) pamu_regs + pamu_reg_off;
> +		setup_one_pamu(pamu_reg_base, pamu_reg_off, ppaact_phys,
> +				 spaact_phys, omt_phys);
> +		/* Disable PAMU bypass for this PAMU */
> +		pamubypenr &=3D ~pamu_counter;
> +	}
> +
> +	setup_omt(omt);
> +
> +	/* Enable all relevant PAMU(s) */
> +	out_be32(&guts_regs->pamubypenr, pamubypenr);
> +
> +	iounmap(guts_regs);
> +
> +	/* Enable DMA for the LIODNs in the device tree*/
> +
> +	setup_liodns();
> +
> +	return 0;
> +
> +error_genpool:
> +	gen_pool_destroy(spaace_pool);
> +
> +error:
> +	if (irq !=3D NO_IRQ)
> +		free_irq(irq, data);
> +
> +	if (data) {
> +		memset(data, 0, sizeof(struct pamu_isr_data));
> +		kfree(data);
> +	}
> +
> +	if (pamu_regs)
> +		iounmap(pamu_regs);
> +
> +	if (guts_regs)
> +		iounmap(guts_regs);
> +
> +	if (ppaact)
> +		free_pages((unsigned long)ppaact, order);
> +
> +	ppaact =3D NULL;
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id fsl_of_pamu_ids[] =3D {
> +	{
> +		.compatible =3D "fsl,p4080-pamu",
> +	},
> +	{
> +		.compatible =3D "fsl,pamu",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver fsl_of_pamu_driver =3D {
> +	.driver =3D {
> +		.name =3D "fsl-of-pamu",
> +		.owner =3D THIS_MODULE,
> +	},
> +	.probe =3D fsl_pamu_probe,
> +};
> +
> +static __init int fsl_pamu_init(void)
> +{
> +	struct platform_device *pdev =3D NULL;
> +	struct device_node *np;
> +	int ret;
> +
> +	/*
> +	 * The normal OF process calls the probe function at some
> +	 * indeterminate later time, after most drivers have loaded.  This
> is
> +	 * too late for us, because PAMU clients (like the Qman driver)
> +	 * depend on PAMU being initialized early.
> +	 *
> +	 * So instead, we "manually" call our probe function by creating
> the
> +	 * platform devices ourselves.
> +	 */
> +
> +	/*
> +	 * We assume that there is only one PAMU node in the device tree.
> A
> +	 * single PAMU node represents all of the PAMU devices in the SOC
> +	 * already.   Everything else already makes that assumption, and
> the
> +	 * binding for the PAMU nodes doesn't allow for any parent-child
> +	 * relationships anyway.  In other words, support for more than one
> +	 * PAMU node would require significant changes to a lot of code.
> +	 */
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,pamu");
> +	if (!np) {
> +		pr_err("fsl-pamu: could not find a PAMU node\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D platform_driver_register(&fsl_of_pamu_driver);
> +	if (ret) {
> +		pr_err("fsl-pamu: could not register driver (err=3D%i)\n",
> ret);
> +		goto error_driver_register;
> +	}
> +
> +	pdev =3D platform_device_alloc("fsl-of-pamu", 0);
> +	if (!pdev) {
> +		pr_err("fsl-pamu: could not allocate device %s\n",
> +		       np->full_name);
> +		ret =3D -ENOMEM;
> +		goto error_device_alloc;
> +	}
> +	pdev->dev.of_node =3D of_node_get(np);
> +
> +	ret =3D pamu_domain_init();
> +	if (ret)
> +		goto error_device_add;
> +
> +	ret =3D platform_device_add(pdev);
> +	if (ret) {
> +		pr_err("fsl-pamu: could not add device %s (err=3D%i)\n",
> +		       np->full_name, ret);
> +		goto error_device_add;
> +	}
> +
> +	return 0;
> +
> +error_device_add:
> +	of_node_put(pdev->dev.of_node);
> +	pdev->dev.of_node =3D NULL;
> +
> +	platform_device_put(pdev);
> +
> +error_device_alloc:
> +	platform_driver_unregister(&fsl_of_pamu_driver);
> +
> +error_driver_register:
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +arch_initcall(fsl_pamu_init);
> diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
> new file mode 100644
> index 0000000..8fc1a12
> --- /dev/null
> +++ b/drivers/iommu/fsl_pamu.h
> @@ -0,0 +1,410 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
> USA.
> + *
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + */
> +
> +#ifndef __FSL_PAMU_H
> +#define __FSL_PAMU_H
> +
> +#include <asm/fsl_pamu_stash.h>
> +
> +/* Bit Field macros
> + *	v =3D bit field variable; m =3D mask, m##_SHIFT =3D shift, x =3D valu=
e to
> load
> + */
> +#define set_bf(v, m, x)		(v =3D ((v) & ~(m)) | (((x) <<
> (m##_SHIFT)) & (m)))
> +#define get_bf(v, m)		(((v) & (m)) >> (m##_SHIFT))
> +
> +/* PAMU CCSR space */
> +#define PAMU_PGC 0x00000000     /* Allows all peripheral accesses */
> +#define PAMU_PE 0x40000000      /* enable PAMU                    */
> +
> +/* PAMU_OFFSET to the next pamu space in ccsr */
> +#define PAMU_OFFSET 0x1000
> +
> +#define PAMU_MMAP_REGS_BASE 0
> +
> +struct pamu_mmap_regs {
> +	u32 ppbah;
> +	u32 ppbal;
> +	u32 pplah;
> +	u32 pplal;
> +	u32 spbah;
> +	u32 spbal;
> +	u32 splah;
> +	u32 splal;
> +	u32 obah;
> +	u32 obal;
> +	u32 olah;
> +	u32 olal;
> +};
> +
> +/* PAMU Error Registers */
> +#define PAMU_POES1 0x0040
> +#define PAMU_POES2 0x0044
> +#define PAMU_POEAH 0x0048
> +#define PAMU_POEAL 0x004C
> +#define PAMU_AVS1  0x0050
> +#define PAMU_AVS1_AV    0x1
> +#define PAMU_AVS1_OTV   0x6
> +#define PAMU_AVS1_APV   0x78
> +#define PAMU_AVS1_WAV   0x380
> +#define PAMU_AVS1_LAV   0x1c00
> +#define PAMU_AVS1_GCV   0x2000
> +#define PAMU_AVS1_PDV   0x4000
> +#define PAMU_AV_MASK    (PAMU_AVS1_AV | PAMU_AVS1_OTV | PAMU_AVS1_APV |
> PAMU_AVS1_WAV \
> +			| PAMU_AVS1_LAV | PAMU_AVS1_GCV | PAMU_AVS1_PDV)
> +#define PAMU_AVS1_LIODN_SHIFT 16
> +#define PAMU_LAV_LIODN_NOT_IN_PPAACT 0x400
> +
> +#define PAMU_AVS2  0x0054
> +#define PAMU_AVAH  0x0058
> +#define PAMU_AVAL  0x005C
> +#define PAMU_EECTL 0x0060
> +#define PAMU_EEDIS 0x0064
> +#define PAMU_EEINTEN 0x0068
> +#define PAMU_EEDET 0x006C
> +#define PAMU_EEATTR 0x0070
> +#define PAMU_EEAHI 0x0074
> +#define PAMU_EEALO 0x0078
> +#define PAMU_EEDHI 0X007C
> +#define PAMU_EEDLO 0x0080
> +#define PAMU_EECC  0x0084
> +#define PAMU_UDAD  0x0090
> +
> +/* PAMU Revision Registers */
> +#define PAMU_PR1 0x0BF8
> +#define PAMU_PR2 0x0BFC
> +
> +/* PAMU version mask */
> +#define PAMU_PR1_MASK 0xffff
> +
> +/* PAMU Capabilities Registers */
> +#define PAMU_PC1 0x0C00
> +#define PAMU_PC2 0x0C04
> +#define PAMU_PC3 0x0C08
> +#define PAMU_PC4 0x0C0C
> +
> +/* PAMU Control Register */
> +#define PAMU_PC 0x0C10
> +
> +/* PAMU control defs */
> +#define PAMU_CONTROL 0x0C10
> +#define PAMU_PC_PGC 0x80000000  /* PAMU gate closed bit */
> +#define PAMU_PC_PE   0x40000000 /* PAMU enable bit */
> +#define PAMU_PC_SPCC 0x00000010 /* sPAACE cache enable */
> +#define PAMU_PC_PPCC 0x00000001 /* pPAACE cache enable */
> +#define PAMU_PC_OCE  0x00001000 /* OMT cache enable */
> +
> +#define PAMU_PFA1 0x0C14
> +#define PAMU_PFA2 0x0C18
> +
> +#define PAMU_PC2_MLIODN(X) ((X) >> 16)
> +#define PAMU_PC3_MWCE(X) (((X) >> 21) & 0xf)
> +
> +/* PAMU Interrupt control and Status Register */
> +#define PAMU_PICS 0x0C1C
> +#define PAMU_ACCESS_VIOLATION_STAT   0x8
> +#define PAMU_ACCESS_VIOLATION_ENABLE 0x4
> +
> +/* PAMU Debug Registers */
> +#define PAMU_PD1 0x0F00
> +#define PAMU_PD2 0x0F04
> +#define PAMU_PD3 0x0F08
> +#define PAMU_PD4 0x0F0C
> +
> +#define PAACE_AP_PERMS_DENIED  0x0
> +#define PAACE_AP_PERMS_QUERY   0x1
> +#define PAACE_AP_PERMS_UPDATE  0x2
> +#define PAACE_AP_PERMS_ALL     0x3
> +
> +#define PAACE_DD_TO_HOST       0x0
> +#define PAACE_DD_TO_IO         0x1
> +#define PAACE_PT_PRIMARY       0x0
> +#define PAACE_PT_SECONDARY     0x1
> +#define PAACE_V_INVALID        0x0
> +#define PAACE_V_VALID          0x1
> +#define PAACE_MW_SUBWINDOWS    0x1
> +
> +#define PAACE_WSE_4K           0xB
> +#define PAACE_WSE_8K           0xC
> +#define PAACE_WSE_16K          0xD
> +#define PAACE_WSE_32K          0xE
> +#define PAACE_WSE_64K          0xF
> +#define PAACE_WSE_128K         0x10
> +#define PAACE_WSE_256K         0x11
> +#define PAACE_WSE_512K         0x12
> +#define PAACE_WSE_1M           0x13
> +#define PAACE_WSE_2M           0x14
> +#define PAACE_WSE_4M           0x15
> +#define PAACE_WSE_8M           0x16
> +#define PAACE_WSE_16M          0x17
> +#define PAACE_WSE_32M          0x18
> +#define PAACE_WSE_64M          0x19
> +#define PAACE_WSE_128M         0x1A
> +#define PAACE_WSE_256M         0x1B
> +#define PAACE_WSE_512M         0x1C
> +#define PAACE_WSE_1G           0x1D
> +#define PAACE_WSE_2G           0x1E
> +#define PAACE_WSE_4G           0x1F
> +
> +#define PAACE_DID_PCI_EXPRESS_1 0x00
> +#define PAACE_DID_PCI_EXPRESS_2 0x01
> +#define PAACE_DID_PCI_EXPRESS_3 0x02
> +#define PAACE_DID_PCI_EXPRESS_4 0x03
> +#define PAACE_DID_LOCAL_BUS     0x04
> +#define PAACE_DID_SRIO          0x0C
> +#define PAACE_DID_MEM_1         0x10
> +#define PAACE_DID_MEM_2         0x11
> +#define PAACE_DID_MEM_3         0x12
> +#define PAACE_DID_MEM_4         0x13
> +#define PAACE_DID_MEM_1_2       0x14
> +#define PAACE_DID_MEM_3_4       0x15
> +#define PAACE_DID_MEM_1_4       0x16
> +#define PAACE_DID_BM_SW_PORTAL  0x18
> +#define PAACE_DID_PAMU          0x1C
> +#define PAACE_DID_CAAM          0x21
> +#define PAACE_DID_QM_SW_PORTAL  0x3C
> +#define PAACE_DID_CORE0_INST    0x80
> +#define PAACE_DID_CORE0_DATA    0x81
> +#define PAACE_DID_CORE1_INST    0x82
> +#define PAACE_DID_CORE1_DATA    0x83
> +#define PAACE_DID_CORE2_INST    0x84
> +#define PAACE_DID_CORE2_DATA    0x85
> +#define PAACE_DID_CORE3_INST    0x86
> +#define PAACE_DID_CORE3_DATA    0x87
> +#define PAACE_DID_CORE4_INST    0x88
> +#define PAACE_DID_CORE4_DATA    0x89
> +#define PAACE_DID_CORE5_INST    0x8A
> +#define PAACE_DID_CORE5_DATA    0x8B
> +#define PAACE_DID_CORE6_INST    0x8C
> +#define PAACE_DID_CORE6_DATA    0x8D
> +#define PAACE_DID_CORE7_INST    0x8E
> +#define PAACE_DID_CORE7_DATA    0x8F
> +#define PAACE_DID_BROADCAST     0xFF
> +
> +#define PAACE_ATM_NO_XLATE      0x00
> +#define PAACE_ATM_WINDOW_XLATE  0x01
> +#define PAACE_ATM_PAGE_XLATE    0x02
> +#define PAACE_ATM_WIN_PG_XLATE  \
> +                (PAACE_ATM_WINDOW_XLATE | PAACE_ATM_PAGE_XLATE)
> +#define PAACE_OTM_NO_XLATE      0x00
> +#define PAACE_OTM_IMMEDIATE     0x01
> +#define PAACE_OTM_INDEXED       0x02
> +#define PAACE_OTM_RESERVED      0x03
> +
> +#define PAACE_M_COHERENCE_REQ   0x01
> +
> +#define PAACE_PID_0             0x0
> +#define PAACE_PID_1             0x1
> +#define PAACE_PID_2             0x2
> +#define PAACE_PID_3             0x3
> +#define PAACE_PID_4             0x4
> +#define PAACE_PID_5             0x5
> +#define PAACE_PID_6             0x6
> +#define PAACE_PID_7             0x7
> +
> +#define PAACE_TCEF_FORMAT0_8B   0x00
> +#define PAACE_TCEF_FORMAT1_RSVD 0x01
> +/*
> + * Hard coded value for the PAACT size to accomodate
> + * maximum LIODN value generated by u-boot.
> + */
> +#define PAACE_NUMBER_ENTRIES    0x500
> +/* Hard coded value for the SPAACT size */
> +#define SPAACE_NUMBER_ENTRIES	0x800
> +
> +#define	OME_NUMBER_ENTRIES      16
> +
> +/* PAACE Bit Field Defines */
> +#define PPAACE_AF_WBAL			0xfffff000
> +#define PPAACE_AF_WBAL_SHIFT		12
> +#define PPAACE_AF_WSE			0x00000fc0
> +#define PPAACE_AF_WSE_SHIFT		6
> +#define PPAACE_AF_MW			0x00000020
> +#define PPAACE_AF_MW_SHIFT		5
> +
> +#define SPAACE_AF_LIODN			0xffff0000
> +#define SPAACE_AF_LIODN_SHIFT		16
> +
> +#define PAACE_AF_AP			0x00000018
> +#define PAACE_AF_AP_SHIFT		3
> +#define PAACE_AF_DD			0x00000004
> +#define PAACE_AF_DD_SHIFT		2
> +#define PAACE_AF_PT			0x00000002
> +#define PAACE_AF_PT_SHIFT		1
> +#define PAACE_AF_V			0x00000001
> +#define PAACE_AF_V_SHIFT		0
> +
> +#define PAACE_DA_HOST_CR		0x80
> +#define PAACE_DA_HOST_CR_SHIFT		7
> +
> +#define PAACE_IA_CID			0x00FF0000
> +#define PAACE_IA_CID_SHIFT		16
> +#define PAACE_IA_WCE			0x000000F0
> +#define PAACE_IA_WCE_SHIFT		4
> +#define PAACE_IA_ATM			0x0000000C
> +#define PAACE_IA_ATM_SHIFT		2
> +#define PAACE_IA_OTM			0x00000003
> +#define PAACE_IA_OTM_SHIFT		0
> +
> +#define PAACE_WIN_TWBAL			0xfffff000
> +#define PAACE_WIN_TWBAL_SHIFT		12
> +#define PAACE_WIN_SWSE			0x00000fc0
> +#define PAACE_WIN_SWSE_SHIFT		6
> +
> +/* PAMU Data Structures */
> +/* primary / secondary paact structure */
> +struct paace {
> +	/* PAACE Offset 0x00 */
> +	u32 wbah;				/* only valid for Primary PAACE */
> +	u32 addr_bitfields;		/* See P/S PAACE_AF_* */
> +
> +	/* PAACE Offset 0x08 */
> +	/* Interpretation of first 32 bits dependent on DD above */
> +	union {
> +		struct {
> +			/* Destination ID, see PAACE_DID_* defines */
> +			u8 did;
> +			/* Partition ID */
> +			u8 pid;
> +			/* Snoop ID */
> +			u8 snpid;
> +			/* coherency_required : 1 reserved : 7 */
> +			u8 coherency_required; /* See PAACE_DA_* */
> +		} to_host;
> +		struct {
> +			/* Destination ID, see PAACE_DID_* defines */
> +			u8  did;
> +			u8  reserved1;
> +			u16 reserved2;
> +		} to_io;
> +	} domain_attr;
> +
> +	/* Implementation attributes + window count + address & operation
> translation modes */
> +	u32 impl_attr;			/* See PAACE_IA_* */
> +
> +	/* PAACE Offset 0x10 */
> +	/* Translated window base address */
> +	u32 twbah;
> +	u32 win_bitfields;			/* See PAACE_WIN_* */
> +
> +	/* PAACE Offset 0x18 */
> +	/* first secondary paace entry */
> +	u32 fspi;				/* only valid for Primary PAACE */
> +	union {
> +		struct {
> +			u8 ioea;
> +			u8 moea;
> +			u8 ioeb;
> +			u8 moeb;
> +		} immed_ot;
> +		struct {
> +			u16 reserved;
> +			u16 omi;
> +		} index_ot;
> +	} op_encode;
> +
> +	/* PAACE Offsets 0x20-0x38 */
> +	u32 reserved[8];			/* not currently implemented */
> +};
> +
> +/* OME : Operation mapping entry
> + * MOE : Mapped Operation Encodings
> + * The operation mapping table is table containing operation mapping
> entries (OME).
> + * The index of a particular OME is programmed in the PAACE entry for
> translation
> + * in bound I/O operations corresponding to an LIODN. The OMT is used
> for translation
> + * specifically in case of the indexed translation mode. Each OME
> contains a 128
> + * byte mapped operation encoding (MOE), where each byte represents an
> MOE.
> + */
> +#define NUM_MOE 128
> +struct ome {
> +	u8 moe[NUM_MOE];
> +} __attribute__((packed));
> +
> +#define PAACT_SIZE              (sizeof(struct paace) *
> PAACE_NUMBER_ENTRIES)
> +#define SPAACT_SIZE              (sizeof(struct paace) *
> SPAACE_NUMBER_ENTRIES)
> +#define OMT_SIZE                (sizeof(struct ome) *
> OME_NUMBER_ENTRIES)
> +
> +#define PAMU_PAGE_SHIFT 12
> +#define PAMU_PAGE_SIZE  4096ULL
> +
> +#define IOE_READ        0x00
> +#define IOE_READ_IDX    0x00
> +#define IOE_WRITE       0x81
> +#define IOE_WRITE_IDX   0x01
> +#define IOE_EREAD0      0x82    /* Enhanced read type 0 */
> +#define IOE_EREAD0_IDX  0x02    /* Enhanced read type 0 */
> +#define IOE_EWRITE0     0x83    /* Enhanced write type 0 */
> +#define IOE_EWRITE0_IDX 0x03    /* Enhanced write type 0 */
> +#define IOE_DIRECT0     0x84    /* Directive type 0 */
> +#define IOE_DIRECT0_IDX 0x04    /* Directive type 0 */
> +#define IOE_EREAD1      0x85    /* Enhanced read type 1 */
> +#define IOE_EREAD1_IDX  0x05    /* Enhanced read type 1 */
> +#define IOE_EWRITE1     0x86    /* Enhanced write type 1 */
> +#define IOE_EWRITE1_IDX 0x06    /* Enhanced write type 1 */
> +#define IOE_DIRECT1     0x87    /* Directive type 1 */
> +#define IOE_DIRECT1_IDX 0x07    /* Directive type 1 */
> +#define IOE_RAC         0x8c    /* Read with Atomic clear */
> +#define IOE_RAC_IDX     0x0c    /* Read with Atomic clear */
> +#define IOE_RAS         0x8d    /* Read with Atomic set */
> +#define IOE_RAS_IDX     0x0d    /* Read with Atomic set */
> +#define IOE_RAD         0x8e    /* Read with Atomic decrement */
> +#define IOE_RAD_IDX     0x0e    /* Read with Atomic decrement */
> +#define IOE_RAI         0x8f    /* Read with Atomic increment */
> +#define IOE_RAI_IDX     0x0f    /* Read with Atomic increment */
> +
> +#define EOE_READ        0x00
> +#define EOE_WRITE       0x01
> +#define EOE_RAC         0x0c    /* Read with Atomic clear */
> +#define EOE_RAS         0x0d    /* Read with Atomic set */
> +#define EOE_RAD         0x0e    /* Read with Atomic decrement */
> +#define EOE_RAI         0x0f    /* Read with Atomic increment */
> +#define EOE_LDEC        0x10    /* Load external cache */
> +#define EOE_LDECL       0x11    /* Load external cache with stash lock
> */
> +#define EOE_LDECPE      0x12    /* Load external cache with preferred
> exclusive */
> +#define EOE_LDECPEL     0x13    /* Load external cache with preferred
> exclusive and lock */
> +#define EOE_LDECFE      0x14    /* Load external cache with forced
> exclusive */
> +#define EOE_LDECFEL     0x15    /* Load external cache with forced
> exclusive and lock */
> +#define EOE_RSA         0x16    /* Read with stash allocate */
> +#define EOE_RSAU        0x17    /* Read with stash allocate and unlock
> */
> +#define EOE_READI       0x18    /* Read with invalidate */
> +#define EOE_RWNITC      0x19    /* Read with no intention to cache */
> +#define EOE_WCI         0x1a    /* Write cache inhibited */
> +#define EOE_WWSA        0x1b    /* Write with stash allocate */
> +#define EOE_WWSAL       0x1c    /* Write with stash allocate and lock */
> +#define EOE_WWSAO       0x1d    /* Write with stash allocate only */
> +#define EOE_WWSAOL      0x1e    /* Write with stash allocate only and
> lock */
> +#define EOE_VALID       0x80
> +
> +/* Function prototypes */
> +int pamu_domain_init(void);
> +int pamu_enable_liodn(int liodn);
> +int pamu_disable_liodn(int liodn);
> +void pamu_free_subwins(int liodn);
> +int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t
> win_size,
> +		       u32 omi, unsigned long rpn, u32 snoopid, uint32_t
> stashid,
> +		       u32 subwin_cnt, int prot);
> +int pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin_addr,
> +		       phys_addr_t subwin_size, u32 omi, unsigned long rpn,
> +		       uint32_t snoopid, u32 stashid, int enable, int prot);
> +
> +u32 get_stash_id(u32 stash_dest_hint, u32 vcpu);
> +void get_ome_index(u32 *omi_index, struct device *dev);
> +int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value);
> +int pamu_disable_spaace(int liodn, u32 subwin);
> +u32 pamu_get_max_subwin_cnt(void);
> +
> +#endif  /* __FSL_PAMU_H */
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c
> new file mode 100644
> index 0000000..14d803a
> --- /dev/null
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -0,0 +1,1172 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
> USA.
> + *
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + * Author: Varun Sethi <varun.sethi@freescale.com>
> + *
> + */
> +
> +#define pr_fmt(fmt)    "fsl-pamu-domain: %s: " fmt, __func__
> +
> +#include <linux/init.h>
> +#include <linux/iommu.h>
> +#include <linux/notifier.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/of_platform.h>
> +#include <linux/bootmem.h>
> +#include <linux/err.h>
> +#include <asm/io.h>
> +#include <asm/bitops.h>
> +
> +#include <asm/pci-bridge.h>
> +#include <sysdev/fsl_pci.h>
> +
> +#include "fsl_pamu_domain.h"
> +#include "pci.h"
> +
> +/*
> + * Global spinlock that needs to be held while
> + * configuring PAMU.
> + */
> +static DEFINE_SPINLOCK(iommu_lock);
> +
> +static struct kmem_cache *fsl_pamu_domain_cache;
> +static struct kmem_cache *iommu_devinfo_cache;
> +static DEFINE_SPINLOCK(device_domain_lock);
> +
> +static int __init iommu_init_mempool(void)
> +{
> +
> +	fsl_pamu_domain_cache =3D kmem_cache_create("fsl_pamu_domain",
> +					 sizeof(struct fsl_dma_domain),
> +					 0,
> +					 SLAB_HWCACHE_ALIGN,
> +
> +					 NULL);
> +	if (!fsl_pamu_domain_cache) {
> +		pr_debug("Couldn't create fsl iommu_domain cache\n");
> +		return -ENOMEM;
> +	}
> +
> +	iommu_devinfo_cache =3D kmem_cache_create("iommu_devinfo",
> +					 sizeof(struct device_domain_info),
> +					 0,
> +					 SLAB_HWCACHE_ALIGN,
> +					 NULL);
> +	if (!iommu_devinfo_cache) {
> +		pr_debug("Couldn't create devinfo cache\n");
> +		kmem_cache_destroy(fsl_pamu_domain_cache);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain,
> dma_addr_t iova)
> +{
> +	u32 win_cnt =3D dma_domain->win_cnt;
> +	struct dma_window *win_ptr =3D
> +				&dma_domain->win_arr[0];
> +	struct iommu_domain_geometry *geom;
> +
> +	geom =3D &dma_domain->iommu_domain->geometry;
> +
> +	if (!win_cnt || !dma_domain->geom_size) {
> +		pr_debug("Number of windows/geometry not configured for the
> domain\n");
> +		return 0;
> +	}
> +
> +	if (win_cnt > 1) {
> +		u64 subwin_size;
> +		dma_addr_t subwin_iova;
> +		u32 wnd;
> +
> +		subwin_size =3D dma_domain->geom_size >> ilog2(win_cnt);
> +		subwin_iova =3D iova & ~(subwin_size - 1);
> +		wnd =3D (subwin_iova - geom->aperture_start) >>
> ilog2(subwin_size);
> +		win_ptr =3D &dma_domain->win_arr[wnd];
> +	}
> +
> +	if (win_ptr->valid)
> +		return (win_ptr->paddr + (iova & (win_ptr->size - 1)));
> +
> +	return 0;
> +}
> +
> +static int map_subwins(int liodn, struct fsl_dma_domain *dma_domain)
> +{
> +	struct dma_window *sub_win_ptr =3D
> +				&dma_domain->win_arr[0];
> +	int i, ret;
> +	unsigned long rpn, flags;
> +
> +	for (i =3D 0; i < dma_domain->win_cnt; i++) {
> +		if (sub_win_ptr[i].valid) {
> +			rpn =3D sub_win_ptr[i].paddr >>
> +				 PAMU_PAGE_SHIFT;
> +			spin_lock_irqsave(&iommu_lock, flags);
> +			ret =3D pamu_config_spaace(liodn, dma_domain->win_cnt, i,
> +						 sub_win_ptr[i].size,
> +						 ~(u32)0,
> +						 rpn,
> +						 dma_domain->snoop_id,
> +						 dma_domain->stash_id,
> +						 (i > 0) ? 1 : 0,
> +						 sub_win_ptr[i].prot);
> +			spin_unlock_irqrestore(&iommu_lock, flags);
> +			if (ret) {
> +				pr_debug("PAMU SPAACE configuration failed for
> liodn %d\n",
> +					 liodn);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int map_win(int liodn, struct fsl_dma_domain *dma_domain)
> +{
> +	int ret;
> +	struct dma_window *wnd =3D &dma_domain->win_arr[0];
> +	phys_addr_t wnd_addr =3D dma_domain->iommu_domain-
> >geometry.aperture_start;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu_lock, flags);
> +	ret =3D pamu_config_ppaace(liodn, wnd_addr,
> +				 wnd->size,
> +				 ~(u32)0,
> +				 wnd->paddr >> PAMU_PAGE_SHIFT,
> +				 dma_domain->snoop_id, dma_domain->stash_id,
> +				 0, wnd->prot);
> +	spin_unlock_irqrestore(&iommu_lock, flags);
> +	if (ret)
> +		pr_debug("PAMU PAACE configuration failed for liodn %d\n",
> +			liodn);
> +
> +	return ret;
> +}
> +
> +/* Map the DMA window corresponding to the LIODN */
> +static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
> +{
> +	if (dma_domain->win_cnt > 1)
> +		return map_subwins(liodn, dma_domain);
> +	else
> +		return map_win(liodn, dma_domain);
> +
> +}
> +
> +/* Update window/subwindow mapping for the LIODN */
> +static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain,
> u32 wnd_nr)
> +{
> +	int ret;
> +	struct dma_window *wnd =3D &dma_domain->win_arr[wnd_nr];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu_lock, flags);
> +	if (dma_domain->win_cnt > 1) {
> +		ret =3D pamu_config_spaace(liodn, dma_domain->win_cnt, wnd_nr,
> +					 wnd->size,
> +					 ~(u32)0,
> +					 wnd->paddr >> PAMU_PAGE_SHIFT,
> +					 dma_domain->snoop_id,
> +					 dma_domain->stash_id,
> +					 (wnd_nr > 0) ? 1 : 0,
> +					 wnd->prot);
> +		if (ret)
> +			pr_debug("Subwindow reconfiguration failed for liodn
> %d\n", liodn);
> +	} else {
> +		phys_addr_t wnd_addr;
> +
> +		wnd_addr =3D dma_domain->iommu_domain->geometry.aperture_start;
> +
> +		ret =3D pamu_config_ppaace(liodn, wnd_addr,
> +					 wnd->size,
> +					 ~(u32)0,
> +					 wnd->paddr >> PAMU_PAGE_SHIFT,
> +					dma_domain->snoop_id, dma_domain->stash_id,
> +					0, wnd->prot);
> +		if (ret)
> +			pr_debug("Window reconfiguration failed for liodn
> %d\n", liodn);
> +	}
> +
> +	spin_unlock_irqrestore(&iommu_lock, flags);
> +
> +	return ret;
> +}
> +
> +static int update_liodn_stash(int liodn, struct fsl_dma_domain
> *dma_domain,
> +				 u32 val)
> +{
> +	int ret =3D 0, i;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu_lock, flags);
> +	if (!dma_domain->win_arr) {
> +		pr_debug("Windows not configured, stash destination update
> failed for liodn %d\n", liodn);
> +		spin_unlock_irqrestore(&iommu_lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < dma_domain->win_cnt; i++) {
> +		ret =3D pamu_update_paace_stash(liodn, i, val);
> +		if (ret) {
> +			pr_debug("Failed to update SPAACE %d field for liodn
> %d\n ", i, liodn);
> +			spin_unlock_irqrestore(&iommu_lock, flags);
> +			return ret;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&iommu_lock, flags);
> +
> +	return ret;
> +}
> +
> +/* Set the geometry parameters for a LIODN */
> +static int pamu_set_liodn(int liodn, struct device *dev,
> +			   struct fsl_dma_domain *dma_domain,
> +			   struct iommu_domain_geometry *geom_attr,
> +			   u32 win_cnt)
> +{
> +	phys_addr_t window_addr, window_size;
> +	phys_addr_t subwin_size;
> +	int ret =3D 0, i;
> +	u32 omi_index =3D ~(u32)0;
> +	unsigned long flags;
> +
> +	/*
> +	 * Configure the omi_index at the geometry setup time.
> +	 * This is a static value which depends on the type of
> +	 * device and would not change thereafter.
> +	 */
> +	get_ome_index(&omi_index, dev);
> +
> +	window_addr =3D geom_attr->aperture_start;
> +	window_size =3D dma_domain->geom_size;
> +
> +	spin_lock_irqsave(&iommu_lock, flags);
> +	ret =3D pamu_disable_liodn(liodn);
> +	if (!ret)
> +		ret =3D pamu_config_ppaace(liodn, window_addr, window_size,
> omi_index,
> +					 0, dma_domain->snoop_id,
> +					 dma_domain->stash_id, win_cnt, 0);
> +	spin_unlock_irqrestore(&iommu_lock, flags);
> +	if (ret) {
> +		pr_debug("PAMU PAACE configuration failed for liodn %d,
> win_cnt =3D%d\n", liodn, win_cnt);
> +		return ret;
> +	}
> +
> +	if (win_cnt > 1) {
> +		subwin_size =3D window_size >> ilog2(win_cnt);
> +		for (i =3D 0; i < win_cnt; i++) {
> +			spin_lock_irqsave(&iommu_lock, flags);
> +			ret =3D pamu_disable_spaace(liodn, i);
> +			if (!ret)
> +				ret =3D pamu_config_spaace(liodn, win_cnt, i,
> +							 subwin_size, omi_index,
> +							 0, dma_domain->snoop_id,
> +							 dma_domain->stash_id,
> +							 0, 0);
> +			spin_unlock_irqrestore(&iommu_lock, flags);
> +			if (ret) {
> +				pr_debug("PAMU SPAACE configuration failed for
> liodn %d\n", liodn);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int check_size(u64 size, dma_addr_t iova)
> +{
> +	/*
> +	 * Size must be a power of two and at least be equal
> +	 * to PAMU page size.
> +	 */
> +	if (!is_power_of_2(size) || size < PAMU_PAGE_SIZE) {
> +		pr_debug("%s: size too small or not a power of two\n",
> __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* iova must be page size aligned*/
> +	if (iova & (size - 1)) {
> +		pr_debug("%s: address is not aligned with window size\n",
> __func__);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct fsl_dma_domain *iommu_alloc_dma_domain(void)
> +{
> +	struct fsl_dma_domain *domain;
> +
> +	domain =3D kmem_cache_zalloc(fsl_pamu_domain_cache, GFP_KERNEL);
> +	if (!domain)
> +		return NULL;
> +
> +	domain->stash_id =3D ~(u32)0;
> +	domain->snoop_id =3D ~(u32)0;
> +	domain->win_cnt =3D pamu_get_max_subwin_cnt();
> +	domain->geom_size =3D 0;
> +
> +	INIT_LIST_HEAD(&domain->devices);
> +
> +	spin_lock_init(&domain->domain_lock);
> +
> +	return domain;
> +}
> +
> +static inline struct device_domain_info *find_domain(struct device *dev)
> +{
> +	return dev->archdata.iommu_domain;
> +}
> +
> +static void remove_device_ref(struct device_domain_info *info, u32
> win_cnt)
> +{
> +	unsigned long flags;
> +
> +	list_del(&info->link);
> +	spin_lock_irqsave(&iommu_lock, flags);
> +	if (win_cnt > 1)
> +		pamu_free_subwins(info->liodn);
> +	pamu_disable_liodn(info->liodn);
> +	spin_unlock_irqrestore(&iommu_lock, flags);
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	info->dev->archdata.iommu_domain =3D NULL;
> +	kmem_cache_free(iommu_devinfo_cache, info);
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +}
> +
> +static void detach_device(struct device *dev, struct fsl_dma_domain
> *dma_domain)
> +{
> +	struct device_domain_info *info, *tmp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> +	/* Remove the device from the domain device list */
> +	list_for_each_entry_safe(info, tmp, &dma_domain->devices, link) {
> +		if (!dev || (info->dev =3D=3D dev))
> +			remove_device_ref(info, dma_domain->win_cnt);
> +	}
> +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +}
> +
> +static void attach_device(struct fsl_dma_domain *dma_domain, int liodn,
> struct device *dev)
> +{
> +	struct device_domain_info *info, *old_domain_info;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	/*
> +	 * Check here if the device is already attached to domain or not.
> +	 * If the device is already attached to a domain detach it.
> +	 */
> +	old_domain_info =3D find_domain(dev);
> +	if (old_domain_info && old_domain_info->domain !=3D dma_domain) {
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		detach_device(dev, old_domain_info->domain);
> +		spin_lock_irqsave(&device_domain_lock, flags);
> +	}
> +
> +	info =3D kmem_cache_zalloc(iommu_devinfo_cache, GFP_ATOMIC);
> +
> +	info->dev =3D dev;
> +	info->liodn =3D liodn;
> +	info->domain =3D dma_domain;
> +
> +	list_add(&info->link, &dma_domain->devices);
> +	/*
> +	 * In case of devices with multiple LIODNs just store
> +	 * the info for the first LIODN as all
> +	 * LIODNs share the same domain
> +	 */
> +	if (!old_domain_info)
> +		dev->archdata.iommu_domain =3D info;
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +}
> +
> +static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
> +					    dma_addr_t iova)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +
> +	if ((iova < domain->geometry.aperture_start) ||
> +		iova > (domain->geometry.aperture_end))
> +		return 0;
> +
> +	return get_phys_addr(dma_domain, iova);
> +}
> +
> +static int fsl_pamu_domain_has_cap(struct iommu_domain *domain,
> +				      unsigned long cap)
> +{
> +	return cap =3D=3D IOMMU_CAP_CACHE_COHERENCY;
> +}
> +
> +static void fsl_pamu_domain_destroy(struct iommu_domain *domain)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +
> +	domain->priv =3D NULL;
> +
> +	/* remove all the devices from the device list */
> +	detach_device(NULL, dma_domain);
> +
> +	dma_domain->enabled =3D 0;
> +	dma_domain->mapped =3D 0;
> +
> +	kmem_cache_free(fsl_pamu_domain_cache, dma_domain);
> +}
> +
> +static int fsl_pamu_domain_init(struct iommu_domain *domain)
> +{
> +	struct fsl_dma_domain *dma_domain;
> +
> +	dma_domain =3D iommu_alloc_dma_domain();
> +	if (!dma_domain) {
> +		pr_debug("dma_domain allocation failed\n");
> +		return -ENOMEM;
> +	}
> +	domain->priv =3D dma_domain;
> +	dma_domain->iommu_domain =3D domain;
> +	/* defaul geometry 64 GB i.e. maximum system address */
> +	domain->geometry.aperture_start =3D 0;
> +	domain->geometry.aperture_end =3D (1ULL << 36) - 1;
> +	domain->geometry.force_aperture =3D true;
> +
> +	return 0;
> +}
> +
> +/* Configure geometry settings for all LIODNs associated with domain */
> +static int pamu_set_domain_geometry(struct fsl_dma_domain *dma_domain,
> +				    struct iommu_domain_geometry *geom_attr,
> +				    u32 win_cnt)
> +{
> +	struct device_domain_info *info;
> +	int ret =3D 0;
> +
> +	list_for_each_entry(info, &dma_domain->devices, link) {
> +		ret =3D pamu_set_liodn(info->liodn, info->dev, dma_domain,
> +				      geom_attr, win_cnt);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Update stash destination for all LIODNs associated with the domain */
> +static int update_domain_stash(struct fsl_dma_domain *dma_domain, u32
> val)
> +{
> +	struct device_domain_info *info;
> +	int ret =3D 0;
> +
> +	list_for_each_entry(info, &dma_domain->devices, link) {
> +		ret =3D update_liodn_stash(info->liodn, dma_domain, val);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Update domain mappings for all LIODNs associated with the domain */
> +static int update_domain_mapping(struct fsl_dma_domain *dma_domain, u32
> wnd_nr)
> +{
> +	struct device_domain_info *info;
> +	int ret =3D 0;
> +
> +	list_for_each_entry(info, &dma_domain->devices, link) {
> +		ret =3D update_liodn(info->liodn, dma_domain, wnd_nr);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +
> +static int disable_domain_win(struct fsl_dma_domain *dma_domain, u32
> wnd_nr)
> +{
> +	struct device_domain_info *info;
> +	int ret =3D 0;
> +
> +	list_for_each_entry(info, &dma_domain->devices, link) {
> +		if (dma_domain->win_cnt =3D=3D 1 && dma_domain->enabled) {
> +			ret =3D pamu_disable_liodn(info->liodn);
> +			if (!ret)
> +				dma_domain->enabled =3D 0;
> +		} else {
> +			ret =3D pamu_disable_spaace(info->liodn, wnd_nr);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void fsl_pamu_window_disable(struct iommu_domain *domain, u32
> wnd_nr)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> +	if (!dma_domain->win_arr) {
> +		pr_debug("Number of windows not configured\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return;
> +	}
> +
> +	if (wnd_nr >=3D dma_domain->win_cnt) {
> +		pr_debug("Invalid window index\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return;
> +	}
> +
> +	if (dma_domain->win_arr[wnd_nr].valid) {
> +		ret =3D disable_domain_win(dma_domain, wnd_nr);
> +		if (!ret) {
> +			dma_domain->win_arr[wnd_nr].valid =3D 0;
> +			dma_domain->mapped--;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +
> +}
> +
> +static int fsl_pamu_window_enable(struct iommu_domain *domain, u32
> wnd_nr,
> +				  phys_addr_t paddr, u64 size, int prot)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	struct dma_window *wnd;
> +	int pamu_prot =3D 0;
> +	int ret;
> +	unsigned long flags;
> +	u64 win_size;
> +
> +	if (prot & IOMMU_READ)
> +		pamu_prot |=3D PAACE_AP_PERMS_QUERY;
> +	if (prot & IOMMU_WRITE)
> +		pamu_prot |=3D PAACE_AP_PERMS_UPDATE;
> +
> +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> +	if (!dma_domain->win_arr) {
> +		pr_debug("Number of windows not configured\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return -ENODEV;
> +	}
> +
> +	if (wnd_nr >=3D dma_domain->win_cnt) {
> +		pr_debug("Invalid window index\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	win_size =3D dma_domain->geom_size >> ilog2(dma_domain->win_cnt);
> +	if (size > win_size) {
> +		pr_debug("Invalid window size \n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	if (dma_domain->win_cnt =3D=3D 1) {
> +		if (dma_domain->enabled) {
> +			pr_debug("Disable the window before updating the
> mapping\n");
> +			spin_unlock_irqrestore(&dma_domain->domain_lock,
> flags);
> +			return -EBUSY;
> +		}
> +
> +		ret =3D check_size(size, domain->geometry.aperture_start);
> +		if (ret) {
> +			pr_debug("Aperture start not aligned to the size\n");
> +			spin_unlock_irqrestore(&dma_domain->domain_lock,
> flags);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	wnd =3D &dma_domain->win_arr[wnd_nr];
> +	if (!wnd->valid) {
> +		wnd->paddr =3D paddr;
> +		wnd->size =3D size;
> +		wnd->prot =3D pamu_prot;
> +
> +		ret =3D update_domain_mapping(dma_domain, wnd_nr);
> +		if (!ret) {
> +			wnd->valid =3D 1;
> +			dma_domain->mapped++;
> +		}
> +	} else {
> +		pr_debug("Disable the window before updating the mapping\n");
> +		ret =3D -EBUSY;
> +	}
> +
> +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +
> +	return ret;
> +}
> +
> +/*
> + * Attach the LIODN to the DMA domain and configure the geometry
> + * and window mappings.
> + */
> +static int handle_attach_device(struct fsl_dma_domain *dma_domain,
> +				 struct device *dev, const u32 *liodn,
> +				 int num)
> +{
> +	unsigned long flags;
> +	struct iommu_domain *domain =3D dma_domain->iommu_domain;
> +	int ret =3D 0;
> +	int i;
> +
> +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> +	for (i =3D 0; i < num; i++) {
> +
> +		/* Ensure that LIODN value is valid */
> +		if (liodn[i] >=3D PAACE_NUMBER_ENTRIES) {
> +			pr_debug("Invalid liodn %d, attach device failed for
> %s\n",
> +				liodn[i], dev->of_node->full_name);
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		attach_device(dma_domain, liodn[i], dev);
> +		/*
> +		 * Check if geometry has already been configured
> +		 * for the domain. If yes, set the geometry for
> +		 * the LIODN.
> +		 */
> +		if (dma_domain->win_arr) {
> +			u32 win_cnt =3D dma_domain->win_cnt > 1 ? dma_domain-
> >win_cnt : 0;
> +			ret =3D pamu_set_liodn(liodn[i], dev, dma_domain,
> +					      &domain->geometry,
> +					      win_cnt);
> +			if (ret)
> +				break;
> +			if (dma_domain->mapped) {
> +				/*
> +				 * Create window/subwindow mapping for
> +				 * the LIODN.
> +				 */
> +				ret =3D map_liodn(liodn[i], dma_domain);
> +				if (ret)
> +					break;
> +			}
> +		}
> +	}
> +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +
> +	return ret;
> +}
> +
> +static int fsl_pamu_attach_device(struct iommu_domain *domain,
> +				  struct device *dev)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	const u32 *liodn;
> +	u32 liodn_cnt;
> +	int len, ret =3D 0;
> +	struct pci_dev *pdev =3D NULL;
> +	struct pci_controller *pci_ctl;
> +
> +	/*
> +	 * Use LIODN of the PCI controller while attaching a
> +	 * PCI device.
> +	 */
> +	if (dev->bus =3D=3D &pci_bus_type) {
> +		pdev =3D to_pci_dev(dev);
> +		pci_ctl =3D pci_bus_to_host(pdev->bus);
> +		/*
> +		 * make dev point to pci controller device
> +		 * so we can get the LIODN programmed by
> +		 * u-boot.
> +		 */
> +		dev =3D pci_ctl->parent;
> +	}
> +
> +	liodn =3D of_get_property(dev->of_node, "fsl,liodn", &len);
> +	if (liodn) {
> +		liodn_cnt =3D len / sizeof(u32);
> +		ret =3D handle_attach_device(dma_domain, dev,
> +					 liodn, liodn_cnt);
> +	} else {
> +		pr_debug("missing fsl,liodn property at %s\n",
> +		          dev->of_node->full_name);
> +			ret =3D -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void fsl_pamu_detach_device(struct iommu_domain *domain,
> +				      struct device *dev)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	const u32 *prop;
> +	int len;
> +	struct pci_dev *pdev =3D NULL;
> +	struct pci_controller *pci_ctl;
> +
> +	/*
> +	 * Use LIODN of the PCI controller while detaching a
> +	 * PCI device.
> +	 */
> +	if (dev->bus =3D=3D &pci_bus_type) {
> +		pdev =3D to_pci_dev(dev);
> +		pci_ctl =3D pci_bus_to_host(pdev->bus);
> +		/*
> +		 * make dev point to pci controller device
> +		 * so we can get the LIODN programmed by
> +		 * u-boot.
> +		 */
> +		dev =3D pci_ctl->parent;
> +	}
> +
> +	prop =3D of_get_property(dev->of_node, "fsl,liodn", &len);
> +	if (prop)
> +		detach_device(dev, dma_domain);
> +	else
> +		pr_debug("missing fsl,liodn property at %s\n",
> +		          dev->of_node->full_name);
> +}
> +
> +static  int configure_domain_geometry(struct iommu_domain *domain, void
> *data)
> +{
> +	struct iommu_domain_geometry *geom_attr =3D data;
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	dma_addr_t geom_size;
> +	unsigned long flags;
> +
> +	geom_size =3D geom_attr->aperture_end - geom_attr->aperture_start +
> 1;
> +	/*
> +	 * Sanity check the geometry size. Also, we do not support
> +	 * DMA outside of the geometry.
> +	 */
> +	if (check_size(geom_size, geom_attr->aperture_start) ||
> +		!geom_attr->force_aperture) {
> +			pr_debug("Invalid PAMU geometry attributes\n");
> +			return -EINVAL;
> +		}
> +
> +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> +	if (dma_domain->enabled) {
> +		pr_debug("Can't set geometry attributes as domain is
> active\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return  -EBUSY;
> +	}
> +
> +	/* Copy the domain geometry information */
> +	memcpy(&domain->geometry, geom_attr,
> +	       sizeof(struct iommu_domain_geometry));
> +	dma_domain->geom_size =3D geom_size;
> +
> +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +
> +	return 0;
> +}
> +
> +/* Set the domain stash attribute */
> +static int configure_domain_stash(struct fsl_dma_domain *dma_domain,
> void *data)
> +{
> +	struct pamu_stash_attribute *stash_attr =3D data;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> +
> +	memcpy(&dma_domain->dma_stash, stash_attr,
> +		 sizeof(struct pamu_stash_attribute));
> +
> +	dma_domain->stash_id =3D get_stash_id(stash_attr->cache,
> +					    stash_attr->cpu);
> +	if (dma_domain->stash_id =3D=3D ~(u32)0) {
> +		pr_debug("Invalid stash attributes\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D update_domain_stash(dma_domain, dma_domain->stash_id);
> +
> +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +
> +	return ret;
> +}
> +
> +/* Configure domain dma state i.e. enable/disable DMA*/
> +static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain,
> bool enable)
> +{
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> +
> +	if (enable && !dma_domain->mapped) {
> +		pr_debug("Can't enable DMA domain without valid mapping\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return -ENODEV;
> +	}
> +
> +	dma_domain->enabled =3D enable;
> +	list_for_each_entry(info, &dma_domain->devices,
> +				 link) {
> +		ret =3D (enable) ? pamu_enable_liodn(info->liodn) :
> +			pamu_disable_liodn(info->liodn);
> +		if (ret)
> +			pr_debug("Unable to set dma state for liodn %d",
> +				 info->liodn);
> +	}
> +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
> +				 enum iommu_attr attr_type, void *data)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	int ret =3D 0;
> +
> +
> +	switch (attr_type) {
> +	case DOMAIN_ATTR_GEOMETRY:
> +		ret =3D configure_domain_geometry(domain, data);
> +		break;
> +	case DOMAIN_ATTR_FSL_PAMU_STASH:
> +		ret =3D configure_domain_stash(dma_domain, data);
> +		break;
> +	case DOMAIN_ATTR_FSL_PAMU_ENABLE:
> +		ret =3D configure_domain_dma_state(dma_domain, *(int *)data);
> +		break;
> +	default:
> +		pr_debug("Unsupported attribute type\n");
> +		ret =3D -EINVAL;
> +		break;
> +	};
> +
> +	return ret;
> +}
> +
> +static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
> +				 enum iommu_attr attr_type, void *data)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	int ret =3D 0;
> +
> +
> +	switch (attr_type) {
> +	case DOMAIN_ATTR_FSL_PAMU_STASH:
> +		memcpy((struct pamu_stash_attribute *) data, &dma_domain-
> >dma_stash,
> +				 sizeof(struct pamu_stash_attribute));
> +		break;
> +	case DOMAIN_ATTR_FSL_PAMU_ENABLE:
> +		*(int *)data =3D dma_domain->enabled;
> +		break;
> +	case DOMAIN_ATTR_FSL_PAMUV1:
> +		*(int *)data =3D DOMAIN_ATTR_FSL_PAMUV1;
> +		break;
> +	default:
> +		pr_debug("Unsupported attribute type\n");
> +		ret =3D -EINVAL;
> +		break;
> +	};
> +
> +	return ret;
> +}
> +
> +#define REQ_ACS_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR |
> PCI_ACS_UF)
> +
> +static struct iommu_group *get_device_iommu_group(struct device *dev)
> +{
> +	struct iommu_group *group;
> +
> +	group =3D iommu_group_get(dev);
> +	if (!group)
> +		group =3D iommu_group_alloc();
> +
> +	return group;
> +}
> +
> +static  bool check_pci_ctl_endpt_part(struct pci_controller *pci_ctl)
> +{
> +	u32 version;
> +
> +	/* Check the PCI controller version number by readding BRR1
> register */
> +	version =3D in_be32(pci_ctl->cfg_addr + (PCI_FSL_BRR1 >> 2));
> +	version &=3D PCI_FSL_BRR1_VER;
> +	/* If PCI controller version is >=3D 0x204 we can partition
> endpoints*/
> +	if (version >=3D 0x204)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/* Get iommu group information from peer devices or devices on the
> parent bus */
> +static struct iommu_group *get_shared_pci_device_group(struct pci_dev
> *pdev)
> +{
> +	struct pci_dev *tmp;
> +	struct iommu_group *group;
> +	struct pci_bus *bus =3D pdev->bus;
> +
> +	/*
> +	 * Traverese the pci bus device list to get
> +	 * the shared iommu group.
> +	 */
> +	while (bus) {
> +		list_for_each_entry(tmp, &bus->devices, bus_list) {
> +			if (tmp =3D=3D pdev)
> +				continue;
> +			group =3D iommu_group_get(&tmp->dev);
> +			if (group)
> +				return group;
> +		}
> +
> +		bus =3D bus->parent;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
> +{
> +	struct pci_controller *pci_ctl;
> +	bool pci_endpt_partioning;
> +	struct iommu_group *group =3D NULL;
> +	struct pci_dev *bridge, *dma_pdev =3D NULL;
> +
> +	pci_ctl =3D pci_bus_to_host(pdev->bus);
> +	pci_endpt_partioning =3D check_pci_ctl_endpt_part(pci_ctl);
> +	/* We can partition PCIe devices so assign device group to the
> device */
> +	if (pci_endpt_partioning) {
> +		bridge =3D pci_find_upstream_pcie_bridge(pdev);
> +		if (bridge) {
> +			if (pci_is_pcie(bridge))
> +				dma_pdev =3D pci_get_domain_bus_and_slot(
> +						pci_domain_nr(pdev->bus),
> +						bridge->subordinate->number, 0);
> +			if (!dma_pdev)
> +				dma_pdev =3D pci_dev_get(bridge);
> +		} else
> +			dma_pdev =3D pci_dev_get(pdev);
> +
> +		/* Account for quirked devices */
> +		swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));
> +
> +		/*
> +		 * If it's a multifunction device that does not support our
> +		 * required ACS flags, add to the same group as lowest
> numbered
> +		 * function that also does not suport the required ACS flags.
> +		 */
> +		if (dma_pdev->multifunction &&
> +		    !pci_acs_enabled(dma_pdev, REQ_ACS_FLAGS)) {
> +			u8 i, slot =3D PCI_SLOT(dma_pdev->devfn);
> +
> +			for (i =3D 0; i < 8; i++) {
> +				struct pci_dev *tmp;
> +
> +				tmp =3D pci_get_slot(dma_pdev->bus, PCI_DEVFN(slot,
> i));
> +				if (!tmp)
> +					continue;
> +
> +				if (!pci_acs_enabled(tmp, REQ_ACS_FLAGS)) {
> +					swap_pci_ref(&dma_pdev, tmp);
> +					break;
> +				}
> +				pci_dev_put(tmp);
> +			}
> +		}
> +
> +		/*
> +		 * Devices on the root bus go through the iommu.  If that's
> not us,
> +	 	 * find the next upstream device and test ACS up to the root
> bus.
> +		 * Finding the next device may require skipping virtual
> buses.
> +		 */
> +		while (!pci_is_root_bus(dma_pdev->bus)) {
> +			struct pci_bus *bus =3D dma_pdev->bus;
> +
> +			while (!bus->self) {
> +				if (!pci_is_root_bus(bus))
> +					bus =3D bus->parent;
> +				else
> +					goto root_bus;
> +			}
> +
> +			if (pci_acs_path_enabled(bus->self, NULL,
> REQ_ACS_FLAGS))
> +				break;
> +
> +			swap_pci_ref(&dma_pdev, pci_dev_get(bus->self));
> +		}
> +
> +root_bus:
> +		group =3D get_device_iommu_group(&dma_pdev->dev);
> +		pci_dev_put(dma_pdev);
> +		/*
> +		 * PCIe controller is not a paritionable entity
> +		 * free the controller device iommu_group.
> +		 */
> +		if (pci_ctl->parent->iommu_group)
> +			iommu_group_remove_device(pci_ctl->parent);
> +	} else {
> +		/*
> +		 * All devices connected to the controller will share the
> +		 * PCI controllers device group. If this is the first
> +		 * device to be probed for the pci controller, copy the
> +		 * device group information from the PCI controller device
> +		 * node and remove the PCI controller iommu group.
> +		 * For subsequent devices, the iommu group information can
> +		 * be obtained from sibling devices (i.e. from the
> bus_devices
> +		 * link list).
> +		 */
> +		if (pci_ctl->parent->iommu_group) {
> +			group =3D get_device_iommu_group(pci_ctl->parent);
> +			iommu_group_remove_device(pci_ctl->parent);
> +		} else
> +			group =3D get_shared_pci_device_group(pdev);
> +	}
> +
> +	return group;
> +}
> +
> +static int fsl_pamu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group =3D NULL;
> +	struct pci_dev *pdev;
> +	const u32 *prop;
> +	int ret, len;
> +
> +	/*
> +	 * For platform devices we allocate a separate group for
> +	 * each of the devices.
> +	 */
> +	if (dev->bus =3D=3D &pci_bus_type) {
> +		pdev =3D to_pci_dev(dev);
> +		/* Don't create device groups for virtual PCI bridges */
> +		if (pdev->subordinate)
> +			return 0;
> +
> +		group =3D get_pci_device_group(pdev);
> +
> +	} else {
> +		prop =3D of_get_property(dev->of_node, "fsl,liodn", &len);
> +		if (prop)
> +			group =3D get_device_iommu_group(dev);
> +	}
> +
> +	if (!group || IS_ERR(group))
> +		return PTR_ERR(group);
> +
> +	ret =3D iommu_group_add_device(group, dev);
> +
> +	iommu_group_put(group);
> +	return ret;
> +}
> +
> +static void fsl_pamu_remove_device(struct device *dev)
> +{
> +	iommu_group_remove_device(dev);
> +}
> +
> +static int fsl_pamu_set_windows(struct iommu_domain *domain, u32
> w_count)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> +	/* Ensure domain is inactive i.e. DMA should be disabled for the
> domain */
> +	if (dma_domain->enabled) {
> +		pr_debug("Can't set geometry attributes as domain is
> active\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return  -EBUSY;
> +	}
> +
> +	/* Ensure that the geometry has been set for the domain */
> +	if (!dma_domain->geom_size) {
> +		pr_debug("Please configure geometry before setting the number
> of windows\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Ensure we have valid window count i.e. it should be less than
> +	 * maximum permissible limit and should be a power of two.
> +	 */
> +	if (w_count > pamu_get_max_subwin_cnt() || !is_power_of_2(w_count))
> {
> +		pr_debug("Invalid window count\n");
> +		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D pamu_set_domain_geometry(dma_domain, &domain->geometry,
> +				((w_count > 1) ? w_count : 0));
> +	if (!ret) {
> +		if (dma_domain->win_arr)
> +			kfree(dma_domain->win_arr);
> +		dma_domain->win_arr =3D kzalloc(sizeof(struct dma_window) *
> +							  w_count, GFP_ATOMIC);
> +		if (!dma_domain->win_arr) {
> +			spin_unlock_irqrestore(&dma_domain->domain_lock,
> flags);
> +			return -ENOMEM;
> +		}
> +		dma_domain->win_cnt =3D w_count;
> +	}
> +	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> +
> +	return ret;
> +}
> +
> +static u32 fsl_pamu_get_windows(struct iommu_domain *domain)
> +{
> +	struct fsl_dma_domain *dma_domain =3D domain->priv;
> +
> +	return dma_domain->win_cnt;
> +}
> +
> +static struct iommu_ops fsl_pamu_ops =3D {
> +	.domain_init	=3D fsl_pamu_domain_init,
> +	.domain_destroy =3D fsl_pamu_domain_destroy,
> +	.attach_dev	=3D fsl_pamu_attach_device,
> +	.detach_dev	=3D fsl_pamu_detach_device,
> +	.domain_window_enable =3D fsl_pamu_window_enable,
> +	.domain_window_disable =3D fsl_pamu_window_disable,
> +	.domain_get_windows =3D fsl_pamu_get_windows,
> +	.domain_set_windows =3D fsl_pamu_set_windows,
> +	.iova_to_phys	=3D fsl_pamu_iova_to_phys,
> +	.domain_has_cap =3D fsl_pamu_domain_has_cap,
> +	.domain_set_attr =3D fsl_pamu_set_domain_attr,
> +	.domain_get_attr =3D fsl_pamu_get_domain_attr,
> +	.add_device	=3D fsl_pamu_add_device,
> +	.remove_device	=3D fsl_pamu_remove_device,
> +};
> +
> +int pamu_domain_init()
> +{
> +	int ret =3D 0;
> +
> +	ret =3D iommu_init_mempool();
> +	if (ret)
> +		return ret;
> +
> +	bus_set_iommu(&platform_bus_type, &fsl_pamu_ops);
> +	bus_set_iommu(&pci_bus_type, &fsl_pamu_ops);
> +
> +	return ret;
> +}
> diff --git a/drivers/iommu/fsl_pamu_domain.h
> b/drivers/iommu/fsl_pamu_domain.h
> new file mode 100644
> index 0000000..c90293f
> --- /dev/null
> +++ b/drivers/iommu/fsl_pamu_domain.h
> @@ -0,0 +1,85 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
> USA.
> + *
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + */
> +
> +#ifndef __FSL_PAMU_DOMAIN_H
> +#define __FSL_PAMU_DOMAIN_H
> +
> +#include "fsl_pamu.h"
> +
> +struct dma_window {
> +	phys_addr_t paddr;
> +	u64 size;
> +	int valid;
> +	int prot;
> +};
> +
> +struct fsl_dma_domain {
> +	/*
> +	 * Indicates the geometry size for the domain.
> +	 * This would be set when the geometry is
> +	 * configured for the domain.
> +	 */
> +	dma_addr_t			geom_size;
> +	/*
> +	 * Number of windows assocaited with this domain.
> +	 * During domain initialization, it is set to the
> +	 * the maximum number of subwindows allowed for a LIODN.
> +	 * Minimum value for this is 1 indicating a single PAMU
> +	 * window, without any sub windows. Value can be set/
> +	 * queried by set_attr/get_attr API for DOMAIN_ATTR_WINDOWS.
> +	 * Value can only be set once the geometry has been configured.
> +	 */
> +	u32				win_cnt;
> +	/*
> +	 * win_arr contains information of the configured
> +	 * windows for a domain. This is allocated only
> +	 * when the number of windows for the domain are
> +	 * set.
> +	 */
> +	struct dma_window		*win_arr;
> +	/* list of devices associated with the domain */
> +	struct list_head		devices;
> +	/* dma_domain states:
> +	 * mapped - A particular mapping has been created
> +	 * within the configured geometry.
> +	 * enabled - DMA has been enabled for the given
> +	 * domain. This translates to setting of the
> +	 * valid bit for the primary PAACE in the PAMU
> +	 * PAACT table. Domain geometry should be set and
> +	 * it must have a valid mapping before DMA can be
> +	 * enabled for it.
> +	 *
> +	 */
> +	int				mapped;
> +	int				enabled;
> +	/* stash_id obtained from the stash attribute details */
> +	u32				stash_id;
> +	struct pamu_stash_attribute	dma_stash;
> +	u32				snoop_id;
> +	struct iommu_domain		*iommu_domain;
> +	spinlock_t			domain_lock;
> +};
> +
> +/* domain-device relationship */
> +struct device_domain_info {
> +	struct list_head link;	/* link to domain siblings */
> +	struct device *dev;
> +	u32 liodn;
> +	struct fsl_dma_domain *domain; /* pointer to domain */
> +};
> +#endif  /* __FSL_PAMU_DOMAIN_H */
> --
> 1.7.4.1
