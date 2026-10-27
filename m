Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39E606A31E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAX1JNaC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDXng4gYnz2xLt;
	Wed, 28 Oct 2026 01:24:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793111095;
	cv=none; b=bUJ4DhnifbBTMr0VDOwigQnQVyhJGtXUecTL5vwoZvqkQpaiWEBYbhYKED9tgJAkgWwcuaDS9+zdLW5NQwqxG/QkCA6crwxz7T7bRp9hqnOMuUNUeYayHCnocd9l/gcS3Zzivk60cVOdyPuzTwsuSXWFypXm+iVL87pKLR9UMUI+8UZhGxfq8hDNgSB/6CI5PZ7YPVpK51g65grto25U5CtWBw7eiBgXbqp7R1fycX+f8hfoAJDSLa0XqCwsCVz/jTcRcYzeuJ2RDbVxG8VrPhCVcEABLG3T+BYWHwoTOgnEzpcNp1h+ZdT2bx5Ja3eBO20u3MmrN+hezPA9PrkylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793111095; c=relaxed/relaxed;
	bh=yEWNUsKm7Qc1kCh6w8kIYNOu8KlZoqm6MpCK94ycMCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX9SILIuMxRxc0FRYJeUr3nxmmmYY2tTJ72wrjXpIAERr7aK/Wb1UY3sfmOzPjEgL0w9BF9fCOuw01y8iGOsQZTZqNYoeHlLh7DSvOSulJwXt5B6M5xi5nog6vMNdk8j/QYmCFS3cHqpfip1nWnLuYBLAGH7brJ++BQ4ZKWyvsUf/qSWn3R16dRNMXODnzCn3Oo+CLCubnhy4Ea3QhQ6fURC703IXxz73kUbGkdgTAWHzruP0/uNMjnLMhePyQh8UepnPZLGYwQ9XnTDBGbBahQd/FrCll5qUlBBkMg6y+3PB45Kr0vy7pOgtUW/0tUcYK+0/TzIWvEjdB75E9U2OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAX1JNaC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAX1JNaC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDXnf46PGz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 01:24:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 03F1B411DC;
	Tue, 27 Oct 2026 14:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858481F031E0;
	Tue, 27 Oct 2026 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111092;
	bh=yEWNUsKm7Qc1kCh6w8kIYNOu8KlZoqm6MpCK94ycMCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fAX1JNaCubrcsyleu5JKFAE8DVZpgxXVUYNn2Ftrdmin+Pji/mIbRMzmeXpQ6X+Dt
	 GiQlG4UjzjAX2RQJjvdSuBjWINtAivR46bYlRVZmePivZz31DHHty/dklPbB5Rfcdf
	 Y5j5wUmx2I+2y7frliw6sAmAlANp4VyGdlvLU3pxdFE/XCZIg9mTps0eGdmaR+7nmm
	 LUAPpflg3DQF/mufmw9/BZMJa+zr2vqHA/Of68S8yK8+I7KOuGjIPQkJHF+AdaJ8an
	 MtrWT/8TB45x7JSGXPUphbK3IS4vYPw5mpSnjtD5o+IIhwa4YTzB9ZxZc1ukVozk/x
	 v5E0Bl5UB+HiQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id EA8431980047;
	Tue, 27 Oct 2026 10:24:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 10:24:50 -0400
X-ME-Sender: <xms:LbTgah0Y2zUPM-xl095OIMJHEEk1nZLl-Xwkwcr3ihWoTEXW7hhyKA>
    <xme:LbTgavcSnHTljp_qgS-o-aGa-RdYdxJx8almLF0RvrQDy82IxyAZM8QgP8aCesr3N
    i8Y_CPaqbelc9CSgeY7LKlahn6_GDfBCn_m4lXNKKymEDXmzM_GN9x7>
