Return-Path: <linuxppc-dev+bounces-24562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0914BC44515
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 00:10:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3yTP0cJlz2ySg;
	Tue, 21 Jul 2026 10:10:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784592649;
	cv=none; b=oYIZxwIZ1ZuPgC9C8SeORbdqhJW0O5xechE6SxHhxL4Og+2hEJGD3RGxpQKkVQSoywhdCvpN/hXezrHr3jSI3ozUs5Kx7ZWswF/DCQXha7EcB1nnelEsqwvukmOVE5Cp60iXFFZB2MgbYcqS8pt1eaQEJiIRqEwzYenTr1E1obPqYcmNXnuqvdNY1xG1dujpTLTMTv3hMCJCG4QnS0zpqEwt3Ojk08NyvV9Z7hY76wLPuPR8wpggMxgvLsexqF3G3G10WU9UTFhhfJrgNk3r3Yy/VOZfbEEzn5Oqb2ytfQ9zb7Ys12FEtaMgdgRVHEWi/WfyKBW0BhGCPl8277+4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784592649; c=relaxed/relaxed;
	bh=SU7NTZV6ctCmaLjoIpubALICGle8Rsbisa8IJw6vOYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TC/aAKu/dg1kTfsTNKYtHzXaO6kjuAYL1NrJ4FxyBNEuTi9o9gNHqhhYiAIbRH5Aj0iOkwjdvso1wg4r1mCkmCE2DY4hFyknndueP+FPS5tCpvmvBQejeF4LMeZuko3hqptj64Ks+oypq6UQW8eligBPXoZAaESiLGeWuNGfxxohe6RvUs4KDEDt52pPpnSjbkfJBOL1oQMf4APcgvN5MVoDzvHxsxl6sB8Xxz0VriTU6IP5f/X+ql8Guf7WuuC+8Zx33x8+ydLYHV7BGBc7h3tBOyOGiJPyZCHrDNI4S1EtIu/kndJF/3MQfUgyt3IOqkQ0UuT/W1QF0njaB3noJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCdOFSaV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCdOFSaV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3yTM6gGlz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 10:10:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 066F960A7A;
	Tue, 21 Jul 2026 00:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7861F000E9;
	Tue, 21 Jul 2026 00:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784592644;
	bh=SU7NTZV6ctCmaLjoIpubALICGle8Rsbisa8IJw6vOYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GCdOFSaVTBcd3wvW6vYIJ/3ZigDnTHY1FKRMuNdeOw4ahdDa34XAYMPIJ/el+goF8
	 xr3/Ffndunr0z1CE4DL31ZaL0zXTHzpU6F/TJeT/ppenqrA0U3Ao9BLUyAwJ723jEi
	 7vKyEYVgHhBn/lB96KfVsQh0vlpkYFWldKIWhdlAAFFyZg4P1D6wY4W8Wm89J1uVn8
	 4+R83+SGAeAUsqFfNjIZSYFvt3kbVwL4R1c9c8926jGfK0xW/eTEHFXrrejrNWobSo
	 FsX/g3DUbZL0F7xjl8aJGgw6ZIYwggtzajJIJVXk5argfJbfGTSPiuA7obuw28ZwuQ
	 X8i61yLh2oK4A==
Date: Tue, 21 Jul 2026 01:10:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 12/13] PCI/CXL: Mask/Unmask CXL protocol errors
Message-ID: <20260721011036.0227e6a8@jic23-huawei>
In-Reply-To: <20260717222706.3540281-13-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-13-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:27:05 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL protocol errors are not enabled for all CXL devices after boot.
> They must be enabled in order to process CXL protocol errors. Provide
> matching teardown helpers so the masks are restored when a CXL Port
> or dport goes away.
> 
> Add pci_aer_mask_internal_errors() as the symmetric counterpart to
> pci_aer_unmask_internal_errors() and export both for the cxl_core
> module.
> 
> Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
> in cxl_core to wrap the PCI helpers with the dev_is_pci() and
> pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
> or non-PCI @dev so callers do not have to special-case it.
> 
> Wire cxl_unmask_proto_interrupts() into the success path of
> cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask
> only runs when the RAS register block was actually mapped. Pair each
> unmask with a devm_add_action_or_reset() registration of
> cxl_mask_proto_irqs() scoped to the host device so the mask is
> restored when devres is released. This applies to dports, Endpoints,
> Upstream Switch Ports, Downstream Switch Ports, and Root Ports.
> 
> Remove the dev_is_pci(dport->dport_dev) guard in
> devm_cxl_dport_rch_ras_setup(). On RCH systems dport->dport_dev is the
> pci_host_bridge device, which is not on pci_bus_type, so this guard
> caused the function to return early on real hardware without mapping
> dport RAS or AER registers. The caller already gates on dport->rch,
> which is sufficient to exclude cxl_test mock devices.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 

One minor thing inline and maybe take another spin at a more concise
patch description

Either way on both of them.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


...


> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0bd23a65e7ebc..be6dc2cbd4491 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1143,12 +1143,32 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>  
> -/*
> - * Internal errors are too device-specific to enable generally, however for CXL
> - * their behavior is standardized for conveying CXL protocol errors.
> +/**
> + * pci_aer_mask_internal_errors - mask internal errors
> + * @dev: pointer to the pci_dev data structure
> + *
> + * Mask internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 mask;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	mask |= PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
Could do
	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
				       0, PCI_ERR_COR_INTERNAL);
or something along those lines.

Maybe it is worth wrapping that in some helpers to make it a bit
more regmap like in that it could have set and clear only variants.

> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	mask |= PCI_ERR_COR_INTERNAL;
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_mask_internal_errors, "cxl_core");


