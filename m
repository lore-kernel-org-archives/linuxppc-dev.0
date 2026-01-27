Return-Path: <linuxppc-dev+bounces-16333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C829D2FED9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jan 2026 21:36:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0zHP32vpz2xXB;
	Wed, 28 Jan 2026 08:36:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769506084;
	cv=none; b=iRZ2T0c5qbjt69rDhJR+Oka03YpS/EOzPAzFZkTCHp+PwFOJ62h0B8jDhpXiAynvjmOLkHND+PbozZUVAPd2BgOkVE5H5+hogPj8wah1yttqRwoWJdyEN3Da5kyUKTD9IM/SeASRHgMs3i6i/hLqUxJwUqIsDWqkMAl8tD5OUSbKWgJQoBODriBXC+o9JgENhvbrvK2TCIMO3JP4dVU3q4wC9FJLn1pTAM6Wd47xMI/OH+6m10au3+3Po8FXJaY/bWEsCN7ufKp28nZWEOHA1ZrEsUceyIPRc14N9DLtizZaMW6pG6NC7YX4l/69Le2lRD3DydsNCk1hPB2BTnwusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769506084; c=relaxed/relaxed;
	bh=QxWbi0fR89aN2JlOIVMD+G7j77d5nNaeRsUPp7VB8Yk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9+BTUZISWZ8Vty7t2fbyTysYYljrafK7KC89O7igw3mMT42RxZpKRdwhd2Xfg6qyUr0R1/blsNIhKq40GF7DgD3+eDTVXQ2pAAQ46SqKaOfiN2a3Jo7dEKKZ1zqb5pfTHipdmKrrX8LJKlEsFgk30E0aRuA/dPbM9SduTVwwRJOn5TwKsWPCN482tyB0nVdo4r5GJ8EQwuNesL+kv/mj9hsaHCV+d4AYQjrxZuY9z7CnIf+Jh4cFXrlgsj56jwCKJcj3fYfXrZStpyeFY0vThxcIrZsRyaC4vV0JpjZ8IA9I3f2Lj91lHHbH0macPrAKaRCTbvfbGD0ztbayrqi2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oEO2FeMp; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oEO2FeMp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0g774rG2z2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2026 20:28:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A3E6260143;
	Tue, 27 Jan 2026 09:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA751C116C6;
	Tue, 27 Jan 2026 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769506081;
	bh=NUtdM1nWlicDFUqsuPzcoMB/gzA3aziNceLt7F8iSE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oEO2FeMpvi1NaSCO2Gn8Cj6UbLkdPGgHSCr2a7tIho96JHKe2OPIWUlyKRZRs+g/p
	 bOydMQemiNt+degt62tyGOKCzCMxGQP/+fWYHd5fQoEeMMtMBrEhvbKzxQI+uASfo+
	 WnvxAODGQoHBidevnuikSB14Qm/l1uuA8SKt8swMro14a0ryd5Zo1SXOw/QtvrZtYe
	 o9wowBLm4NktfnH4gj6vq4gkvSOgZCJwp+WvtCKPASNeo0iUYm1k9Mj89Qs/nBEKdC
	 UoXofhNhiJNlSAVG+UzzUh/MKGzx0b0QaoSEXAsSwPPoP60aL3O7aNFQz0OEp+KLaq
	 Ksz08X55xve/w==
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
 sophgo@lists.linux.dev
Subject: Re: [PATCH v3 2/4] PCI/MSI: Check msi_addr_mask in
 msi_verify_entries()
In-Reply-To: <20260123-pci-msi-addr-mask-v3-2-9f9baa048524@iscas.ac.cn>
References: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
 <20260123-pci-msi-addr-mask-v3-2-9f9baa048524@iscas.ac.cn>
Date: Tue, 27 Jan 2026 10:27:58 +0100
Message-ID: <87jyx3be1t.ffs@tglx>
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
> Instead of a 32-bit/64-bit dichotomy, check the MSI address against
> msi_addr_mask.
>
> This allows platforms with MSI doorbell above 32-bit address space to

with a MSI doorbell address above the 32-bit limit to

> work with devices without full 64-bit MSI address support, as long as
> the doorbell is within addressable range of MSI of the device.

within the addressable

>  static int msi_verify_entries(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
> +	u64 address;
>  
>  	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
>  		return 0;
>  
>  	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> -		if (entry->msg.address_hi) {
> -			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
> -				entry->msg.address_hi, entry->msg.address_lo);
> +		address = (u64)entry->msg.address_hi << 32 |
> +			  entry->msg.address_lo;

No line break required. Let it stick out.

> +		if (address & ~dev->msi_addr_mask) {
> +			pci_err(dev, "arch assigned 64-bit MSI address %#llx above device MSI address mask %#llx\n",
> +				address, dev->msi_addr_mask);
>  			break;
>  		}
>  	}

Other than those nits:

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

