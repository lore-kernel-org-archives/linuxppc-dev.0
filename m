Return-Path: <linuxppc-dev+bounces-22345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFD4CD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:45:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZVXJ3KhNz2ySf;
	Tue, 09 Jun 2026 23:45:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781012704;
	cv=none; b=CrMYopbYhAWB3I+U/oN9TjAglo6uNa8LS+zX5oLPLY21Ffxb0GTLLyiokcSdDdS4bhyax7WwtvdiqAm6wi1KhXLWz399frIH+KzqYBPfXt35flUA6uEQRcErSiNEZ1owWGXLwgARGs1Blqf9woA/hzRBHPFkokg/X1guPHx1089nkkuULqX/bRdjH2Rj7Fv8KO5m0T4q8dTQwKpjJ6Dr39SMgkFnntDJA/iAvPHlu5Q+Pc5ER7Jrxf4yDeTxU0fRKHOjUnAEMFzhDkom2WJgZ/fqM0asbiflp21SbVmDAnj/6s6FxG4Kvzmx8RSZl5DsFLXLrWXJo8OPMzh6t79iCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781012704; c=relaxed/relaxed;
	bh=LuuGrD50s5G3lD4/z7kBXBEhX4EmmbgTscTqHB7mZBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTYXylAQgbgGS9Gm2lr2Uu9EUhTzCQs/hbXvq65uG0z9zqZEsjqBlWdk59Ef9TsbLTAtdSiMQGT/SdsZjdAxc0cARaMO+i0UctS760DikPRXBx4HULqMjOgxmFYCGf8M5wQJS/KyjkAoFy22NTkfky2jbaAfP0xtnosBUhJRXTINY3K61QG7HKYM9otzPWoQcgz7IPTY/Qa8DXlSsnx3spcM1Il/OW+OUzm/mGaGWE8Knpj0g71Qn3rzhBMaDt3wl+9TXzFRgmzvrJUXvGjs2Lpja7aTxoNT0RF2VsGLzJU5AXZZv9FwqVEHPhSu+JdsMJvV0qEP0LUY5mhVVbs1HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gKioAK9A; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gKioAK9A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZVXH2jFZz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:45:03 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC782680;
	Tue,  9 Jun 2026 06:44:27 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49E23F905;
	Tue,  9 Jun 2026 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781012671; bh=sAi/28Ft7rUbm6jJKXWvzjgglgd9xi220pLzfWlK/Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKioAK9AfWzXIl8F+KIX30lllhvxwMiVRvIFqydsD0FsElstjxRZAfMI51W33L2KM
	 GPIVct1Y43GhET5ugQ/BxbruZ05sXnpwZnMPS8+Yqkf2/gPN0mjEdIyCnScHgQyqqN
	 ilwpJkC/4+BPsJTt/AyPUC1vxz8ON2m0+P4pPjsI=
Date: Tue, 9 Jun 2026 14:44:24 +0100
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Halil Pasic <pasic@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Jaehoon Kim <jhkim@linux.ibm.com>
Subject: Re: [PATCH v6 01/20] s390: Expose protected virtualization through
 cc_platform_has()
Message-ID: <aigYuHoKHPJPCGjz@arm.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-2-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260604083959.1265923-2-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:40PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Protected virtualization guests use memory encryption, so advertise that to
> the rest of the kernel through cc_platform_has(CC_ATTR_MEM_ENCRYPT).
> 
> s390 already forces DMA mappings to be unencrypted for protected
> virtualization guests through force_dma_unencrypted(). Add
> ARCH_HAS_CC_PLATFORM and provide the matching cc_platform_has()
> implementation
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---

Nit: just drop the --- line if you did intend to cc those people.
Nothing wrong for them to end up in the commit log (proof that they've
been cc'ed if they did not reply ;)).

-- 
Catalin

