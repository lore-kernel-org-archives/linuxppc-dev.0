Return-Path: <linuxppc-dev+bounces-28022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7865AC9830C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 13:22:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqd1F6r6Xz2yqw;
	Wed, 23 Sep 2026 23:22:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790169745;
	cv=none; b=jzI8tp5nT11Kiz3QwECdP3HUyVu7sawbPoxnfl7X1SWwzmhiPtcStoc2mZuRcDwVK/jUeE6pYiuNLJRGXQEOyGN8gQnd6vOazKYy11erlchNNjyQDpr+IrZ0z4U6OFFNAazjthKcGjGFPORYQ9hqJn3eTswK5ZFxrHV8TmhYvf95u7aSw6VAbWQgGVlexK1dOkbDCmgbAYkdWP6CqmUqkMJIPTP4c7QFlpdP6V1kNaf9xJ+I3M4GsitbTgVnwhIBpoC16NeNKobG0o8yP+7fWZrD0+vsysxfJOj25xIocPsXdLoxFArAHnrKN7CDkQLfBZ5azSYxJgMVdsW2NQ1+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790169745; c=relaxed/relaxed;
	bh=fv/PJsh8Z0zTlCVSKOt2XBkxllgDkngoF7NIde+KnzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlGv1A67rWSZNS0WUEBpgw4/YwaRwITv/MYzBYZdlfAhS298ybbHMuTdy4Vp1I05rsEjPoeTELjynXQbubDJqStTV0zi/hw7Tat9NHUdOW0f8QEvZqmmvkgQSez698iyDjuy69prTUZ+D14MRJvXvh7UQMQVGc7nzrZ3Q976/ZyQJvDwSJgXrYTG8JVlgSCYb1Rel7yJU+MQD9DbqkQA7v4QJKpyYsoZOVWFrTwzLHHtka3bJ7Mel4KiNHxLiKlE325+WnFwl4fj1XKfhE+nWAQXEiqpEeiHeFhw7stuUNWF0ZiRjT22Nua/j2+S9RHbe+hfhc5J2G6QvQazLgvRxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQwWOQky; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQwWOQky;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqd1D6ZJLz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 23:22:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85B4A601FB;
	Wed, 23 Sep 2026 13:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B955C1F000FF;
	Wed, 23 Sep 2026 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790169741;
	bh=fv/PJsh8Z0zTlCVSKOt2XBkxllgDkngoF7NIde+KnzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oQwWOQkywYDf1JkmRsDbC/o6DR3oPInrHh+/leVHpzXY/fgKnBPlAbat4yOirXksi
	 EWALa8XUeMd2tsIqTrSCJ0hISS3LcHe3D0i0Tgz4u8GN0a6ybM3BZinVZZLhG3Kwem
	 I7b4mFWjjtLPtBFFyxKMPPiC1fv/6tqbKR6ms7bWmlQ8jqkRp5houN8+Tl0nlHq8Ok
	 pNWxEWvRV+ENJCiZHISEOFERm2DQsybnZiI9c7WeH02xnMWwF75/9ODvNlEXLXkUxS
	 1sCqPrGh63gyzzgORCeokaPT4Set6v00jX6f1b6hgWldcMbm+rJMuLtgU0iQ1Yzy3g
	 sAGIwJhyz9HZg==
Date: Wed, 23 Sep 2026 14:21:56 +0100
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
Subject: Re: [PATCH v4 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-motorola
Message-ID: <arPSa1dVX3AOHAvM@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
 <20260923131634.47896-1-lance.yang@linux.dev>
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
In-Reply-To: <20260923131634.47896-1-lance.yang@linux.dev>

On Wed, Sep 23, 2026 at 09:16:34PM +0800, Lance Yang wrote:
>
> On Tue, Sep 22, 2026 at 04:35:40PM +0100, Lorenzo Stoakes (ARM) wrote:
> >sun3 and coldfire are already supported, however motorola requires a little
> >more care.
> >
> >Here, custom table removal logic is required, so
> >CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.
> >
> >Firstly as part of this change, the page table level must be communicated
> >to the underlying __tlb_remove_table() implementation.
> >
> >Take advantage of the fact that page tables are aligned by more than enough
> >to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
> >and store this there.
> >
> >Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
> >then have __tlb_remove_table() decode this and pass it to
> >free_pointer_table().
> >
> >The page table freeing is performed via call_rcu(), so free_pointer_table()
> >now will be invoked from softirq context, and as such may be re-entrant.
> >
> >Introduce an irq save/restore spinlock to handle this, and hold it over the
> >time a given ptable entry is being referenced in both get_pointer_table()
> >and free_pointer_table().
> >
> >In order to make things a little easier in this respect, separate out the
> >logic for adding a new ptable entry into add_pointer_table() and only hold
> >the lock during ptable entry insertion in this case.
> >
> >Note that original list_add_tail(new, dp) added new prior to dp, which is
> >ptable_list[type].next, i.e. after ptable_list[type].
> >
> >The equivalent therefore is list_add(new, &ptable_list[type]), which adds
> >new after ptable_list[type], only without needing to make reference to dp.
> >
> >Note that, as m68k-motorola specifies CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE, it
> >does not enable CONFIG_PT_RECLAIM. This isn't meaningfully impactful.
> >
> >With this applied, all of m68k implements CONFIG_MMU_GATHER_RCU_TABLE_FREE.
> >
> >This forms part of an overall effort to switch every architecture to this
> >mode.
> >
> >Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >---
>
> I wondered about slot reuse during the RCU wait, but that can't happen :)
>
> The slot stays marked busy until free_pointer_table() runs after RCU, and
> the last free unlinks the page under ptable_lock.
>
> Also ran page-table teardown stress and fork/exec churn on
> qemu-system-m68k (virt, m68040, CONFIG_MMU_MOTOROLA=y). All 40 rounds ran
> cleanly :D
>
> Acked-by: Lance Yang <lance.yang@linux.dev>
>
> Tested-by: Lance Yang <lance.yang@linux.dev>

Great, thanks! Really appreciate the testing :)

--
Cheers, Lorenzo

