Return-Path: <linuxppc-dev+bounces-21840-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C4FC5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 06:10:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV0mq23qjz2xmX;
	Tue, 02 Jun 2026 16:10:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780380619;
	cv=none; b=U1Um5DBr9+5PlNCrc7ltMxTpcwcANfwAE2VXq37iqApS5dWsG6O2MdmO/LYzO7u9KSNleSEcNutOi3Y7CwzYyE/JBj/6r8PJdwUGa9sNKQt8MKQR7HbsnRr3Fs4cXw4ksymPoT5/7btQXzERdBJYb8L46nHud/ISWmIciIxMy7X1VOiqJbGylyeUKSIO71H9ARwwU/8MhrSCoqKSg2PFAniosutg3uDDJHHy2zFPuniW3xsctjCllPBV+SFWk0HALeFGw1vGX8ybT/KqyOCG9e3kp7vhno4z3K90T4EwfPioIna3VDIalqPH2vBYnoo01oJU2Km5BnDOEKHwSN7Meg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780380619; c=relaxed/relaxed;
	bh=tFMH5l5MTUaf6Xe98VNs76Ti6mPZN2RO0Y2Ijj9ZpVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGZPaKlEBQOdV51AcUt+WZkNkCCkrEfjj6zmcIgh4wqCC10x1FeKQ0TTiMoI3qR2LxBM/ruTxWluNHDYxKmRwXuzSqbd3VnFxAqyXcAhsgqekye2CUHarU7RpU5uzHviQI91otwU+1vZMyEHOSdiwlolaDXAgispdKmTm54cquiNdFgdSFAeal4203KaK2K422OU8OBLvYntjV2OlQVV9uXcg4G2AOfb+MPV//VjYqydP0xW2yhUgWAxqCEr5bJCLDM+RLUjUTyN4wrmLI6ALK+zrT/vfBCpg+nEcmSlSddktBZ5Ej83evJigYel/kL4Pu7SmykD7vCUXeorcu5TAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZHJyOBo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZHJyOBo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV0mp2GHvz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 16:10:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1EDFC6001A;
	Tue,  2 Jun 2026 06:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4341F00893;
	Tue,  2 Jun 2026 06:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780380614;
	bh=tFMH5l5MTUaf6Xe98VNs76Ti6mPZN2RO0Y2Ijj9ZpVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fZHJyOBoEGHiD16yVMLzAjbsRhIR7CFE9cGa8xrtaW1fYnxZpDeAP0dlt+35R/Mt6
	 lwiApCD3vWaU5f/ov1UftsC46EHnWWu9gVCnryDWlTRVbG8/Awo2j7YCs1kkoKzFUW
	 CLiouOcaFGFR32sW24z1VM1bmsWZYup1WOlxsoyfafKWKAqaMUDNcPp6rSaZlrOose
	 2+KdIT0Et7q2lWeCijk6GKIW77oJ2/Hmw08YSLGVBKiEFhtlIH4Duf/oWZrG7NccM7
	 XJbsbh+yK33nHz1p9/ZqYXK8Iv1em79IHjEcPrS+wx+QrhI/G32wo36vWwfGqLIiXr
	 rc4x3UNOXfQIA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-11-aneesh.kumar@kernel.org>
 <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Tue, 02 Jun 2026 11:40:00 +0530
Message-ID: <yq5acxy9scav.fsf@kernel.org>
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

Michael Kelley <mhklinux@outlook.com> writes:

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> Sent: Thursday, Ma=
y 21, 2026 9:28 PM
>>=20
>> Teach dma_direct_map_phys() to select the DMA address encoding based on
>> DMA_ATTR_CC_SHARED.
>>=20
>> Use phys_to_dma_unencrypted() for decrypted mappings and
>> phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
>> but the source physical address is still encrypted, force the mapping
>> through swiotlb so the DMA address and backing memory attributes remain
>> consistent.
>>=20
>> Update the arm64, x86, s390 and powerpc secure-guest setup to not use
>> swiotlb force option
>>=20
>> Tested-by: Jiri Pirko <jiri@nvidia.com>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

...

> With this patch removing SWIOTLB_FORCE from four places in
> kernel code, there are no remaining places where it is set.
> The test of SWIOTLB_FORCE could be removed from
> swiotlb_init_remap(), and its definition could be deleted
> from include/linux/swiotlb.h.
>

Sure, I=E2=80=99ll add that as a separate patch in the series.

-aneesh

