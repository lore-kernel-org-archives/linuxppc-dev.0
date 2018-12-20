Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7297C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 16:48:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167D820869
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 16:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167D820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LHkj6kS2zDr37
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 03:48:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LHhJ4ybvzDqTW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 03:46:08 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29D145A1EA;
 Thu, 20 Dec 2018 16:46:06 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD71860BE5;
 Thu, 20 Dec 2018 16:46:04 +0000 (UTC)
Date: Thu, 20 Dec 2018 09:46:04 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v7 20/20] vfio_pci: Add NVIDIA GV100GL [Tesla
 V100 SXM2] subdriver
Message-ID: <20181220094604.7d172cbe@x1.home>
In-Reply-To: <20181220082350.58113-21-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
 <20181220082350.58113-21-aik@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 20 Dec 2018 16:46:06 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Leonardo Augusto =?UTF-8?B?R3Vp?= =?UTF-8?B?bWFyw6Nlcw==?= Garcia
 <lagarcia@br.ibm.com>, Reza Arbab <arbab@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 20 Dec 2018 19:23:50 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
> pluggable PCIe devices but still have PCIe links which are used
> for config space and MMIO. In addition to that the GPUs have 6 NVLinks
> which are connected to other GPUs and the POWER9 CPU. POWER9 chips
> have a special unit on a die called an NPU which is an NVLink2 host bus
> adapter with p2p connections to 2 to 3 GPUs, 3 or 2 NVLinks to each.
> These systems also support ATS (address translation services) which is
> a part of the NVLink2 protocol. Such GPUs also share on-board RAM
> (16GB or 32GB) to the system via the same NVLink2 so a CPU has
> cache-coherent access to a GPU RAM.
> 
> This exports GPU RAM to the userspace as a new VFIO device region. This
> preregisters the new memory as device memory as it might be used for DMA.
> This inserts pfns from the fault handler as the GPU memory is not onlined
> until the vendor driver is loaded and trained the NVLinks so doing this
> earlier causes low level errors which we fence in the firmware so
> it does not hurt the host system but still better be avoided; for the same
> reason this does not map GPU RAM into the host kernel (usual thing for
> emulated access otherwise).
> 
> This exports an ATSD (Address Translation Shootdown) register of NPU which
> allows TLB invalidations inside GPU for an operating system. The register
> conveniently occupies a single 64k page. It is also presented to
> the userspace as a new VFIO device region. One NPU has 8 ATSD registers,
> each of them can be used for TLB invalidation in a GPU linked to this NPU.
> This allocates one ATSD register per an NVLink bridge allowing passing
> up to 6 registers. Due to the host firmware bug (just recently fixed),
> only 1 ATSD register per NPU was actually advertised to the host system
> so this passes that alone register via the first NVLink bridge device in
> the group which is still enough as QEMU collects them all back and
> presents to the guest via vPHB to mimic the emulated NPU PHB on the host.
> 
> In order to provide the userspace with the information about GPU-to-NVLink
> connections, this exports an additional capability called "tgt"
> (which is an abbreviated host system bus address). The "tgt" property
> tells the GPU its own system address and allows the guest driver to
> conglomerate the routing information so each GPU knows how to get directly
> to the other GPUs.
> 
> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
> know LPID (a logical partition ID or a KVM guest hardware ID in other
> words) and PID (a memory context ID of a userspace process, not to be
> confused with a linux pid). This assigns a GPU to LPID in the NPU and
> this is why this adds a listener for KVM on an IOMMU group. A PID comes
> via NVLink from a GPU and NPU uses a PID wildcard to pass it through.
> 
> This requires coherent memory and ATSD to be available on the host as
> the GPU vendor only supports configurations with both features enabled
> and other configurations are known not to work. Because of this and
> because of the ways the features are advertised to the host system
> (which is a device tree with very platform specific properties),
> this requires enabled POWERNV platform.
> 
> The V100 GPUs do not advertise any of these capabilities via the config
> space and there are more than just one device ID so this relies on
> the platform to tell whether these GPUs have special abilities such as
> NVLinks.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v6.1:
> * fixed outdated comment about VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD
> 
> v6:
> * reworked capabilities - tgt for nvlink and gpu and link-speed
> for nvlink only
> 
> v5:
> * do not memremap GPU RAM for emulation, map it only when it is needed
> * allocate 1 ATSD register per NVLink bridge, if none left, then expose
> the region with a zero size
> * separate caps per device type
> * addressed AW review comments
> 
> v4:
> * added nvlink-speed to the NPU bridge capability as this turned out to
> be not a constant value
> * instead of looking at the exact device ID (which also changes from system
> to system), now this (indirectly) looks at the device tree to know
> if GPU and NPU support NVLink
> 
> v3:
> * reworded the commit log about tgt
> * added tracepoints (do we want them enabled for entire vfio-pci?)
> * added code comments
> * added write|mmap flags to the new regions
> * auto enabled VFIO_PCI_NVLINK2 config option
> * added 'tgt' capability to a GPU so QEMU can recreate ibm,npu and ibm,gpu
> references; there are required by the NVIDIA driver
> * keep notifier registered only for short time
> ---
>  drivers/vfio/pci/Makefile           |   1 +
>  drivers/vfio/pci/trace.h            | 102 ++++++
>  drivers/vfio/pci/vfio_pci_private.h |  14 +
>  include/uapi/linux/vfio.h           |  37 +++
>  drivers/vfio/pci/vfio_pci.c         |  27 +-
>  drivers/vfio/pci/vfio_pci_nvlink2.c | 482 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/Kconfig            |   6 +
>  7 files changed, 667 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/vfio/pci/trace.h
>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
> 
...
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 8131028..5562587 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -353,6 +353,21 @@ struct vfio_region_gfx_edid {
>  #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
>  };
>  
> +/*
> + * 10de vendor sub-type
> + *
> + * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
> + */
> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
> +
> +/*
> + * 1014 vendor sub-type
> + *
> + * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
> + * to do TLB invalidation on a GPU.
> + */
> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> +
>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within
> @@ -363,6 +378,28 @@ struct vfio_region_gfx_edid {
>   */
>  #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>  
> +/*
> + * Capability with compressed real address (aka SSA - small system address)
> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
> + */
> +#define VFIO_REGION_INFO_CAP_NVLINK2_SSATGT	4
> +
> +struct vfio_region_info_cap_nvlink2_ssatgt {
> +	struct vfio_info_cap_header header;
> +	__u64 tgt;
> +};
> +
> +/*
> + * Capability with an NVLink link speed.
> + */

I was really hoping for something more like SSATGT above indicating the
intended users and purpose, and an update to SSATGT since it's now used
by both the GPU and NPU2.  This comment is correct, but it's basically
useless, it doesn't provide any information that isn't readily apparent
from the structure definition.  AIUI, SSATGT is used not only for the
GPU to determine where its RAM is mapped on the system bus, but also by
the NPU2 to associate itself to a GPU, right?  And the link speed here
is consumed by the NPU2 in order to fill in DT information for the
guest for compatibility and possibly routing optimizations?  Thanks,

Alex

> +#define VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD	5
> +
> +struct vfio_region_info_cap_nvlink2_lnkspd {
> +	struct vfio_info_cap_header header;
> +	__u32 link_speed;
> +	__u32 __pad;
> +};
> +
