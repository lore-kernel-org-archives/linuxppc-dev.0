Return-Path: <linuxppc-dev+bounces-28028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821BDC98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 14:18:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqfG36djTz2yqq;
	Thu, 24 Sep 2026 00:18:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790173115;
	cv=none; b=kVT9utvgpMsKuHf3bpAO3Rjn1ViWUAO6sOnnHEhqEx0PJWeWDaQPwTiYDyPcnWUKWpIoNBmxJJ54m0JINstHz7lw5DHdW2mFPcitI7qy8tn4n0h8qfMPeTJk2x7IfrSEdnfshu3AiMTVGRTPU4u7GTiS0CSXdJJNL2pXp2/0LUULhGehS39YtwGHC1ThHIN2JDf8fQ+NhTpfnaPGgtn6fi2pflPOoydXa5w8a2NYWsPdM/wUpxEf0tp8o7TU8mPdlRvEwE5/pR09NUxslFV1c0Jsavui6xpQRqYWf2bxtsMcIFdMOooAXSTyquQjzwGgQx3lDZMVUvedt0n2DQauBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790173115; c=relaxed/relaxed;
	bh=66owRjOvJSAr/FtK7BlN29u7V5NJZ0MbFNauyPpj7FQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HA/L7ghy8CA8fy4AYwG+7ZUvtM2mONUfjDlkcAgJeuYgwOjv5qXEQBiULbNH4XbQIALz2tlwVFvLYio/bCZD/2zBw/Nlx2VmhD/G4w34ftNA6x1kWGKy2RlONY2eZaYgzfY98/9pcPJ6J3DaOa3Xmv0nIypS65fLxCFp3nI+iyZLzBmh/iY5Qa+LUoOqksjTsnp4MalwXheJX2T36BJqXzA8fWIJ1R4fl5SPB4aWzUtgjIQCHRqyeo7m41YXh+weuUy0Hpr8P3mz673bvA7x8kqswM5eGqDKdrpVhd3mAw1UHCIVKB3XanYVqKdmtUdsWPhYg4KTE4wrfLrDF3zamQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c09/orxs; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c09/orxs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqfG26DCjz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 00:18:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 50F09400FD;
	Wed, 23 Sep 2026 14:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AEC1F000FF;
	Wed, 23 Sep 2026 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790173112;
	bh=66owRjOvJSAr/FtK7BlN29u7V5NJZ0MbFNauyPpj7FQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=c09/orxsyiIgQr/XyV4THd+6iBSzQc+CshjgJM2aYHJg3nIicfYSVJmPSlSo5eFCG
	 73M97zJBx7RC8G1UDuMC4dveij/CiJQWWbFiW+OEd8kV+Cyc9mTNrOw2ns0ax3MTDP
	 avvAEjCrzYEPWHqfvFJUlE4W+kzhwxoPDQB9AvNWNECA0vioHaZenC1uGyNZ3nqHJv
	 4MedGiREESIFrLlZ7bkyRnA0Yc+Sr+MQuaCJEm+QJTuJbhZ1jAwpzyTFOJOwe5smc4
	 HBTbt1JP9nhGwgB5/15SJUaOSpadMGna89qHgONKNr3b7WbH0HXPGdbC0lFsvvTwfG
	 LxBRc+m1G3jZg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH v5 5/6] dma: swiotlb: Add an overridable architecture
 pool opt-out
In-Reply-To: <8c9c04ae-cba7-4096-a7d1-70b90a46c161@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-6-aneesh.kumar@kernel.org>
 <8c9c04ae-cba7-4096-a7d1-70b90a46c161@arm.com>
Date: Wed, 23 Sep 2026 19:48:13 +0530
Message-ID: <yq5azex8126y.fsf@kernel.org>
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

Robin Murphy <robin.murphy@arm.com> writes:

> On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
>> On x86, iommu=off historically prevented SWIOTLB initialization by not
>> setting SWIOTLB_INIT_ADDRESSING_LIMIT. This overloads that flag: it
>> controls both whether a pool is selected and where the pool is
>> allocated. If another requirement, swiotlb=force selects a pool
>> independently, omitting SWIOTLB_INIT_ADDRESSING_LIMIT may place it above
>> the addressable range of devices which need bounce buffering.
>
> Well then surely something is wrong with the design? If 
> SWIOTLB_INIT_ADDRESSING_LIMIT is set then SWIOTLB still needs to respect 
> it irrespective of any *additional* reasons for activating (either from 
> arch code or internally). And conversely, if devices have addressing 
> limits but SWIOTLB_INIT_ADDRESSING_LIMIT is *not* set, then the arch 
> code has clearly gone wrong or made a bad assumption, but that doesn't 
> seem like SWIOTLB's problem to worry about.
>

That is what this patch does. It sets SWIOTLB_INIT_ADDRESSING_LIMIT
based on max_possible_pfn, while SWIOTLB_INIT_FORCE_DISABLE allows the
architecture to opt out of SWIOTLB initialization independently.


>
>> Add SWIOTLB_INIT_FORCE_DISABLE to let an architecture opt out of normal
>> pool initialization without discarding the pool placement constraints.
>> 
>> Unlike swiotlb_force_disable, which is set by swiotlb=noforce and
>> unconditionally prevents pool initialization, the new flag is an
>> architecture default. Explicit requirements such as memory encryption,
>> architecture remapping, or swiotlb=force take precedence over it.
>
> Logically, that should already be implied by the architecture passing no 
> SWIOTLB_INIT flags.
>

We now have a case where max_possible_pfn causes
SWIOTLB_INIT_ADDRESSING_LIMIT to be set, while the kernel command line
specifies iommu=off. We want to disable SWIOTLB in this case even though
the SWIOTLB_INIT flags are nonzero.

-aneesh

