Return-Path: <linuxppc-dev+bounces-24182-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBCDC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 03:35:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzlM237xSz2y71;
	Tue, 14 Jul 2026 13:35:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784000142;
	cv=none; b=HISg6ZuEw9hadaKPrPvodmItyo1B1KhO1GZWwtHWyNfwU+S8rYGWBXdWk5PC1Ph3oiaDbWTFIQw/9C4KhqIMCrONfTkv8Zuh/EdNwMaqVagDV1vPreTbmLDKQfAdsPJXDu0dZEPLA0iA9h/Rd0N0bkbXWwRVhwqOgkQk7CA0w3K99vr1avnhhIziQ/DJFrDUmBGa8j3ZiOa3Bn47LDuR8ishAjA5f3afdnnsZTJcjPjdYwpemooWcqGJxbdRO3Ill7LfFSAgx8Bf1qrDiARihkufiPonPHy0/oXd+xzdV2smOJsnDf7WgvA6Q3hvU/U96IN2Ko2M6S5XvQuGc0zUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784000142; c=relaxed/relaxed;
	bh=J8EROicyvyqBHzNN9rE23d0T/JySclZqP++7t7T4RaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cz/0MwCc6i+BS5sTHjLPgJ2AwCypOryO8vTSxfwLK3Tt9aJPfmrvyZv95z62SlfRsLLFmC4Cm8h6yH3VjkWPun9m0qJ27mu+i5Z7HQ5n1fmJlLvD+JiN6M2ETdS1hg9VWwl1DmYUPiO3poCQu2v6Hg6TPiT4pOvN0YFC+q6h6PqstYxQ4DcDMzm6hQbvd6//NEmMJUhWop4BjgZ8tdbKmls40DzozLag0SPym/rYRIBt8UKWGe+ZpfQMyn3C81Ccm3FfxM+ZwNfJocorVKMFCnFEwYXEcVPfyasFHjTWzQ7xk80+UGA+vhHac2MQ+bZvpSQCQ1WGe/jKvfEzmOkZ1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcW9AEgv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcW9AEgv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzlM14MPrz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 13:35:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C84614349A;
	Tue, 14 Jul 2026 03:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3675A1F000E9;
	Tue, 14 Jul 2026 03:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784000138;
	bh=J8EROicyvyqBHzNN9rE23d0T/JySclZqP++7t7T4RaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EcW9AEgvcMudcqLdd5C8/BiDRQ3ckffoh+3joXtfcvQArty1Bqy7GiIydvzIBCLJI
	 ZYtj7PhBn7KY5xOXpbDoYrxVdGcfi3vpdsHKGCNWFha4MIt+IhEV5jDEBjBoyWy2iq
	 bj05AAquiv+sKEDadr4DNLJ3+mfRTpc6qQeInr7Odr7bDn+pbXtO5yQMpfS+FUvAU4
	 8ZpHoUc5+sQxY4Zemd+uQ3SKfXOCSJ2Ui1KfmTI6rr1/awo2nLjrYkhAKzaSTOFy+Z
	 5A/hh2E0gsAAMZGguGSuY4n+PIlelCOb6vjM8CYbnyg5x9L/brWLTpdEsmw8Hz8Ctc
	 KsvvwB6a/KzRw==
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
Subject: Re: [PATCH v7 02/22] dma-pool: fix page leak in
 atomic_pool_expand() cleanup
In-Reply-To: <20260713175433.GI3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-3-aneesh.kumar@kernel.org>
 <20260713175433.GI3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 09:05:25 +0530
Message-ID: <yq5azezumef6.fsf@kernel.org>
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

> On Wed, Jul 01, 2026 at 11:19:06AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>  	 */
>>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>>  				   1 << order);
>> -	if (ret)
>> +	if (ret) {
>> +		leak_pages = true;
>>  		goto remove_mapping;
>> +	}
>
> Truely these _set_memory_decrypted() things are an insane API. So a if
> it fails to decrypt it can be in any messy state?
>

Yes, we could possibly try to encrypt the page again and, if that
succeeds, avoid leaking it. We might want to do that tree-wide in a
separate patch.

>
>> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>  				   1 << order);
>>  	if (WARN_ON_ONCE(ret)) {
>>  		/* Decrypt succeeded but encrypt failed, purposely leak */
>> -		goto out;
>> +		leak_pages = true;
>
> At least this one makes some sense..
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Jason

-aneesh

