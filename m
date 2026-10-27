Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE1606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLH/Tvkc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDXQl1qY9z2yDc;
	Wed, 28 Oct 2026 01:08:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793110111;
	cv=none; b=E8tS/elptMaWAmgj7WAywpuFFOFt1A3wy787RbwLWsb4vMxSIgX/LMAvxcO4m5kz3AlJ8GLEH5VYckZA7MSLih3h4TaAMj0XPd61oEjVWgnD6AvlycmM9j/wzbDs7X9LfBepmofBqRisO7emreNKSp2E2v3Nk5tReXriq6hZmzkboiEhkZSODjRl8r5FXXrY7/hEhpRgf+71j8dO3rnlHhzXVI14mfLNGnR2LtpEs7Up2XQQ6b3cBLUHxlUcBgWj/J/2z3QSc+uPiCTlfv4LEt8Z+87gj5npyLvw6w6JhL8/RK8ezixnpVtrNGoIevAz1HghZUeAcjXLXyLYKFbq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793110111; c=relaxed/relaxed;
	bh=CbvGWJmf9YwWN00g1u/NHLatne7a6bJt0jiNry4VqD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8G1bwOIKE1vRJvTwhp7Ey3+qg3Xr8pExWoeLRV3Mdx3hX1pb8mFQRtas/8J77oB5+vgTDhWvAdWiqlFnuh7rDTRN3dfp1ShBX9vUNU1HErlxvnkAvbYiTQHxSxJ0axpctGh9YVvFCNtiNFS2sFJIfz95zkKbrT83mrtNA9WpD4GeZNJN/47URMfgWDfqvVzB+B1tufAHYbBGP7L+HyWeLkCOcZeP4nh7Ag07EXAIWqqt3LJM2uUqMEtoGyDiVEft+1PRuIfBeI2h7ugcs/8b35SJtgNTUXOixpK6gpC9T1KsUKnJF389n1EeciVZdYVfgHNJzLkSh5ecG4aWjTMbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLH/Tvkc; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLH/Tvkc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDXQk1CY7z2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 01:08:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8526A60218;
	Tue, 27 Oct 2026 14:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4301F031E0;
	Tue, 27 Oct 2026 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110107;
	bh=CbvGWJmf9YwWN00g1u/NHLatne7a6bJt0jiNry4VqD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mLH/TvkcbPJ5pX+EjBJOwjRTX74u6eNmAvjU9QfleDiVHjaVjQW/UQou30MulrOxj
	 jToXXyijxOB6MGesqEn7wu9ky5T8zw86VlRcsgKAnpYqYNkDKNrV6WE/Z8nbpCvEfZ
	 lO19Saq3/9HbIkvTIRHU901td+3nILEzJ/Gr/WAPBSpbxNJbFujf3z9Br1/D4YByki
	 3RRrOcQ4fNSbdoc4nJ2hs6Lf7+NnSiUPF3Tb2rYJ6ge5fQSMQ80AyBQhDFy+VhWIJu
	 8TL/npIiy1WUyq4OObCMLtpqBEnh8iql8u0bu3P4zLEUlretOIC4LadBPf4u1zanll
	 OH7d9xyxmpb/w==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 263961980047;
	Tue, 27 Oct 2026 10:08:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 10:08:24 -0400
X-ME-Sender: <xms:U7DgavnxdSNtUxqaNd3ZPHA-GgqWp0ak_-5ObLq_rxP4hAiTlHOoKg>
    <xme:U7DgahvkmRPPsHyleWajOnL83T8ou18ct43iD-MVEmfDhiGNYWj7adNpuXMgzcSvL
    h-Aib8Gkk3fFuJtkkdHHLlzGDYFt5FEMK9Xn7XjtbUpLHkRz6o9QzU>
