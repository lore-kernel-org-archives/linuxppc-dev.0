Return-Path: <linuxppc-dev+bounces-25764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CBCC5CFEB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 11:08:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKm1x3cJBz3bpP;
	Wed, 12 Aug 2026 21:08:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786532901;
	cv=none; b=Kxq91V+ezdpVEcsBSgNOwbK68T6TZ8soV3a2woennz7nPb27HOfO2opBsK+jItyd7bILRR+J1976bbIdAnF8acKEomphayd/Ga340k4md0t9umBnidv6XsZJUPFgPqc8y/OVEi5wkKeUizV1lFxCfOs+fcDj8suZv5pXTg+4HWDuWfLwAXz/SHcntBk9WrRGoWIQclnVDek3tvZbzShu1KBGTTmPMwsoQ10ZlOtOshHs1SNiJ5xyCvaqtCNx64L41VnhApAUg5bYHZOWIA3DuzY13C62pPlcK+CDtgNqVd1hn5BJxPjnh9/zhWOYBdp+4CohG6MF14S8Qbeipo4Mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786532901; c=relaxed/relaxed;
	bh=wrG8DuqyrTgTLnhCEF0YR7wirnsbC3EpRyGJXVbGCIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HqijoDUNCBukisPPgz0W2XnDEw6/serPvVzEr19Blo/sxeRcaFxhPbIZ/a21yeJqo/QsPbCb3vu9F48on/tjFs86l6xb6WLGt5SdY1ZeHFLBFAUBUEEWFQr9EgDOezi6qQd/u7wN0/QiTKiei/5jT8fglpaC5G9kNuZbiqzh0p9NVhds1yz8DFVeCM3d9rz1EJjah05/eBZ+rzV9LZQCRSOCmPf3A64Re9ZKXJ8kG7NLFMrg6uXKx4TXT2f287Eopa4JROQWZzBFrYrguBUvIo5/jA4EJ+wQ+lsrpN6jgRxQ5TEm3qgCWhKvbulTona148JDSzUnMaYhm8FFcweogA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkPSCeLD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkPSCeLD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKm1w2mY6z2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 21:08:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2E350600E2;
	Wed, 12 Aug 2026 11:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332981F000E9;
	Wed, 12 Aug 2026 11:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532896;
	bh=wrG8DuqyrTgTLnhCEF0YR7wirnsbC3EpRyGJXVbGCIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EkPSCeLDP67zu3BNdozJVWmVgN/lwbl/w5cX6yfGYw9yVFjo6oPLCa0KuCgxJq/bJ
	 KCRPGDosYj4GfgaVr2nyBLrLMQzyq56jcmCurtz+u98h44jUMGlYs5abspQ7HI6rsh
	 QfoHCmaUDsxiRzdFLpT+tVjAjEYbE4nO23QHgxFCh00LDfMeQi+Ph7C2SSyb7vjFYB
	 hmnKnnLtrOxIfLT7V/pLXlLtaxUOl4T+7oG8LNW7m3pliZ+JhFVaHDpU+gCrQUFKvh
	 ITPhU3LDVqetWIWSsynW6Wc8ICVklFrAdPPAB/k0svEdGHBfo3zvurKffjxX4mpEdJ
	 bjOpTJ9BJHYPw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
In-Reply-To: <anxEc8EHmJQywVI5@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
Date: Wed, 12 Aug 2026 16:38:03 +0530
Message-ID: <yq5ajypvioks.fsf@kernel.org>
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

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Aug 11, 2026 at 07:10:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Systems with memory encryption use swiotlb to provide shared or
>> unencrypted buffers for device DMA. Confidential guests may route all
>> DMA through these buffers, while SME hosts use them for devices that
>> cannot address encrypted memory. The default swiotlb pool can therefore
>> be exhausted under I/O-intensive workloads.
>> 
>> Let architectures mark the default swiotlb pool as shared before
>> swiotlb_init().
>
> I thought we wanted even this decision to be moved out of the arch code.
>

Architectures may want to use an unencrypted swiotlb pool for different
reasons, one of them being CC_ATTR_GUEST_MEM_ENCRYPT. x86 hosts also
require unencrypted pool to support SME. We can cover both cases using
CC_ATTR_MEM_ENCRYPT. However, pKVM does not want an unencrypted SWIOTLB
pool. So I was thinking it would be much cleaner to let the architecture
code drive that decision.

>
>> Move the existing x86 sizing policy into generic swiotlb
>> code and add early pool marking for arm64 Realm guests, powerpc secure
>> guests, s390 protected-virtualization guests, and x86 memory-encryption
>> platforms. Use CC_ATTR_MEM_ENCRYPT on x86 to include host SME, whose
>> swiotlb pool must also be decrypted for devices that cannot address
>> encrypted memory.
>
> That's a functional change for x86. For now, I'd keep it to
> CC_ATTR_GUEST_MEM_ENCRYPT.
>
> BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
> option in realms?
>
>> Move the powerpc secure-guest swiotlb enablement before initialization
>> so that the shared pool is allocated with the required flags. pKVM
>> guests continue to use a restricted DMA pool instead of the default
>> swiotlb pool.
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  arch/arm64/mm/init.c                 |  6 ++-
>>  arch/powerpc/mm/mem.c                |  7 +++
>>  arch/powerpc/platforms/pseries/svm.c | 10 ----
>>  arch/s390/mm/init.c                  |  2 +
>>  arch/x86/mm/mem_encrypt.c            | 27 ++--------
>>  include/linux/swiotlb.h              |  7 ++-
>>  kernel/dma/swiotlb.c                 | 73 ++++++++++++++++++++++------
>>  7 files changed, 82 insertions(+), 50 deletions(-)
>> 
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index e308a7cabd12..4c022e8aed43 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -338,8 +338,12 @@ void __init arch_setup_zero_pages(void)
>>  void __init arch_mm_preinit(void)
>>  {
>>  	unsigned int flags = SWIOTLB_VERBOSE;
>> +	/* pKVM uses restricted-dma-pool */
>> +	bool cc_guest = is_realm_world();
>>  
>> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>> +	if (cc_guest) {
>> +		swiotlb_mark_default_cc_shared();
>> +	} else if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
>>  		/*
>>  		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
>>  		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
>
> With your other reworking, doesn't the core code know the swiotlb will
> be shared? Can it not make the decision to resize at that point based
> solely on CC_ATTR_GUEST_MEM_ENCRYPT?
>
> I also wonder whether we could address Will's pKVM request not to
> allocate a bounce buffer once pKVM guests will start reporting
> CC_ATTR_GUEST_MEM_ENCRYPT. Some simple heuristic: if a
> restricted-dma-pool is advertised in DT (it will end up in
> rmem_swiotlb_setup()), skip resizing the default swiotlb. It's not
> perfect but the bounce buffer can be overridden on the command line.
>

For the same reason I mentioned above, architectures may have different
reasons for setting cc_shared = true. IMHO, it is cleaner to let the
architecture code make that decision before swiotlb_init().

-aneesh

