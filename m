Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FC606A32D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8OWakWc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9JfJ5M0Jz2yK7;
	Thu, 22 Oct 2026 19:07:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792656440;
	cv=none; b=Qu2UgSyt2RSxwCYjGuIJTuoKHFPIMJhObOKBN9AQ4rnxU/EsRULBpUZrMb5THIm23zlc0xt4Zx168EbIlligvPswEe+bp5dRtTJ/hMnm9j9fspqR2/GnmnS7e7L89JOCF8tOxegy2UxbKzB6dziLlELv/A1V0QoSQkFg5a5EJ3MV3LW5DC/54RypYP8cuxHj5YkE0tGI2VKJZMx1I8j1wYxy5By0pNcXbEJe5rE98Y2gPz4A0Ic4OT3A2mlliUGEwBSXM4jIyEsYdT1jfNlG2Ij8+zOIJ0zDXe6o+BuxNZE3aG11QgbN8LAn+EhluUdJVgdQFf4skC5oDvdir4KwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792656440; c=relaxed/relaxed;
	bh=IK3vlu7wIXXSLKBylI9CXBQS+y3D6BVh2hkB8AeGdBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldGRBXYuSt8uEgg6o/NetNfsGHLtv4qamqyIhRqBNwCm8GJgU8qdL9eYf8D+Xisvq3STdvixy+6+vGOzTO00zfRt8GlKhys6sWjY8NsYlB2rLf6OQNmd3hCwhjz3KGnsyzJD46W8XjYJxRGxlpPY4OxwVlAAdOkU7boWaf9bDqixiFNe9IJPl0t8fyJuGeOLOZtIifX/WIOzvripvSay3y72/G8pPOIUOcJ7bjYw9PRBmi6wryuesBuw0wZtDjDVuE4iD2x2HLGPbD8jRybKAcRxdq0+LqTxMCVVMdvYhi2PUYaEcY149L5CBfTiV5r5pZj2yFgdMT9sEOAVcnSLgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8OWakWc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8OWakWc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9JfH4lsxz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 19:07:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 01594414E6;
	Thu, 22 Oct 2026 08:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4890C1F000C2;
	Thu, 22 Oct 2026 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792656436;
	bh=IK3vlu7wIXXSLKBylI9CXBQS+y3D6BVh2hkB8AeGdBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W8OWakWcVu6p39n/i/pswI3AEMxPh3lVJFQRbJlRBkHWiGvyfX0zXNVk2SA4fB53g
	 JHz4wNXmab5xisFmoVJgNFDkp+pI303W5So1d0OPUiMMHVQJWz8xuIK2aEajORCG++
	 reNbr9AqxfCgM8sCBsaPNlNAtM/M7qg+ZuOxPYKUvOrJRA2PnNbcCNNvkN2coaJAdq
	 FP7utVEamab8mGO32rjrrQwCCeXrVEPqqsXIZBlr2QOEY3hDSZgnzuU+phWNMEaN5b
	 82XCF3BVPJKHXalMygYHHKD5QJ+Hda5VHcVnDI/8kyvAqN7UYo8dXeht0md63zKLNg
	 Y4d6s9egOW1PA==
Date: Thu, 22 Oct 2026 09:07:09 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	=?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
Message-ID: <atnEFyGRYGGf9shA@gremlin>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:36:00PM +0200, Konstantin Khorenko wrote:
> folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
> __folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
> PTE mappings to the folio instead of one PMD mapping. Each unmap of the
> PMD removes one PMD mapping:
>
> - the folio's mapcount never returns to zero, and removing the folio
>   from the page cache reports "Bad page cache", or hits a VM_BUG_ON
>   with CONFIG_DEBUG_VM;
> - the first unmap already counts as the last one and drops the
>   PMD-mapped statistics while the other mm still maps the folio;
> - the second one drives the entire mapcount below zero and drops them
>   again.
>
> The helper has no caller yet, the next patch adds the first one. Pass
> PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.
>
> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")

Was this a mistake in d8ef5e311d7b, or actually intentional for whatever reason?
If the latter this shouldn't be a fixes.

> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  include/linux/rmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 0b332770abeed..7562017416094 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -558,7 +558,7 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
>  		struct page *page, struct vm_area_struct *dst_vma)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PTE);
> +	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PMD);
>  #else
>  	WARN_ON_ONCE(true);
>  #endif
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

