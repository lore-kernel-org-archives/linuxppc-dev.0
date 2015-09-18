Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 308721A0038
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 01:47:35 +1000 (AEST)
Message-ID: <1442591252.23936.254.camel@redhat.com>
Subject: Re: [PATCH 0/2] VFIO: Accept IOMMU group (PE) ID
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, david@gibson.dropbear.id.au
Date: Fri, 18 Sep 2015 09:47:32 -0600
In-Reply-To: <1442557469-22185-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1442557469-22185-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

On Fri, 2015-09-18 at 16:24 +1000, Gavin Shan wrote:
> This allows to accept IOMMU group (PE) ID from the parameter from userland
> when handling EEH operation so that the operation only affects the target
> IOMMU group (PE). If the IOMMU group (PE) ID in the parameter from userland
> is invalid, all IOMMU groups (PEs) attached to the specified container are
> affected as before.
> 
> Gavin Shan (2):
>   drivers/vfio: Support EEH API revision
>   drivers/vfio: Support IOMMU group for EEH operations
> 
>  drivers/vfio/vfio_iommu_spapr_tce.c | 50 ++++++++++++++++++++++++++++++++++---
>  drivers/vfio/vfio_spapr_eeh.c       | 46 ++++++++++++++++++++++------------
>  include/linux/vfio.h                | 13 +++++++---
>  include/uapi/linux/vfio.h           |  6 +++++
>  4 files changed, 93 insertions(+), 22 deletions(-)

This interface is terrible.  A function named foo_enabled() should
return a bool, yes or no, don't try to overload it to also return a
version.  AFAICT, patch 2/2 breaks current users by changing the offset
of the union in struct vfio_eeh_pe_err.  Also, we generally pass group
file descriptors rather than a group ID because we can prove the
ownership of the group through the file descriptor and we don't need to
worry about races with the group because we can hold a reference to it.
