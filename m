Return-Path: <linuxppc-dev+bounces-27856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD379C982ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 12:50:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpNPq1SMpz2xk7;
	Mon, 21 Sep 2026 22:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789995055;
	cv=none; b=JljwhE3P4OER4XcfXqxdxXSpQ1lqncOIrYeZnntB9nG5mpNmyAWJ0g0igOHe6af41KOMc7NqAwfgpaP3W437zShWTdhH30bpZ/Eo1Mbzcdlj1lsIh+HeFbxFTAJ9tnZiURjJBpKbNPze1PgfmU86lQQHQcvwBpuAlmIASbrJ1jC9XqFJHVNscG/1b5mLbtTH5udS3JACJqGSjgJyJMc1w2jmLzp/YIpE+qa9QLLMNha93nMY6oaV6KcQBbT3K/vmepKcbwL50BiVhVfD7p+PuRDLq1pYu1vZg3wmpx88eKHgurGjuW8NZCdwMUI7QsOdCZRRaZRvPEuqY03IwhYb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789995055; c=relaxed/relaxed;
	bh=fGZGEKRmpT20WJeHjbdlS6czM4JmHTnUJYSdUcbfzcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VToyihAWkfYp0ssK/OdyXjl0O5aPsFhun+csrESIjmW1eQkN4TxwMa8iMwj3FinXRrqsKP0kz6CJHSTVdn16dNC/SXOv/L4Cl74CqW/XKofyX0P1m2rkCynTyozW0+tguXaZHX6Lhp/TDg9xkqBAmIpEDf5j1Ik/4ZGBKwvcEBHzxfHCZ0qMtuYUfXDIcwG4otdCI00AGLVVWExAQrLmhyVUSaHk9ULewByK6+ncz/9qzViYZaMtCAS0NKwhtMHv53F0Ct580VdEPd3AIVdCjWwbZLsrTYKWo6sM+G2vWdfwlvQk4ndCldx/xtoaAA0GJTHg+jWB1vn9ZYvFAPGB6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A1SoKiy+; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A1SoKiy+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpNPm63qfz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 22:50:51 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4588F176C;
	Mon, 21 Sep 2026 05:50:15 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2AE03F86C;
	Mon, 21 Sep 2026 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789995018; bh=TQv7l9aU1HPhSsH6yPVKN6maCdi89qI1I+QaGJPz64U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1SoKiy+LIZ9OZR6QAKSKC1Ux368ZuAKB18oX6607x3al7a+KRnZc9iDJhGX3ZePO
	 aT176Jp0/eANP5NLj9yCAhkVS10FWvTpr9OikBj7j5132HFZWEeyUqhAkayVoeKSwu
	 OMGqtJEAqxDVi+EZSvFdcDPrspc5Js6YggW/hMp0=
Date: Mon, 21 Sep 2026 13:50:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 2/6] dma: swiotlb: Track whether the pool size was
 explicitly set
Message-ID: <arEoAq9mhsx2mt1P@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-3-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260921063628.362078-3-aneesh.kumar@kernel.org>

On Mon, Sep 21, 2026 at 12:06:24PM +0530, Aneesh Kumar K.V (Arm) wrote:
> swiotlb_adjust_size() must not override a pool size supplied through the
> swiotlb= command-line parameter.
> 
> Currently, it determines whether a size was supplied by comparing
> default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
> explicitly requests the compiled-in default size, allowing the request
> to be overwritten by automatic pool sizing.
> 
> Record whether swiotlb= supplied a numeric size and add
> swiotlb_default_size_changed() to query that state.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

