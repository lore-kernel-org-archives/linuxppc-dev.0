Return-Path: <linuxppc-dev+bounces-23723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C71C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:59:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvnWs404Nz2xWY;
	Wed, 08 Jul 2026 02:59:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783443577;
	cv=none; b=dSgrz8TjFd1SjC4RJb3P7JJ31yGz35PFiCwKQXN0OAXtCLvNmtA/hG0LHTq0i8PRQwrCErYqYohy2e0W/6BCJ9XlpAvXiqsUn5WQKSXXbRa1+/yC5zwicSySbzLOxEnJQtV6W4td728P8abCC/NA1BOow7tOrT3IULrNp1+O2/vd/MHq0QHpeRKmTWTFTZaL7O2cDHU+kYy0cdjFQHjOw4mNCQ1zzrRHr8FLyhO8lsCcd6SqNcSicohjcksPfyg/9GFj5bzLgffNkAw9ZmG0lO9OZify3Kt94v5Hs/tFwHv3/eZHdw8tjaCxFWZtuLzg+3m0S3FQmZIbQfua/i+kSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783443577; c=relaxed/relaxed;
	bh=4Vcq1MkvzQbk9zfV5EhPNRi0N88gZnT6KsgF9u39VmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGjR1GHqqYV7yN02BBG1jvqB08r9I6AYHLCxdq+KQ3xVyewmAbyTJcqeZqcZW8pJ2aJgFDkPlAdzvHMbmvwa6fv0aXodF85MeDyxhkBfCjg1+aD4NMyHe8Fny9Z+JPO/BqSe15PtEM2TQSTCK29fbliH6Qd7ss1DTrKFaFRMq+2OJ1HRhrL59jJGaM5+sOd/MMW1FYMGFS0jErS/8q6dnJaY+SNkr5gGjy/4iTuksGV8MmFV7X70kCWdZ5F/2gnI4NtirfCFOoMR50V75KfKJOjzTV5dHSF8RdnxYfegiIcmGb960AYoJSSv6F9EDzmXemOIJ0ZCmV6yZZZrxZhGow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=J6v2nAcR; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=J6v2nAcR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvnWp3sF3z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 02:59:32 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A719D1595;
	Tue,  7 Jul 2026 09:58:54 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABC683F7B4;
	Tue,  7 Jul 2026 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783443539; bh=oftr5G3z6oBFV+GyZMslvtqhdQup3zVW7NYWudILDro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6v2nAcRCNpFw9tipYNPbCKnfR8iFde0+KzBbP0B3K2mz0ujgYDRy+VwFGktKRv2z
	 X8AGtqBWVpyqZUf4u6DfAHxBW5lfZj+N0eRs5hl4SptX1ZSmjrqSPoGb2LgAo/aLPr
	 cSJFc8xIxc30w+dQMcq1+PliaWcEFwqlAXdZ5TMU=
Date: Tue, 7 Jul 2026 17:58:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH v7 08/22] coco: arm64: s390: powerpc: Mark secure guests
 with CC_ATTR_GUEST_MEM_ENCRYPT
Message-ID: <ak0wTKrjTDZ3COS3@arm.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-9-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-9-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:12AM +0530, Aneesh Kumar K.V (Arm) wrote:
> arm64 Realms, powerpc secure guests and s390 protected virtualization
> guests currently report CC_ATTR_MEM_ENCRYPT, but not
> CC_ATTR_GUEST_MEM_ENCRYPT.
> 
> These environments are all secure guest configurations. Their
> force_dma_unencrypted() implementations also treat the same secure guest
> state as requiring unencrypted DMA. Report CC_ATTR_GUEST_MEM_ENCRYPT for
> the same condition so generic confidential-computing code can distinguish
> guest memory encryption from host memory encryption instead of relying only
> on CC_ATTR_MEM_ENCRYPT.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

