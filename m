Return-Path: <linuxppc-dev+bounces-23645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C11C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 18:05:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvC2k4n4Cz3bqV;
	Tue, 07 Jul 2026 04:05:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783361150;
	cv=none; b=MkEAV1WYUkuLrRxbiOf+2Zw8zFU3IRVOefqJXFUQSTIBuXFTcgL2PAx34RTH7lGDVQi/C6slniWLgOFS1G5dpHIhkf7bfWGwwoCpEaA65/4IkzKwJUr7pAemUyNGQwu+jIhRvdYoi7VRvIEscDkx+iNezmtS32ajLDBNUyKEb0s8hOTfXtYU9cbRZrTXvB6jH15PGTZBn3wDUsbW/4885aquxi1GvEYWThyWCvI/POneyFP5IA5VJnLR5cnfppMZQupASGf3Lpk+12Dwp9Aqi7QPD4nyqdc6+WeAzit0eyX4KcSEenscFmomVacRM4EAxg/RW1zdMtyCoyuPM9aFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783361150; c=relaxed/relaxed;
	bh=lS5mQ8jxBl2iII3sye5/k61Ij6XIW0SLlPx3ORBjMOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxQ5b7MfIn0gzsAk2xEIUXUkcOTAPkTdf1AChBbo0jR/nr8BkcsUSNJrlxNjCAqxnviOK2FKi9xX3PTiLGpB2dVCB9iO5hXl+Gybj3hUIaqiOCp1HTdgOYD9OL7Qf6eVWKhd48cEWxLotK7zrlVSbWuyyBMHKIvO2s7z7g4Ib/UERSYydhg225NT4xgIf11DX7khFudwv1eUyzQ0JdjsjWatnveNH29eN8XjRSxLIWUkAxlhkjaCPIUpaOtzaU+NoZPvouf46uySOYyGHU8RaMxfjIZAPDXV4PDzi/PT1VAodnk8ePv9BJTH4KXOtyYVMOZRkeOmackwmSl8hA/dIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mThbQP0B; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mThbQP0B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvC2k09TMz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 04:05:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4410641E51;
	Mon,  6 Jul 2026 18:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03E31F000E9;
	Mon,  6 Jul 2026 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361147;
	bh=lS5mQ8jxBl2iII3sye5/k61Ij6XIW0SLlPx3ORBjMOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mThbQP0Basmxs9eRhzjXAjifVVsdk5rdVEEOd/kevttMi1gacBMgRcKY2XemUdnpJ
	 yq6WxLgYPq+adOButB24df822RmfCsSkd8m4ETWURm8HOViCmzONZRF4KrchnEtif+
	 14nILHnzGeaC8a7DV2PUAnKj8bGqPMFNNIuYh/7njFoY7kjoDOLDqtwpQEH78ki2GC
	 xTm9DJb6p+vaML+XjB4639WzBm5+XenJm2EsOlBXAHxzbKUoQZQ+zNcYVF9j5pHhDq
	 Em4xzMaL69KoIavoPnl6H611ydaQbyyTZ2xmYPtFfUoOdTctdImF9Q1QVYQJs/xbo6
	 R1UgX+sTznfGg==
Date: Tue, 7 Jul 2026 03:05:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/sysfs: Fix out-of-bounds read in
 pci_write_legacy_io()
Message-ID: <20260706180158.GC265195@rocinante>
References: <20260616163131.2763281-1-kwilczynski@kernel.org>
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
In-Reply-To: <20260616163131.2763281-1-kwilczynski@kernel.org>

Hello,

> pci_write_legacy_io() loads 4 bytes from the kernfs write buffer
> regardless of how many bytes userspace wrote:
> 
>   if (count != 1 && count != 2 && count != 4)
>           return -EINVAL;
> 
>   return pci_legacy_write(bus, off, *(u32 *)buf, count);
> 
> kernfs_fop_write_iter() allocates the buffer with kmalloc(len + 1),
> so a 1-byte write to the legacy_io sysfs file allocates 2 bytes and
> the unconditional u32 load reads up to 2 bytes past the end of the
> allocation, which KASAN reports as a slab-out-of-bounds read.
> Similarly, a 2-byte write overreads by 1 byte.
> 
> Thus, read only the number of bytes requested using get_unaligned_le16()
> and get_unaligned_le32() for the 2 and 4 byte cases, interpreting the
> buffer as little-endian to match the byte ordering of PCI I/O port
> space.
> 
> The PowerPC implementation previously compensated for the generic
> code's native-endian 32-bit load by shifting the value into place
> for the 1 and 2 byte cases.  The shifts were only correct on
> big-endian kernels.
> 
> On little-endian PowerPC (POWER8 and later), they extracted the wrong
> bytes, so a 1-byte write wrote an out-of-bounds byte instead of the
> requested value.  On big-endian, the native load also caused out_le16()
> and out_le32() to reverse the user's bytes on the wire for 2 and 4 byte
> writes.  The little-endian helpers resolve both issues, so the shifts
> are removed.
> 
> No changes are needed for the Alpha platform.
> 
> The legacy_io file is root-only and exists only on Alpha and PowerPC,
> the two architectures that define HAVE_PCI_LEGACY.

Applied to the sysfs branch.  I would like for the 0-day bot to pick this
up, and also to have some linux-next soak time, if possible.

Thank you!

	Krzysztof

