Return-Path: <linuxppc-dev+bounces-24187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388BBC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 05:04:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gznK32QKKz2xRs;
	Tue, 14 Jul 2026 15:04:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784005447;
	cv=none; b=MrRW4Rq6ACEYKrzXzDx1DLYZ3wnmaPMOLnmwvlF5U5nk4uaTEenHltb1f0XpGSeVnukuV7Ye3KwOBMASMJbEdcYoG8KcKwHpjNpaKq8Yueor2PolGAyZ5hpFRKz3zKyV4XI7T/0dR1e9sXdIFgb8MbSKSZUoNSg8wuxciF9kBw7x7olk4SfZjKR9DSwxHiNg5yd7A6iUB+oLixCwUBs0cL6xOTAd9wAcLGpc2T58Yb0uckgYOrBBJcueqHd3rH0qIm69dXjhLjOBVtl7ATrxZevWvmI96Kuq14iPh6cnJEJ9kkBm6DjiuFXWXzyyoBoLAhU+s33qqH0A5G6pUmvTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784005447; c=relaxed/relaxed;
	bh=GWX7BHocDQy79xg1nWh2GEbrLAdwjBZsgjhN9hnUanY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9CNK3ywgadsgMOwb8SO87AK/G+A8nRnV8MkEPVCMsIhbiNwHOyI8oxjJRShA0wqVfV/vDOZyNMj/ykk+wY0wlLGjEl0VmEZo16BttwhOGadVSzTubskeAG22TbnXNkNc1egqNrRJnbEfUpHwQVRXidZCnw7dNrEz7j31b6v6KunTZBkAx7PFQLmUEt+e8dfYiqlIZqe5+Wdr55GS84IWi6+UBsRjr/rcogy5Ebo3lTkxJpMvadkc8P7g7p1PUiJNeAdN0YsbB7NnqL90TsAct4fDVV+4wwVMVGo7uxKCqm2poAvwG1t0Ry5fXZPcQim0FdeBnzADA0t/HbMn5otKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKlMkUeo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKlMkUeo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gznK20p2wz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 15:04:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C4C7A41851;
	Tue, 14 Jul 2026 05:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B5E1F000E9;
	Tue, 14 Jul 2026 05:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784005442;
	bh=GWX7BHocDQy79xg1nWh2GEbrLAdwjBZsgjhN9hnUanY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CKlMkUeoK3O/MtOhbbbjwFwTm02ZhG1JN0IrLP/cep1imp4Q1D4dC+CryFlGQdYf0
	 p9WAKGQzC5wBQM5okRin6feO0hARpilwewRhbaiNNcCKM1j8Jc7MocDpN5cw2tKRK8
	 nj+1LYvvaTzSiKhPl4FiIFz0yQWKY4HCBfMNmOWwUa9RX0yKX9PkcYdXM49sULT1/h
	 UYL/h7YPtNp3dRvfiutw7m+FoTgPWe+acBb+18F1Q4lrBV7r68ZIbrLJjQvU18da7D
	 JyZBOTNljbEhD6ihH8+PmlV84vY3FW+tDDZSgTIf8Zax7ZuCxIIFsxyvwgxavAix6i
	 2U6+oR3PBWaIQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 20/22] dma: swiotlb: free dynamic pools from process
 context
In-Reply-To: <20260713194131.GZ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-21-aneesh.kumar@kernel.org>
 <20260713194131.GZ3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 10:33:49 +0530
Message-ID: <yq5ao6gamabu.fsf@kernel.org>
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

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jul 01, 2026 at 11:19:24AM +0530, Aneesh Kumar K.V (Arm) wrote:
>
>> @@ -840,7 +843,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
>>  	list_del_rcu(&pool->node);
>>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>>  
>> -	call_rcu(&pool->rcu, swiotlb_dyn_free);
>> +	swiotlb_schedule_dyn_free(pool);
>
> This knows if the pool has cc_shared memory in it since there is now a
> flag tracking that? So should the work queue version be conditional on
> that flag?
>

We could definitely do that. I was not sure whether it was worth it,
considering that it would add two paths for SWIOTLB dynamic free.

-aneesh

