Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D229ECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 21:54:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030ED208E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 21:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030ED208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42b5Z05vXRzF3Zl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 08:54:48 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42b5Ws2Q6bzF3Rv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 08:52:56 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1486D307D90E;
 Wed, 17 Oct 2018 21:52:54 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1D3B1001640;
 Wed, 17 Oct 2018 21:52:52 +0000 (UTC)
Date: Wed, 17 Oct 2018 15:52:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] [10de:1db1] subdriver
Message-ID: <20181017155252.2f15d0f0@w520.home>
In-Reply-To: <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-4-aik@ozlabs.ru>
 <20181016130824.20be215b@w520.home>
 <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 17 Oct 2018 21:52:54 +0000 (UTC)
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
Cc: kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>, Reza Arbab <arbab@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 17 Oct 2018 12:19:20 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 17/10/2018 06:08, Alex Williamson wrote:
> > On Mon, 15 Oct 2018 20:42:33 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> POWER9 Witherspoon machines come with 4 or 6 V100 GPUs which are not
> >> pluggable PCIe devices but implement PCIe links for config space and MMIO.
> >> In addition to that the GPUs are interconnected to each other and also
> >> have direct links to the P9 CPU. The links are NVLink2 and provide direct
> >> access to the system RAM for GPUs via NPU (an NVLink2 "proxy" on P9 chip).
> >> These systems also support ATS (address translation services) which is
> >> a part of the NVLink2 prototol. Such GPUs also share on-board RAM
> >> (16GB in tested config) to the system via the same NVLink2 so a CPU has
> >> cache-coherent access to a GPU RAM.
> >>
> >> This exports GPU RAM to the userspace as a new PCI region. This
> >> preregisters the new memory as device memory as it might be used for DMA.
> >> This inserts pfns from the fault handler as the GPU memory is not onlined
> >> until the NVIDIA driver is loaded and trained the links so doing this
> >> earlier produces low level errors which we fence in the firmware so
> >> it does not hurt the host system but still better to avoid.
> >>
> >> This exports ATSD (Address Translation Shootdown) register of NPU which
> >> allows the guest to invalidate TLB. The register conviniently occupies
> >> a single 64k page. Since NPU maps the GPU memory, it has a "tgt" property
> >> (which is an abbreviated host system bus address). This exports the "tgt"
> >> as a capability so the guest can program it into the GPU so the GPU can
> >> know how to route DMA trafic.  
> > 
> > I'm not really following what "tgt" is and why it's needed.  Is the GPU
> > memory here different than the GPU RAM region above?  Why does the user
> > need the host system bus address of this "tgt" thing?  Are we not able
> > to relocate it in guest physical address space, does this shootdown
> > only work in the host physical address space and therefore we need this
> > offset?  Please explain, I'm confused.  
> 
> 
> This "tgt" is made of:
> - "memory select" (bits 45, 46)
> - "group select" (bits 43, 44)
> - "chip select" (bit 42)
> - chip internal address (bits 0..41)
> 
> These are internal to GPU and this is where GPU RAM is mapped into the
> GPU's real space, this fits 46 bits.
> 
> On POWER9 CPU the bits are different and higher so the same memory is
> mapped higher on P9 CPU. Just because we can map it higher, I guess.
> 
> So it is not exactly the address but this provides the exact physical
> location of the memory.
> 
> We have a group of 3 interconnected GPUs, they got their own
> memory/group/chip numbers. The GPUs use ATS service to translate
> userspace to physical (host or guest) addresses. Now a GPU needs to know
> which specific link to use for a specific physical address, in other
> words what this physical address belongs to - a CPU or one of GPUs. This
> is when "tgt" is used by the GPU hardware.

Clear as mud ;)  So tgt, provided by the npu2 capability of the ATSD
region of the NPU tells the GPU (a completely separate device) how to
route it its own RAM via its NVLink interface?  How can one tgt
indicate the routing for multiple interfaces?

