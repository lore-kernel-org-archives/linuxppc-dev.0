Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D5C6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:36:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7362098A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="tt4haWxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7362098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X2kV2k00zDrpw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:36:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="tt4haWxv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="tt4haWxv"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42X1LT0jkmzF3LD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 08:34:07 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id f78-v6so1037874pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LHzipgUbb9bD6KKi7C8OH4ai2uXb2G2QZZei89osBiM=;
 b=tt4haWxvZLIGYgzjVvsH+gjFwfPR7DwtAHjZBdy13UoFAue6QtBjQ7yFpwdRLddwrz
 5M7Rt9vrVAomTaqAQJ7suNm3XfxtViA+swo1shgRv6b5mcASOaSfl1jxY9Io26x/3N43
 kJHc/sqKzp2v6SuHG2C8dEeJBeZpx9rXlnSqNr5HyQtCYHzhqAX/snQjGfm5BB5VdZSs
 MEUpJyErXmrbzyP5LvHp09wHHqO17A1BhLGE8wPOnD0xxGQXTAOimdYT+DkyVwz2AN51
 go/7rEXftCDBj/fYKEoPC9lVN9fdUs5TJXPwZPZIVEu19exs/DzqHb05FsfuzodtJKAK
 +mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LHzipgUbb9bD6KKi7C8OH4ai2uXb2G2QZZei89osBiM=;
 b=gCKlpudn5JO4HnNzKrhaXsm0dB1hlpXJjNBD1wLxPPFs2Jp0Uidsa30yHVHDvi/mei
 C/SM9Ap1x9UpeB4754H1ygqpw/j9OycQ6MTaUIOHC+lv8AiA5lXyMYWCpnkjUrM1ykhm
 i14nzYLuvB9Pt4GTLwSRuj6kr4TgAWXDTSg/2C/dpp2/cUaKPeZbsU5DoY1nxSlIhrDS
 MATz7b/ZSqmckzFO7AL/RlSNcW3U+m3/8J5mg9Z+f9gAR06qBByqN/exNiXS356OL7Pi
 FP3vOZY/gyO5L3VgepwzN8S5mkIjL3zsiMPOVXx3rmmhOaMHrX/pNls5FPIx/wV/Grva
 EXhQ==
X-Gm-Message-State: ABuFfog4Zijy5BJdgEsj9lKSsX3Sb2Zalp45bWjbhthsTnKfLs0nsKQG
 jDSweykMpt9x3LQEmzrcTYcaCw==
X-Google-Smtp-Source: ACcGV60SvcDuwwFfUZrEoWm25R56HMmg4aebudF5owuY6h5Fceo65AszhVv0RP3+l3Jd652Z5Qm4rw==
X-Received: by 2002:a63:7b09:: with SMTP id
 w9-v6mr7023932pgc.385.1539380045793; 
 Fri, 12 Oct 2018 14:34:05 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com.
 [192.55.54.38])
 by smtp.gmail.com with ESMTPSA id t85-v6sm3751969pfi.73.2018.10.12.14.34.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 14:34:04 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 0D98A300030; Sat, 13 Oct 2018 00:34:00 +0300 (+03)
Date: Sat, 13 Oct 2018 00:33:59 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181012213359.qpvq3obugbvy73bg@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012131946.zoab2lpfmrycmuju@kshutemo-mobl1>
 <20181012165719.GE223066@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012165719.GE223066@joelaf.mtv.corp.google.com>
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

On Fri, Oct 12, 2018 at 09:57:19AM -0700, Joel Fernandes wrote:
> On Fri, Oct 12, 2018 at 04:19:46PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Oct 12, 2018 at 05:50:46AM -0700, Joel Fernandes wrote:
> > > On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> > > > On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > > > > Android needs to mremap large regions of memory during memory management
> > > > > related operations. The mremap system call can be really slow if THP is
> > > > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > > > pte at a time, and can be really slow across a large map. Turning on THP
> > > > > may not be a viable option, and is not for us. This patch speeds up the
> > > > > performance for non-THP system by copying at the PMD level when possible.
> > > > > 
> > > > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > > > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > > > > 
> > > > > Before:
> > > > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > > > 
> > > > > After:
> > > > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > > > 
> > > > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > > > tlb every time we do this optimization since I couldn't find a way to
> > > > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > > > doing so is not much compared the improvement, on both x86-64 and arm64.
> > > > 
> > > > I looked into the code more and noticed move_pte() helper called from
> > > > move_ptes(). It changes PTE entry to suite new address.
> > > > 
> > > > It is only defined in non-trivial way on Sparc. I don't know much about
> > > > Sparc and it's hard for me to say if the optimization will break anything
> > > > there.
> > > 
> > > Sparc's move_pte seems to be flushing the D-cache to prevent aliasing. It is
> > > not modifying the PTE itself AFAICS:
> > > 
> > > #ifdef DCACHE_ALIASING_POSSIBLE
> > > #define __HAVE_ARCH_MOVE_PTE
> > > #define move_pte(pte, prot, old_addr, new_addr)                         \
> > > ({                                                                      \
> > >         pte_t newpte = (pte);                                           \
> > >         if (tlb_type != hypervisor && pte_present(pte)) {               \
> > >                 unsigned long this_pfn = pte_pfn(pte);                  \
> > >                                                                         \
> > >                 if (pfn_valid(this_pfn) &&                              \
> > >                     (((old_addr) ^ (new_addr)) & (1 << 13)))            \
> > >                         flush_dcache_page_all(current->mm,              \
> > >                                               pfn_to_page(this_pfn));   \
> > >         }                                                               \
> > >         newpte;                                                         \
> > > })
> > > #endif
> > > 
> > > If its an issue, then how do transparent huge pages work on Sparc?  I don't
> > > see the huge page code (move_huge_pages) during mremap doing anything special
> > > for Sparc architecture when moving PMDs..
> > 
> > My *guess* is that it will work fine on Sparc as it apprarently it only
> > cares about change in bit 13 of virtual address. It will never happen for
> > huge pages or when PTE page tables move.
> > 
> > But I just realized that the problem is bigger: since we pass new_addr to
> > the set_pte_at() we would need to audit all implementations that they are
> > safe with just moving PTE page table.
> > 
> > I would rather go with per-architecture enabling. It's much safer.
> 
> I'm Ok with the per-arch enabling, I agree its safer. So I should be adding a
> a new __HAVE_ARCH_MOVE_PMD right, or did you have a better name for that?

I believe Kconfig option is more cononical way to do this nowadays.
So CONFIG_HAVE_ARCH_MOVE_PMD, I guess. Or CONFIG_HAVE_MOVE_PMD.
An arch that supports it would select the option.

> Also, do you feel we should still need to remove the address argument from
> set_pte_alloc? Or should we leave that alone if we do per-arch?
> I figure I spent a bunch of time on that already anyway, and its a clean up
> anyway, so may as well do it. But perhaps that "pte_alloc cleanup" can then
> be a separate patch independent of this series?

Yeah. The cleanup makes sense anyway.

-- 
 Kirill A. Shutemov
