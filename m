Return-Path: <linuxppc-dev+bounces-28973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DCCCA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 21:43:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzqW84gl9z2yTP;
	Wed, 07 Oct 2026 08:43:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791322996;
	cv=none; b=cYcHNu7HHxlQGbcRUaPOJGtmabVfzCn7D1evn2Ra61pW7kIF9A9bwQ5AzxgCNeQ39DlFtFlbAjgTkHqLgZ9basOVgjF/+fxTdoYm5fqF3/n1hYoyEnB6ZvoF5qXo9YpqYdL8AAvYUpB/w+2l5nZJRxgwNHu18ZEB0g/bP+QwaAJWF0rB52AgwmzHm/s9y+5Uu+is0rr+SIUlY4iL+hb26NxCE9EUa2dcl55wv3O82P4C32YnpY4zIQbXNHaealvKtF0wdr/F3rLAYnJkp/1nDkRbqaDWheixO/HwB9Y+3RSsBLFP78e7pVeex9LZrKfuT6Ubd+GLVynKcfn6gFt4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791322996; c=relaxed/relaxed;
	bh=ZioSMG43MEHFd9pfn3EIJe0Ig/c7Qq/kf97OHfOELpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VYjlr44lQIzOHNBQ33Ox4EAsFIaVMd2jH6hL6ww4yHkwhXCHMCevZHC0RPVKSc+40VFQBbjDHCnoBeePTFCMVzHwzWhFIICaf6NMdPnkUA+Zf361VbNPnrCzDlb6zk0SxgP68/J+f+ULwOdIgYTPQarGjynGMN+iFLJHiAkh8VLsJLEWNh7WEdX3teDG6gUbmuV9plS8ygYj1Oy2xPQ+VCq5+9AD5guLvAwBknmrtf3nn6kXAR3fwIXqKm6B4cycBOW7qNUT6P3YJvbGUTZQFyNfngKND0HvXRY8ypraJ+sWthOd73y146YDn0dp3yK7Go4iwq2i8q8EN9Ro+pKDPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=X7izBr5m; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=X7izBr5m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzqW52LMZz2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 08:43:11 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261006214259euoutp01c5bc7ee57334b408af09a066c2d8412b~cDsI8Wk8f1988319883euoutp01S;
	Tue,  6 Oct 2026 21:42:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261006214259euoutp01c5bc7ee57334b408af09a066c2d8412b~cDsI8Wk8f1988319883euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791322979;
	bh=ZioSMG43MEHFd9pfn3EIJe0Ig/c7Qq/kf97OHfOELpI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=X7izBr5m8cmXF7INH1PfY//K2/ri63BnSaoZWWQn+J7F7DSyWLAOh8zyLCqoA49T1
	 fLrFXwNe1fB08G783PVdG9eZQswPfnng02g4QBXO6NsFZq0Etq3vQI7hHj5Ixmn3ua
	 C9iDLQSmItu72iRpHKjS66EAZ/bv/+aIrijM19SA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261006214258eucas1p21c51f2c73891f0ad8a848a058ab4e7b2~cDsH4gZff0914409144eucas1p2i;
	Tue,  6 Oct 2026 21:42:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261006214255eusmtip2826fd9cdfb4c80046b451ff2238aee5d~cDsFarzwa1576315763eusmtip2a;
	Tue,  6 Oct 2026 21:42:55 +0000 (GMT)
Message-ID: <ff4f59ea-6c51-41d6-a92d-d1dd205b1e78@samsung.com>
Date: Tue, 6 Oct 2026 23:42:54 +0200
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
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v6 0/8] dma: swiotlb: Centralize default pool policy and
 sizing
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
	Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Petr Tesarik
	<ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, Madhavan
	Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, Russell
	King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, WANG
	Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>, Peter
	Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
	Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261006214258eucas1p21c51f2c73891f0ad8a848a058ab4e7b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260924060823eucas1p1d27fbf57221c9b4c0e9831a9b0cdd7d3
X-EPHeader: CA
X-CMS-RootMailID: 20260924060823eucas1p1d27fbf57221c9b4c0e9831a9b0cdd7d3
References: <CGME20260924060823eucas1p1d27fbf57221c9b4c0e9831a9b0cdd7d3@eucas1p1.samsung.com>
	<20260924060756.1325156-1-aneesh.kumar@kernel.org>

On 24.09.2026 08:07, Aneesh Kumar K.V (Arm) wrote:
> This series centralizes swiotlb default-pool selection and sizing, and
> simplifies the initialization flags used to describe pool placement.
>
> The first patch replaces the addressing-limit argument with initialization
> flags and introduces explicit policies for the different reasons a default
> pool may be needed. Architectures now report DMA addressing constraints with
> SWIOTLB_INIT_ADDRESSING_LIMIT, while the core selects the corresponding pool
> policy.
>
> The second patch moves the reduced sizing used when the pool is needed only
> for unaligned kmalloc bouncing from arm64 and RISC-V into the swiotlb core.
>
> The third patch centralizes swiotlb sizing for memory-encrypted systems. It
> moves the existing x86 guest-sizing policy into the core. Host memory
> encryption retains the normal pool size, and a shared default pool is not
> selected solely for guest memory encryption when a restricted DMA pool is
> present.
>
> The fourth patch removes SWIOTLB_ANY. Pool placement is derived directly from
> SWIOTLB_INIT_ADDRESSING_LIMIT: pools required for limited DMA addressing are
> allocated below the architecture's low address limit, while other pools may
> be allocated anywhere in directly mapped memory. Xen continues to request a
> pool explicitly with SWIOTLB_INIT_REMAP without imposing a low-address
> constraint.


I will give this patchset a chance in linux-next. If one feels that it still needs
to be improved or sees any other reason why it shouldn't be merged, let me know
asap.


Applied to dma-mapping-for-next.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


