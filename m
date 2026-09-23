Return-Path: <linuxppc-dev+bounces-28014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C8C9830D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 11:57:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqb6f2xtZz2yr0;
	Wed, 23 Sep 2026 21:56:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790164618;
	cv=none; b=P5q/2PCK/cHLchYlqKiq3uYgyjNVYAtwYGjUM3C7aoFUonTe4I2RukUzE3Pzfhbr0fXtwiDBAs6X3fntucWZhZLSZKfzs/J88hzsr1J4wpcId7U4HM8f2wu6wF1qpQBWqC3BOgb2HVFaM+xJElTWuJnLSQgC+pKHUGpAxEpQCVyduKZNKWD6eIrC2ncHP9sFMu/2MAr+rK88Y1FKR6kh3pgk13fnoaNn4QeekHHXRKFDeM9nEZVUfwQx0d9PArr/yB/7Ox9DyeujJ7XG2IDXiJiJ9zaWZDtX+55lO4kVppQPv7drJbSBIJ8O7ufLHj0Fh0FwkHVCSmaDn67wC6RcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790164618; c=relaxed/relaxed;
	bh=Ds2KAw8gvOa+tR2z36qGcwS8SV5iMl/blAUnmIflQkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN4ssfE7a3cujhLfAcKL1tN/0hFEziKwb9rZYD/NLKvYR14fmVi6nAJvfW4KNip6zy3yGMp/GXfbmwBhoyNd5n134auRcKvjyDVbQvRrglbRgrV7yI5Ns45bGkj3KNMGazNadkVmGvir5dVlIzPH0PjkTO6FqD3aZv6cEp2KretcyyfITNLnF2w5LBlKHBqe3Y4DU8GxMjcdgawxxHf3hDWlU6xjE/v5eelX5IrkyjEpECvVO0/eTzs3lUguktq98pXZz3QFYWcYNSmWqkgaePi39Bcf2i97l1WKn8Ay3NIifIu+QS8JjSoVvAzusP3HhzP4ecM5WoHASAMHjfe9WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLzOlpie; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLzOlpie;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqb6d3Wlsz2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:56:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D470C439E9;
	Wed, 23 Sep 2026 11:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2610A1F000FF;
	Wed, 23 Sep 2026 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790164614;
	bh=Ds2KAw8gvOa+tR2z36qGcwS8SV5iMl/blAUnmIflQkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MLzOlpiehBp7rmWLxJ9aplJ887M0HtvnTYcr7Feppz4GpXnrb891HqE1sAdH3CEdJ
	 l+KxVqMBqRNoASgtK1ZWDhIV9vd6xSNNP12m6pFGj2BbzuxpBXMCxSHLYzmSxu6TWY
	 VREKtAqIxlSX2XhdiU58tDKPP9A+aK2QQnnqLStGVJR1fPKeyEbSVAJVeAQ3VTMf9A
	 d/C+oL9WdOE7XZZXqx582LOK0Vav7S1QSMg/Rx3fXHnkivLhsw3ynV4BU43Z8gVVyr
	 XvvM4WhyacwSjjIwFyNJgXErigsiQzZKnEfV38NBbIL0nF4laCa9rcV0Y3Asd/YJ+G
	 a8K3aXfd2AHzA==
Date: Wed, 23 Sep 2026 12:56:30 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
	guoren@kernel.org, bcain@kernel.org, geert@linux-m68k.org, dinguyen@kernel.org, 
	schuster.simon@siemens-energy.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, 
	shorne@gmail.com, dalias@libc.org, glaubitz@physik.fu-berlin.de, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux@armlinux.org.uk, 
	vgupta@kernel.org, monstr@monstr.eu, chris@zankel.net, jcmvbkbc@gmail.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org, 
	davem@davemloft.net, andreas@gaisler.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, 
	ysato@users.sourceforge.jp, shakeel.butt@linux.dev, corbet@lwn.net, rdunlap@infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, hughd@google.com, 
	qi.zheng@linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 08/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
Message-ID: <arO-Y0qZpqpdqzwB@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-8-fe1ad1f1e303@kernel.org>
 <20260923115417.34112-1-lance.yang@linux.dev>
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
In-Reply-To: <20260923115417.34112-1-lance.yang@linux.dev>

On Wed, Sep 23, 2026 at 07:54:17PM +0800, Lance Yang wrote:
>
> On Tue, Sep 22, 2026 at 04:35:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> >Currently, non-x2 sh specifies CONFIG_MMU_GATHER_RCU_TABLE_FREE allowing
> >RCU page table freeing.
> >
> >sh-X2 is problematic because it utilises slab-allocated PMD page tables,
> >and thus tlb_remove_ptdesc() cannot be used in these cases.
> >
> >All other sh variants are fine as commit e3ecf7c7d082 ("mm: pgtable:
> >convert some architectures to use tlb_remove_ptdesc()") already converted
> >page table freeing to use tlb_remove_ptdesc(), which does so after an RCU
> >grace period when CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
> >
> >Resolve this issue by firstly specifying CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
> >for sh-X2, so the arch can provide its own __tlb_remove_table()
> >implementation (called after the RCU grace period).
> >
> >Then, convert __pmd_free_tlb() to tag the pointer to the PMD, and have
> >__tlb_remove_table() check this tag to determine whether to free via the
> >slab or to use pagetable_dtor_free().
>
> Makes sense to me, so RCU callback won't mistake a slab PMD for a PTE
> page :)

Yes indeed :)

>
> >This follows the pattern used by sparc64 as implemented in commit
> >4a0100f7546f ("sparc64: use RCU page table freeing").
> >
> >Previously __pmd_free_tlb() freed PMD page tables immediately, before any
> >TLB flush IPI. This seems to be a pre-existing bug, which this change also
> >resolves.
> >
> >CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is only specified for sh-X2, as setting
> >it disables CONFIG_PT_RECLAIM and causes __tlb_remove_table_one() to call
> >tlb_remove_table_sync_rcu() and synchronize_rcu() in turn, and this is not
> >necessary for other sh variants.
> >
> >This forms part of an overall effort to switch every architecture to this
> >mode.
> >
> >Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >---
>
> LGTM, feel free to add:
>
> Acked-by: Lance Yang <lance.yang@linux.dev>

Thanks!

--
Cheers, Lorenzo

