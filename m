Return-Path: <linuxppc-dev+bounces-29323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD0FCA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 19:06:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RlM6k0mz30hC;
	Tue, 13 Oct 2026 06:06:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791831983;
	cv=none; b=ICpGKxWl2WNP98lqrQaIo6P1N8KO15OdnoSJ66EIqhEhXcRuly51BqdUFRtHj5uhtb6Lf7mwRYZeDnpk2I05bIBuYbPFGeToxKDSEQI0T2LWmz+94e0JA1n34rM9xen6I2+55w4XTSFsWJt9A6oIxuLLfZia/vOMWrW0eun/Cxt4kVfKWz3A3i78qqH8Bj13zhGQeSXDEO090lC3NU3s6yI+fXI4f9Q0Ety7iUyYdnTYU6vMXxTzgN+2XvYSFC2lEkiq0xOGUHCmbOwvIJeKZeejLZT3dycJ/3wYkIZWIcpCQcufDZaUazRYnh6JV7oQ7NtPD7qvQIal7ICww88/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791831983; c=relaxed/relaxed;
	bh=q0m342rqLls2tmLwC9vxj6OcplNETCneYide1wTCHnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha6EYPBHkKoOgATjMORi+SRZab8JCvvwL7yxOjJFGT3zaPXwrDU5Vsx5IaTPuZvpYveSH4S5yGi3W8EL8Cvc/J7Jjnp+Oui/oZQc8b4lTNMLgsl4GjiSfmNDvrYJzfu1bxhDlhEZoug9pIu+nhx1LaPp2mFqeDGQ2UUAmLFBmGvUCh0x3KSnuTLGuQzg68R7kwSEiGOtEHrGsxNRz9N1Alt3dwTupVppW45xF7iHf2aEop5yuDeW5JxUPfsb4Niflzdt15cKRkJ9JXIMKwzZzktex2g12CdH2EpS/4WE5dgOP0VcrABqNVFy+U9fWcC0zQGfAh7b6/vIeMnGu2tUmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RlL5dxxz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 06:06:20 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id DA4C62A87;
	Mon, 12 Oct 2026 21:06:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 94FDF600E1CF; Mon, 12 Oct 2026 21:06:13 +0200 (CEST)
Date: Mon, 12 Oct 2026 21:06:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <aditya.garg@linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Jason Perlow <jperlow@gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip unmasking Advisory Non-Fatal
 Errors on T2 SEP
Message-ID: <as0vpb8EVlo_8Gx1@wunner.de>
References: <20261010172301.12764-1-aditya.garg@linux.dev>
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
In-Reply-To: <20261010172301.12764-1-aditya.garg@linux.dev>

On Sat, Oct 10, 2026 at 10:53:01PM +0530, Aditya Garg wrote:
> Jason reported that since commit eddba19b8b5f ("PCI/AER: Support Advisory
> Non-Fatal Errors"), the Macs with Apple T2 Security Chip were powering
> off a few seconds after every boot. He also found the PCI Device
> 106b:1802, which corresponds to the Apple T2 Secure Enclave Processor was
> misbehaving and the most likely reason is that the device is ANFE
> incompatible due to Apple's custom hardware.

Nit:  Not sure what "misbehaving" means beyond the sudden power-off?

> +++ b/drivers/pci/pcie/aer.c
> @@ -428,7 +428,8 @@ void pci_aer_init(struct pci_dev *dev)
>  	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
>  	 * 7.8.4.6).
>  	 */
> -	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
> +	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER &&
> +		!dev->no_aer_anfe)
>  		pci_clear_and_set_config_dword(dev,
>  					       dev->aer_cap + PCI_ERR_COR_MASK,
>  					       PCI_ERR_COR_ADV_NFAT, 0);

Nit: The "!dev->no_aer_anfe" is not aligned with the opening brace.

It's probably not necessary to respin for the nits alone because
Bjorn may resolve them when applying the patch.

Reviewed-by: Lukas Wunner <lukas@wunner.de>