X-ME-Received: <xmr:LbTgasMkIrRCiVWd4olqDjheZxCHlGu28Zg_-RduqHp4oo75tJbWsdNjsjo>
X-ME-Proxy-Cause: dmFkZTEY7jaHDxQTEHTExXmqATn3TLnQPFgZZSRP0UGVbFG61dzcxdwg1+6lqF/EbilMy8
    kGIUZu59aEs28drJOODW15kao7vxrYDqwJWwMD5qolD3GG5RJNK3YouzLlKD4P5N/+AnT/
    V+KB46kMbRC/tqkZ7JM/qFMTKwgFjdtx8NJuqp8whRVPFF/LABQe+3fjRdn8g8HHcwQWQ0
    /JIv4J9NBgrVmUFlnH/h+d+lra/nEXZZ6i72c+v7yPQ/0iN5IPmbKaFLVVqZqs/TCC+doQ
    NKK5Z8jg35RfRe1XoCKltDFCkiubplQ/n2C6OV5aNqtcGJKNis+aP3phFz4wOInMw6NHUZ
    oBxkpCoYzMXHT9otR7FxT3RKzIHyZDBPWEqfjYqxrAmY0kbhT+WCr9jk4x4n/ptOHxmBOI
    K7VN4ooTSjgriQG70UUfAvtbgY7whOPgODYDICVDtzBDDegIDa5x1061P0tRu7XDJnr4Ac
    01roTkEO7+e+nyRlPAXCyaaEDQ6IojvMMMtZ1G0pHZepYB29zVeTbzwsI+ZD/QKrsskd30
    sO7XbzjtRDPjp83vRAXtnLG9BOcbcLqA85OG4/w1e4HYBFIkaqQ1uzGj6+91RucfEjxNZg
    3TmZM5JelINSN2jKAecBHsE/BdpGGzW3wpBbodKNcSEotpAqHgYegXN90QXQ
X-ME-Proxy: <xmx:LbTgak0WwXqcogqRvas4QCxiGAPXeKPTd37Miz5AJK1hi1YjAK-J1A>
    <xmx:LbTgan1DufEsTFW9f2ItVSaUyEdhgCeqfAWV5ZMVZI5xtnd7-Tn3Ww>
    <xmx:LbTgaiULC2sV0jVr2uVPOMjZvUTfgMHSTqZBB4QZqi2AsNo7QkYTWg>
    <xmx:LbTgahiFu_fq0FMpKro8JZ7vva5k21ZPLUGrewRqjHdfFedeZq0dIA>
    <xmx:LbTgatJsqum3IFN3Q0rVKi8wl6c9tMliCODtpaMdX9s70a9rri26ZS3H>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:24:44 -0400 (EDT)
Date: Tue, 27 Oct 2026 14:24:43 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	kvm@vger.kernel.org, =?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
Message-ID: <auCz5LKkNatuoIxM@thinkstation>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-3-66f00b7a564c@virtuozzo.com>
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
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-3-66f00b7a564c@virtuozzo.com>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:36:02PM +0200, Konstantin Khorenko wrote:
> copy_huge_pmd() reads a special PMD without the page table lock and
> copies that value to the child. The mmap write lock held by fork does
> not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
> lock.
> 
> The zap visits the parent VMA before the child's, as dup_mmap() links
> the child right after the parent in i_mmap. If it clears the parent PMD
> after fork has read it, and passes the child before fork copies it, the
> child keeps a mapping the driver has revoked, for example:
> 
> - vfio-pci: the child reaches the BAR after the device memory was
>   disabled or the device was reset, instead of getting SIGBUS;
> - panthor: the child maps the pages of an evicted buffer object after
>   the driver has released them.
> 
> The same branch deposits no page table under the copy. ppc64 in hash
> mode keeps the hash slot array of every huge PMD in that table, so the
> child dereferences a NULL table on the first hash fault, in
> __hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().
> 
> Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
> from a folio under them, as copy_present_ptes() does with
> vm_normal_page(). The zap clears the parent PMD under the same lock, so
> either fork finds it none and skips it, or the copy is in place before
> the zap reaches the child.
> 
> The copy of a PFN mapping then goes through the same tail as a folio:
> 
> - it gets a page table where the architecture needs one;
> - in a shared mapping it is marked clean in the child, as a PTE is;
> - in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
>   protected instead of a warning being printed.
> 
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

I have limited understating of VM_PFNMAP/VM_MIXEDMAP, but looks okay to
me:

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

