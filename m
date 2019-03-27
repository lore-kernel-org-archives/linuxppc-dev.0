Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8095DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 14:12:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83B22087C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYt+osEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83B22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Tqgm12npzDqQB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 01:12:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SYt+osEd"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tqdg1P65zDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 01:10:14 +1100 (AEDT)
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9051F2075E;
 Wed, 27 Mar 2019 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553695811;
 bh=bgHB+wJN6vYjXHAxa3KCEexObQLCB+901YU2ya0y75A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SYt+osEdoZYOgisiMPKPhFzvFyoSJCIt4La2KxqyGNE7Ex9FIa4m9lH0BS4ZNq9Mi
 Rb8YbEzUngku86fB+uX+rtKV+olOEmOEFt5wIse/eVt7joPNUiY116OHZI+iXbUKDk
 djsnYUxxrbwqRPABloq7D0VjkxPuAVU6VK5Pez34=
Date: Wed, 27 Mar 2019 09:10:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH v5 0/8] powerpc/powernv/pci: Make hotplug
 self-sufficient, independent of FW and DT
Message-ID: <20190327141010.GB24180@google.com>
References: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-pci@vger.kernel.org,
 linux@yadro.com, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Sergey,

Since this doesn't touch drivers/pci, I assume powerpc folks will
handle this series.  Let me know if otherwise.

On Mon, Mar 11, 2019 at 02:52:25PM +0300, Sergey Miroshnichenko wrote:
> This patchset allows switching from the pnv_php module to the standard
> pciehp driver for PCIe hotplug functionality, if the platform supports it:
> PowerNV working on on top of the skiboot with the "core/pci: Sync VFs and
> the changes of bdfns between the firmware and the OS" [1] patch serie
> applied.

s/bdfns/BDFs/  Maybe?  I see this is a reference to another patch
  series, but if it hasn't been merged yet, "BDFs" would be consistent
  with "VFs" and give a hint that "bdfns" is not itself a word.

s/serie/series/

> The feature is activated by the "pci=realloc" command line argument.

From a user point of view, it doesn't seem intuitive that
"pci=realloc" also means "switch from pnv_php to pciehp".

The only direct effect of "pci=realloc" is to set pci_realloc_enable.
I haven't read the patches, but is there really something in
arch/powerpc/ that does something different based on
pci_realloc_enable?

> The goal is ability to hotplug bridges full of devices in the future. The
> "Movable BARs" [2] is a platform-independent part of our work in this. The
> final part will be movable bus numbers to support inserting a bridge in the
> middle of an existing PCIe tree.
> 
> Tested on POWER8 PowerNV+PHB3 ppc64le (our Vesnin server) with:
>  - the pciehp driver active;
>  - the pnv_php driver disabled;
>  - The "pci=realloc" argument is passed;
>  - surprise hotplug of an NVME disk works;
>  - controlled hotplug of a network card with SR-IOV works;
>  - activating of SR-IOV on a network card works;
>  - [with extra patches] manually initiated (via sysfs) rescan has found
>    and turned on a hotplugged bridge;
>  - Without "pci=realloc" works just as before.
> 
> Changes since v4:
>  - Fixed failing build when EEH is disabled in a kernel config;
>  - Unfreeze the bus on EEH_IO_ERROR_VALUE(size), not only 0xffffffff;
>  - Replaced the 0xff magic constant with phb->ioda.reserved_pe_idx;
>  - Renamed create_pdn() -> pci_create_pdn_from_dev();
>  - Renamed add_one_dev_pci_data(..., vf_index, ...) -> pci_alloc_pdn();
>  - Renamed add_dev_pci_data() -> pci_create_vf_pdns();
>  - Renamed remove_dev_pci_data() -> pci_destroy_vf_pdns();
>  - Removed the patch fixing uninitialized IOMMU group - now it is fixed in
>    commit 8f5b27347e88 ("powerpc/powernv/sriov: Register IOMMU groups for
>    VFs")
> 
> Changes since v3 [3]:
>  - Subject changed;
>  - Don't disable EEH during rescan anymore - instead just unfreeze the
>    target buses deliberately;
>  - Add synchronization with the firmware when changing the PCIe topology;
>  - Fixed for VFs;
>  - Code cleanup.
> 
> Changes since v2:
>  - Don't reassign bus numbers on PowerNV by default (to retain the default
>    behavior), but only when pci=realloc is passed;
>  - Less code affected;
>  - pci_add_device_node_info is refactored with add_one_dev_pci_data;
>  - Minor code cleanup.
> 
> Changes since v1:
>  - Fixed build for ppc64le and ppc64be when CONFIG_PCI_IOV is disabled;
>  - Fixed build for ppc64e when CONFIG_EEH is disabled;
>  - Fixed code style warnings.
> 
> [1] https://lists.ozlabs.org/pipermail/skiboot/2019-March/013571.html
> [2] https://www.spinics.net/lists/linux-pci/msg79995.html
> [3] https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-September/178053.html
> 
> Sergey Miroshnichenko (8):
>   powerpc/pci: Access PCI config space directly w/o pci_dn
>   powerpc/powernv/pci: Suppress an EEH error when reading an empty slot
>   powerpc/pci: Create pci_dn on demand
>   powerpc/pci: Reduce code duplication in pci_add_device_node_info
>   powerpc/pci/IOV: Add support for runtime enabling the VFs
>   powerpc/pci: Don't rely on DT is the PCI_REASSIGN_ALL_BUS is set
>   powerpc/powernv/pci: Hook up the writes to PCI_SECONDARY_BUS register
>   powerpc/powernv/pci: Enable reassigning the bus numbers
> 
>  arch/powerpc/include/asm/pci-bridge.h        |   4 +-
>  arch/powerpc/include/asm/ppc-pci.h           |   1 +
>  arch/powerpc/kernel/pci_dn.c                 | 170 ++++++++++-----
>  arch/powerpc/kernel/rtas_pci.c               |  97 ++++++---
>  arch/powerpc/platforms/powernv/eeh-powernv.c |   2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c    |   4 +-
>  arch/powerpc/platforms/powernv/pci.c         | 205 +++++++++++++++++--
>  arch/powerpc/platforms/pseries/pci.c         |   4 +-
>  8 files changed, 379 insertions(+), 108 deletions(-)
> 
> -- 
> 2.20.1
> 
