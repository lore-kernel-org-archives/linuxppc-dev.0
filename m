Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADECC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 16:38:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14692064A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 16:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14692064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NzJQ2VrdzDqDs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:38:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NzFz6pX8zDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 03:36:23 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D71E930BC643;
 Tue, 19 Mar 2019 16:36:20 +0000 (UTC)
Received: from x1.home (ovpn-116-218.phx2.redhat.com [10.3.116.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1CB1001DD9;
 Tue, 19 Mar 2019 16:36:19 +0000 (UTC)
Date: Tue, 19 Mar 2019 10:36:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel RFC 2/2] vfio-pci-nvlink2: Implement interconnect
 isolation
Message-ID: <20190319103619.6534c7df@x1.home>
In-Reply-To: <20190315081835.14083-3-aik@ozlabs.ru>
References: <20190315081835.14083-1-aik@ozlabs.ru>
 <20190315081835.14083-3-aik@ozlabs.ru>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 19 Mar 2019 16:36:21 +0000 (UTC)
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 15 Mar 2019 19:18:35 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe links and
> (on POWER9) NVLinks. In addition to that, GPUs themselves have direct
> peer to peer NVLinks in groups of 2 to 4 GPUs. At the moment the POWERNV
> platform puts all interconnected GPUs to the same IOMMU group.
> 
> However the user may want to pass individual GPUs to the userspace so
> in order to do so we need to put them into separate IOMMU groups and
> cut off the interconnects.
> 
> Thankfully V100 GPUs implement an interface to do by programming link
> disabling mask to BAR0 of a GPU. Once a link is disabled in a GPU using
> this interface, it cannot be re-enabled until the secondary bus reset is
> issued to the GPU.
> 
> This defines a reset_done() handler for V100 NVlink2 device which
> determines what links need to be disabled. This relies on presence
> of the new "ibm,nvlink-peers" device tree property of a GPU telling which
> PCI peers it is connected to (which includes NVLink bridges or peer GPUs).
> 
> This does not change the existing behaviour and instead adds
> a new "isolate_nvlink" kernel parameter to allow such isolation.
> 
> The alternative approaches would be:
> 
> 1. do this in the system firmware (skiboot) but for that we would need
> to tell skiboot via an additional OPAL call whether or not we want this
> isolation - skiboot is unaware of IOMMU groups.
> 
> 2. do this in the secondary bus reset handler in the POWERNV platform -
> the problem with that is at that point the device is not enabled, i.e.
> config space is not restored so we need to enable the device (i.e. MMIO
> bit in CMD register + program valid address to BAR0) in order to disable
> links and then perhaps undo all this initialization to bring the device
> back to the state where pci_try_reset_function() expects it to be.

The trouble seems to be that this approach only maintains the isolation
exposed by the IOMMU group when vfio-pci is the active driver for the
device.  IOMMU groups can be used by any driver and the IOMMU core is
incorporating groups in various ways.  So, if there's a device specific
way to configure the isolation reported in the group, which requires
some sort of active management against things like secondary bus
resets, then I think we need to manage it above the attached endpoint
driver.  Ideally I'd see this as a set of PCI quirks so that we might
leverage it beyond POWER platforms.  I'm not sure how we get past the
reliance on device tree properties that we won't have on other
platforms though, if only NVIDIA could at least open a spec addressing
the discovery and configuration of NVLink registers on their
devices :-\  Thanks,

Alex
