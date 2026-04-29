Return-Path: <linuxppc-dev+bounces-20301-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED88FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 21:53:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5WJc1tF0z2yMk;
	Thu, 30 Apr 2026 07:53:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777499600;
	cv=none; b=cOBjAy3KHHKNKJNU/abmei4+DXULqAzxssQtY7Hows8txUlo1T8YfPNsbCr2pdnGtXtylc1G/+4cLOd3Gm+sbOlOtamZkmLmwrtVEG4RosEA1hXaAOrTKGJ87oLClpKvwgN5+k3R2MKWRgJs+PLEdyXRg8SnMIMu0V3VtCzzPKfGSh1SeYMIOV+mPS6xZdwKuMHTHU62YVQpZbHBsRAwEdIi0lt98GhPZ1Uj0NIhMkWqlNntlsLzJQOrLBhPMPswrSBkJIeWLcY0zPojR1K+oT1KYpbphG/sHJjJ2BjwQWkTahDJCWtdluuZ32CnLwExURdhSA+CmAYXfkF/LWqfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777499600; c=relaxed/relaxed;
	bh=TzVo9cJFiymgoLOVVCrQnwTMVaF8owCu9OKFC0qxyIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+3yWDLEpwFNIC4VpNiHJbHtGdOjA2JQ5dia1JfiX+ZCfCv+9anyHc0VluVpEF7lHGeWJuNoQ5ZA6dPgVijhcvEZUbSWZsKOJfWAQ6V0Vef5QC7+UTu7P8T2l8HXbtc2/WRKyVML6JihTOGcm5HjUJGkOKR+DmNo5EKkOs961cPJBnCZbP6d1C6Ql2PbPaPc9rF047MHLQKp1uExhVJQObmTrOIm6e4xNKb5rPqOo257GtFYQDDeUb8FMHHjIrQ8tZD6c5jDhbBZuuSvSdC/N9t/eLEk4C1KT995vERp6IcF6BzypoWKlAgdBtFlH2nYO/TPg4cuUtn5vtp/DYo3+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DB9+kZPD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DB9+kZPD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5WJZ4YT8z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 07:53:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DE78542DC4;
	Wed, 29 Apr 2026 21:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDA5C19425;
	Wed, 29 Apr 2026 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777499595;
	bh=QMStOrC9ijSdcmZwpecCfj8cW7cjmtEWxaBR3/UpVls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DB9+kZPDshUQej3kRybqEfvdwkk667Gm6CkHX5VlzJSsCkGdxN0SK66RBIbtcRQiX
	 oR5JEXAjnydRYcR1XVvWKjGNU0kKz3vRPzjlIIomF/G+LQ0IDnd+et2lboaOd8Qc/8
	 WcepsbyXQUbwF/WWXTIE11uuDVG6Vpu6lT02czNXEtD/0Z/ih1iJc/XNmBhnIpFn80
	 QN3DdAaMXmFzbd4t1ZLgozXRJ5n769qzHJuv/YZJfLpmpAt/Zud3+Eb4H963mf/p4+
	 rEdieLZ7HK7keBlOU6yHJ+A7kGjM7uCVMbX9JXbQubG0LkVt/W4rDPibeeifUAjchc
	 zVufsAqHwppjA==
Date: Thu, 30 Apr 2026 06:53:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Lukas Wunner <lukas@wunner.de>, 
	Oliver O'Halloran <oohall@gmail.com>, Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Shuan He <heshuan@bytedance.com>, Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to
 platforms with PCI mmap
Message-ID: <20260429212749.GB3724801@rocinante>
References: <20260422161407.118748-25-kwilczynski@kernel.org>
 <20260429204932.GA318462@bhelgaas>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429204932.GA318462@bhelgaas>

Hello,

> > The resourceN_resize sysfs attributes allow users to resize
> > Resizable BARs (ReBAR).  After a successful resize, the resource
> > attribute groups are removed and recreated so that the updated
> > BAR sizes are reflected in the sysfs files.
> 
> Out of curiosity, where does this removal/recreation happen?  I don't
> see it in pci_resize_resource() or
> pci_do_resource_release_and_resize().

The __resource_resize_store() helper carries the relevant code, per:

  sysfs_remove_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups);

  ret = pci_resize_resource(pdev, n, size, 0);
  if (ret)
  	pci_warn(pdev, "Failed to resize BAR %d: %pe\n",
  		 n, ERR_PTR(ret));

  pci_assign_unassigned_bus_resources(bus);

  if (sysfs_create_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
  	pci_warn(pdev, "Failed to recreate resource groups after BAR resizing\n");

  pci_write_config_word(pdev, PCI_COMMAND, cmd);

This takes place under the device_lock() with a given device woken up using
pci_config_pm_runtime_get().

See for reference:

  https://elixir.bootlin.com/linux/v7.0.1/source/drivers/pci/pci-sysfs.c#L1596

> > Resizable BARs are a PCI Express extended capability
> > (PCI_EXT_CAP_ID_REBAR), which requires PCIe extended config
> > space.
> 
> It sounds like the fact that ReBAR requires extended config space is
> important somehow (beyond just the fact that we can't discover ReBAR
> without it)?  Is there some connection between extended config space
> and mmap?

No, there is no connection between extended configuration space and mmap.

I was trying to establish two separate facts:

  - ReBAR requires PCI Express (for the extended configuration
    space support).
  - Every PCI Express-capable architecture defines either
    HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE.

The commit message should have captured the reasoning better.
 
> > Every PCIe-capable architecture defines either HAVE_PCI_MMAP or
> > ARCH_GENERIC_PCI_MMAP_RESOURCE (via the relevant arch headers
> > or the generic asm-generic/pci.h fallback).  On platforms that
> > define neither, the resource files are not created and the sysfs
> > group remove and create calls in __resource_resize_store() are
> > no-ops.
> 
> What's the connection between ReBAR and mmap?

The connection is somewhat indirect, through the sysfs resource files.

The resourceN_resize attribute exists so userspace can resize a BAR and
then access it through the resourceN sysfs files.  Those resource files
only exist on platforms that define HAVE_PCI_MMAP or
ARCH_GENERIC_PCI_MMAP_RESOURCE.

On architectures without either of these defines, pci_dev_resource_attr_groups
array will be NULL and the sysfs_remove_groups() and sysfs_create_groups()
calls in __resource_resize_store() are no-ops.  And there will be no
resource files to tear down or recreate.

To add, there are some kernel drivers that need ReBAR call pci_resize_resource()
directly (e.g., amdgpu, xe, i915), not through the sysfs attribute.

The only platform without these aforementioned defines is Alpha, which is
conventional PCI only and cannot have ReBAR.  So this guard removes dead
sysfs code on platforms where it can never be executed.

Hope this helps.

Thank you!

	Krzysztof