> A GPU could run all the DMA trafic via the system bus indeed, just not
> as fast.
> 
> I am also struggling here and adding an Nvidia person in cc: (I should
> have done that when I posted the patches, my bad) to correct when/if I
> am wrong.
> 
> 
> 
> >    
> >> For ATS to work, the nest MMU (an NVIDIA block in a P9 CPU) needs to
> >> know LPID (a logical partition ID or a KVM guest hardware ID in other
> >> words) and PID (a memory context ID of an userspace process, not to be
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
> >> This hardcodes the NVLink2 support for specific vendor and device IDs
> >> as there is no reliable way of knowing about coherent memory and ATS
> >> support. The GPU has an unique vendor PCIe capability 0x23 but it was
> >> confirmed that it does not provide required information (and it is still
> >> undisclosed what it actually does).
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  drivers/vfio/pci/Makefile           |   1 +
> >>  drivers/vfio/pci/vfio_pci_private.h |   2 +
> >>  include/uapi/linux/vfio.h           |  18 ++
> >>  drivers/vfio/pci/vfio_pci.c         |  37 +++-
> >>  drivers/vfio/pci/vfio_pci_nvlink2.c | 409 ++++++++++++++++++++++++++++++++++++
> >>  drivers/vfio/pci/Kconfig            |   4 +
> >>  6 files changed, 469 insertions(+), 2 deletions(-)
> >>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
> >>
> >> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> >> index 76d8ec0..9662c06 100644
> >> --- a/drivers/vfio/pci/Makefile
> >> +++ b/drivers/vfio/pci/Makefile
> >> @@ -1,5 +1,6 @@
> >>  
> >>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> >>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> >> +vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
> >>  
> >>  obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
> >> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> >> index 93c1738..7639241 100644
> >> --- a/drivers/vfio/pci/vfio_pci_private.h
> >> +++ b/drivers/vfio/pci/vfio_pci_private.h
> >> @@ -163,4 +163,6 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
> >>  	return -ENODEV;
> >>  }
> >>  #endif
> >> +extern int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev);
> >> +extern int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev);
> >>  #endif /* VFIO_PCI_PRIVATE_H */
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index f378b98..9e9a8d3 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -303,6 +303,12 @@ struct vfio_region_info_cap_type {
> >>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> >>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> >>  
> >> +/* NVIDIA GPU NVlink2 RAM */
> >> +#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
> >> +
> >> +/* IBM NPU NVlink2 ATSD */
> >> +#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> >> +  
> > 
> > Please include some of the description in the commitlog here for
> > reference.  Also please be explicit that these are vendor defined
> > regions and note the numerical vendor ID associated with them.  
> 
> These are PCI region subtypes which are not from any PCI spec and which
> we define as we like, are not they all "vendor"?

No, it's not entirely obvious that they're vendor regions, I had to
look at the usage later in the patch.  See linux-next where Gerd has
added an EDID region which is not a vendor region.  You make use of
these by masking VFIO_REGION_TYPE_PCI_VENDOR_TYPE into the type, which
indicates they are a PCI vendor type region, which means they are
associated to a specific vendor.  That vendor should be explicitly,
numerically, indicated (some hardware vendors own multiple PCI vendor
IDs or may acquire more).

> >>  /*
> >>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
> >>   * which allows direct access to non-MSIX registers which happened to be within
> >> @@ -313,6 +319,18 @@ struct vfio_region_info_cap_type {
> >>   */
> >>  #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
> >>  
> >> +/*
> >> + * Capability with compressed real address (aka SSA - small system address)
> >> + * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
> >> + */
> >> +#define VFIO_REGION_INFO_CAP_NPU2		4
> >> +
> >> +struct vfio_region_info_cap_npu2 {
> >> +	struct vfio_info_cap_header header;
> >> +	__u64 tgt;
> >> +	/* size is defined in VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM */  
> > 
> > But this is a capability for the IBM_NVLINK2_ATSD?  What is the
> > relevance of this comment?  Is this capability relevant to the RAM or
> > ATSD?  
> 
> It is relevant to NPU (NVLink host bus adapter of POWER9) which maps the
> GPU RAM to the system bus and acts as a proxy to nestMMU (NVIDIA's unit
> in POWER9 CPU) for ATS/ATSD services so it is a property of NPU. But
> then one might ask "wait, here is the address, where is the size then",
>  hence the comment...

So the tgt field within the npu2 capability of the ATSD region on the
NPU device describes the GPU internal address of the GPU RAM which is
described by the NVLINK2 RAM region on the GPU device... *twitch*  What
business does the NPU have exposing this piece of information and how
is it related to the ATSD region/register?  Is this tgt base used in
the process of doing address translation shootdowns?
 
> >> +};
> >> +
> >>  /**
> >>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
> >>   *				    struct vfio_irq_info)
> >> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> >> index 4a3b93e..e9afd43 100644
> >> --- a/drivers/vfio/pci/vfio_pci.c
> >> +++ b/drivers/vfio/pci/vfio_pci.c
> >> @@ -224,6 +224,16 @@ static bool vfio_pci_nointx(struct pci_dev *pdev)
> >>  	return false;
> >>  }
> >>  
> >> +int __weak vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
> >> +{
> >> +	return -ENODEV;
> >> +}
> >> +
> >> +int __weak vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
> >> +{
> >> +	return -ENODEV;
> >> +}
> >> +
> >>  static int vfio_pci_enable(struct vfio_pci_device *vdev)
> >>  {
> >>  	struct pci_dev *pdev = vdev->pdev;
> >> @@ -302,14 +312,37 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
> >>  		if (ret) {
> >>  			dev_warn(&vdev->pdev->dev,
> >>  				 "Failed to setup Intel IGD regions\n");
> >> -			vfio_pci_disable(vdev);
> >> -			return ret;
> >> +			goto disable_exit;
> >> +		}
> >> +	}
> >> +
> >> +	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
> >> +	    pdev->device == 0x1db1) {
> >> +		ret = vfio_pci_nvdia_v100_nvlink2_init(vdev);
> >> +		if (ret) {
> >> +			dev_warn(&vdev->pdev->dev,
> >> +				 "Failed to setup NVIDIA NV2 RAM region\n");
> >> +			goto disable_exit;
> >> +		}
> >> +	}  
> > 
> > This device ID is not unique to POWER9 Witherspoon systems, I see your
> > comment in the commitlog, but this is clearly going to generate a
> > dev_warn and failure on an x86 system with the same hardware.  Perhaps
> > this could be masked off with IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2) like
> > the IGD code above this chunk does?  
> 
> Right, will fix.
> 
> 
> >> +
> >> +	if (pdev->vendor == PCI_VENDOR_ID_IBM &&
> >> +			pdev->device == 0x04ea) {
> >> +		ret = vfio_pci_ibm_npu2_init(vdev);
> >> +		if (ret) {
> >> +			dev_warn(&vdev->pdev->dev,
> >> +					"Failed to setup NVIDIA NV2 ATSD region\n");
> >> +			goto disable_exit;
> >>  		}  
> > 
> > So the NPU is also actually owned by vfio-pci and assigned to the VM?  
> 
> Yes. On a running system it looks like:
> 
> 0007:00:00.0 Bridge: IBM Device 04ea (rev 01)
> 0007:00:00.1 Bridge: IBM Device 04ea (rev 01)
> 0007:00:01.0 Bridge: IBM Device 04ea (rev 01)
> 0007:00:01.1 Bridge: IBM Device 04ea (rev 01)
> 0007:00:02.0 Bridge: IBM Device 04ea (rev 01)
> 0007:00:02.1 Bridge: IBM Device 04ea (rev 01)
> 0035:00:00.0 PCI bridge: IBM Device 04c1
> 0035:01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> 0035:02:04.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> 0035:02:05.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> 0035:02:0d.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> 0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
> (rev a1
> 0035:04:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
> (rev a1)
> 0035:05:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
> (rev a1)
> 
> One "IBM Device" bridge represents one NVLink2, i.e. a piece of NPU.
> They all and 3 GPUs go to the same IOMMU group and get passed through to
> a guest.
> 
> The entire NPU does not have representation via sysfs as a whole though.

So the NPU is a bridge, but it uses a normal header type so vfio-pci
will bind to it?  And the ATSD register that we need on it is not
accessible through these PCI representations of the sub-pieces of the
NPU?  Thanks,

Alex
