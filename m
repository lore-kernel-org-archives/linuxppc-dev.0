Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02883C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 18:56:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828FB20844
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 18:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828FB20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pwhM1vKbzDqS3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 05:56:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=mst@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pwfN3hdWzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 05:54:48 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3075C05D41E;
 Tue, 29 Jan 2019 18:54:45 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
 by smtp.corp.redhat.com (Postfix) with SMTP id 6977D53;
 Tue, 29 Jan 2019 18:54:43 +0000 (UTC)
Date: Tue, 29 Jan 2019 13:54:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Message-ID: <20190129135345-mutt-send-email-mst@kernel.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190118103235-mutt-send-email-mst@kernel.org>
 <0ba215f5-e856-bf31-8dd9-a85710714a7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba215f5-e856-bf31-8dd9-a85710714a7a@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 29 Jan 2019 18:54:46 +0000 (UTC)
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
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com,
 linux-pci@vger.kernel.org, jasowang@redhat.com, linuxppc-dev@lists.ozlabs.org,
 will.deacon@arm.com, frowand.list@gmail.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, bhelgaas@google.com, robin.murphy@arm.com,
 kvmarm@lists.cs.columbia.edu, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 21, 2019 at 11:29:05AM +0000, Jean-Philippe Brucker wrote:
> Hi,
> 
> On 18/01/2019 15:51, Michael S. Tsirkin wrote:
> > 
> > On Tue, Jan 15, 2019 at 12:19:52PM +0000, Jean-Philippe Brucker wrote:
> >> Implement the virtio-iommu driver, following specification v0.9 [1].
> >>
> >> This is a simple rebase onto Linux v5.0-rc2. We now use the
> >> dev_iommu_fwspec_get() helper introduced in v5.0 instead of accessing
> >> dev->iommu_fwspec, but there aren't any functional change from v6 [2].
> >>
> >> Our current goal for virtio-iommu is to get a paravirtual IOMMU working
> >> on Arm, and enable device assignment to guest userspace. In this
> >> use-case the mappings are static, and don't require optimal performance,
> >> so this series tries to keep things simple. However there is plenty more
> >> to do for features and optimizations, and having this base in v5.1 would
> >> be good. Given that most of the changes are to drivers/iommu, I believe
> >> the driver and future changes should go via the IOMMU tree.
> >>
> >> You can find Linux driver and kvmtool device on v0.9.2 branches [3],
> >> module and x86 support on virtio-iommu/devel. Also tested with Eric's
> >> QEMU device [4]. Please note that the series depends on Robin's
> >> probe-deferral fix [5], which will hopefully land in v5.0.
> >>
> >> [1] Virtio-iommu specification v0.9, sources and pdf
> >>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
> >>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
> >>
> >> [2] [PATCH v6 0/7] Add virtio-iommu driver
> >>     https://lists.linuxfoundation.org/pipermail/iommu/2018-December/032127.html
> >>
> >> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.2
> >>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9.2
> >>
> >> [4] [RFC v9 00/17] VIRTIO-IOMMU device
> >>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html
> >>
> >> [5] [PATCH] iommu/of: Fix probe-deferral
> >>     https://www.spinics.net/lists/arm-kernel/msg698371.html
> > 
> > Thanks for the work!
> > So really my only issue with this is that there's no
> > way for the IOMMU to describe the devices that it
> > covers.
> > 
> > As a result that is then done in a platform-specific way.
> > 
> > And this means that for example it does not solve the problem that e.g.
> > some power people have in that their platform simply does not have a way
> > to specify which devices are covered by the IOMMU.
> 
> Isn't power using device tree? I haven't looked much at power because I
> was told a while ago that they already paravirtualize their IOMMU and
> don't need virtio-iommu, except perhaps for some legacy platforms. Or
> something along those lines. But I would certainly be interested in
> enabling the IOMMU for more architectures.

I have CC'd the relevant ppc developers, let's see what do they think.


> As for the enumeration problem, I still don't think we can get much
> better than DT and ACPI as solutions (and IMO they are necessary to make
> this device portable). But I believe that getting DT and ACPI support is
> just a one-off inconvenience. That is, once the required bindings are
> accepted, any future extension can then be done at the virtio level with
> feature bits and probe requests, without having to update ACPI or DT.
> 
> Thanks,
> Jean
> 
> > Solving that problem would make me much more excited about
> > this device.
> > 
> > On the other hand I can see that while there have been some
> > developments most of the code has been stable for quite a while now.
> > 
> > So what I am trying to do right about now, is making a small module that
> > loads early and pokes at the IOMMU sufficiently to get the data about
> > which devices use the IOMMU out of it using standard virtio config
> > space.  IIUC it's claimed to be impossible without messy changes to the
> > boot sequence.
> > 
> > If I succeed at least on some platforms I'll ask that this design is
> > worked into this device, minimizing info that goes through DT/ACPI.  If
> > I see I can't make it in time to meet the next merge window, I plan
> > merging the existing patches using DT (barring surprises).
> > 
> > As I only have a very small amount of time to spend on this attempt, If
> > someone else wants to try doing that in parallel, that would be great!
> > 
> > 
> >> Jean-Philippe Brucker (7):
> >>   dt-bindings: virtio-mmio: Add IOMMU description
> >>   dt-bindings: virtio: Add virtio-pci-iommu node
> >>   of: Allow the iommu-map property to omit untranslated devices
> >>   PCI: OF: Initialize dev->fwnode appropriately
> >>   iommu: Add virtio-iommu driver
> >>   iommu/virtio: Add probe request
> >>   iommu/virtio: Add event queue
> >>
> >>  .../devicetree/bindings/virtio/iommu.txt      |   66 +
> >>  .../devicetree/bindings/virtio/mmio.txt       |   30 +
> >>  MAINTAINERS                                   |    7 +
> >>  drivers/iommu/Kconfig                         |   11 +
> >>  drivers/iommu/Makefile                        |    1 +
> >>  drivers/iommu/virtio-iommu.c                  | 1158 +++++++++++++++++
> >>  drivers/of/base.c                             |   10 +-
> >>  drivers/pci/of.c                              |    7 +
> >>  include/uapi/linux/virtio_ids.h               |    1 +
> >>  include/uapi/linux/virtio_iommu.h             |  161 +++
> >>  10 files changed, 1449 insertions(+), 3 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
> >>  create mode 100644 drivers/iommu/virtio-iommu.c
> >>  create mode 100644 include/uapi/linux/virtio_iommu.h
> >>
> >> -- 
> >> 2.19.1
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > 
