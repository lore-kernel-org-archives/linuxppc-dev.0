Return-Path: <linuxppc-dev+bounces-21340-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6623ECD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 17:21:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLwDW0Zz8z2xS2;
	Fri, 22 May 2026 03:21:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779384075;
	cv=none; b=cNAqRYMjaRSybxaipdGILGBNhll1TEzvYVpDK4qbEmKCfHASRFRyHDBkXGzM80/cubxxYdWNR5vNe8WROSbodYTfxEvc5rdDUvl0OXJzrI8eHQGVPlwn2kAoMAP74SopdPSD4CvpPIBdRl8JgvVFTqoA4C1dd8FBa47MM1AunX2okXm8toWRFPQnloqd4wv+GsVRpWW2xGAArwMnvLWVIlNbN43C/aMhhCBewgTyO6GWMidoiTVi0FnmO7h9lMPU4gbrAwjXO0VRWtBqLxgS3Hcblf1DhXAf56L88u1dKTXqEuMc7mED7zakmc/wAhmlS4vNSdxyLj31sPnefjvHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779384075; c=relaxed/relaxed;
	bh=8+P0QoHoTHxpMs7EjsNIrR5Oc0zPqR8/3ahzhGgBQjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkAf8CDwPAdDa0mwKkcBunnbs2UbirF7Mu/DEES0WsYjCG2aGax9nb1YPDDXxdqEKSLm+CadoycyuU0B+fcEJSWwBApo3apfLZ87WlXQEqwtYtwLZ28IRot1pxqc0LOOSWKZ9c1W6+MsJujm55QoE9DOykIc0aV92b5mzAf+zu9LOhSi3vpV4LQBrH9V1jglVQZOxG/IV1kfedBRUGvP6GkIK4ipaknG88PkrMEh/0gjU2qJj3L3UZmUThKalfe51IKWjwvkz1KHipTogH8uYScItz961CTGmW1ANITwVfgGhLYuNiF5WcLOyM9NWzyu+KCHZ9H+uxkAjZl+E1qxZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8TPsNT5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8TPsNT5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLwDT6Cp8z2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 03:21:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC693601F4;
	Thu, 21 May 2026 17:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344331F000E9;
	Thu, 21 May 2026 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779384070;
	bh=8+P0QoHoTHxpMs7EjsNIrR5Oc0zPqR8/3ahzhGgBQjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n8TPsNT5xWOQ0ZbzyEP21CLY9l5MWJNGlKthwGOPoIGjoa5e48zuFBt+nL3maSNnj
	 rNBVzfwTX1hh5zz9WEHGee/P5K+Y56Pp7SaNk6uICSM9/VPiT6pGp2lEfjvNjD/34T
	 F/SoSbSYaiskuTt6m3QfIvA7actDo68ku+uQjU/bGEic7MasVfMV2AqB26qA3cV0oM
	 iVcQz/OGOGRqMzzS2RJvnFirBiauNMW9kIyeW2XdqyYANYsuH63fKYd9+Pu50LkGzN
	 6lxL+vreHASBDePhXYndBIEWFeq6v//OLfF0VFvKMPQQmCXb0JWSMeXnWOfqerLCtd
	 jxf7Pc2APU6tA==
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <CAFgf54o4ZnvnJ3369bHb10tvJJVP+5YWq=ec4Jh5K6S6U9uNEA@mail.gmail.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <CAFgf54o4ZnvnJ3369bHb10tvJJVP+5YWq=ec4Jh5K6S6U9uNEA@mail.gmail.com>
Date: Thu, 21 May 2026 22:50:51 +0530
Message-ID: <yq5atss065n0.fsf@kernel.org>
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

Mostafa Saleh <smostafa@google.com> writes:

> On Tue, May 12, 2026 at 10:05=E2=80=AFAM Aneesh Kumar K.V (Arm)
> <aneesh.kumar@kernel.org> wrote:
>> @@ -1411,6 +1436,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*dev, phys_addr_t orig_addr,
>>         if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>>                 pr_warn_once("Memory encryption is active and system is =
using DMA bounce buffers\n");
>>
>> +       /*
>> +        * if we are trying to swiotlb map a decrypted paddr or the padd=
r is encrypted
>> +        * but the device is forcing decryption, use decrypted io_tlb_mem
>> +        */
>> +       if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
>
> I don't think swiotlb needs to know about force_dma_unencrypted(), the
> dma/direct caller should have all the information to pass the
> appropriate flags.
>
> Thanks.
> Mostafa
>
>> +               require_decrypted =3D true;
>> +
>> +       if (require_decrypted !=3D mem->unencrypted)
>> +               return (phys_addr_t)DMA_MAPPING_ERROR;
>> +

Based on other email threads, this is now updated to

@@ -1372,9 +1417,19 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
  *			any pre- or post-padding for alignment
  * @alloc_align_mask:	Required start and end alignment of the allocated bu=
ffer
  * @dir:		DMA direction
- * @attrs:		Optional DMA attributes for the map operation
+ * @attrs:		Optional DMA attributes for the map operation, updated
+ *			to match the selected SWIOTLB pool
  *
  * Find and allocate a suitable sequence of IO TLB slots for the request.
+ * The device's SWIOTLB pool must match the device's current DMA encryption
+ * requirements. If the device requires decrypted DMA, bouncing is done th=
rough
+ * an unencrypted pool and the mapping is marked shared. If the device can=
 DMA
+ * to encrypted memory, bouncing is done through an encrypted pool even wh=
en the
+ * original DMA address was unencrypted. Enabling encrypted DMA for a devi=
ce is
+ * therefore expected to update its default io_tlb_mem to an encrypted poo=
l, so
+ * later bounce mappings for both encrypted and decrypted original memory =
use
+ * that encrypted pool.
+ *
  * The allocated space starts at an alignment specified by alloc_align_mas=
k,
  * and the size of the allocated space is rounded up so that the total amo=
unt
  * of allocated space is a multiple of (alloc_align_mask + 1). If
@@ -1411,6 +1466,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *de=
v, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce=
 buffers\n");
=20
+	/* swiotlb pool is incorrect for this device */
+	if (unlikely(mem->unencrypted !=3D force_dma_unencrypted(dev)))
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+
+	/* Force attrs to match the kind of memory in the pool */
+	if (mem->unencrypted)
+		*attrs |=3D DMA_ATTR_CC_SHARED;
+	else
+		*attrs &=3D ~DMA_ATTR_CC_SHARED;
+
 	/*
 	 * The default swiotlb memory pool is allocated with PAGE_SIZE
 	 * alignment. If a mapping is requested with larger alignment,
@@ -1608,8 +1673,11 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr=
_t paddr, size_t size,
 	if (swiotlb_addr =3D=3D (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
=20
-	/* Ensure that the address returned is DMA'ble */
-	dma_addr =3D phys_to_dma_unencrypted(dev, swiotlb_addr);
+	if (attrs & DMA_ATTR_CC_SHARED)
+		dma_addr =3D phys_to_dma_unencrypted(dev, swiotlb_addr);
+	else
+		dma_addr =3D phys_to_dma_encrypted(dev, swiotlb_addr);
+
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
 		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC,
@@ -1773,7 +1841,7 @@ static inline void swiotlb_create_debugfs_files(struc=
t io_tlb_mem *mem,

