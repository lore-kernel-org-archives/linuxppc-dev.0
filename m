Return-Path: <linuxppc-dev+bounces-26126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E50EC5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 05:28:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVqnP3ZNVz2xwN;
	Thu, 27 Aug 2026 15:28:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787808537;
	cv=none; b=ouopBj8zpB5twDyEpFSLO32kCwHnUjCT4nRC33V8bth95Z86OmMJP62hicnyb5kfU99iMixaDyr5svZ9k4CT7UtcxgeycHHkBv8YA4L9WXgnXyGoZqD1aR7mZnadUidOzzO2rlEx7H60C3M+i91YZsrbnu+IsYzmZbbE98OXCfEFGd2ergmJrQbUlfVCKgtQkYY+nolu7AkjXhIMHm8AUWBuWG5rAGMAyWTQf6w06onr7X4S2CSrhmqCu9poL3Z1vMizPnfSNCgqgFeR6xwe2BfDLo2mQd1K8qrWSXdB+XrJ8HazeHsZwxDtvdCYO/57sOIlUsIbk4oDPrwNkOLChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787808537; c=relaxed/relaxed;
	bh=1H2HKWXQ51kiTh+XvcBnYz+8AssjoQxnEuTfe7RXVqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwZOlXipnjhJVBBoN+ZzwHgKbvN4fru/yOwG/HFfa/pdEvMbFgvE6ol/x/5Xfu6zSs0RSrdy8Jgp0NyQv2EZdG+daZSjlt1govXQBnQDnYHmYOMFb2vc3SrKpvqSqKJt75geWM90dsxglMZUXdO48kOLKQTgRA2uNwmytKH48Y8JHgLFWE0X2vDc3hTtg6mDujMVqrnWgKeMbOO3yIaWTGEKn8o3VyakkoVJHdgYnCw24IeQJBiOIk+7pae1JOLZcdp3/8d6aJ0uxHj5xUKI9n+wHu+c5+BfvLDu1SGRvfzRI/6VcrTg8KM+ttLlGQAH8mK4zgsyZfNYGT5iRm+ugA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Qbvokt9Y; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Qbvokt9Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVqnL0cdsz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 15:28:51 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E07A71691;
	Wed, 26 Aug 2026 22:28:14 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0D43F66F;
	Wed, 26 Aug 2026 22:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787808498; bh=r3zpWAjSDYwO4obpTt1hi/LzERvjZcV2ma+xAQZJE1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qbvokt9YNMXIimouS57c8IUjHG3UY/NxbyriHVJNF09htLAHlcOYfMdqN9rNk2Y3/
	 mSu7y20m+SkO9PdnMyXySHrLzwhN7q5RvdaRZuxZGl6y42IopDCGHEBnjAJBHjcg2R
	 GlMX/PkmQ3bkQo82ApB3CeCPp5qCKqiyYLpu1D5M=
Date: Thu, 27 Aug 2026 10:58:15 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
Subject: Re: [RFC V3 8/8] mm: Drop pxd_ERROR()
Message-ID: <ajnoyja6a3hi2b7zn52n4dwrnpaa3ofpk6enekdan3babfsmbv@lnc3mbpogtq5>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-9-anshuman.khandual@arm.com>
 <6dae9cae-9665-4dc8-9a49-d6e5acda221b@sifive.com>
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
In-Reply-To: <6dae9cae-9665-4dc8-9a49-d6e5acda221b@sifive.com>

