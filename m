Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7565C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 01:40:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB5220874
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 01:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB5220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LWXL5ffyzDqly
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 12:40:02 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LWTw0YM5zDqly
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 12:37:54 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E45783E2AF;
 Fri, 21 Dec 2018 01:37:52 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 551501019627;
 Fri, 21 Dec 2018 01:37:51 +0000 (UTC)
Date: Thu, 20 Dec 2018 18:37:50 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v7 20/20] vfio_pci: Add NVIDIA GV100GL [Tesla
 V100 SXM2] subdriver
Message-ID: <20181220183750.44535f1c@x1.home>
In-Reply-To: <8c4ee37c-8759-a618-0c38-034210858b89@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
 <20181220082350.58113-21-aik@ozlabs.ru>
 <20181220094604.7d172cbe@x1.home>
 <8c4ee37c-8759-a618-0c38-034210858b89@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 21 Dec 2018 01:37:53 +0000 (UTC)
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

On Fri, 21 Dec 2018 12:23:16 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 21/12/2018 03:46, Alex Williamson wrote:
> > On Thu, 20 Dec 2018 19:23:50 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
> >> pluggable PCIe devices but still have PCIe links which are used
> >> for config space and MMIO. In addition to that the GPUs have 6 NVLinks
> >> which are connected to other GPUs and the POWER9 CPU. POWER9 chips
> >> have a special unit on a die called an NPU which is an NVLink2 host bus
> >> adapter with p2p connections to 2 to 3 GPUs, 3 or 2 NVLinks to each.
> >> These systems also support ATS (address translation services) which is
> >> a part of the NVLink2 protocol. Such GPUs also share on-board RAM
> >> (16GB or 32GB) to the system via the same NVLink2 so a CPU has
> >> cache-coherent access to a GPU RAM.
> >>
> >> This exports GPU RAM to the userspace as a new VFIO device region. This
> >> preregisters the new memory as device memory as it might be used for DMA.
> >> This inserts pfns from the fault handler as the GPU memory is not onlined
> >> until the vendor driver is loaded and trained the NVLinks so doing this
> >> earlier causes low level errors which we fence in the firmware so
> >> it does not hurt the host system but still better be avoided; for the same
> >> reason this does not map GPU RAM into the host kernel (usual thing for
> >> emulated access otherwise).
> >>
> >> This exports an ATSD (Address Translation Shootdown) register of NPU which
> >> allows TLB invalidations inside GPU for an operating system. The register
> >> conveniently occupies a single 64k page. It is also presented to
> >> the userspace as a new VFIO device region. One NPU has 8 ATSD registers,
> >> each of them can be used for TLB invalidation in a GPU linked to this NPU.
> >> This allocates one ATSD register per an NVLink bridge allowing passing
> >> up to 6 registers. Due to the host firmware bug (just recently fixed),
> >> only 1 ATSD register per NPU was actually advertised to the host system
> >> so this passes that alone register via the first NVLink bridge device in
> >> the group which is still enough as QEMU collects them all back and
> >> presents to the guest via vPHB to mimic the emulated NPU PHB on the host.
> >>
> >> In order to provide the userspace with the information about GPU-to-NVLink
> >> connections, this exports an additional capability called "tgt"
> >> (which is an abbreviated host system bus address). The "tgt" property
> >> tells the GPU its own system address and allows the guest driver to
> >> conglomerate the routing information so each GPU knows how to get directly
> >> to the other GPUs.
> >>
> >> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
> >> know LPID (a logical partition ID or a KVM guest hardware ID in other
> >> words) and PID (a memory context ID of a userspace process, not to be
> >> confused with a linux pid). This assigns a GPU to LPID in the NPU and
> >> this is why this adds a listener for KVM on an IOMMU group. A PID comes
> >> via NVLink from a GPU and NPU uses a PID wildcard to pass it through.
> >>
> >> This requires coherent memory and ATSD to be available on the host as
> >> the GPU vendor only supports configurations with both features enabled
> >> and other configurations are known not to work. Because of this and
> >> because of the ways the features are advertised to the host system
> >> (which is a device tree with very platform specific properties),
> >> this requires enabled POWERNV platform.
> >>
> >> The V100 GPUs do not advertise any of these capabilities via the config
> >> space and there are more than just one device ID so this relies on
> >> the platform to tell whether these GPUs have special abilities such as
> >> NVLinks.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >> Changes:
> >> v6.1:
> >> * fixed outdated comment about VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD
> >>
> >> v6:
> >> * reworked capabilities - tgt for nvlink and gpu and link-speed
> >> for nvlink only
> >>
> >> v5:
> >> * do not memremap GPU RAM for emulation, map it only when it is needed
> >> * allocate 1 ATSD register per NVLink bridge, if none left, then expose
> >> the region with a zero size
> >> * separate caps per device type
> >> * addressed AW review comments
> >>
> >> v4:
> >> * added nvlink-speed to the NPU bridge capability as this turned out to
> >> be not a constant value
> >> * instead of looking at the exact device ID (which also changes from system
> >> to system), now this (indirectly) looks at the device tree to know
> >> if GPU and NPU support NVLink
> >>
> >> v3:
> >> * reworded the commit log about tgt
> >> * added tracepoints (do we want them enabled for entire vfio-pci?)
> >> * added code comments
> >> * added write|mmap flags to the new regions
> >> * auto enabled VFIO_PCI_NVLINK2 config option
> >> * added 'tgt' capability to a GPU so QEMU can recreate ibm,npu and ibm,gpu
> >> references; there are required by the NVIDIA driver
> >> * keep notifier registered only for short time
> >> ---
> >>  drivers/vfio/pci/Makefile           |   1 +
> >>  drivers/vfio/pci/trace.h            | 102 ++++++
> >>  drivers/vfio/pci/vfio_pci_private.h |  14 +
> >>  include/uapi/linux/vfio.h           |  37 +++
> >>  drivers/vfio/pci/vfio_pci.c         |  27 +-
> >>  drivers/vfio/pci/vfio_pci_nvlink2.c | 482 ++++++++++++++++++++++++++++
> >>  drivers/vfio/pci/Kconfig            |   6 +
> >>  7 files changed, 667 insertions(+), 2 deletions(-)
> >>  create mode 100644 drivers/vfio/pci/trace.h
> >>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
> >>  
> > ...  
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index 8131028..5562587 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -353,6 +353,21 @@ struct vfio_region_gfx_edid {
> >>  #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
> >>  };
> >>  
> >> +/*
> >> + * 10de vendor sub-type
> >> + *
> >> + * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
> >> + */
> >> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
> >> +
> >> +/*
> >> + * 1014 vendor sub-type
> >> + *
> >> + * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
> >> + * to do TLB invalidation on a GPU.
> >> + */
> >> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> >> +
> >>  /*
> >>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
> >>   * which allows direct access to non-MSIX registers which happened to be within
> >> @@ -363,6 +378,28 @@ struct vfio_region_gfx_edid {
> >>   */
> >>  #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
> >>  
> >> +/*
> >> + * Capability with compressed real address (aka SSA - small system address)
> >> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
> >> + */
> >> +#define VFIO_REGION_INFO_CAP_NVLINK2_SSATGT	4
> >> +
> >> +struct vfio_region_info_cap_nvlink2_ssatgt {
> >> +	struct vfio_info_cap_header header;
> >> +	__u64 tgt;
> >> +};
> >> +
> >> +/*
> >> + * Capability with an NVLink link speed.
> >> + */  
> > 
> > I was really hoping for something more like SSATGT above indicating the
> > intended users and purpose, and an update to SSATGT since it's now used
> > by both the GPU and NPU2.  This comment is correct, but it's basically
> > useless, it doesn't provide any information that isn't readily apparent
> > from the structure definition.  AIUI, SSATGT is used not only for the
> > GPU to determine where its RAM is mapped on the system bus, but also by
> > the NPU2 to associate itself to a GPU, right?  
> 
> Correct. It could be improved by
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5562587..ff238ef9c 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -380,7 +380,8 @@ struct vfio_region_gfx_edid {
> 
>  /*
>   * Capability with compressed real address (aka SSA - small system address)
> - * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing
> + * and by the userspace to associate a NVLink bridge with a GPU.
>   */
>  #define VFIO_REGION_INFO_CAP_NVLINK2_SSATGT    4
> 
> 
> 
> > And the link speed here
> > is consumed by the NPU2 in order to fill in DT information for the
> > guest for compatibility and possibly routing optimizations?  
> 
> 
> It is just some speed number, 8 or 9, one works and the other does not,
> depending on the actual system. The NVIDIA driver handles it in the
> binary blob. The existing comment is not much use but I am really not
> sure what other comment could be useful in here.

So why do we need to expose it?  "Exposed on NPU2 devices for userspace
to export to guest VM via DT(?) or else <something bad happens/doesn't
work> in the guest".  Work with me, there must be some justification
for why it gets exposed, not just what it is.  Thanks,

Alex
