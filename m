Return-Path: <linuxppc-dev+bounces-27668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CDFC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:14:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmP4m2Mr1z2yhP;
	Fri, 18 Sep 2026 17:14:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789715656;
	cv=none; b=Rzt8ayDRNLb8Pnj1YqzacsdLDg/Xp4cYqpYPVLFFRwZmmuqs6Is7QCCbvhVLx9PBZ6Wx1zOFgA7vba4XWR/4cStlMrA+Bf4EomqFFnTskW6L9rTSdnR/isSqg9zC0oW3/c11AIxLWP6ptfmiWSJIwhnZpjUJoh3121vVwddZSv7YV4Lc68na3Uacb7Hl3seBFNffSebFBVgk5NGuctpcU+O7X3PkmNM+4f5WUOKc2l1ve6gFyy2XiPMtSoJI2fXmaajWadNukil4+3dO3yQ6WEKTlei95/mOpVeDOkYOwKbwh1Wyk0sgKURd+fpI2rjZlOiZVWz+TDXyxajMQnjbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789715656; c=relaxed/relaxed;
	bh=JSN/3RICUGwBIu5VwI98GdvFqpcrp4blbXSy58qpsRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxMuBLooKiBu/PenSLRqz947L8rTtfz+/f26X+NZV9TlJ7qMmrSjVCbK+BwD87iucQIa/Srh7w8xLBOOhN8iFzB1kUT7VCabIFXOyLIYekV8BKJYuKDJVJmtp7GF/pPVZ66qOuffwrfIQ64EV8zdfIBFZnuBlhSVXbqKlQAbaq449hNTFSQdY0dbgPyzlvuXruW+TNGTGmJtq9zJ/BOTWfqd661+E/CfZJu0j8ZK96GJmIf159hQOiyr3yAwFYgHeU97/oXJKI+oHVSatr8Da7chk4lfARsvijDziZhsQLvieh5qvPWyNS2uv65gV3IZDTyRtlPSohsGLnbSBaIjeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ko5U5Hyd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ko5U5Hyd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmP4l2d7Fz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:14:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D4BA643309;
	Fri, 18 Sep 2026 07:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D737D1F000FF;
	Fri, 18 Sep 2026 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789715652;
	bh=JSN/3RICUGwBIu5VwI98GdvFqpcrp4blbXSy58qpsRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Ko5U5HydpSiCUC607T3WB/2e0AHn/OAQOLnxt0skGjaJ6dlvhiveUPAe5HA2uE/PT
	 /hc+DeZpWm/sd4F8F5oAdb0eLJNrmiRC+bntUlPg4EDlGiIcfENFfIbBGiIxZDGJK+
	 wUq6IdZ/oaxCSHRvKEaIWY6++Qi6+D40+DXu4AW9PP3xG3yH/xeFAfC9eAUQ8BglQC
	 k3mFx4QcVIodeIsTG2wP5wzvEjPZ+f94XFWjmYH+IIE1de1/4uniXYM9JgPIaPqejU
	 MOnV3VtS8mgbZEoQ/cKvMnpocjve8EM2tRtFBwQoUzlU/nCjp62BkJGkb9lbetw+5s
	 qREbZFA6/p+FA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 3/5] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <aqwPKO80ZEn0cqa7@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-4-aneesh.kumar@kernel.org>
 <aqwPKO80ZEn0cqa7@arm.com>
Date: Fri, 18 Sep 2026 12:43:59 +0530
Message-ID: <yq5a1par116w.fsf@kernel.org>
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

> On Mon, Sep 14, 2026 at 12:31:32PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> +/**
>> + * swiotlb_adjusted_size() - get the prospective adjusted SWIOTLB size
>> + *
>> + * Return the size that confidential-computing guest sizing would select for
>> + * the default pool, without changing the configured SWIOTLB size. An
>> + * explicit swiotlb= size is always preserved. An explicit area count is
>> + * included in the size calculation. Automatic area sizing is initialized
>> + * later from the running kernel's possible CPU map and any resulting size
>> + * adjustment is therefore not reflected in the returned size.
>> + */
>> +unsigned long __init swiotlb_adjusted_size(void)
>> +{
>> +	unsigned long nslabs, size = swiotlb_size_or_default();
>> +
>> +	if (swiotlb_default_size_changed() ||
>> +	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +		return size;
>> +	/*
>> +	 * For SEV and TDX and CCA, all DMA has to occur via
>> +	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
>> +	 * happen without changing device drivers. However, depending on
>> +	 * the workload being run, the default 64MB of SWIOTLB may not be
>> +	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
>> +	 * I/O errors and/or performance degradation especially with high
>> +	 * I/O workloads.
>> +	 *
>> +	 * Adjust the default size of SWIOTLB using a percentage of guest
>> +	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
>> +	 * memory is allocated from low memory, ensure that the adjusted
>> +	 * size is within the limits of low available memory.
>
> Nit: if SWIOTLB_ANY is passed, do we still allocate only from low
> memory? I think this comment made sense on x86 but it's not valid for
> s390, pseries with the changes so far.
>

I'll remove that part of the comment, as the code does not check the
adjusted size against the low-memory limit.

>
> Otherwise:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-aneesh