On Mon, Aug 24, 2026 at 10:50:37AM -0500, Samuel Holland wrote:
> On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
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
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > Changes in RFC V3
> > 
> > - Moved ptrval_to_str() as header in a [PATCH 1/8]
> > - Stopped using pxd_ERROR() in generic MM in [PATCH 2/8]
> > - Dropped pxd_ERRO() macros from all platforms in this patch
> > 
> >  arch/alpha/include/asm/pgtable.h               |  7 -------
> >  arch/arc/include/asm/pgtable-levels.h          | 11 -----------
> >  arch/arm/include/asm/pgtable.h                 |  7 -------
> >  arch/arm/kernel/traps.c                        | 17 -----------------
> >  arch/arm64/include/asm/pgtable.h               | 15 ---------------
> >  arch/csky/include/asm/pgtable.h                |  4 ----
> >  arch/hexagon/include/asm/pgtable.h             |  3 ---
> >  arch/loongarch/include/asm/pgtable.h           | 11 -----------
> >  arch/m68k/include/asm/mcf_pgtable.h            |  6 ------
> >  arch/m68k/include/asm/motorola_pgtable.h       |  8 --------
> >  arch/m68k/include/asm/sun3_pgtable.h           |  7 -------
> >  arch/microblaze/include/asm/pgtable.h          |  7 -------
> >  arch/mips/include/asm/pgtable-32.h             | 10 ----------
> >  arch/mips/include/asm/pgtable-64.h             | 13 -------------
> >  arch/nios2/include/asm/pgtable.h               |  7 -------
> >  arch/openrisc/include/asm/pgtable.h            |  7 -------
> >  arch/parisc/include/asm/pgtable.h              |  9 ---------
> >  arch/powerpc/include/asm/book3s/32/pgtable.h   |  2 --
> >  arch/powerpc/include/asm/book3s/64/pgtable.h   |  7 -------
> >  arch/powerpc/include/asm/nohash/32/pgtable.h   |  2 --
> >  .../powerpc/include/asm/nohash/64/pgtable-4k.h |  3 ---
> >  arch/powerpc/include/asm/nohash/64/pgtable.h   |  5 -----
> >  arch/riscv/include/asm/pgtable-64.h            |  9 ---------
> >  arch/riscv/include/asm/pgtable.h               |  4 ----
> >  arch/s390/include/asm/pgtable.h                | 11 -----------
> >  arch/sh/include/asm/pgtable-3level.h           |  3 ---
> >  arch/sh/include/asm/pgtable_32.h               |  8 --------
> >  arch/sparc/include/asm/pgtable_32.h            |  3 ---
> >  arch/sparc/include/asm/pgtable_64.h            | 10 ----------
> >  arch/um/include/asm/pgtable-2level.h           |  7 -------
> >  arch/um/include/asm/pgtable-4level.h           | 13 -------------
> >  arch/x86/include/asm/pgtable-2level.h          |  5 -----
> >  arch/x86/include/asm/pgtable-3level.h          | 11 -----------
> >  arch/x86/include/asm/pgtable_64.h              | 18 ------------------
> >  arch/xtensa/include/asm/pgtable.h              |  4 ----
> >  include/asm-generic/pgtable-nop4d.h            |  1 -
> >  include/asm-generic/pgtable-nopmd.h            |  1 -
> >  include/asm-generic/pgtable-nopud.h            |  1 -
> >  38 files changed, 277 deletions(-)
> > ...
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 5d5756bda82e..993a6505eb8f 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -559,10 +559,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> >  	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
> >  }
> >  
> > -#define pgd_ERROR(e) \
> > -	pr_err("%s:%d: bad pgd " PTE_FMT ".\n", __FILE__, __LINE__, pgd_val(e))
> 
> We can drop the PTE_FMT macro now too.

Agreed, will just fold in the following changes.

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 709a36fb4323..b4bbae55e931 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -76,12 +76,6 @@ typedef struct page *pgtable_t;
 #define __pgd(x)       ((pgd_t) { (x) })
 #define __pgprot(x)    ((pgprot_t) { (x) })

-#ifdef CONFIG_64BIT
-#define PTE_FMT "%016lx"
-#else
-#define PTE_FMT "%08lx"
-#endif
-
 #if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
 /*
  * We override this value as its generic definition uses __pa too early in

> 
> Regards,
> Samuel
> 

