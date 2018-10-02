Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F89C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 21:02:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25DC2082A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 21:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrlUApMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25DC2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Ps6y6b47zF3F4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 07:02:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VrlUApMo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="VrlUApMo"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ps2h3jf2zF3FT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 06:59:07 +1000 (AEST)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 430B12082A;
 Tue,  2 Oct 2018 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538513945;
 bh=NhShGRlF3tvA3wPqMetEvDsa+MXMBWRWcegxI0YNFUQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VrlUApMoHYMLzjumPIlCSSIgIIKQ8IBo3cly3bPbZ6rMCxrrSFR2Qen2Ljvvn6rsg
 uu3M9ERNwPR7ZWRZlriqVlR4pDu0NLzS8SU13jwcn27jfCIzyQIzfdHDaE+OM4mF/W
 hsSmQFg18TrNMExTlRVbce97ivlHjiB7qe60yz0Q=
Date: Tue, 2 Oct 2018 15:59:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 00/15] PCI: turn some __weak functions into callbacks
Message-ID: <20181002205903.GD120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817102645.3839621-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 17, 2018 at 12:26:30PM +0200, Arnd Bergmann wrote:
> Hi Bjorn and others,
> 
> Triggered by Christoph's patches, I had another go at converting
> all of the remaining pci host bridge implementations to be based
> on pci_alloc_host_bridge and a separate registration function.
> 
> This is made possible through work from Lorenzo and others to
> convert many of the existing drivers, as well as the removal
> of some of the older architectures that nobody used.
> 
> I'm adding a bit of duplication into the less maintained code
> here, but it makes everything more consistent, and gives an
> easy place to hook up callback functions etc.
> 
> The three parts of this series are:
> 
> a) push up the registration into the callers (this is where
>    code gets added)
> b) clean up some of the more common host bridge
>    implementations again to integrate that code better.
>    This could be done for the rest as well, or we could just
>    leave them alone.
> c) start moving the __weak functions into callbacks in
>    pci_host_bridge. This is intentionally incomplete, since
>    it is a lot of work to do it for all those functions,
>    and I want to get consensus on the approach first, as well
>    as maybe get other developers to help out with the rest.
> 
> Please have a look.
> 
>        Arnd
> 
> [1] https://lore.kernel.org/lkml/4288331.jNpl6KXlNO@wuerfel/
> [2] https://patchwork.kernel.org/patch/10555657/
> 
> Arnd Bergmann (15):
>   PCI: clean up legacy host bridge scan functions
>   PCI: move pci_scan_bus into callers
>   PCI: move pci_scan_root_bus into callers
>   PCI: export pci_register_host_bridge
>   PCI: move pci_create_root_bus into callers
>   powerpc/pci: fold pci_create_root_bus into pcibios_scan_phb
>   PCI/ACPI: clean up acpi_pci_root_create()
>   x86: PCI: clean up pcibios_scan_root()
>   PCI: xenfront: clean up pcifront_scan_root()
>   sparc/PCI: simplify pci_scan_one_pbm
>   PCI: hyperv: convert to pci_scan_root_bus_bridge
>   PCI: make pcibios_bus_add_device() a callback function
>   PCI: turn pcibios_alloc_irq into a callback
>   PCI: make pcibios_root_bridge_prepare a callback
>   PCI: make pcibios_add_bus/remove_bus callbacks
> 
>  arch/arm64/kernel/pci.c               |  40 ++-----
>  arch/ia64/pci/pci.c                   |  25 +----
>  arch/ia64/sn/kernel/io_init.c         |  27 +++++
>  arch/microblaze/pci/pci-common.c      |  27 +++++
>  arch/powerpc/include/asm/pci-bridge.h |   3 +
>  arch/powerpc/kernel/pci-common.c      |  60 +++++------
>  arch/s390/pci/pci.c                   |  30 +++++-
>  arch/sh/drivers/pci/pci.c             |   1 +
>  arch/sh/drivers/pci/pcie-sh7786.c     |   3 +-
>  arch/sh/include/asm/pci.h             |   2 +
>  arch/sparc/kernel/pci.c               |  40 ++++---
>  arch/sparc/kernel/pcic.c              |  35 ++++++
>  arch/x86/pci/acpi.c                   |  15 +--
>  arch/x86/pci/common.c                 |  42 ++++----
>  arch/xtensa/kernel/pci.c              |  27 +++++
>  drivers/acpi/pci_root.c               |  43 +++++---
>  drivers/parisc/dino.c                 |  28 +++++
>  drivers/parisc/lba_pci.c              |  28 +++++
>  drivers/pci/bus.c                     |   8 +-
>  drivers/pci/controller/pci-hyperv.c   |  47 ++++----
>  drivers/pci/controller/vmd.c          |  30 +++++-
>  drivers/pci/hotplug/ibmphp_core.c     |  35 ++++++
>  drivers/pci/pci-driver.c              |  13 ++-
>  drivers/pci/probe.c                   | 150 +++++++++-----------------
>  drivers/pci/xen-pcifront.c            |  40 +++----
>  include/linux/acpi.h                  |   2 +
>  include/linux/pci.h                   |  17 ++-
>  27 files changed, 514 insertions(+), 304 deletions(-)

Sorry for the late response to this.

I think I'm generally on-board with this.  I admit I'm a little
hesitant about adding 200 lines of code when this is really more
"cleanup" than new functionality, but I think a lot of that is because
this series contains costs (e.g., duplicating code) for everybody but
only has the corresponding benefits for a few (ACPI, x86, xenfront).
Those cases are much closer to parity in terms of lines added/removed.

I saw some minor comments that suggested you had some updates, so I'll
watch for an updated posting.

Bjorn
