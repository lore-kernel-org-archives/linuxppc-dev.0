Return-Path: <linuxppc-dev+bounces-29089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83597CA6019
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 10:18:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1N9V3vg5z2yK7;
	Fri, 09 Oct 2026 21:18:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791541102;
	cv=none; b=C63V5xzvNsbCzzjMyLPpERbbpaA3BSf52hsS4rKL+9UIf2Bc4yQGrTxd2UPfWcl1DzNBZIE19aNeWZM3sW1C8c1FqP/xgY20iYOezboWaOcJaX2iykPUnjH/T0vD0ZKgI4RBGKNyHoshzhCdHY6lrsLylo5/E1PQe+X5EHWd4NJP+3/D05MOo6BKdtiV27/iD3VitVC9CfY4HuF7dM32bXk5K/GWDCKoLtKvzX8w22EfNaTvitb1QoAXxyAL2KIr4t2QyBDYnRBX88genB3ps/x9GxJGs+4neESHasjxLm/BO0QQDvS1eqvA3XIDTpvkP+OX7ResSdngS0UcKPRGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791541102; c=relaxed/relaxed;
	bh=wxARsjGuquaiLxgSm18RK/GYX/5yHnqt2BOAs4KeGsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8f7dZ1eyVuc2QXrXBtQnj9hAqDvCgTjoJ5yh1jZpnK3ZrzNVFde5Ac6dbJF51Ql9xBCYDawGX1kZNgJm6zO1/oNK4Iq1VtLv6uHmkxkB/YKSPu8buzNia44J0JMYwsHRiHyNLmUyATzT5FVQYF3ymkPfuZSga4tzXFn/E3meygGOqa+lqWQPS1q9oD7rJp2j6Rn2LLgPjqw5DUuuBenVtK3Y39VLNleDHZ58Gy5SYh05q/dxDcSSyuaAmhMXyJWqgno+SW73eOhq3BFKIfEn2v88D2T65LVzv1X3OKWeJUUB21uPf4AndxYRaQ81r+9h9W5+GsZvVIN4OH8okwv7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/Ulp1ki; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/Ulp1ki;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1N9T1Lhxz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 21:18:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E416541471;
	Fri,  9 Oct 2026 10:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FA51F000FF;
	Fri,  9 Oct 2026 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541098;
	bh=wxARsjGuquaiLxgSm18RK/GYX/5yHnqt2BOAs4KeGsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/Ulp1kiU/fHLorufnUGZviVewHpZ4i2nh7ovjmbgtSVM9rKK3zfjolFAXlJiCoG/
	 BMW5Ubh23ZkHDtz2gC3M7BH0DoQb7aWS09Fvb5ai3Tah7LXu0pj6waoAyV4+Ys7d5Z
	 +iywIF9ht9ECEh7ry8yPogWZ87BGl4TKzbkbZrEJI5fQcCBS3ROhYfkTdcqveZDJbP
	 aeEe9F9SdlEQjf4RfVxNp6TljhzSQkjK1V50hbw9FBfJgs2u42Zj9iTGwDxFCYK4CY
	 7TdAyz5T7sPBsEmViOMRCDgegOg9M7rT99tg9OQAo14hJB5idOZRFpneZ6VooRc89y
	 jEHJjjoVpql9w==
Date: Fri, 9 Oct 2026 11:18:05 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <asi_XW2FaVjjWhxk@willie-the-truck>
References: <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
 <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
 <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org>
 <aseRzPshcoys7AJS@arm.com>
 <CGME20261008143238eucas1p1ee087352709f2a82d2aec95540ae2031@eucas1p1.samsung.com>
 <yq5ao6d48dqr.fsf@kernel.org>
 <c2e38455-cb31-4854-ab84-4a370fabc1f9@samsung.com>
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
In-Reply-To: <c2e38455-cb31-4854-ab84-4a370fabc1f9@samsung.com>

On Thu, Oct 08, 2026 at 05:32:44PM +0200, Marek Szyprowski wrote:
> On 08.10.2026 16:32, Aneesh Kumar K.V wrote:
> > Patch 3 is a fix, so you may want to take it even if we drop the rest of
> > the series. Perhaps the first three patches could be taken together?
> 
> Okay, I will take only the first 3 patches to dma-mapping-for-next branch now
> and wait for the remaining patches until they gets sorted out.

Thanks, Marek.

Will

