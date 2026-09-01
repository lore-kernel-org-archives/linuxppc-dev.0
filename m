Return-Path: <linuxppc-dev+bounces-26389-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9080C624D7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ60k1lWdz2xlv;
	Tue, 01 Sep 2026 23:20:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788268806;
	cv=none; b=ntH5q2ooqv1QWxNMHFE/gtGUE5OiuDWIvDpyLb6HAF8kDFhLl62KWgH0JXM9uoaXZQg5g2cqXfNuUaNZiUe03tkKRTGEkjZYY4tptCw5MJY8EGcGAZ0pg795WxdN7CNaQ2aaPQTmAvV59HrLACkpfB5rAyCbeazTFcVIi4ZYl/cta7e9YRwdhsDOXE1+fQkeK1LGa/A0N3uU6cjeHpdm3ZJcT8FdqMkkNhU/iAW93OyitqDcg9DwaeEB2PuRGxMie3V7GwP7EJWWCNysyajgwBUTHaPksQkTjsx7/vEHpeZa4DxBaPedAqVCgNh4ZUSHSXOnCNkeOJE/bXV0WBjJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788268806; c=relaxed/relaxed;
	bh=4K0ioKV5pbE4Ef4e+GKU9dV30pSsLWe3AR7B9Tx4qSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMQWOWTNyjbdEnCRO8mwdRFVTQ+XQAkcMfJD7y+LVwWJogcR18xbuyvzcfDyblyyH/Czl4keD22yfbG7yBGGASDMPron1kTDUg0EfHSaNbYOB2gXpXBx4J+22goGEO9C7eYJ85ROpH+e30gP1DB14R7MRPaQymTaMDpnmp0XiCGIwB6F4yisXkloQ3X3zzWmAQZ4L8XgUL+kreCSrXBlLQURZ5/4DN0vYeRaSEf3/ygG6W4o3QYrIrp5z14/uILqo3TQNcDTXXYNX2dD7GAW0GsIPnSx0vfffEYxkLy8YaG3XWhp56nW5cik241P8XRxBXHVQTfQucWkEsm/+Kp72w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LztPPiMV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LztPPiMV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ60j04fnz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:20:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 77231602D4;
	Tue,  1 Sep 2026 13:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C311F00ACF;
	Tue,  1 Sep 2026 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268801;
	bh=4K0ioKV5pbE4Ef4e+GKU9dV30pSsLWe3AR7B9Tx4qSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LztPPiMV0JqOpNGcM41RcGzmbo2W1gJcf9SI62leim+lngFeaunkaW+2nY2NDVI1m
	 ULsGIJWi3F4NrXyL/AqwzQQiFjHV5Yx1hxefG7V4xPPGDn1pMAwntNN7JIu/Rix+9Z
	 7ZSlk1HEz2LWrV8N9Fu/mC7Kq55lUG/A/Jv+D6SD6i66T2Kyg57qnFA+Duqze1ZSnY
	 YIXrZoxooTwzySNTMwxqPLe5CV6rfaKw3uBfTa9eNKWB0Kt+VtTqKKXruYHd2qsjYA
	 iphxkHzHGvAM6eAxohN/0yj4STTgQskoh0AiVqyhuCVt8DYTqViwQa/mrRPa8fkGUY
	 5UprRaTjqGrKQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 2F80A1980077;
	Tue,  1 Sep 2026 09:19:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 09:19:54 -0400
X-ME-Sender: <xms:69CWaij5CIKvTS9JuyLleD9s3d7G5S5Cj7oKCUXn13hGseHouuUSag>
    <xme:69CWalGYd0dc4bcEB3etN9RaYjD7HYzO3v8zVyh93Vx39I_dw7XkZfKP4mbB2pf7a
    yCC0ABYtDzS2RhTTaZ8dfYsqjhrn_rW7zK2cNPqftkFgUuGuUM2EbU>
