Return-Path: <linuxppc-dev+bounces-29078-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA6CA6017
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 02:24:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j19gC4wxnz3048;
	Fri, 09 Oct 2026 13:24:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791512695;
	cv=none; b=mFSmalUqXssEqidMS5ZDtjijjNnvkBGof6oWSKe8e9TdSENT4S8HykJTfFfboGYm6Dby5VWhBhUKDQ8SLLqgFb6hxjtwyyjdQD57hEHLJuzkOu5PnLD4AJ2aKefomou8Rn1OsM+hX201x+n5mSxmQD9O/alr69OzmW92HQCJdvKno/ja44sq1Q4rckFyPr5ITQCfmJBbT/q0iBwxexSFY5H5rwOX4eKI72hbg5ZCi830vMIDV45L86A5GN7OUrt0LVm99L3bYB0EHZ2tWOu7jQ5h+ajHFzOkbwDEep+erv4OABKOsf334p49AdNTHAx2dFUvyQh73Ghz4rIsi+1Zog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791512695; c=relaxed/relaxed;
	bh=hPjRWEqA4h+QELW2/pkZVWJ2BIEGTsNOGSrmLEnqrIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iedd3F1V8mi/GWvWYUnHWbAh39nVljQBWiiLbmhBsOtEtMXVR5heEY0P5kBqRuL5uu7wRxmsKRc3JpYQhRelQgitl5ZoDkb0OzF29vf3VpjPZaLPm4/LejIfZHa2Beo7nNt/g491zI3HOmV06jCsH4r8m593tWK2SRPP93Wc1skLAyRLyIqQultGmZrn3ikWqDhwyOfXjzg1/YEB2BQLTXqMZL8/daYoiQ+ddDGVz/Bw6z/sZEW10oKlx1p4hmBgqu7K8ZGytddHP2hix03TceATM+vNT1h6O/JObj0hg91xQplXkdfyIETHaHR0DY8SDp3vXIOCmtlWbwrCJ/lemQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cdimGt4B; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cdimGt4B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j19g91CX7z2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 13:24:51 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0010F1692;
	Thu,  8 Oct 2026 19:24:14 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99E593F66F;
	Thu,  8 Oct 2026 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791512658; bh=2QLRKUYyFp8S6i+UXZO3Wxnz517D73K9DyPKeDJE9KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdimGt4BwBkbC2kvqJXbpnU8+qL/O0F0HZ2Z0H4CpSxUOxCh+EcoJtLXctAWoTzrV
	 OtcAfxF5iREGuxkwM6scrG4vYN4mDhOT5dXuCp6y3UYQNkA+QiuO7WX1/GccVSzj2V
	 OoaC3kiLUtydOmdP9bIBEODXTrrr6BODQU57YXnw=
Date: Fri, 9 Oct 2026 07:54:15 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-mm@kvack.org, samuel.holland@sifive.com, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 8/8] mm: Drop pxd_ERROR()
Message-ID: <y4zwpwqqxnjtwzm2j5xrdnnmdle5eiih7tsn7quywur7w2beh4@z3lk5ztxdz35>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-9-anshuman.khandual@arm.com>
 <c24fc419-7bee-4fe4-be12-9aa378d49af1@gaisler.com>
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
In-Reply-To: <c24fc419-7bee-4fe4-be12-9aa378d49af1@gaisler.com>

On Thu, Oct 08, 2026 at 11:20:14AM +0200, Andreas Larsson wrote:
> On 2026-08-31 07:43, Anshuman Khandual wrote:
> > There are no more users left for any pxd_ERROR() either in generic MM or in
> > the platform MM. Hence all these platform macros along with their generic
> > fallback could be dropped across the tree.
> > 
> > Cc: linux-alpha@vger.kernel.org
> > Cc: linux-snps-arc@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-csky@vger.kernel.org
> > Cc: linux-hexagon@vger.kernel.org
> > Cc: loongarch@lists.linux.dev
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-openrisc@vger.kernel.org
> > Cc: linux-parisc@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-s390@vger.kernel.org
> > Cc: linux-sh@vger.kernel.org
> > Cc: sparclinux@vger.kernel.org
> > Cc: linux-um@lists.infradead.org
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ...>  /*
> >   * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
> >   * are !pte_none() && !pte_present().
> > diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> > index f89b1250661d..5a5f54a090f5 100644
> > --- a/arch/sparc/include/asm/pgtable_32.h
> > +++ b/arch/sparc/include/asm/pgtable_32.h
> > @@ -40,9 +40,6 @@ void load_mmu(void);
> >  unsigned long calc_highpages(void);
> >  unsigned long __init bootmem_init(unsigned long *pages_avail);
> >  
> > -#define pte_ERROR(e)   __builtin_trap()
> > -#define pmd_ERROR(e)   __builtin_trap()
> > -#define pgd_ERROR(e)   __builtin_trap()
> >  
> >  #define PTRS_PER_PTE    	64
> >  #define PTRS_PER_PMD    	64
> > diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> > index 0837ebbc5dce..44d1333065a6 100644
> > --- a/arch/sparc/include/asm/pgtable_64.h
> > +++ b/arch/sparc/include/asm/pgtable_64.h
> > @@ -96,16 +96,6 @@ bool kern_addr_valid(unsigned long addr);
> >  #define PTRS_PER_PUD	(1UL << PUD_BITS)
> >  #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
> >  
> > -#define pmd_ERROR(e)							\
> > -	pr_err("%s:%d: bad pmd %p(%016lx) seen at (%pS)\n",		\
> > -	       __FILE__, __LINE__, &(e), pmd_val(e), __builtin_return_address(0))
> > -#define pud_ERROR(e)							\
> > -	pr_err("%s:%d: bad pud %p(%016lx) seen at (%pS)\n",		\
> > -	       __FILE__, __LINE__, &(e), pud_val(e), __builtin_return_address(0))
> > -#define pgd_ERROR(e)							\
> > -	pr_err("%s:%d: bad pgd %p(%016lx) seen at (%pS)\n",		\
> > -	       __FILE__, __LINE__, &(e), pgd_val(e), __builtin_return_address(0))
> > -
> >  #endif /* !(__ASSEMBLER__) */
> 
> Perhaps a bit of a pity to lose the printing of the address of the pxd
> that a number of architectures did before this series, but i have no
> strong opinion.
> 
> Acked-by: Andreas Larsson <andreas@gaisler.com> # sparc

Thanks Andreas.

