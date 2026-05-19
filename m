Return-Path: <linuxppc-dev+bounces-21162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCB7CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 14:18:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKcG26qYyz2yFK;
	Wed, 20 May 2026 00:18:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779200282;
	cv=none; b=A3Grvsrz2V5sLRFSlcfIV+wbcACsAqBTwK7uqIlAXzCWnN2vIjZ+p1szPCfzQToAqEMF950yHwBe4wojwqTIGwK9u2NpPZ5DYP3/SN396mdvVKP3Txvt7YlxUgU+Gc5mC21hqqiXyX1IYHTAGxqShoIOKLBaIfq2lD6YcpPLfqto9PJAzw/eXkCLe0Vf8lMGqal8P2ffx9TH5gX5bFsxNpFe6wX/LGQ4ZOUiIuMVGjAH/9Ghclqug3Xlb9mIaqt00Dqja9CtIp+Jpbj4kmZExz1N/ZdCg9chEz3iFTbZHyyJQx9MD0/yGbiaIApnErTR/jeNV6EUIKe3RFlr1vsdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779200282; c=relaxed/relaxed;
	bh=RapJmIm33RCWpt2jGkwySkStxOP5ayW5s+SF7qpxfO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mMKA0bFNiIf1vFKdLAIZ1the5uCR8oqihagXNmU/bXhsJk/o08rm/lxcF3ytnihd4QtLrOXM6r8XjzrzMn2aR5VGzFV+q1bTJQ5/wUeSCzjGP7pIeFzUC4WHCMzdmvcUhl/QHf35Tm4sacSXK1wfiKIya++Nj4Jz0cXg7nBBregsBJZO1HCdEqR6TWTPw0IDI0yT1IFF1jLR3cs5NCaac2Q3hdQFYHO8JtWsOYYPR3ZHKHcgXFwml11bN1b9VJpA9cEKg/ZjOhkv1C4H/lP6C7GgTdWPAJJl+yPsGJCE4+8Lp5pp2Mx+1LZNyIDU9i9zn7KH/SyIoBEXwBCRlgxw4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lTYt6sua; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lTYt6sua;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKcG15W5nz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:18:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B109445E0;
	Tue, 19 May 2026 14:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3CDC2BCB3;
	Tue, 19 May 2026 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200279;
	bh=omX4jWGqSc4euJhfKZDzYDEyAA00xkxKBKP+MlYpCw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lTYt6sua65tkoXlE6Q2BlS8sWIBZa2T8L6x1+ychuvbjhIgKDes/YlNtctIs5MurS
	 wD2Sl12rive3qkbqzpkk+tCLwkjQs/DxCrfGdUoXLC02uYIc1JCFEdy86S52d2uc9y
	 g9FC2LhMSJtxI6g9uj7rH6gjLQpb0NEpM4k1SN6H2g7ngPyox//4uss4/gZtV+Ifkr
	 HJA7XMc52oT9bXh/mEx/JXlwnYV1qcuMWkMR9VA/wBbF3wBtAG826RnNSvIIDkS5uY
	 AZew3Mf53E71+ceTl7ybvn6GgsZDq0hT4sHTpN4L72FhePHSUiBlWNlbwgUDVM05nW
	 MgRHtOceOiSng==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
In-Reply-To: <agxt7SFGT7OLMIah@google.com>
References: <agSKQrSIhizCXKwx@google.com> <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com> <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com> <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com> <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com> <yq5ah5o3sdn3.fsf@kernel.org>
 <agxt7SFGT7OLMIah@google.com>
Date: Tue, 19 May 2026 19:47:48 +0530
Message-ID: <yq5aecj7sctv.fsf@kernel.org>
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

> On Tue, May 19, 2026 at 07:30:16PM +0530, Aneesh Kumar K.V wrote:
>> Mostafa Saleh <smostafa@google.com> writes:
>>=20
>> >> >=20
>> >> > I am still running more tests, but looking more into it. Setting
>> >> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
>> >> > guest shouldn=E2=80=99t try to decrypt arbitrary memory as it can i=
nclude
>> >> > sensitive information (for example in case of virtio sub-page
>> >> > allocation) and should strictly rely on the restricted-dma-pool
>> >> > for that.
>> >>=20
>> >> ??
>> >>=20
>> >> Where does force_dma_unencrypted() cause arbitary memory passed into
>> >> the DMA API to be decrypted? That should never happen???
>> >
>> > Sorry, maybe arbitrary is not the right expression again :)
>> > I mean that, with emulated devices that use the DMA-API under pKVM,
>> > they will map memory coming from other layers (VFS, net) through
>> > vitrio-block, virtio-net... These can be smaller than a page, and
>> >
>>=20
>> Don't we PAGE_ALIGN these requests?
>>=20
>> dma_direct_alloc
>> 	size =3D PAGE_ALIGN(size);
>>=20
>> iommu_dma_alloc_pages
>> 	size_t alloc_size =3D PAGE_ALIGN(size);
>>=20
>>=20
>
> For allocation, yes, and that's fine because we bring memory from
> the pool.
> But not for mapping, as dma_direct_map_phys(), where the memory is
> allocated from the driver or other parts in the kernel and the page
> may be shared with other kernel components.
>

But if we are using restricted-dma-pool, we also have:

mem->force_bounce =3D true;
mem->for_alloc =3D true;

So, will we use the swiotlb buffers for mapping and copy only the shared
content into those swiotlb buffers?

-aneesh

