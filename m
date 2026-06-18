Return-Path: <linuxppc-dev+bounces-22761-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCCFCD98ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:37:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggvHN0fWpz2yNn;
	Thu, 18 Jun 2026 18:37:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781771855;
	cv=none; b=HlKIrSG2LNpTM1k6BtvCFN0FvhHvfXSzuerfVBN7NXKnWIuogYkLPzK3iyy3K/6539/DvGmPiuCNWKr3khZN1UY4XBFOIxRMU1FAOdSerQZOY6PB+NkS8BECApXf0aACkEj7sj/HP92arfpMVNKg8pwl0JE4j+K9OuTlvJTXEc1/4Y0x+AKqw6x6L1Pirk9KJqDdJ7QtfOWcj12sWd8AFziwd8DNzdRzBa5PytVQ8gtB8+SqfjTzm1rdK09Wz05Fj8ZwB2o5B9iX3jy5caXm72Pi3a2iyqOGNOF1z2U0219f5M1XtRaccBadgoYk9+ABSOXkD2wCfIyXvgc+qp6xsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781771855; c=relaxed/relaxed;
	bh=Tjfp3FF0f+SxzpFBuG9E9B1amsn/loCXBkKBhFITWIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kan3lIogiU2xlg6Buu6TYZryJamykzd0hUIiFm85DbzNA0k4eth9T4IWPLijfJR1qGID/It1MjCEApINcz74c6vuScHYokRBIPI/BegDcwrGRwQC6cKodNPYQ6ZBhVv5WvoXm8lZgVbOCfu9tJGBD/+rESAjW4v6Ku+ZWgEw3vFFHJpDrjGQ1k0685BF5FIiOmfRBUWGd6jWNJ24Qx/DOZf/Yv27l2ebquKbvqb4GuvnDkboSs1Q4qgxt/r29f7pKPcQcay8EsOUp65G6zJkAyR2vlHiukbWU/cquKK8bLY+9H9jHB9pn7ef5FLwxT9EVpgrrZ9yB1U3wwfuGwI8qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJYmurEU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJYmurEU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggvHL6jH3z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 18:37:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C08CE436FD;
	Thu, 18 Jun 2026 08:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334ED1F000E9;
	Thu, 18 Jun 2026 08:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771851;
	bh=Tjfp3FF0f+SxzpFBuG9E9B1amsn/loCXBkKBhFITWIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bJYmurEUTf4p9ddXp1VSCskBHjygy+xD/oNjB9s2Ep/Uu73ZeAFn3grah/ZH/26bC
	 Z2IKNbkJrX3SQyniq2V3c43nApViK8ptRc8Gz9vZ5aBx3WYWws6jmsSQ1n8wC/ZhsC
	 aPXbP4vBO9+s7L7Gu2B1QTaU30Q3lwF3YsxuWM4vVa7T2kphUxDrfVTBh2RPbtKviM
	 f3h5f4VrWfNGB2xgQRFYm9r1q8fBv53E49ns83ljI6VaL3Opsq3DE6buX9d8xYbXtu
	 r9HlAXaeEfYUQ5HKSssJFRAz7y8WVKnEyAfSl5fBP2P87RedjDBY2R+S227cOm339+
	 HGR07rvOMXPTg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
Date: Thu, 18 Jun 2026 09:37:22 +0100
Message-ID: <yq5aqzm4dz25.fsf@kernel.org>
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

Alexey Kardashevskiy <aik@amd.com> writes:

> On 10/6/26 00:47, Jason Gunthorpe wrote:
>> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
>>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>>> are handled consistently.
>>>>
>>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>>> shared/decrypted buffer handling. This series consolidates the
>>>> force_dma_unencrypted() checks in the top-level functions and ensures
>>>> that the remaining DMA interfaces use DMA attributes to make the correct
>>>> decisions.
>>>
>>> Please check Sashiko's reports, it has some good points:
>>>
>>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
>>>
>>> I think the main one is the swiotlb_tbl_map_single() changes which break
>>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
>>> but force_dma_unencrypted() is false. Normally you'd not end up on this
>>> path but you can have swiotlb=force.
>> 
>> IMHO that's an AMD issue, not with the design of this series..
>> 
>> The series is right, a device that is !force_dma_decrypted() must be
>> considerd to be a trusted device and we must never place any DMA
>> mappings for a trusted device into shared memory.
>
>
> swiotlb=force forces swiotlb, not decryption.
>
>> That AMD has done somethine insane:
>> 
>> bool force_dma_unencrypted(struct device *dev)
>> {
>> 	/*
>> 	 * For SEV, all DMA must be to unencrypted addresses.
>> 	 */
>> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> 		return true;
>> 
>> 	/*
>> 	 * For SME, all DMA must be to unencrypted addresses if the
>> 	 * device does not support DMA to addresses that include the
>> 	 * encryption mask.
>> 	 */
>> 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>> 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>> 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>> 						dev->bus_dma_limit);
>> 
>> 		if (dma_dev_mask <= dma_enc_mask)
>> 			return true;
>> 	}
>
>
> So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this patchset, it fails to boot. But it boots with a hack like this:
>
> ===
> @@ -39,7 +41,7 @@ bool force_dma_unencrypted(struct device *dev)
>                          return true;
>          }
>   
> -       return false;
> +       return swiotlb_force_bounce;
>   }
> ===
>
> Or we say "mem_encrypt=on iommu=pt swiotlb=force" combo is just weird and we won't be supporting which bit in this? Thanks,
>

Something like?

modified   arch/x86/mm/mem_encrypt.c
@@ -34,6 +34,13 @@ bool force_dma_unencrypted(struct device *dev)
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
+		/*
+		 * With memory encryption enabled, SWIOTLB is marked decrypted.
+		 * If SWIOTLB bouncing is forced, treat the device as requiring
+		 * decrypted DMA.
+		 */
+		if (is_swiotlb_force_bounce(dev))
+			return true;
 
 		if (dma_dev_mask <= dma_enc_mask)
 			return true;



-aneesh

