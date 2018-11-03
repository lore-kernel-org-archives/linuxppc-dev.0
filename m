Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74859C0044C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 21:28:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CDF2081F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 21:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FV1Q0wDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CDF2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42nX9r3rNlzF1Hm
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 08:28:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FV1Q0wDv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="FV1Q0wDv"; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42nSGR1zhlzDsM2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Nov 2018 05:32:13 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id g21-v6so2496479pfi.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Nov 2018 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=+lLPEfrVQ9C2llxSALOmcEKlDAWxZKsHsAd4XJOgi+8=;
 b=FV1Q0wDvKgkG4kZRj+VZtvFgfpLxegdKxvEOWdUoTsGuYYqOt63vQBXT1gkyiQdbAi
 svoRJLCKxf1oY5viw67ejDUpLUlGpXOV6p6fsqhz+scN/mBqlRF6BsiaYvQifD6XRBSl
 F1mKSr8VXjBVgcSHM1RqfBbz7rT2K+1dKDQgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=+lLPEfrVQ9C2llxSALOmcEKlDAWxZKsHsAd4XJOgi+8=;
 b=RZpuV+A4uGdpkpS12nI29ae6VkaTraiteakUP20OJ/M1APPRuZws34pmL4gCnhMt/S
 /X6zwUCmBDqLJsMbM3WnvQ8pHK4jHgVvHSubxwUXNT5dr/xCIuCRWsRJSqHZ1SLC5lAt
 jsMzTiawKBQpVM7Z1uKyyGNVU6tLdXozGAUTBFyNlfSwELrSqjfLVwLmG4dpkiAyDOig
 bufItcox4Xz6FweEhFk04oGOOcCaqnUle3aLqMxGh5hN4VlX7TIkxnFLUwzeCzpw55iA
 da8yMatoPM+hrBBMp99h+sUUxKo+iF7jH74pPBmSITalUMNhlHqrkLND1cPJxTJWLyRy
 9jmw==
X-Gm-Message-State: AGRZ1gJ88etVmfuVjVVWLAbit2Yb+30UNhaDnLrON/1sESmr2jOGWwqu
 GmxeRibxpfleYYN+GXeioOk4BQ==
X-Google-Smtp-Source: AJdET5cVGh+4UnJ6apMI+3/UlVSbVol0AIxVykI0yDHUDrs2IM14b8w2piyx1JVd0OmDbLiGVERHfA==
X-Received: by 2002:a63:94:: with SMTP id 142mr13240807pga.74.1541269931140;
 Sat, 03 Nov 2018 11:32:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id f22-v6sm46381558pff.29.2018.11.03.11.32.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 03 Nov 2018 11:32:09 -0700 (PDT)
Date: Sat, 3 Nov 2018 11:32:08 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
Message-ID: <20181103183208.GA56850@google.com>
References: <20181103040041.7085-1-joelaf@google.com>
 <6886607.O3ZT5bM3Cy@blindfold>
 <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Sun, 04 Nov 2018 08:19:31 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com,
 linux-ia64@vge.kvack.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-xtensa@linux-xtensa.org, Richard Weinberger <richard@nod.at>,
 Helge Deller <deller@gmx.de>, r.kernel.org@lithops.sigma-star.at,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 pantin@google.com, linux-kernel@vger.kernel.org, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 03, 2018 at 09:24:05AM +0000, Anton Ivanov wrote:
> On 03/11/2018 09:15, Richard Weinberger wrote:
> > Joel,
> > 
> > Am Samstag, 3. November 2018, 05:00:38 CET schrieb Joel Fernandes:
> > > Hi,
> > > Here is the latest "fast mremap" series. This just a repost with Kirill's
> > > Acked-bys added. I would like this to be considered for linux -next.  I also
> > > dropped the CONFIG enablement patch for arm64 since I am yet to test it with
> > > the new TLB flushing code that is in very recent kernel releases. (None of my
> > > arm64 devices run mainline right now.) so I will post the arm64 enablement once
> > > I get to that. The performance numbers in the series are for x86.
> > > 
> > > List of patches in series:
> > > 
> > > (1) mm: select HAVE_MOVE_PMD in x86 for faster mremap
> > > 
> > > (2) mm: speed up mremap by 20x on large regions (v4)
> > > v1->v2: Added support for per-arch enablement (Kirill Shutemov)
> > > v2->v3: Updated commit message to state the optimization may also
> > > 	run for non-thp type of systems (Daniel Col).
> > > v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
> > > 	Rebased ontop of Linus's master, updated perf results based
> > >          on x86 testing. Added Kirill's Acks.
> > > 
> > > (3) mm: treewide: remove unused address argument from pte_alloc functions (v2)
> > > v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
> > >          update changelog with manual fixups for m68k and microblaze.
> > > 
> > > not included - (4) mm: select HAVE_MOVE_PMD in arm64 for faster mremap
> > >      This patch is dropped since last posting pending further performance
> > >      testing on arm64 with new TLB gather updates. See notes in patch
> > >      titled "mm: speed up mremap by 500x on large regions" for more
> > >      details.
> > > 
> > This breaks UML build:
> >    CC      mm/mremap.o
> > mm/mremap.c: In function ‘move_normal_pmd’:
> > mm/mremap.c:229:2: error: implicit declaration of function ‘set_pmd_at’; did you mean ‘set_pte_at’? [-Werror=implicit-function-declaration]
> >    set_pmd_at(mm, new_addr, new_pmd, pmd);
> >    ^~~~~~~~~~
> >    set_pte_at
> >    CC      crypto/rng.o
> >    CC      fs/direct-io.o
> > cc1: some warnings being treated as errors
> > 
> > To test yourself, just run on a x86 box:
> > $ make defconfig ARCH=um
> > $ make linux ARCH=um
> > 
> > Thanks,
> > //richard
> > 
> > 
> > 
> 
> UM somehow managed to miss one of the 3-level functions, I sent a patch at
> some point to add to the mmremap series, but it looks like it did not get
> included in the final version.
> 
> You need these two incremental on top of Joel's patch. Richard - feel free
> to relocate the actual implementation of the set_pgd_at elsewhere - I put it
> at the end of tlb.c
> 
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index 7485398d0737..1692da55e63a 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -359,4 +359,7 @@ do {                                                \
>         __flush_tlb_one((vaddr));               \
>  } while (0)
> 
> +extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +               pmd_t *pmdp, pmd_t pmd);
> +
>  #endif
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index 763d35bdda01..d17b74184ba0 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -647,3 +647,9 @@ void force_flush_all(void)
>                 vma = vma->vm_next;
>         }
>  }
> +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +               pmd_t *pmdp, pmd_t pmd)
> +{
> +       *pmdp = pmd;
> +}
> +
> 

Looks like more architectures don't define set_pmd_at. I am thinking the
easiest way forward is to just do the following, instead of defining
set_pmd_at for every architecture that doesn't care about it. Thoughts?

diff --git a/mm/mremap.c b/mm/mremap.c
index 7cf6b0943090..31ad64dcdae6 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -281,7 +281,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
-		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
+		} else if (extent == PMD_SIZE) {
+#ifdef CONFIG_HAVE_MOVE_PMD
 			/*
 			 * If the extent is PMD-sized, try to speed the move by
 			 * moving at the PMD level if possible.
@@ -296,6 +297,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 				drop_rmap_locks(vma);
 			if (moved)
 				continue;
+#endif
 		}
 
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
