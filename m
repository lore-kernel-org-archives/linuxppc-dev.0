Return-Path: <linuxppc-dev+bounces-21371-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627D7CD5BB3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 08:13:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMJ1m4PYCz2xSN;
	Fri, 22 May 2026 18:13:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779437596;
	cv=none; b=TmTI/9+48GnPmcFShDEp8ncMOo3Z9a56hFOv84dN74E1tgJo+YCEiO6zUUGhg0BM+55hHPvpQbztKICRgXAEw+rT36SalcuqwVCUY0AGqPfZSBCAlLJhG2Wny1n9qBL7jYNmmYQt7RXIQHCP+/mKWfvncCVzzsQblyrJyTGl5QJXGwVMUxiC+L5wUkjk4HaJ7PENhrM3hLMXUhRzgEddO3cJ5lNcTiIw15bzsPte53WbUDzboRbT+ShKDLZwa6HMEsD/UomrO/C4JblFLhOHCS0ZYZZVxgi86/vHkoOjWVf7W7rj0jhGoO/iaFjvAqX3HYvNzfl8f+Sa9lyMFAHjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779437596; c=relaxed/relaxed;
	bh=ccAeL1ERB+r+345gl5qU77eKpAq9Gi9fPD1ei35H+Ds=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=o1/Ejq+L15TAXNgiMkOsP3Th/UMvDec0DYeKhcLvwF8SG1BHyjHbmyv/57Um9EHFP7y0OzOkkjuKVjgqMNZCqrAyS7Vs2JyRkP33dF5RhgK3BEDnw59Xds0gJ6QhKYDbSSuHhNt/8WQndbjTcgzTsO2agfd6hq++Txzs++Oe5lz7Iob9qgUOiz7kzOEM/QKqUeuuXDl7AuxNkVfarFe+XAGKwAH+jrdWV6h5oZwV5jA+LgxJGT+isuCcUcReIZ+1t2ItBm93IOXGEh+Satn3ZCePN5hd6HQZyS3BgiVNPylpnXtdpmyvFsdw/LOJl37ueYVTfodDMM0cPHLoXAL5pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGn+PukV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGn+PukV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMJ1l4BGhz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 18:13:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CD9D43BBB;
	Fri, 22 May 2026 08:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20621F00A3D;
	Fri, 22 May 2026 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779437592;
	bh=ccAeL1ERB+r+345gl5qU77eKpAq9Gi9fPD1ei35H+Ds=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=eGn+PukV59bZ4yYZYIu/6OODX6Oe878o6WY0cJENFbE2XlZkjr/2wFcE04d+3TEiz
	 Y7hHSoWKIXg6X4g4d114pWk6QsLMZYAtspGjq1mLjpQmlWXhTXmJCXkx5SzRt+UoeE
	 oLS3hqZtLjdjfJ+MQZoeSCS3N7txkvPPiulcf5cVxXKsCHqCWvYP4U5ubgvXy9/qvs
	 zUxt2E758jAjGQ2j4J7XSijH3Sk286cGzVG3u3hqMJakLtEBHyXVdP9Yw16kXWFUuy
	 s+6Uoc9bkxzRMGxVIuC2kJe2ubo/4zjiFjWRtq0KcJPiHp/dCziQCmYVqraWgsw4bA
	 9oTutTYukNlnQ==
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
Subject: Re: [PATCH v2 04/69] mm/hugetlb: Initialize gigantic bootmem
 hugepage struct pages earlier
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
In-Reply-To: <20260513130542.35604-5-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-5-songmuchun@bytedance.com>
Date: Fri, 22 May 2026 11:13:03 +0300
Message-Id: <177943758344.3662727.2192220418077361290.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 13 May 2026 21:04:32 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> Gigantic bootmem HugeTLB pages are currently initialized from hugetlb_init(),
> but page_alloc_init_late() runs earlier and walks pageblocks to determine
> zone contiguity.
> 
> If a bootmem HugeTLB region is marked noinit, set_zone_contiguous() can
> observe still-uninitialized struct pages through __pageblock_pfn_to_page().
> This may not trigger an immediate failure, but it can make
> set_zone_contiguous() compute the wrong zone contiguity state. If extra
> poisoned-page checks are added in this path, such as PF_POISONED_CHECK()
> in page_zone_id(), it can also trigger an early boot panic.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


