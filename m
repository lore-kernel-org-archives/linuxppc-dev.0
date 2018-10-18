Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B5C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 18:08:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AFA2145D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 18:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AFA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bcVv49SbzDqdv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:08:55 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bcQW1936zF3FX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 05:05:06 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B11F830832CF;
 Thu, 18 Oct 2018 18:05:04 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6959E105704B;
 Thu, 18 Oct 2018 18:05:03 +0000 (UTC)
Date: Thu, 18 Oct 2018 12:05:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] [10de:1db1] subdriver
Message-ID: <20181018120502.057feb7a@w520.home>
In-Reply-To: <0e0db29d-a1e8-af85-b715-c1ba1a2f3875@nvidia.com>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-4-aik@ozlabs.ru>
 <20181016130824.20be215b@w520.home>
 <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
 <20181017155252.2f15d0f0@w520.home>
 <2175dbbd-21d9-df26-67f5-4b41f90ab1bc@ozlabs.ru>
 <20181018105503.088a343f@w520.home>
 <0e0db29d-a1e8-af85-b715-c1ba1a2f3875@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 18 Oct 2018 18:05:04 +0000 (UTC)
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
Cc: Reza Arbab <arbab@linux.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 18 Oct 2018 10:37:46 -0700
Piotr Jaroszynski <pjaroszynski@nvidia.com> wrote:

> On 10/18/18 9:55 AM, Alex Williamson wrote:
> > On Thu, 18 Oct 2018 11:31:33 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> On 18/10/2018 08:52, Alex Williamson wrote:  
> >>> On Wed, 17 Oct 2018 12:19:20 +1100
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>      
> >>>> On 17/10/2018 06:08, Alex Williamson wrote:  
> >>>>> On Mon, 15 Oct 2018 20:42:33 +1100
> >>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:    
> >>>>>> +
> >>>>>> +	if (pdev->vendor == PCI_VENDOR_ID_IBM &&
> >>>>>> +			pdev->device == 0x04ea) {
> >>>>>> +		ret = vfio_pci_ibm_npu2_init(vdev);
> >>>>>> +		if (ret) {
> >>>>>> +			dev_warn(&vdev->pdev->dev,
> >>>>>> +					"Failed to setup NVIDIA NV2 ATSD region\n");
> >>>>>> +			goto disable_exit;
> >>>>>>   		}  
> >>>>>
> >>>>> So the NPU is also actually owned by vfio-pci and assigned to the VM?  
> >>>>
> >>>> Yes. On a running system it looks like:
> >>>>
> >>>> 0007:00:00.0 Bridge: IBM Device 04ea (rev 01)
> >>>> 0007:00:00.1 Bridge: IBM Device 04ea (rev 01)
> >>>> 0007:00:01.0 Bridge: IBM Device 04ea (rev 01)
> >>>> 0007:00:01.1 Bridge: IBM Device 04ea (rev 01)
> >>>> 0007:00:02.0 Bridge: IBM Device 04ea (rev 01)
> >>>> 0007:00:02.1 Bridge: IBM Device 04ea (rev 01)
> >>>> 0035:00:00.0 PCI bridge: IBM Device 04c1
> >>>> 0035:01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> >>>> 0035:02:04.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> >>>> 0035:02:05.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> >>>> 0035:02:0d.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> >>>> 0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
> >>>> (rev a1
> >>>> 0035:04:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
> >>>> (rev a1)
> >>>> 0035:05:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
> >>>> (rev a1)
> >>>>
> >>>> One "IBM Device" bridge represents one NVLink2, i.e. a piece of NPU.
> >>>> They all and 3 GPUs go to the same IOMMU group and get passed through to
> >>>> a guest.
> >>>>
> >>>> The entire NPU does not have representation via sysfs as a whole though.  
> >>>
> >>> So the NPU is a bridge, but it uses a normal header type so vfio-pci
> >>> will bind to it?  
> >>
> >> An NPU is a NVLink bridge, it is not PCI in any sense. We (the host
> >> powerpc firmware known as "skiboot" or "opal") have chosen to emulate a
> >> virtual bridge per 1 NVLink on the firmware level. So for each physical
> >> NPU there are 6 virtual bridges. So the NVIDIA driver does not need to
> >> know much about NPUs.
> >>  
> >>> And the ATSD register that we need on it is not
> >>> accessible through these PCI representations of the sub-pieces of the
> >>> NPU?  Thanks,  
> >>
> >> No, only via the device tree. The skiboot puts the ATSD register address
> >> to the PHB's DT property called 'ibm,mmio-atsd' of these virtual bridges.  
> > 
> > Ok, so the NPU is essential a virtual device already, mostly just a
> > stub.  But it seems that each NPU is associated to a specific GPU, how
> > is that association done?  In the use case here it seems like it's just
> > a vehicle to provide this ibm,mmio-atsd property to guest DT and the tgt
> > routing information to the GPU.  So if both of those were attached to
> > the GPU, there'd be no purpose in assigning the NPU other than it's in
> > the same IOMMU group with a type 0 header, so something needs to be
> > done with it.  If it's a virtual device, perhaps it could have a type 1
> > header so vfio wouldn't care about it, then we would only assign the
> > GPU with these extra properties, which seems easier for management
> > tools and users.  If the guest driver needs a visible NPU device, QEMU
> > could possibly emulate one to make the GPU association work
> > automatically.  Maybe this isn't really a problem, but I wonder if
> > you've looked up the management stack to see what tools need to know to
> > assign these NPU devices and whether specific configurations are
> > required to make the NPU to GPU association work.  Thanks,  
> 
> I'm not that familiar with how this was originally set up, but note that 
> Alexey is just making it work exactly like baremetal does. The baremetal 
> GPU driver works as-is in the VM and expects the same properties in the 
> device-tree. Obviously it doesn't have to be that way, but there is 
> value in keeping it identical.
> 
> Another probably bigger point is that the NPU device also implements the 
> nvlink HW interface and is required for actually training and 
> maintaining the link up. The driver in the guest trains the links by 
> programming both the GPU end and the NPU end of each link so the NPU 
> device needs to be exposed to the guest.

Ok, so there is functionality in assigning the NPU device itself, it's
not just an attachment point for meta data.  But it still seems there
must be some association of NPU to GPU, the tgt address seems to pair
the NPU with a specific GPU, they're not simply a fungible set of NPUs
and GPUs.  Is that association explicit anywhere or is it related to
the topology or device numbering that needs to match between the host
and guest?  Thanks,

Alex