X-ME-Received: <xmr:U7DgamDt0DMoMRD9ALRRPZ69IGo-7jn5OsY2yyrJLpMhj7CGSymFsXIejhg>
X-ME-Proxy-Cause: dmFkZTEaZA2PaW1k67BxuO7K43FLH0AXzaKFjjKJfwu/KpGOFsmjjz9GSuR+5Cg+oI7dZA
    8BXp96hrgxr8G83eICbVIuq3GGRRXyrwDLmbW5B80ASp3E45NdoC/6iVPRbMkGsI5q7/3F
    T/g200QQfYlzbcx2nKjkpGdEmX7ucWHHKtmchRf9OkWPEt+EEpay6nygL4fJYyKb7W+qAI
    nnRokAmwK7V8GxQtulk6RfB7RjPcJAnuFWyVrb3qEDbKJeUsNsxtS0j+Q49GQ8esgGy3V4
    ZmsVBdUTtK1knjxzJbTbkJX1GHETc68pBeGN/x1WbGSyB4OKk1yN7DYa2iMaIpVnzTIslT
    7aA4dhG3GVMCk4eZnUELWNFF4UCcuoeVpQmaHUKgefcK9w4C4Fz6Xfyz1MXvkM+/i/gpv/
    wBnbicRBljlVlfuS5RDXoX/VTYAjKsd0JUJl0skwrZ0+MYdjfRy9CTdoATnXysrrO8qD48
    ApJmhXkDd/lBtfES8tOCo1i9zCfzVj450Dq23/37fF1tv1GUAZLrsktJHSdjL7zr28Z1ac
    S4BhWxDe++Qv8LvAK0GnXF9RoJFURWADYIzEd52HXcM6KX9aBC7rpJZnJZNEdRNln4q3+U
    PMKz0qtlHCAmXs1bZFdjhJBbn8eFOnfdZUQFqf5iyvcczuw2MU6juU0LijUg
X-ME-Proxy: <xmx:U7Dgasla_gR8q-sI-JNR1LqZkQT_nTfLQl1cHRv6T4W4Ake79iTPUg>
    <xmx:U7Dgavj3xzu4vBZbB51HVdp4cr7W5e3S-oo_c-kw6mfh46R1sa5L_A>
    <xmx:U7Dgalty37v8Eg1mkg7bNhiCDj1BSRmb1trVWEo2bwPQFkPmtlNaOg>
    <xmx:U7DgamBSPtDBwLyo5fZ2kF7cR9JCXEkjyH8DP8ww1lZzUQy3zWuzTA>
    <xmx:U7DgagVwQ30ZdR7dUwwj3cSK-abW5nEmNfwTYvWuLxrxaHMCSBiyglPP>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:08:18 -0400 (EDT)
Date: Tue, 27 Oct 2026 14:08:17 +0000
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
Subject: Re: [PATCH v4 2/4] mm/huge_memory: copy file THPs at fork like
 copy_present_ptes() does
Message-ID: <auCwHD83jRCtt8Xo@thinkstation>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-2-66f00b7a564c@virtuozzo.com>
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
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-2-66f00b7a564c@virtuozzo.com>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:36:01PM +0200, Konstantin Khorenko wrote:
> This fixes no bug: it makes fork copy a PMD the way copy_present_ptes()
> copies a PTE. Until now copy_huge_pmd() skipped every folio PMD of a
> non-anonymous VMA and left the child to fault them in again, while the
> PTEs of the same VMA are copied.
> 
> Treat file folios as the PTE path does: take a reference, duplicate the
> rmap and account them. fork then pays a reference and an rmap update
> per PMD, and saves the child a fault per PMD it touches. The next patch
> sends PFN mappings through the same tail.
> 
> That covers the VMAs vma_needs_copy() sends here:
> 
> - private file mappings with an anon_vma;
> - VM_COPY_ON_FORK ones: uffd-wp and uffd-rwp, VM_MIXEDMAP (fuse DAX),
>   and VM_MAYBE_GUARD, which shared shmem, file and DAX mappings get
>   from a guard region.
> 
> The DAX huge zero PMD is copied too, with a reference taken by
> mm_get_huge_zero_folio() as for anonymous VMAs. A migration entry of a
> file folio is copied and accounted like copy_nonpresent_pte() does, and
> made read-only in both processes only in a CoW mapping.
> 
> The copy then gets the same tail as __copy_present_ptes(): write
> protect both sides in a CoW mapping, mark the child's copy clean in a
> shared one, and drop the uffd-wp bit where the child is not armed. An
> anonymous THP is now write protected only when its PMD is writable, as
> a PTE is.
> 
> A page table is deposited under the copy where the fault paths deposit
> one: in anonymous VMAs, and wherever the architecture needs one.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

Okay, I see benefit of aligning it to copy_present_ptes().

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

