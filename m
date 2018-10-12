Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A38FC6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:11:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C509A2087D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YGQLxTR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C509A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X29c6y4xzDr3t
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:11:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YGQLxTR/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="YGQLxTR/"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WpNC61jnzF3Sv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 00:19:54 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id 30-v6so5929002plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qPLu7mXDYNebnqy2itkdFlgzgYtAbH0/XYuxd81Ni0g=;
 b=YGQLxTR/pEGGaKQwkJOPBPFRTunxlW3tZGxesrOXRnJ6KNUkprkgsjFH3yz3BCwgrr
 aYzpBghcn1iHyBVjtKgD40ZPbxRHkilAmJzb7/aFvPSk5SxyasOy3AigGVde1WJB2nax
 zY2/Ac5VgCKM0KrcyJ+RW5uG3SsqMPxflZ6l1QaePADC37N9Ltvz6oG9Aod/JKTtPaDs
 CNP1gfPNcIhVYS97nBIRjsXfwVI0/hOh6yz5e52vOr0n6L+OGcaaHMTa3oKpjyQI30pq
 +2lbu9/KfK8VHGL5qG/kTRpE1ENspnuC41qZ5FOTEi8qxtzqM+whP9MXiu/XeiCSptlJ
 /2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qPLu7mXDYNebnqy2itkdFlgzgYtAbH0/XYuxd81Ni0g=;
 b=JUnoladCBmIPlPWoa8yLRYIvbkwq3n88QGhQU19z+VpiYgUNCL3BfzrCuSv/sEFVH3
 rLuEK+TSr8s5q0G/OhuHlqJe0mZm05cj5F4zBC8xMO+hNLx7+svI3/zys4caaQTqqrXA
 IErPLNkxRk12R6/FJeB5X7RKwTDS6SSRn0DQV6ljd6vKisE5izfSa/AcNoYLIFbysoBE
 bDXcWFx+pKv7DrQG2KWDZDLH+tDhIhwxAYde2X9nA+ZaWdoPn7Ti+XeBKlG+j7ZvIJeY
 FIc4yvTtjwVZKGWPSSrMtMzHEptmrfKQ1hVck/iP4t2FZQ3a51AbaEHzO2B7BJb5v59q
 sjvg==
X-Gm-Message-State: ABuFfogc3r9+EXEk4TpKOVY8PDLnXArbjSknWYEYnn13qPaUu1m0LMKg
 J/2XVBLv+tHsQ6Ws9ry1Tv7iiw==
X-Google-Smtp-Source: ACcGV63NiI8G9L9RoeLis69krPaHbnldlLDZCtg1d0C3iU/tVpX89y6Av72eJGnMr1LMuMBi4E+eAQ==
X-Received: by 2002:a17:902:bf0a:: with SMTP id
 bi10-v6mr5901268plb.72.1539350392511; 
 Fri, 12 Oct 2018 06:19:52 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
 by smtp.gmail.com with ESMTPSA id t22-v6sm2727444pfk.141.2018.10.12.06.19.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 06:19:51 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id E9F3E300030; Fri, 12 Oct 2018 16:19:46 +0300 (+03)
Date: Fri, 12 Oct 2018 16:19:46 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181012131946.zoab2lpfmrycmuju@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012125046.GA170912@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
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

On Fri, Oct 12, 2018 at 05:50:46AM -0700, Joel Fernandes wrote:
> On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > > Android needs to mremap large regions of memory during memory management
> > > related operations. The mremap system call can be really slow if THP is
> > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > pte at a time, and can be really slow across a large map. Turning on THP
> > > may not be a viable option, and is not for us. This patch speeds up the
> > > performance for non-THP system by copying at the PMD level when possible.
> > > 
> > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > > 
> > > Before:
> > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > 
> > > After:
> > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > 
> > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > tlb every time we do this optimization since I couldn't find a way to
> > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > doing so is not much compared the improvement, on both x86-64 and arm64.
> > 
> > I looked into the code more and noticed move_pte() helper called from
> > move_ptes(). It changes PTE entry to suite new address.
> > 
> > It is only defined in non-trivial way on Sparc. I don't know much about
> > Sparc and it's hard for me to say if the optimization will break anything
> > there.
> 
> Sparc's move_pte seems to be flushing the D-cache to prevent aliasing. It is
> not modifying the PTE itself AFAICS:
> 
> #ifdef DCACHE_ALIASING_POSSIBLE
> #define __HAVE_ARCH_MOVE_PTE
> #define move_pte(pte, prot, old_addr, new_addr)                         \
> ({                                                                      \
>         pte_t newpte = (pte);                                           \
>         if (tlb_type != hypervisor && pte_present(pte)) {               \
>                 unsigned long this_pfn = pte_pfn(pte);                  \
>                                                                         \
>                 if (pfn_valid(this_pfn) &&                              \
>                     (((old_addr) ^ (new_addr)) & (1 << 13)))            \
>                         flush_dcache_page_all(current->mm,              \
>                                               pfn_to_page(this_pfn));   \
>         }                                                               \
>         newpte;                                                         \
> })
> #endif
> 
> If its an issue, then how do transparent huge pages work on Sparc?  I don't
> see the huge page code (move_huge_pages) during mremap doing anything special
> for Sparc architecture when moving PMDs..

My *guess* is that it will work fine on Sparc as it apprarently it only
cares about change in bit 13 of virtual address. It will never happen for
huge pages or when PTE page tables move.

But I just realized that the problem is bigger: since we pass new_addr to
the set_pte_at() we would need to audit all implementations that they are
safe with just moving PTE page table.

I would rather go with per-architecture enabling. It's much safer.

> Also, do we not flush the caches from any path when we munmap address space?
> We do call do_munmap on the old mapping from mremap after moving to the new one.

Are you sure about that? It can be hided deeper in architecture-specific
code.

-- 
 Kirill A. Shutemov
