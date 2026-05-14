Return-Path: <linuxppc-dev+bounces-20939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3D9CD4F39
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 06:24:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGL0J26cFz2xlQ;
	Thu, 14 May 2026 16:24:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778739888;
	cv=none; b=AF1+McvyDO0JTPIAnwu7LKjfpxkT+RWM/FtLLK8CWynU9aZOAgoO1NiJrPF2mh2XPCCP09UjgbqwVREJQuijH1bWWgDa2RbZzkICnS15Q6EQ/jNPjwwsaqAmJFmqT1FwuwgiWY8O3wOF+17jkEjysh68hEYHSJB9QoXRAOUzu4SBIbYJ8accxrlySGqt5gEd+JJCWvf8NZnKDEQv0vz/p96BPCeL/30jVvtTi0ddN75BGd8uJgCvHOuy9T1cL6hkwju+YBNOvcH33ISHcXJBk+Bhue6vtjWLSkW5THdJY7HHLN6ZiokJOTFe69HtVs5T/aQtP63DvhHOgw+XBbI23w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778739888; c=relaxed/relaxed;
	bh=lVwzh7YuBLKrnB/3wy8MuXgNUlPj7/YkEbnMaWT4mW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P5o8nRVfR1WYywjsO5XsbxvnzG9HryGSA7t2l2r2GYeo3c34FHoHRXs2O8xdRZIhoGBz8na6+lzzPs8+vD7IAuVWglMhLjESqAb9C1N5ChT1xLDhCY16wvhSukYG7h2iYcwCrcS8tc3/33fxRBw0AtMon/DRTNOSUlz+O+enQwz4n36rY58Ca9DcpBWbOs5kOBE8g5aaY6CYddlB5rNW1NW2weZ6L2K+g+E3EoWbMPcyME9RV1rLNWKSnxCIPDjTTfka+6UqetPOVFChlVMewUbt5AfwzdgMvfz279EKYRk6+137NNSslnQJYbU0aUItAU/Y4f/ii8Ky8m2tpFI9hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VIFBftDk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VIFBftDk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGL0H12mfz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 16:24:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F0FEE600AE;
	Thu, 14 May 2026 06:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A983DC2BCB7;
	Thu, 14 May 2026 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778739883;
	bh=ecGsHNVV/zGWfQo2KCz+UMgNIz0oxNVr7CL3H1ueicQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VIFBftDkTqQvTeGSGdUb63C6Y5jX6Qcf/aCnqTSus57moAmWsHaY20Ek8+NzNXF7I
	 r30wh4vj1ifGB0fA2KjcIkRogw3gf/w/DwCz8rVK9iAc/K453wPiIu8E8hBCt7TUx+
	 djavHnjghAjLiadXV9zorYImb47+oIv4wV/oN58jnzuEcvJqM5fABJjEe+zUiHiIwr
	 2QhZIGpd2mWiRm0jNgOlqLkPgQDFCTqrCKFDe2+QllPsd7D5xi2BKD5Z4yDZF3gpjR
	 +BGATD5Q3YuIez48+zWs0mHgv5HFqviNpKfMGsjB3Cx0lI1Sy1ANa46iOb/RUQrXqA
	 h/GpqX2YIjQlQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <20260513172450.GR7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com> <20260513172450.GR7702@ziepe.ca>
Date: Thu, 14 May 2026 11:54:30 +0530
Message-ID: <yq5aecjea4pt.fsf@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

>> And that brings us to the same point whether it=E2=80=99s better to retu=
rn
>> the memory along with it=E2=80=99s state or we pass the requested state.
>> I think for other cases it=E2=80=99s fine for the device/DMA-API to dict=
ate
>> the attrs, but not in restricted-dma case, the firmware just knows bette=
r.
>
> The memory type must be returned back at some level so downstream
> things can do the right transformation of the phys_addr_t.
>
> One of the aspirational CC things that should work is a T=3D1 device
> tries to DMA from a decrypted page, finds the address is above the dma
> limit of the device, so it bounces it with SWIOTLB to an encrypted low
> address page and then the DMA API internal flow switiches from working
> with decrypted to encrypted phys_addr_t.
>
> If we can make that work then maybe the flows are designed correctly.
>

That is what this patch series aims to do. dma_direct_map_phys() will
derive the DMA address based on the attributes of the physical address:

if (attrs & DMA_ATTR_CC_SHARED)
        dma_addr =3D phys_to_dma_unencrypted(dev, phys);
else
        dma_addr =3D phys_to_dma_encrypted(dev, phys);

If that fails the dma_capable() check, we fall back to swiotlb_map():

if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)))
        return swiotlb_map(dev, phys, size, dir, attrs);

We currently do not have an encrypted SWIOTLB pool, but once that is
supported, swiotlb_map() should do the right thing and return the
correct encrypted dma_addr_t based on io_tlb_mem->unencrypted:

if (dev->dma_io_tlb_mem->unencrypted) {
        dma_addr =3D phys_to_dma_unencrypted(dev, swiotlb_addr);
        attrs |=3D DMA_ATTR_CC_SHARED;
} else {
        dma_addr =3D phys_to_dma_encrypted(dev, swiotlb_addr);
}

-aneesh

