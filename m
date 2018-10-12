Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F31C6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:18:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACF52087D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cXLWIF0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACF52087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X2KZ0trqzF3JP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:18:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cXLWIF0p";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="cXLWIF0p"; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WvC72xs4zF36F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 03:57:23 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id r9-v6so6481116pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uVlHzOjCJt1s37XP7P3Q38uoyVSxQUIUy8JlaGTffKg=;
 b=cXLWIF0psQEeOaff/zCLiIOyVLAunEJjwQpMHAjktpY4IMZnzm2ghp8KflvQg70gdF
 EQ3wGdn0DuWTTsMR3/qYn6+Mr2xvpeoMKUhr8DIN5b3h412YRn5qTL3lOpo0fcgGwZVL
 ycFj3Jxu7+NinK3bZZEUua7aW3602iGTxtcqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uVlHzOjCJt1s37XP7P3Q38uoyVSxQUIUy8JlaGTffKg=;
 b=tKzO3qrEiz+hVvmpHP8rzOZzjkTvdF0X52Zq6xW6RvT6HaHP/rljC6i6NfDiYbl7Yt
 Byl8GyWNKo/i8T5iCnBReciOi9BxF6Bf30/SK/BuHAGijJsT4AKJEtdHAz95YvzbMPhV
 3rNRWUfAZebgYUXEuRucBjFfLg+7M29k5J4Q2pkGyDit3KzjBetnFKb3VxnaAQdgMrQw
 35lYXT+ILC6z/te/ayCMOwVrciB9Ved1taoxFG49jU0sl4CIeQS+0UY4IWQQNtkCWvCr
 gLizHhSZHPFnXYyaBUeiO82sHnPQ1VGyyX1BJE0GUJb/o8d31BK6Jt3jnraslxn8uwTc
 4h/g==
X-Gm-Message-State: ABuFfohL/yoQKELUZgwBIyXjCKlzHlFxounfGnwpOgWUBlMszEEEYzDm
 Vb1OyETzoouQTlQfOltu47qdDQ==
X-Google-Smtp-Source: ACcGV634ziEY2cX+WhdmCRDXLZJG6Tx65ueAoLHfg4WZlKinFj+cgj+Q5gdHvY4hYdcks+klUX2ldQ==
X-Received: by 2002:a62:1c06:: with SMTP id c6-v6mr6962172pfc.41.1539363441324; 
 Fri, 12 Oct 2018 09:57:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id x20-v6sm3838560pfe.131.2018.10.12.09.57.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Oct 2018 09:57:19 -0700 (PDT)
Date: Fri, 12 Oct 2018 09:57:19 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181012165719.GE223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012131946.zoab2lpfmrycmuju@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012131946.zoab2lpfmrycmuju@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Sat, 13 Oct 2018 08:58:21 +1100
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
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, nios2-dev@lists.rocketboards.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, Richard Weinberger <richard@nod.at>,
 linux-parisc@vger.kernel.org, pantin@google.com,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
 minchan@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 04:19:46PM +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 12, 2018 at 05:50:46AM -0700, Joel Fernandes wrote:
> > On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> > > On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > > > Android needs to mremap large regions of memory during memory management
> > > > related operations. The mremap system call can be really slow if THP is
> > > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > > pte at a time, and can be really slow across a large map. Turning on THP
> > > > may not be a viable option, and is not for us. This patch speeds up the
> > > > performance for non-THP system by copying at the PMD level when possible.
> > > > 
> > > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > > > 
> > > > Before:
> > > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > > 
> > > > After:
> > > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > > 
> > > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > > tlb every time we do this optimization since I couldn't find a way to
> > > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > > doing so is not much compared the improvement, on both x86-64 and arm64.
> > > 
> > > I looked into the code more and noticed move_pte() helper called from
> > > move_ptes(). It changes PTE entry to suite new address.
> > > 
> > > It is only defined in non-trivial way on Sparc. I don't know much about
> > > Sparc and it's hard for me to say if the optimization will break anything
> > > there.
> > 
> > Sparc's move_pte seems to be flushing the D-cache to prevent aliasing. It is
> > not modifying the PTE itself AFAICS:
> > 
> > #ifdef DCACHE_ALIASING_POSSIBLE
> > #define __HAVE_ARCH_MOVE_PTE
> > #define move_pte(pte, prot, old_addr, new_addr)                         \
> > ({                                                                      \
> >         pte_t newpte = (pte);                                           \
> >         if (tlb_type != hypervisor && pte_present(pte)) {               \
> >                 unsigned long this_pfn = pte_pfn(pte);                  \
> >                                                                         \
> >                 if (pfn_valid(this_pfn) &&                              \
> >                     (((old_addr) ^ (new_addr)) & (1 << 13)))            \
> >                         flush_dcache_page_all(current->mm,              \
> >                                               pfn_to_page(this_pfn));   \
> >         }                                                               \
> >         newpte;                                                         \
> > })
> > #endif
> > 
> > If its an issue, then how do transparent huge pages work on Sparc?  I don't
> > see the huge page code (move_huge_pages) during mremap doing anything special
> > for Sparc architecture when moving PMDs..
> 
> My *guess* is that it will work fine on Sparc as it apprarently it only
> cares about change in bit 13 of virtual address. It will never happen for
> huge pages or when PTE page tables move.
> 
> But I just realized that the problem is bigger: since we pass new_addr to
> the set_pte_at() we would need to audit all implementations that they are
> safe with just moving PTE page table.
> 
> I would rather go with per-architecture enabling. It's much safer.

I'm Ok with the per-arch enabling, I agree its safer. So I should be adding a
a new __HAVE_ARCH_MOVE_PMD right, or did you have a better name for that?

Also, do you feel we should still need to remove the address argument from
set_pte_alloc? Or should we leave that alone if we do per-arch?
I figure I spent a bunch of time on that already anyway, and its a clean up
anyway, so may as well do it. But perhaps that "pte_alloc cleanup" can then
be a separate patch independent of this series?

> > Also, do we not flush the caches from any path when we munmap address space?
> > We do call do_munmap on the old mapping from mremap after moving to the new one.
> 
> Are you sure about that? It can be hided deeper in architecture-specific
> code.

I am sure we do call do_munmap, I was asking if we flush the caches as well.
If we're enabling this per architecture, then I guess it does not matter for
the purposes of this patch.

thanks,

 - Joel

