Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC25606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mF8zRUbq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDX5H3PFKz2yPG;
	Wed, 28 Oct 2026 00:53:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793109203;
	cv=none; b=DU9GAe+z9bxfyET99+ZVt+u1lBVRYLmnIb3LvSD36S3Yv3G4jVIsWtl7Q/buAAH+kugrpK3kMDBhb7ojfzLHbdwA0kKLsunmMNvtp6BKDKAP9nnoj8D0yVlzKgNG9VnYeLJvcWlF6Po9/mtKFS/To1CxHiIQ/tyUNq5F5dop8PhqI4xB9pPQ3O6Wzo97WWFI9OlFjUSFGNPoG5wVqHjtQzFezX/mnWER5x5HP47fHt/EvLU9a6GnLKCki/74BAhAS3hAyzh43aRfXbH9j4oQTxZm67e1qblUzU2S4q6ZJd+5rUQp9AoCERGJAs2XibmyLuY6rt2U8K6vB899y1mIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793109203; c=relaxed/relaxed;
	bh=wGwT1JNbkqmcP8fUAnZimf+aufAiCIdNGNB+5b8MPdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq82t1DZRC/vt9Tw2tN0GfxWtC2O7mySvsHS6RrnS8Jtj3mAEw4bUVZvvUq8m4GcbCu63j3/o6sRKB1gIi4pZ+GBrOO+6qYGb2C7v5rR2D/BMJrbMtPLZ6l/lS4KaPwkPRRYJgMxMry7eHNbWb8V9/ihjtcsOTo451JmQUVNLssea1EMGfIdhk+3UgtVqPBOJ7qkokmtyxu2z7zsbCjfBRPzGEghCuKVvWChVF971cTf1M/5dagxmC72P5PE2nx8baAVDnfgT1zfI79DZ+PQa1zh0PVFufy5ofUQ8KKbH84MT3jLbkmHwKs6fNAiXiAfxGqv/AZNJGEs7o9WHbNMCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mF8zRUbq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mF8zRUbq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDX5G1ZbSz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 00:53:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C518E6021C;
	Tue, 27 Oct 2026 13:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A56A1F01828;
	Tue, 27 Oct 2026 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109198;
	bh=wGwT1JNbkqmcP8fUAnZimf+aufAiCIdNGNB+5b8MPdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mF8zRUbq653nfj1B5K+Z45VMISn5YnE0sHMQhzG2zkRwMerN1u0TrRYVWk97hvTNM
	 uZ0lbteq6tg7KdZ6atcsSTAtfYTmzLqgtX1K28V52vEd6MnMqTJRJtXXcFmIky/8m4
	 WR+SVC3nI3mJmtmiGZw0lBVh9c3YytpGhMYIKmLAbMuSK8tZKjeP376mr2B1DsolpT
	 npnhhnwphjkK431NhDvezTuq5Ni+Vq5zhl/CRuPB0GylScV7NWGxBzcj26Q0m9qpXO
	 ybIZxQd/9nNRMeX/DedkmjK8u6shpdQBEcP8ZqLjIeFW1ucPz08OQzMa15z+dB6HJS
	 6/qy3HLH+nbKA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 85CC7198004A;
	Tue, 27 Oct 2026 09:53:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 09:53:15 -0400
X-ME-Sender: <xms:xqzgal-vr3ZeqbXQYJBliutUwh-BPoCNU76xbXs7mx_Ps-IdSmK23A>
    <xme:xqzgaoksYXGkYGnJF43sYID0Tus98V08BBjG64swDvpdheaZW5VbBJyVOc7DQ6Frl
    aoZ3R23YOrTA4h2thSa7n_eENBiVLh_oK4jdwW4aOnapsUIANjaAKZd>
X-ME-Received: <xmr:xqzgajaYJVYfdqtgodH29574WA_vexf-pM5sNeV3dSMQBjrPqxVqpVsiMiw>
X-ME-Proxy-Cause: dmFkZTEZ/rZ8QL4tKdVH13M4isFoJoqE6mmyk1+ybcvlxgqSp6W0ayLRKd0L7SfTmxuGb5
    U6+Pfm114T++Wp3SC2FV78EqIZ6zQGqKV5XyNS0Q8g8zeea3kGWywXyvNgIRW79CajYQHr
    2jF/D3zyUpa8mENlQ2k9kDlrLHG9vuqIwsGPeExjecTgPLyR3BG4mU+4iFcKzGjlB8O7dl
    rHahXQtAt7H4ct4Hi0ph4caUm45qDhARWvo+NXS6RvFk5in2esxS1VkNF3/wtGoX2gxkDU
    HYhd+ifyLHB/lQg4TvDcO1vty+4TgdFGCdUfD6xIrm+RnS//HTrIeeMZCfQmeBD5mTfrrt
    28F2SJuazbG4sdilPjnUK5Xk2C/b77Urnpd+yJpFkxf0srCyBWlhL6vR0USCQldwnnbiLW
    9q+grn+3rpVTZTV5aFHrdKvOYqBL1I68cy6Ts9EvEo2mG6eqSnlWVGArQuLZTDmYpXGIvS
    wXLvRFTOpi4viZ4HzYk4qCerKNTdy3232MaWMRw4+fGiHl1k0822eLObmoSxbGhZG/SB+U
    RY6eT6x1Fr7R33DiHsTIEPGR6+Uf+O9CEjZE+sUhhEJff/MTsubZ9LmOVI85mrAWUqqbJx
    XWv9aGmJ+yJbAfbRPaNRNIocYryGvdsYvD8pPJi4F3KUYMPNesYsAvQV4dWg
X-ME-Proxy: <xmx:xqzgaudbz8X2mj1TmcVhbSB5pj192_SKV8vP7t-J3qUs-AsDGR5erQ>
    <xmx:x6zgar5lbie9c9vsEIGyR4WR5HHpSCBz3DCSwhV-Wl76bl2cm_9stA>
    <xmx:x6zgaqkT5H7khckA_fD9bSj4bobce4cCO515thNp8GAx2LHLg5LD3g>
    <xmx:x6zgapYUC1r3US7DHJV2QXJyRoI41UHODbj8ZuE46i0U3Qjz7C1IHw>
    <xmx:x6zgagOltv2MpGmQj-wyDgIG_3JLhCWmQzbtOVj1MoCubVlHQLT8Bbj6>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 09:53:10 -0400 (EDT)
Date: Tue, 27 Oct 2026 13:53:09 +0000
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
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
Message-ID: <auCsphluu2gwzEPo@thinkstation>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
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
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

