Return-Path: <linuxppc-dev+bounces-27584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83EFC982D6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:06:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm0xP2P0Cz30Lw;
	Fri, 18 Sep 2026 02:06:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789661193;
	cv=none; b=UWOuA6/iPx1nDGfLdduLgYLaEFQJq6ei0TYOwr0IAAc/3rNqqu9r5FuAu+lobc8f/GnksgPhdkoD+4duvCldBic2dhz69iP0iUlV4QRpql8Ps5AdYMuJxImWatRqJroxHM9CO+t0iUP/CiLCgRW9NT5W0leNtgj8Meh4UHFsQMKvXS1vZQelia21+MLrNovLn2j77NffV1JYfIK3nEru4P4+zuuQ6HVELfp8obfrsHE06OtibfJZkxLnO65G1jhTgv+pQl1cjFm1U2dioJ4iUwlJ4yX7Q/JIGJ6i+qvD1wzDmAhubJtgNjzkc6ROsLeY0gdW1NDCSNgNoJML78JNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789661193; c=relaxed/relaxed;
	bh=avuh6Og9p0aKaIBlcuzJBoKk7NCWagcKodZZuZcN8OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/BIU2F61f1IbcXpkVKSkxeInr0OKYjlKx/18O2iUBxToRWqDTFmiqk45wJkOouCFzcB/k0+9mqVBvhBA39wcF25s26YNSjHydxcTJ2C0DQIocWa7jX4/x3zyryEJ5/3FSKTqeNC6amCJ+kmTc3ghM6eNm1PyKPHm8PJZ53hTcTFzAraN/x6+ZAwvmMJFGhV6gS3DRHPG9wmSHmUmIFi3A4ZvCvl2vVJNoWerw4Q3/1Ae8+y/pR82+tySHftFsJIo3rmItt8PRhNd9t6od/n8l0MqmqOq5bNh7gMS1LcrowyKIqPZvAP8iOFbPQ/AnwOAhKcRY2xIUWuIXNZb6ukVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iSTmFOj/; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iSTmFOj/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm0xN51yGz2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:06:32 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 723D01476;
	Thu, 17 Sep 2026 09:05:57 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0930A3F86F;
	Thu, 17 Sep 2026 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789661161; bh=9mcxnDc8qxIpxmpk6T3Tp+BnQwg+ATLN/zS0rC02bj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSTmFOj/SjkZUclQCqE4zTW0vk94VTD2VbErQFckNg1Hf9DqR+Wb+AcjT1kbXrZTY
	 9NCVL8hRLjredBc9QRerBZnnZDifRLrHjsitRjiaswGzll4lpHF3AB6KbXTdEHKJsU
	 MLwoOZ4/t3+aNJhsyRfmX7PHIpukuOpzzytXFkiM=
Date: Thu, 17 Sep 2026 17:05:53 +0100
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
Subject: Re: [PATCH v4 4/5] dma: swiotlb: Add an overridable architecture
 pool opt-out
Message-ID: <aqwP4ZKugUpFezV7@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-5-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260914070135.313337-5-aneesh.kumar@kernel.org>

On Mon, Sep 14, 2026 at 12:31:33PM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index be3962a33fc6..ef7a776ee508 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -20,6 +20,8 @@ struct scatterlist;
>  #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
>  /* Initialize a default-sized pool that requires architecture remapping. */
>  #define SWIOTLB_INIT_REMAP		(1 << 3)
> +/* Do not initialize a pool unless SWIOTLB is explicitly required. */
> +#define SWIOTLB_INIT_FORCE_DISABLE	(1 << 4)

Nit: maybe better as SWIOTLB_INIT_DEFAULT_OFF. "Force" sounds too
drastic and it can be overridden on the command line to re-enable.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

