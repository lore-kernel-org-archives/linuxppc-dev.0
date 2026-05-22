Return-Path: <linuxppc-dev+bounces-21372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54239CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 08:13:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMJ1r1Dmdz3bpJ;
	Fri, 22 May 2026 18:13:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779437600;
	cv=none; b=k3AhDb6Vt/R9WDJx8A4gi/f4jlJl7m7q3YsoOrwWoXgm4F1ZJ2BwSDvZ8z6h+K1PNshzo09IC2dQ9DiWl3ToWKaMVX88y9uklTNTzJ2XbN17KQpngsuNV2o++hGI4ypas3hjGvcZ8LqCWQWY3v2zNGxoWUlEQdyPvutReAU4qr5gZx/3lduHeO9OYOUKgW2BDvHAkIBv/TLtA/+RKe1WaUiUoF5uAV+xziPGsxRcFOqQcbC5MZxikK5U604wv4LMrvqYxdhj/3SzvODtSFR5xRCTir47Fks+bgnQ6oRFQD+t6fiZbOOBpSdB/9fCz6G0hr1nE7kHscY9BJ/ILBORYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779437600; c=relaxed/relaxed;
	bh=rjd0Ici5RRa42caP7Adz+RlEQcxBp92asdSU7nNb23I=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iqo8KQM6TPDVZn4bNwRl32zu1vk53VDZeKEm2C/RDVn/k0G4oDkxvtPEWRvxg9OLAnU9iwcrvV1BDgU5IoX9n+KVcKOdHCxWg8WQQM4EEmCZ32j2DCZildYY/dB6pFYh0Srui1lkbsvP/O3Fwoh4gzf/DkYKc6amTDmNrJbP9hqOwBp/8h3yEFLs3G1M8qgyOWRsFuEbsEJasN+GUNpj1yX1PbqmeCxhIma6qOtQ37J1StPVv+4KnOnr8V6ueCCbKomfbAiPpGwWojRtfPZfn0eQp34+OXzQSbwKd78/M1vl7Ui5yppNOQKwSs65TVuGhNnwl8PziRf58c8pJ8bs4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwivcnQL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwivcnQL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMJ1q4WJvz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 18:13:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D27DB416E5;
	Fri, 22 May 2026 08:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2071F000E9;
	Fri, 22 May 2026 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779437597;
	bh=rjd0Ici5RRa42caP7Adz+RlEQcxBp92asdSU7nNb23I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VwivcnQLXnX0HPcQa68w4qZ8+B1uxc/PXMVMVHbY6TOn0o9qF8c+f5Yco8PCOZz2E
	 jt3xWk9yPeRSf5Qkc0MmD9ifwaf2NMt6wBX0H6HpZZ7NcC4yS5wmOD+w66pAtJ1gao
	 izXbHWKUo9xaJl6iIeCMCV2jtBWj74XNJPwI5xas0z/a27GMDt04SYMrv/kB0xAILr
	 D/BGxkIiW8vuei6qeeaRnW5mFl4NrJyTlceABTTBZMUjjZtowzUXahrH48wJlfi/o1
	 BpVVTOroqOGNhvcnHz4bV4Xnz8oBlXWQfsanQa5egO/hNbagiyFKskYQdyvok+xfmR
	 e+PDjvzYHmOxQ==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 09/69] mm/mm_init: Defer hugetlb reservation until
 after zone initialization
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
 Ackerley Tng <ackerleytng@google.com>, 
 Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com, 
 joao.m.martins@oracle.com, linux-mm@kvack.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260513130542.35604-10-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-10-songmuchun@bytedance.com>
Date: Fri, 22 May 2026 11:13:03 +0300
Message-Id: <177943758345.3662727.12436499269960922490.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 13 May 2026 21:04:37 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> hugetlb_cma_reserve() and hugetlb_bootmem_alloc() currently run before
> free_area_init(), so HugeTLB reservation happens before zone state is
> initialized.
> 
> Move the reservation step after free_area_init() so the relevant zone
> information is available before HugeTLB reserves memory. This is needed
> for later hugetlb changes that validate boot-time HugeTLB reservations
> against zone boundaries.
> 
> [...]

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


