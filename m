Return-Path: <linuxppc-dev+bounces-6384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA27C021B3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Feb 2025 23:44:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z06DP19dRz30Tp;
	Sat, 22 Feb 2025 10:44:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740181477;
	cv=none; b=QZ3nSZZ9XwVAPdlg6bdH852GxsSgLvh3Y9liI96PMTrLzLW0W4+RVsCjFBAVEtrdhxsOk9IBnQKnYABoRXU8ATm//fw545MTcN3bNQ4SrNrqiDBkRBzZOwjsulpJuCN3YCSyqzwHoSFyYtID776Sry4eCDozRfi6bZNx5zn/+OWRa8N9YegrkElC/Jv8BiyQedSjO6t5G4m9bcJlXu+Ay3ne9CtvkV71lYhTtF47mlD1qA2mvOqXD6vzX4T7iw4+5DDYkcVwD6Z8CEZCIVpPgBSJMJE5BOTE3Y3fOTQP7Y+NQxuH56fyOQ2qFw2GguJIIcyUhol3D48NxurB34ZumA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740181477; c=relaxed/relaxed;
	bh=gwo41Pjm3L6xf8PtHRtkSXtE6BLwPjGeqiymkPUdRLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lR3B+h2hVrOlLrbPXrQR+EVlJX6Te+9IB3QExYeLxXcaCYyBGsL59CLJCCKi5aGLqRSeLB8cc+FmLR/lSBkSfFCJEClrrmquyZzZ3W70p/ccE2p4PXt/8IPmtqZgnU77qjxgEX3wbBOvDmeFT5hgD8A6MoGzFZwDnf4A2Pr8UvVLT3VClFvpY5xnhKGQnkSYvLYStHzm3DsD+9YnrV8oddU0+9khdRLZmAKpjNkB4+hz4ug4MD8BxzMPqhYwzAB0e/KiVIxukzYQec+uCbBF1PHPYpAJ3hjD+07rz79jMJdv7yewJrmIT6v71Us/UYjDFmSxXJrDateBYS7Mcq42ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f5fX07bn; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f5fX07bn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 476 seconds by postgrey-1.37 at boromir; Sat, 22 Feb 2025 10:44:36 AEDT
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z06DN3DMYz2yFB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2025 10:44:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 18CE76136C;
	Fri, 21 Feb 2025 23:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FF8C4CED6;
	Fri, 21 Feb 2025 23:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181002;
	bh=SjESwENVnWgYJ0MUOGBAyfyIRNDQRBm3rm93k+YwaWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f5fX07bnD7HFmEbABZI8ZpxJKvoAbxeYdI7XXSiyCgbDuCb3Rg/inP855rtpQNZHG
	 LTQVtXxyEScvsiFJ8Z2c4Zi6Vgc4yytP5Es38qFs1Jexwai1jx/cHIccvh4N/WgpYQ
	 zhWaUD+M5t5lXbjb2uBQCi7RzZvunSMntj+0yNi17qjD3UeOeN87Fv8MH/p3qRiz7z
	 HZwPQB3BirdyOWe6GaxQk1JagR7YNOamRJBa4WD4jEVZ9CXqzptipJMBsmyWIK0I3B
	 TW6I7hQUEdkMuQdEuCjPXe7xtN40gnH/Ug8uPI+d2FU2x346RU81CP/LfKpY9yKA2M
	 lg0XUiYEevpLQ==
Date: Fri, 21 Feb 2025 17:36:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 0/2] PCI: Add support for logging Flit Mode TLPs
 (PCIe6)
Message-ID: <20250221233640.GA372744@bhelgaas>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>

On Fri, Feb 07, 2025 at 06:18:34PM +0200, Ilpo Järvinen wrote:
> This series adds support for Flit Mode (PCIe6).
> 
> v2:
> - Rebased
> 
> Ilpo Järvinen (2):
>   PCI: Track Flit Mode Status & print it with link status
>   PCI: Handle TLP Log in Flit mode
> 
>  drivers/pci/hotplug/pciehp_hpc.c |  5 +--
>  drivers/pci/pci.c                | 12 ++++---
>  drivers/pci/pci.h                |  6 ++--
>  drivers/pci/pcie/aer.c           |  1 +
>  drivers/pci/pcie/dpc.c           | 18 ++++++++--
>  drivers/pci/pcie/tlp.c           | 56 ++++++++++++++++++++++----------
>  drivers/pci/probe.c              |  5 +--
>  include/linux/aer.h              | 12 +++++--
>  include/linux/pci.h              |  1 +
>  include/ras/ras_event.h          | 12 +++----
>  include/uapi/linux/pci_regs.h    |  6 +++-
>  11 files changed, 94 insertions(+), 40 deletions(-)

Applied to pci/aer for v6.15, thanks!

