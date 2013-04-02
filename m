Return-Path: <B08248@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7EC262C0138
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 02:29:28 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Sethi Varun-B16395 <B16395@freescale.com>, "joro@8bytes.org"
 <joro@8bytes.org>, Wood Scott-B07421 <B07421@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: RE: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Tue, 2 Apr 2013 15:29:19 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035A0D34@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-6-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1364500442-20927-6-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Thursday, March 28, 2013 2:54 PM
> To: joro@8bytes.org; Yoder Stuart-B08248; Wood Scott-B07421; iommu@lists.=
linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; galak@kernel.crashing=
.org; benh@kernel.crashing.org
> Cc: Sethi Varun-B16395
> Subject: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu imple=
mentation.
>=20
> Following is a brief description of the PAMU hardware:
> PAMU determines what action to take and whether to authorize the action o=
n
> the basis of the memory address, a Logical IO Device Number (LIODN), and
> PAACT table (logically) indexed by LIODN and address. Hardware devices wh=
ich
> need to access memory must provide an LIODN in addition to the memory add=
ress.
>=20
> Peripheral Access Authorization and Control Tables (PAACTs) are the prima=
ry
> data structures used by PAMU. A PAACT is a table of peripheral access
> authorization and control entries (PAACE).Each PAACE defines the range of
> I/O bus address space that is accessible by the LIOD and the associated a=
ccess
> capabilities.
>=20
> There are two types of PAACTs: primary PAACT (PPAACT) and secondary PAACT
> (SPAACT).A given physical I/O device may be able to act as one or more
> independent logical I/O devices (LIODs). Each such logical I/O device is
> assigned an identifier called logical I/O device number (LIODN). A LIODN =
is
> allocated a contiguous portion of the I/O bus address space called the DS=
A window
> for performing DSA operations. The DSA window may optionally be divided i=
nto
> multiple sub-windows, each of which may be used to map to a region in sys=
tem
> storage space. The first sub-window is referred to as the primary sub-win=
dow
> and the remaining are called secondary sub-windows.
>=20
> This patch provides the PAMU driver (fsl_pamu.c) and the corresponding IO=
MMU
> API implementation (fsl_pamu_domain.c). The PAMU hardware driver (fsl_pam=
u.c)
> has been derived from the work done by Ashish Kalra and Timur Tabi.
>=20
> Signed-off-by: Timur Tabi <<timur@tabi.org>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
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
>  drivers/iommu/Kconfig           |    8 +
>  drivers/iommu/Makefile          |    1 +
>  drivers/iommu/fsl_pamu.c        | 1269 +++++++++++++++++++++++++++++++++=
++++++
>  drivers/iommu/fsl_pamu.h        |  405 +++++++++++++
>  drivers/iommu/fsl_pamu_domain.c | 1137 +++++++++++++++++++++++++++++++++=
++
>  drivers/iommu/fsl_pamu_domain.h |   85 +++
>  7 files changed, 2910 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/iommu/fsl_pamu.c
>  create mode 100644 drivers/iommu/fsl_pamu.h
>  create mode 100644 drivers/iommu/fsl_pamu_domain.c
>  create mode 100644 drivers/iommu/fsl_pamu_domain.h

Ack.

Stuart
