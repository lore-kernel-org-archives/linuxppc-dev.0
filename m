Return-Path: <linuxppc-dev+bounces-5267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33919E77188
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2025 23:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXm9R5G6Dz30hG;
	Wed, 15 Jan 2025 10:51:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736898667;
	cv=none; b=Kv4oYro+UH8mTYp608uUORcu5H//ECOP/cHokmgBg0xd7IzkqKe/cq4dRF04UdXHdVDNRTRzM5LXJi6GocXNS/UCOcWOxd/uEWDRo9rI+zTyl2oGgX2d7am5jw32f9ploWk4epRHLVo+3evTIjo8mZeLvUghZBZ5S25GUaDI1Tjs8JLmSZ1ZPHepijRvJK31tP2fhVt5+8uu4cvpvPNCEzP9JcnZBILU1j5ztMBvqDoV7UrCN1lpqG9capQa2FW27TTWlvBTGbxq5VqSzpq8YJ/ZCce8jS+76s+DpZhbihM6Msv22XfbcX3ZxkoqGIQlNlNYmNpuex+gZUtR81mqig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736898667; c=relaxed/relaxed;
	bh=Vp2Ceh3wy3Trj6tonIM2IciO6YsnTOI8MGsJ3uAa2YA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X0lDUA8U6F7DX9Ad+NzqmfmYFoum026UMFE9hU+Ioj8dP8yFga0KBcrzBzQ7Sf1m2LkoMmVwyGSZyopIXJABf5r6D4u36Esgy+digGBSNyjTfpbvsrLVNwB57L8PJ3xdO6pTVSI9xEgmy20r9F2BdTj/jd3i89vtHSrtV9rRkQtaphw563Iyq4JfhnXAfrrG/27X8fxQgGLhsEmd8nNZjMbLypoZWyrvqW9nN4yQSvjd7GPSNkaHvgKz18XWqBOYXPmUBg9c1avrr0ydCOP8qvZFJsbswmtWtw+cX8il+nQDXEfpZPzHma9RsB6dqX1SA0V+yCly5L3lSWfJMLNlvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZF2esIB/; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZF2esIB/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXm9Q2PcBz30gv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2025 10:51:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D08E95C55E0;
	Tue, 14 Jan 2025 23:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3208EC4CEDD;
	Tue, 14 Jan 2025 23:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736898663;
	bh=waaozwHAhhKkmwVx8uOafsSyb6MsS7BcvNldbx4m4EY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZF2esIB/dzyq+77rWYSifyTfLbdQOyk1S3D9YVYg9k2RbSXQDbUvF8gQtrfq+3WXt
	 A1wXQVGuWpj9JGv4XuN8aNZI1Ri7NnxCl3UHOFNfhDtLInO2ed29YYmvN5VxsEcHRP
	 xVOKsSh2jbKGRiEob8USkGuCLs/EQx9I5JdptDzEbOAbaf7jQxqHvG0FuI0Horoda2
	 mlPymWepIVjtRduF3YodcSt7xuJ1Dho/LWNk/QR6hCv2gpEwB++TgSHdK5zU7DF8JA
	 rCjxZS/QzvpB8B2c/nW/9ulMjH3l/B0N3aRP/NLKEs/NYcpolZZJVZsAtPpAt3WAoO
	 pAJqPWi6o1VpQ==
Date: Tue, 14 Jan 2025 17:51:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 0/8] PCI: Consolidate TLP Log reading and printing
Message-ID: <20250114235101.GA507662@bhelgaas>
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
In-Reply-To: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>

On Tue, Jan 14, 2025 at 07:08:32PM +0200, Ilpo Järvinen wrote:
> This series has the remaining patches of the AER & DPC TLP Log handling
> consolidation and now includes a few minor improvements to the earlier
> accepted TLP Logging code.
> 
> v9:
> - Added patch to define header logging register sizes.
> 
> v8:
> - Added missing parameter to kerneldoc.
> - Dropped last patch due to conflict with the pci_printk() cleanup
>   series (will move the patch into that series).
> 
> v7:
> - Explain in commit message reasoning why eetlp_prefix_max stores Max
>   End-End TLP Prefixes value instead of limiting it by the bridge/RP
>   imposed limits
> - Take account TLP Prefix Log Present flag.
> - Align PCI_ERR_CAP_* flags in pci_regs.h
> - Add EE_PREFIX_STR define to be able to take its sizeof() for output
>   char[] sizing.
> 
> v6:
> - Preserve "AER:"/"DPC:" prefix on the printed TLP line
> - New patch to add "AER:" also  on other lines of the AER error dump
> 
> v5:
> - Fix build with AER=y and DPC=n
> - Match kerneldoc and function parameter name
> 
> v4:
> - Added patches:
> 	- Remove EXPORT of pcie_read_tlp_log()
> 	- Moved code to pcie/tlp.c and build only with AER enabled
> 	- Match variables in prototype and function
> 	- int -> unsigned int conversion
> 	- eetlp_prefix_max into own patch
> - struct pcie_tlp_log param consistently called "log" within tlp.c
> - Moved function prototypes into drivers/pci/pci.h
> - Describe AER/DPC differences more clearly in one commit message
> 
> v3:
> - Small rewording in a commit message
> 
> v2:
> - Don't add EXPORT()s
> - Don't include igxbe changes
> - Don't use pr_cont() as it's incompatible with pci_err() and according
>   to Andy Shevchenko should not be used in the first place
> 
> 
> Ilpo Järvinen (8):
>   PCI: Don't expose pcie_read_tlp_log() outside of PCI subsystem
>   PCI: Move TLP Log handling to own file
>   PCI: Add defines for TLP Header/Prefix log sizes
>   PCI: Make pcie_read_tlp_log() signature same
>   PCI: Use unsigned int i in pcie_read_tlp_log()
>   PCI: Store # of supported End-End TLP Prefixes
>   PCI: Add TLP Prefix reading into pcie_read_tlp_log()
>   PCI: Create helper to print TLP Header and Prefix Log
> 
>  drivers/pci/ats.c             |   2 +-
>  drivers/pci/pci.c             |  28 ---------
>  drivers/pci/pci.h             |   9 +++
>  drivers/pci/pcie/Makefile     |   2 +-
>  drivers/pci/pcie/aer.c        |  15 ++---
>  drivers/pci/pcie/dpc.c        |  22 +++----
>  drivers/pci/pcie/tlp.c        | 115 ++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c           |  14 +++--
>  drivers/pci/quirks.c          |   6 +-
>  include/linux/aer.h           |  12 +++-
>  include/linux/pci.h           |   2 +-
>  include/uapi/linux/pci_regs.h |  11 ++--
>  12 files changed, 172 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/pci/pcie/tlp.c

Applied to pci/err for v6.14, thanks!

