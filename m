Return-Path: <linuxppc-dev+bounces-16332-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7606ED2FED9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jan 2026 21:35:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0zGj5B0Mz2xRv;
	Wed, 28 Jan 2026 08:35:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769505954;
	cv=none; b=VuKQToPdtDwiwIcC2PfrvcskQR3QuEfADaAr3IazGlp8PMnpGf37qmkhBgoAacqk8yIRY3ZunAP3UpIyEVsknso0EZZnfO8B8qWPQfoI7yBXHdNiz+NSKAW+0rb09ri9pV5VIYMolfVZQK+J1ulLqTvlbq3dPu4k2DQckB7Wx6QJdsYYsinMGcetRKMpWKznH/NY127JwkJPt3Pfu1GwHNoT+OhbplT6oN4om7zSyfTnrDiEvsE2y3xhZPaj3dOr8MuBDKLkA9owv5khB1Pt0yWpeFeK/1yNdfHVY3Qn+9TI5sMSxgNiqE2xiFO4KGhdDMD/WwmZMNcojiCuU18ZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769505954; c=relaxed/relaxed;
	bh=3SoA8W7wL5oSWDlrsFfuFMzduK+SmCJuUoJo2zIds20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQmI2ArB61kzHx5MRLvAYi6pQbLlaFc6lwYRUGe/KiRXg+EwM5ZPRlnYWmE002SCjesXfyg3LqO/lJXHl58lfJ6vxY8sa6/4Dq6iCShHdZqPYv98waTr9TPGYGjvBHGYfUXhKOnFuPOa/flmXxEnPSqcrWn43r2wYmRWuQTi2+0mV6VpZgpHrUsL66yFBbj8AJ/I8AlLAoeJ6F2yxvQDMaF7VaS6LVxZ6IXfwFji4AXDcWACybCVsv//1XiM06WcYDD2yJdMYxXwbFND46qfsJDVea+0Fl+aJkqMnSNI4WB+2bfpfCUCFY9RdcROpmJyGksPxH/JVsL6doP2RIbOnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MwfWSVSN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MwfWSVSN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0g4c6xK2z2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2026 20:25:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8841760132;
	Tue, 27 Jan 2026 09:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD12C2BC86;
	Tue, 27 Jan 2026 09:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769505949;
	bh=4jiQZv9wxoQeg5GZ0kgb1xulJUpKBRxTXH2y58bWr18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MwfWSVSNX2GZRCGGxBdlvB8xQYGAbi+lkcajYFbHijmcWUpTHXDVhI7ydYg1uDjw4
	 HPpv7cCWzutovVqQJEFV3KZL//Hjra5aOIzQJyjIGBzCYXBC3ssyUAgViMMRma4E8N
	 9SI9RpBNdQlO2gZ1RG3HWsxR056Wvm49DwJQ5mjLp02M/PoyIPmVEZs045/mNPrN8l
	 XEVpJ/uVSxciHV8bwp11WnyYsne7NENgI/2Vp0/n6QymhC8d5j3IAzg0x8lS3r/mDR
	 Luvuoy36/GTL+oCN+smnWQtd3kI0mNNEOL3E95afS5itU4dMOYSPhDbadVadZSN/bL
	 xSVk3WlsToqFA==
From: Thomas Gleixner <tglx@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, "Creeley, Brett" <bcreeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 1/4] PCI/MSI: Conservatively generalize no_64bit_msi
 into msi_addr_mask
In-Reply-To: <20260123-pci-msi-addr-mask-v3-1-9f9baa048524@iscas.ac.cn>
References: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
 <20260123-pci-msi-addr-mask-v3-1-9f9baa048524@iscas.ac.cn>
Date: Tue, 27 Jan 2026 10:25:46 +0100
Message-ID: <87o6mfbe5h.ffs@tglx>
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
Content-Type: text/plain

On Fri, Jan 23 2026 at 14:07, Vivian Wang wrote:
> Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
> implement less than 64 address bits. This breaks on platforms where such
> a device is assigned an MSI address higher than what's reachable.
>
> Currently, we deal with this with a single no_64bit_msi flag, and

we don't deal with anything. The code has a single bit
limitation. Please use passive voice as documented.

> (notably on powerpc) forces 32-bit MSI address for these devices.

this is not a valid sentence.

> However, on some platforms the MSI doorbell address is above 32-bit but
> within device ability.
>
> As a first step to enabling MSI on those combinations of devices and
> platforms, conservatively generalize the single-bit flag no_64bit_msi
> into msi_addr_mask. (The name msi_addr_mask is chosen to avoid confusion
> with msi_mask.)
>
> The translation is essentially:
>
> - no_64bit_msi = 1    ->    msi_addr_mask = DMA_BIT_MASK(32)
> - no_64bit_msi = 0    ->    msi_addr_mask = DMA_BIT_MASK(64)
> - if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))
>
> Since no values other than DMA_BIT_MASK(32) and DMA_BIT_MASK(64) is

s/is/are/

> used, no functional change is intended. Future patches that make use of
> intermediate values of msi_addr_mask will follow, allowing devices that
> cannot use full 64-bit addresses for MSI to work on platforms with MSI
> doorbell above 32-bit address space.
>
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Other than those nits:

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