X-ME-Received: <xmr:69CWakpbzJqHJeJRbHpsk7ongNC4txO1ZIIt3gTXSf5VUVWH2Pd6FvJ1H9I>
X-ME-Proxy-Cause: dmFkZTED3aWKojbGUYTqgDI4X4V0F1d+uDC9XUKSeGM5bAtqyf5WoNCcWI8qt7irq+Ycdg
    bP5uMN9J8wue1zj+h4Z5VdmIt5CyC8BtMot40mK2bNoOWP05XNwub7F63HzCejIFCNIwU/
    RwHR/oPnELuI/pgmRue+HPnpkTdxXI2tXXPwQ2XhlfjvZIyZNXMaGXgwL56LFN8ekEPBpX
    QHxLvpjiYjeppSsNC9jkLgljlvJ1f2Rzug/Wzpp30FOzo3biGRK3SJKG4JlcSiSKZV9ApN
    zrblGjeaDfaFoFocDCMSOSTBkwTuSjYQbyrO3U+OcC3IfSEQwCfo2jZutbaEZD8ORHkhOE
    WPvmJHx9cOwRkRzLLHMzt61/y2dH4FBScykL+eQjNlgsUwsdGo8YayjIDE2cNUryQs77Zd
    37yui7ur2Ub4PTGWPTH9vPA/z72KJMVvxVCmJnutZO95zEQmQXdIrYDwRwD/10g1bSXWZv
    5p+rN+4d/l5/jwP9h6pMcwNHnHfrSrfKBvZnNqJN04rROPvVro5LWQHKMqJWCKH7KIqXhO
    kz5cBC197p3oqrUj3bWQUgF9WsFamkEjWJi6OvK/8e1HSfRwBSOXnE0kOoNrxeox4eX16r
    l1yAPWeATBw9u3K+ZxIBaBaFYwt+eQJwZRgzLVYgXvtgrAI3wFtXeAw7uu+A
X-ME-Proxy: <xmx:69CWajFHifz_SIwkxD4BIVpzvuUpvQr-YiTHagPH4og2FD21YdNJgQ>
    <xmx:69CWaoqTHEsNOtjshNsJ3CUngn2ZISAQFdZ45ashJ5fK9S2FYQS66w>
    <xmx:69CWagU-DnjgEXTEnpw6CxzSrHONzOkLH3mSJLYWP1eBStWX0ICgLw>
    <xmx:69CWaoLp9cwfEDd-J-UDdiyYEdkf-I-D6oSdqcqGEGBYulbHTZ9FeA>
    <xmx:69CWap2dwNlx9UBv3N5Z9oAH2VG7dOj0tP6mz8BbcIQFsrC4b0Y4wIoG>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 09:19:37 -0400 (EDT)
Date: Tue, 1 Sep 2026 14:19:36 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 	Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, 	Usama Arif <usama.arif@linux.dev>,
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
 	Geert Uytterhoeven <geert@linux-m68k.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 	Simon Schuster <schuster.simon@siemens-energy.com>,
 Jonas Bonn <jonas@southpole.se>,
 	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 	Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Walmsley <pjw@kernel.org>, 	Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 	Alexandre Ghiti <alex@ghiti.fr>,
 Russell King <linux@armlinux.org.uk>, 	Vineet Gupta <vgupta@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>,
 	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>,
 	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, 	Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 	Andreas Larsson <andreas@gaisler.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 	Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 	Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 	Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 	Sven Schnelle <svens@linux.ibm.com>,
 Richard Weinberger <richard@nod.at>,
 	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 	Arnd Bergmann <arnd@arndb.de>,
 Vlastimil Babka <vbabka@kernel.org>, 	Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, 	Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, 	John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, 	linux-um@lists.infradead.org,
 Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <apbOlyF77yDCV4cF@thinkstation>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>

On Tue, Sep 01, 2026 at 12:01:21PM +0100, Lorenzo Stoakes (ARM) wrote:
> When an anonymous mapping is collapsed for THP, a PTE page table is
> 'deposited' with the installed PMD entry.
> 
> This is done in order that a split can be performed without needing to
> allocate additional memory.
> 
> The freeing occurs in zap_deposited_table() and is done directly without
> any delay via pte_free().
> 
> This is currently not a problem as existing page table walks are protected
> by the mmap or anon rmap lock.
> 
> However this becomes problematic in a future where RCU-only page table
> walkers exist, as there is nothing to prevent a page table walker that
> started the walk prior to collapse having its PTE table freed underneath
> it.
> 
> Commit 13cf577e6b66 ("mm/pgtable: add pte_free_defer() for pgtable as
> page") already provides us the mechanism by which to solve this -
> pte_free_defer().
> 
> Therefore, as a prerequisite to a future commit which will permit fully RCU
> page table walks, update zap_deposited_table() to use pte_free_defer()
> rather than pte_free().
> 
> Note that the IPI sync in collapse_huge_page() is still required to ensure
> refcount correctness against a GUP-fast operation.
> 
> This is because GUP-fast might increment refcount, but
> __collapse_huge_page_isolate() determines whether it is safe to proceed by
> checking folio_ref_count() against folio_expected_ref_count(), so the two
> must be mutually excluded.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 54494c3fa983..505f7b62ff28 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2476,7 +2476,7 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
>  	pgtable_t pgtable;
>  
>  	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
> -	pte_free(mm, pgtable);
> +	pte_free_defer(mm, pgtable);

Hm. So it is call_rcu() on each PMD. It might be costly, especially for
zap_huge_pmd() path: 512 call_rcu() per-GB of unmapped THPs.

Do we want leverage mmu_gather if caller has it?

>  	mm_dec_nr_ptes(mm);
>  }
>  
> 
> -- 
> 2.55.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

