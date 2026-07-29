Return-Path: <linuxppc-dev+bounces-24980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E5CC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 09:05:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h95z94w7Fz2yDr;
	Wed, 29 Jul 2026 19:05:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785315957;
	cv=none; b=Xwbssy+fzUZWWS7xGzDuTBfMUNDJ1G/ulcbZYYSn6EyFqBifXIYPy1+CzzNn4Zc2CbwpWa9Or3/MUUoNjG3OrW3rfjt0J6Ws31sl3xBwjbJOiBGKXa0bGTEexdW8oCe3FF8QcJuPLXwcq1evZAKzM9LczH2fHyInPAWWhgsxZTA9G63Vs7GDUg2Fy1u3U54nUDOqSt+3YGbGhyp2Rr27/HQ4fFqXDJ2SWYOS8Wqs1O3txJyNkmKSgkA+VqHo9WyLZKWpZmdgC/Q4M4AVZD5FHdzilN5KAH66Xkprwpu66g2fqmDspd/VVK0KbhM2QVMWR14FtDHIbwRvruQnpw7qlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785315957; c=relaxed/relaxed;
	bh=mdJF8EmQKgpnQ4yp7hIAeNI8pBNYHTci1rt2RdWV4Nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n9i+YJ17eDo6eZPXinfMH9RNL5d2cP0KlIMKcyJZSmyxm+0y+IB4YOBeJKdlq2OMnwAO+j1kW6VKZjmEte3bllIJO8dCtbej+2tRmkyZxpvz00j9YthjyRTo0tzQCxQcozTKFhOGU4xw8nVO0ARxrPstbQTooe0b5kZ/m1ey2OFZd6TEgOmgjzqIZuHjROdFHRI+UK7b1yNCqk8X2/HxOZfsnsgQJgAoaui2Wuic+BbJItEdGJIvlZBZSytb7qxDURl/xjMlLyt2yhknEyjVOxF6KNz/9nNwLMQFpjM9a+QjCZ2MnKrTsmrOsAVC13AgHP79VsASDzeItFhmPU48gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIiVguq8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIiVguq8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h95z75nnzz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 19:05:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DEAB41693;
	Wed, 29 Jul 2026 09:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B8C1F000E9;
	Wed, 29 Jul 2026 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785315950;
	bh=mdJF8EmQKgpnQ4yp7hIAeNI8pBNYHTci1rt2RdWV4Nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FIiVguq8KuBDqtT0PXndjI3quzG7GdBQ1gIp34vD37A8jQkdWqL0UX8t4ngnnjw/Y
	 C1TGNG6KB/mLppq5/XDp/OJd0nOoba+lKfaEOW1LX+EA2h4mD1pQbF1PvCJ/Q/Eqzu
	 JYHZG1UhYCRPP+hX0i3nNC/TPyuGs3AWR/UFZrCcjQeHQFvPfssnUTotdfEDMCcf9C
	 Bque7EqPetzJBNZ/tmfvnu38rco3IaKUW/tUjUkQDC8B9Va+jAkXSWlio5jwcBDJcQ
	 032EZr/fGZqP3Ig+R6AV32MntNnjBgko8r+IdZsY00ucLhuRfLDTrWkLN6fQNm1iE3
	 VDhP3iJzHAcTA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
In-Reply-To: <ami_mpd_1pF4Tmdu@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
Date: Wed, 29 Jul 2026 14:35:36 +0530
Message-ID: <yq5a5x1ygo7z.fsf@kernel.org>
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

Mostafa Saleh <smostafa@google.com> writes:

> On Fri, Jul 17, 2026 at 11:34:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
>> reference and update the direct callers accordingly.
>> 
>> This is a preparatory change for a follow-up patch which updates the
>> attributes based on the selected swiotlb pool. Keeping the signature change
>> separate makes the follow-up patch easier to review.
>> 
>
> I do not understand the point of this, why would
> swiotlb_tbl_map_single() force attrs over the caller which should
> already know the context (whether DMA is shared or not) which case
> would this be useful to force from the SWIOTLB code?
>

The mapping request was for private memory, but the device could not use
it because the dma_capable() (force_dma_unencrypted() == true) check
failed. As a result, dma_direct_map_phys() allocated a swiotlb bounce
buffer, which is shared. Since the DMA now targets the shared bounce
buffer rather than the original private memory, the attributes must be
updated to reflect the new shared mapping.

dma_addr = phys_to_dma(dev, phys);
if (unlikely(!dma_capable(dev, dma_addr, size, true)))
	if (is_swiotlb_active(dev))
		return swiotlb_map(dev, phys, size, dir, attrs);


-aneesh

